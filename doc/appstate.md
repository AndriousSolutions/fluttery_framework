<head>
<style>
button.accordion {
    background-color: #777;
    color: white;
    cursor: pointer;
    padding: 18px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 15px;
}

button.accordion.active, button.accordion:hover {
background-color: #555;
}

button.accordion:after {
content: '\002B';
color: white;
font-weight: bold;
float: right;
margin-left: 5px;
}

button.accordion.active:after {
content: "\2212";
}

div.panel {
padding: 0 18px;
background-color: #f1f1f1;
max-height: 0;
overflow: hidden;
transition: max-height 0.2s ease-out;
color:black;
}
</style>
</head>

## _The 'Look and Feel' of your app_


<button class="accordion">Collapsible</button>
<div class="panel">
  <p>Some collapsible content. Click the button to toggle between showing and hiding the collapsible content. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
</div>

<button data-toggle="collapse" data-target="#demo">Collapsible</button>
<div id="demo" class="collapse">
Lorem ipsum dolor text....
</div>
