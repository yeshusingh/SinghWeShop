# SinghWeShop


----------------------------------------------------------

WeShop App build as part of Kodeco Bootcamp. 

Choice of Capstone project - Go Shopping Application
App Name - WeShop
App Description - Shopping Application which presents users with a list of products to browse, add to cart and make the purchase.

Api details  - The application uses "https://fakestoreapi.com" api as a free online REST API that you can use to get Pseudo-real data for your e-commerce or shopping website without running any server-side code.


A description of WeShop Application -

WeShop is a tabbed applications contains the following screen​s​ : 

Home Tab - 
It shows a list of products the user can browse. Tapping on any product shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.​ Also, users can swipe on any of the products show in the list view to bring up a "Add to Cart" button, tapping this button will add the product to cart.​
​Users also have an option to search for items by typing into the search field present to the top of the list view.

Discover Tab - 
It shows a grid view of trending products selected for the user. Taping on any grid cell shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.
​Users also have an option to search for items by typing into the search field present to the top of the ​grid view.

Cart Tab - ​It shows an empty cart by default. The user can add products to cart from the Home or Discover Tab screens.​ Users also have an option to remove products from the cart provided via an Orange Remove button attached to every product in cart. 
Any applicable discount is applied to the product price and updated price is reflected in the cart. Users are shown cart total i.e. total ​sum ​amount for the items present in the cart.
When ready users can perform checkout action and will receive a confirmation on successful order placement.

Account Tab - ​This screen shows the user details associated with the logged in user. Also, the Logout option is available if user wishes to logout of the application.​

Onboarding Modal Screen - This view is accessible from Home or Discover screens. And it shows a short introduction to the WeShop Application.




Details on the application code :

MVVM architecture :  The application follows MVVM architecture.

Launch Screen : The application has a launch screen which has been configured utilizing the info.plist file. The configuration is added under "Launch Screen" Dictionary in the info.plist. This dictionary contains key named "Background Color" and "Image Name" which help setup the launch screen.

Models : 
Constants.swift : This file contains few enums which contain static values or constants being utilized in several occurrences in the codebase. Hence keeping it in a constants file makes it easier to avoid typing mistakes and lot easier to change the values.
DiscountType.swift : It contains a enum for DiscountType which has cases for different types of discounts being applied to products in the cart. It also contains a useful extension to String type, which enables to throw strings as error.
Item.swift : It contains the Item struct which defines all the properties our products can store. And it also has sample Items data to help with previews in the codebase.
User.swift : It contains the User struct which defines all the properties for a given user. And it also has sample User data to help with previews in the codebase.

ViewModels : 
UserManager.swift : It contains methods which help in fetching the user data and storing into a Published User property. These methods help in saving user data to JSON files, read user data from JSON files and also to remove existing User JSON file(upon user logout). If needed can invoke an API call to fetch user data.
    Also, contains a published login state property which determines if any user is currently logged in or not.
ItemsManager.swift : It contains methods which help in fetching the items data and storing into a Published allItems property. These methods help in saving items data to JSON files, read items data from JSON files and also to remove existing items JSON file(upon user logout). If needed can invoke an API call to fetch items data.

CartManager.swift : The cart data is stored in a Published cartItems property. It contains methods which help in managing the cart data. These methods help in saving cart data to JSON files, read cart data from JSON files and also to remove existing cart JSON file(upon user logout). Also, some helper methods which help in clearing cart, add/remove items to cart, calculate applicable product discounts and the total amount for the current products added to the cart.
NetworkManager.swift : NetworkManager function to help in the interaction with the API. This includes fetching Product data, fetch User data and also performing the login function. NetworkManager contains all the necessary URL required to perform its designated functions.
MockNetworkManager.swift : This mock NetworkManager helps in Unit testing by providing Items & User data from JSON file stored in the app bundle. So this avoids making a network call for fetching data from API.
NetworkMonitor.swift : This is a utility class which helps in monitoring the network connectivity. This contains a boolean isConnected property which at any given point in time contains the network status(available/unavailable) and accordingly the application can show proper message/view to user. 


Views : 
LoginView.swift : This creates the login screen for the application. Provides user with TextFields to enter credentials and a login button submit those credentials the API for evaluation. If login failed then user is alerted with error message otherwise on successful login the user moves on the TabView screen and this transition is made smooth using subtle animation.
TabView.swift : This is home screen for the application, which is formed by a TabView containing four Tabs 
  "Home" - Shows a list of product.
  "Discover" - Shows limited list of trending products shown in a Grid View.
  "Cart"  - Shows the Cart of the user. Products added to cart show up here.
  "Account" - Shows the Accounts View which shows details of logged in user.
  
ListItem.swift : This shows the view of individual product in list, containing a Image of product along with Title and Price of the product.
ItemsListView.swift : It shows a list of products the user can browse. Tapping on any product shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.​ Also, users can swipe on any of the products show in the list view to bring up a "Add to Cart" button, tapping this button will add the product to cart.​
    ​Users have a option to search for products by utilizing search field present at the top of the list view.
    ​Also, there is a info button on the navigation bar which presents a modal view of onboarding screen.
    ​
GridItem.swift : This shows the view of individual product in grid, containing a Image of the product along with Title and Price of the product.
ItemsGridView.swift : It shows a grid view of trending products selected for the user. Taping on any grid cell shows a more detailed view of the product. Users can add the product to cart from the detail​s​ view or navigate back to the product list.
​    Users have a option to search for products by utilizing search field present at the top of the grid view.
​    Also, there is a info button on the navigation bar which presents a modal view of onboarding screen.
​    
CartRowView.swift : This shows the view of individual product in the cart, containing a Image of the product along with Title, Price and Discounted Price of the product. There is a "Remove" button available too which allows user to remove item from the cart.
CartView.swift : It shows an empty cart by default. The user can add products to cart from the Home or Discover Tab screens.​ Users also have an option to remove products from the cart provided via an Orange Remove button attached to every product entry in the cart. 
    Any applicable discount is applied to the product price and updated price is reflected in the cart. Users are shown cart total i.e. total ​sum ​amount for the items present in the cart.
    When products are removed from the cart a subtle animation happens to provide a visual feedback to the user.
    When ready users can perform checkout action and will receive a confirmation message on successful order placement.

ItemDetailView.swift : This shows the detailed view of a product, containing a large Image of the product along with Title, Price and Detailed Description of the product. There is a "Add to Cart" button available too which allows user to add item to the cart.
OnboardingView.swift : This view is accessible from Home or Discover screens. And it shows a short introduction to the WeShop Application.
AccountView.swift : This screen shows the user details associated with the logged in user. Also, the Logout option is available if user wishes to logout of the application.​
NetworkStatusView.swift : This shows the view which is displayed when network connection seems offline. This view contains a symbol for no connectivity along with a error message to user for connection being offline.


ViewComponents : 
This group contains several extracted views which either are utilized repeatedly across different screens or if a view was growing too big then part of it is extracted to make easier to manage view sizes.

ItemNameView.swift
PriceView.swift
RemoveButtonView.swift
ItemRowImageView.swift
ItemDetailImageView.swift
ItemGridImageView.swift
ShowOnboardingButtonView.swift
SwipeButtonView.swift
ButtonLabelView.swift
ItemDescriptionView.swift
AppPicTitleView.swift
OnboardingRowTextView.swift

Storage : The group contains files which help in building a in-Memory and on disk storage cache system to assist in loading product images.
DiskStorage.swift - Contains all the methods required to read-write to disk.
ImageStorage.swift - It is created as a Global actor and a shared instance created to be accessible in the application. It helps in caching mechanism to keep images in memory or retrieve from disk storage if available. Otherwise the image will be fetched from the network and cached for future usage.

Unit Tests : 
This group consists of a few Unit Test classes which help perform unit tests on several functionalities in the application.

UserManagerUnitTests.swift
MockNetworkManagerUnitTests.swift
NetworkManagerUnitTests.swift
CartManagerUnitTests.swift
ItemsManagerUnitTests.swift

UI Tests : 
This group consists of a few UI Test classes which help perform UI tests on several screens in the application.
AccountViewScreenUITests.swift
OnboardingViewScreenUITests.swift
ItemDetailScreenUITests.swift
CartScreenUITests.swift
DiscoverScreenUITests.swift
HomeScreenUITests.swift
SinghWeShopUITests.swift
SinghWeShopUITestsLaunchTests.swift
XCUIApplicationExtension.swift

