import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score, confusion_matrix

# 1. Column names
cols = [
'age','sex','cp','trestbps','chol','fbs','restecg',
'thalach','exang','oldpeak','slope','ca','thal','target'
]

# 2. Load dataset
df = pd.read_csv("processed.cleveland.data", names=cols)

print(df.head())
print(df.info())

# 3. Replace missing values '?'
df = df.replace('?', np.nan)
df = df.dropna()

# convert numeric
df = df.astype(float)

# 4. Convert target to binary (0 = no disease, 1 = disease)
df['target'] = df['target'].apply(lambda x: 1 if x > 0 else 0)

# 5. Boxplot
sns.boxplot(x='target', y='age', data=df)
plt.title("Age vs Heart Disease")
plt.show()

# 6. Heatmap
plt.figure(figsize=(10,8))
sns.heatmap(df.corr(), cmap='coolwarm')
plt.title("Correlation Heatmap")
plt.show()

# 7. Split
X = df.drop('target', axis=1)
y = df['target']

# 8. Scaling
scaler = StandardScaler()
X = scaler.fit_transform(X)

# 9. Train-test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# 10. MLP model
model = MLPClassifier(hidden_layer_sizes=(20,20), max_iter=500)

# 11. Train
model.fit(X_train, y_train)

# 12. Predict
y_pred = model.predict(X_test)

# 13. Accuracy
print("Accuracy:", accuracy_score(y_test, y_pred))

# 14. Confusion matrix
cm = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:\n", cm)

sns.heatmap(cm, annot=True, fmt='d')
plt.xlabel("Predicted")
plt.ylabel("Actual")
plt.title("Confusion Matrix")
plt.show()

# 15. Misclassified
mis = np.where(y_test != y_pred)[0]
print("Misclassified:", mis)







import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score, confusion_matrix

# 1. Load UCI dataset
columns = [
'id','clump_thickness','uniform_cell_size','uniform_cell_shape',
'marginal_adhesion','single_epithelial_size','bare_nuclei',
'bland_chromatin','normal_nucleoli','mitoses','class'
]

df = pd.read_csv("breast-cancer-wisconsin.data", names=columns)

print(df.head())
print(df.info())

# 2. Replace missing values '?'
df['bare_nuclei'] = df['bare_nuclei'].replace('?', np.nan)
df = df.dropna()

# Convert to numeric
df = df.astype(int)

# 3. Convert class to binary (2=benign, 4=malignant)
df['class'] = df['class'].map({2:0, 4:1})

# 4. Boxplot
sns.boxplot(x='class', y='clump_thickness', data=df)
plt.title("Boxplot")
plt.show()

# 5. Heatmap
plt.figure(figsize=(8,6))
sns.heatmap(df.corr(), cmap='coolwarm')
plt.title("Heatmap")
plt.show()

# 6. Split
X = df.drop(['class','id'], axis=1)
y = df['class']

# 7. Scaling
scaler = StandardScaler()
X = scaler.fit_transform(X)

# 8. Train test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# 9. MLP
model = MLPClassifier(hidden_layer_sizes=(10,10), max_iter=500)

# 10. Train
model.fit(X_train, y_train)

# 11. Predict
y_pred = model.predict(X_test)

# 12. Accuracy
print("Accuracy:", accuracy_score(y_test, y_pred))

# 13. Confusion matrix
cm = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:\n", cm)

sns.heatmap(cm, annot=True, fmt='d')
plt.xlabel("Predicted")
plt.ylabel("Actual")
plt.title("Confusion Matrix")
plt.show()

# 14. Misclassified
mis = np.where(y_test != y_pred)[0]
print("Misclassified:", mis)



import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split

from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier, GradientBoostingClassifier, VotingClassifier

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, ConfusionMatrixDisplay

# load
data = load_breast_cancer()
X = data.data
y = data.target

print(X.shape)
print(y.shape)

# EDA

plt.hist(y)
plt.xlabel("class")
plt.ylabel("count")
plt.show()

plt.boxplot(y)
plt.title("Boxplot")
plt.show()

plt.figure(figsize=(10,8))
sns.heatmap(pd.DataFrame(X).corr(), cmap="coolwarm")
plt.title("Heatmap")
plt.show()

# split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

# 🔥 1. BASE MODEL (Decision Tree)

dt = DecisionTreeClassifier()
dt.fit(X_train, y_train)
y_pred = dt.predict(X_test)

print("Decision Tree")
print("Accuracy:", accuracy_score(y_test, y_pred))
print("Precision:", precision_score(y_test, y_pred))
print("Recall:", recall_score(y_test, y_pred))
print("F1:", f1_score(y_test, y_pred))

ConfusionMatrixDisplay.from_predictions(y_test, y_pred)
plt.show()

# 🔥 2. BAGGING (Random Forest)

rf = RandomForestClassifier()
rf.fit(X_train, y_train)
y_pred = rf.predict(X_test)

print("Random Forest")
print("Accuracy:", accuracy_score(y_test, y_pred))
print("Precision:", precision_score(y_test, y_pred))
print("Recall:", recall_score(y_test, y_pred))
print("F1:", f1_score(y_test, y_pred))

# feature importance
plt.bar(range(len(rf.feature_importances_)), rf.feature_importances_)
plt.title("Feature Importance")
plt.show()

# 🔥 3. BOOSTING (AdaBoost)

ada = AdaBoostClassifier()
ada.fit(X_train, y_train)
y_pred = ada.predict(X_test)

print("AdaBoost Accuracy:", accuracy_score(y_test, y_pred))

# 🔥 Gradient Boosting

gb = GradientBoostingClassifier()
gb.fit(X_train, y_train)
y_pred = gb.predict(X_test)

print("Gradient Boosting Accuracy:", accuracy_score(y_test, y_pred))

# 🔥 4. VOTING

model1 = DecisionTreeClassifier()
model2 = RandomForestClassifier()
model3 = AdaBoostClassifier()

voting = VotingClassifier(
    estimators=[('dt', model1), ('rf', model2), ('ada', model3)],
    voting='hard'
)

voting.fit(X_train, y_train)
y_pred = voting.predict(X_test)

print("Voting Accuracy:", accuracy_score(y_test, y_pred))

# 🔥 soft voting

voting_soft = VotingClassifier(
    estimators=[('dt', model1), ('rf', model2), ('ada', model3)],
    voting='soft'
)

voting_soft.fit(X_train, y_train)
y_pred = voting_soft.predict(X_test)

print("Soft Voting Accuracy:", accuracy_score(y_test, y_pred))
