# SinghWeShop


----------------------------------------------------------

WeShop App build as part of Kodeco Bootcamp 2023

Choice of Capstone project - Go Shopping Application
App Name - WeShop
App Description - Shopping App which presents users with a list of products to browse, add to cart and make the purchase.

Api details  -  ??


A detailed description of WeShop Application -

WeShop is a tabbed applications contains the following screen​s​ : 

Home Tab - 
It shows a list of products the user can browse. Tapping on any product shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.​ Also, users can swipe on any of the products show in the list view to bring up a "Add to Cart" button, tapping this button will add the product to cart.​
​Users also have an option to search for items by typing into the search field present to the top of the list view.

Discover Tab - 
It shows a grid view of trending products selected for the user. Taping on any grid cell shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.
​Users also have an option to search for items by typing into the search field present to the top of the ​grid view.

Cart Tab - ​It shows an empty cart by default. The user can add products to cart from the Home or Discover Tab screens.​ Users also have an option to remove products from the cart enabled via an Orange Remove button attached to every product in cart. 
Any applicable discount is applied to the product price and updated price is reflected in the cart. Users are shown cart total i.e. total ​sum ​amount for the items present in the cart.
When ready users can perform checkout action and will receive a confirmation on successful order placement.

Account Tab - ​This screen shows the user details associated with the logged in user. Also, the Logout option is available if user wishes to logout of the application.​

Onboarding Modal Screen - This screen is accessible from Home or Discover screens. And it shows a short introduction to the WeShop Application.




Details on the application code :

MVVM architecture :  ??

Storage : The group contains files which help in building a in-Memory and on disk storage cache system to assist in loading product images.
DiskStorage.swift - Contains all the methods required to read-write to disk.
ImageStorage.swift - It is created as a Global actor and a shared instance created to be accessible in the application. It helps in caching mechanism to keep images in memory or retrieve from disk storage if available. Otherwise the image will be fetched from the network and cached for future usage.

Models : 
Constants.swift : This file contains few enums which contain static values or constants being utilized in several occurrences in the codebase. Hence keeping it in a constants file makes it easier to avoid typing mistakes and lot easier to change the values.
DiscountType.swift : It contains a enum for DiscountType which has cases for different types of discounts being applied to products in the cart. It also contains a useful extension to String type, which enables to throw strings as error.
Item.swift : It contains the Item struct which defines all the properties our products can store. And it also has sample Items data to help with previews in the codebase.
User.swift : It contains the User struct which defines all the properties for a given user. And it also has sample User data to help with previews in the codebase.


ViewModels : 
UserManager.swift : It contains methods which help in fetching the user data and storing into a Published User property. The methods help in saving user data to JSON files, read user data from JSON files and also to remove existing User JSON file(upon user logout). If needed can invoke an API call to fetch user data.
    Also, contains a published login state property which determines if any user is currently logged in or not.
ItemsManager.swift : It contains methods which help in fetching the items data and storing into a Published allItems property. The methods help in saving items data to JSON files, read items data from JSON files and also to remove existing items JSON file(upon user logout). If needed can invoke an API call to fetch items data.
    Also, contains a published login state property which determines if any user is currently logged in or not.
CartManager.swift : The cart data is stored in a Published cartItems property. It contains methods which help in managing the cart data. The methods help in saving cart data to JSON files, read cart data from JSON files and also to remove existing cart JSON file(upon user logout). Also, some helper methods which help in clearing cart, add/remove items to cart, calculate applicable product discounts and the total amount for the current products added to the cart.
NetworkManager.swift : NetworkManager function to help in the interaction with the API. This includes fetching Product data, fetch User data and also performing the login function. NetworkManager contains all the necessary URL required to perform its designated functions.
MockNetworkManager.swift : This mock NetworkManager helps in Unit testing by providing Items & User data from JSON file stored in the app bundle. So this avoids making a network call for fetching data from API.
NetworkMonitor.swift : This is a utility class which helps in monitoring the network connectivity. This contains a boolean isConnected property which at given point in time contains the network status(available/unavailable) and accordingly the application can show proper message/view to user. 


Views : 



ViewComponents : 



Unit Tests : 


UI Tests : 
