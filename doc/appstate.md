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

