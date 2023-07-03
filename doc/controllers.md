## _State Object Controllers_

### Control The Pattern
By the way, in keeping with the importance of consistency, that’s the general pattern you’ll see in 
the Fluttery Framework when utilizing such Controllers in State classes:

The controller is passed to the State’s super constructor, it’s then assigned to a variable (usually named ‘con’) either in the class's constructor or in its initState() function. That ‘con’ variable is then referenced here and there in the class’s build() function or any other function defined in that class. The ‘con’ variable represents the logic/event handling.

It’s the Controller that contains the business logic and performs the event handling while the State object is just concerned with the interface. See what I mean? Granted, there are variations in how and when the Controller is assigned to a variable, but that’s the general pattern.

### Avoid Controller Bloat
You're able to add as many Controllers as you want to your StateX object.
And so, if there is a number of Controllers assigned to a View, and when ‘an event’ occurs in that View, 
the Controllers will fire, in turn, in the order they were assigned.
<img align="right" src="https://github.com/Andrious/bazaar/assets/32497443/f84c06e9-7622-495a-9a8d-91da133311d0" alt="One-to-Many Controllers">

![multiViewsController](https://github.com/Andrious/bazaar/assets/32497443/9c6ab55d-faf6-4b40-8f3c-6295ebe592b9)


[![bizzarController](https://github.com/Andrious/bazaar/assets/32497443/cdb79266-d973-4c46-b221-4e7ad93a1105)](https://github.com/Andrious/bazaar/blob/5b06048010e425129123f856b6cb669362151b8a/lib/src/view/home/homepage.dart#L34)


Thus, when your controller is ‘registered’ with a State object and its State object’s initState() function is called, its own initState() function will also be called. Anything your controller may need to be initialized, for example, before that widget is displayed can now be done so in its own initState() function.
