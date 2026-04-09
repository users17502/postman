<!DOCTYPE html>
<html>
<head>
  <title>Live Search</title>

  <!-- jQuery CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
    .highlight {
      background-color: yellow;
    }
  </style>
</head>
<body>

<h2>Search Articles</h2>

<input type="text" id="search" placeholder="Type to search...">

<ul id="list">
  <li>Ruby on Rails tutorial</li>
  <li>JavaScript basics</li>
  <li>Learn jQuery step by step</li>
  <li>Web development guide</li>
  <li>Frontend and backend</li>
</ul>

<script>
$(document).ready(function(){

  $("#search").on("keyup", function(){

    let value = $(this).val().toLowerCase();

    $("#list li").each(function(){

      let text = $(this).text();
      let lowerText = text.toLowerCase();

      // Show/hide items
      if (lowerText.includes(value)) {
        $(this).show();

        // Highlight matching text
        let regex = new RegExp("(" + value + ")", "gi");
        let newText = text.replace(regex, '<span class="highlight">$1</span>');
        $(this).html(newText);

      } else {
        $(this).hide();
      }

    });

  });

});
</script>

</body>
</html>
