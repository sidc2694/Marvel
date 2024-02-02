## About Project
- This project uses Marvel APIs (https://developer.marvel.com/).
- Project contains two screens 1) Character list screen 2) Character details screen.
- Character list screen lists the characters from webservice with character image, title and if available then description about that character.
- On Character details screen, 5 comics releted to that character is displayed.
- Storyboard is used to create UI for screens.

## Project Architecture
- To build this project MVVM architecture is used.
- SOLID principles are followed while building this project.
- As per the MVVM architectural pattern each module has Model, View and ViewModel. In addition to that there is one more file called Router is introduced which takes care of navigation from one screen to another screen.
- This project contains dedicated classes for handling actual webservice call and mock webservice call which adheres to single responsibility principle.
- For each ViewModel there is a protocol created which contains all the methods and variables which are used by ViewController to request data from ViewModel and this protocol is implemented by actual ViewModel class. This gives added advantage if ViewModel has a method which should not be exposed to ViewController but it needs to be unit tested.
- In each ViewController, ViewModel dependency is injected in order to avoid changes in ViewModel anytime after initialisation of ViewController.
- As in the MVVM architecture all the business logic and business decisions must be implemented inside ViewModel, a closure variable is introduced named eventState in ViewModel which accepts an Enum as an argument. This gives advantage of triggerig events from ViewModel whenever any business decision is taken by ViewModel and we just need to make UI change to reflect that on ViewController.

## Third Party Libararies
- Project uses two third party libraries
    1) Kingfisher: To download and cache images.
    2) SVProgressHUD: To show loader while webservice call is in progress.
