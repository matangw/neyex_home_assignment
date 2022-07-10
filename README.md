# neyex_home_assignment

Matan gabso home assignment for neyex job application

## Getting Started

Work flow :
    1) - I started by creating models of the articles base on data scheme from the api, and created diffrent model for the 
        source object inside the article.
    2) - Started creating the services client using retro fit and dio, and ran a build runner command to build the three
        .g.dart classes: newsClient , article model and source model.
    3) - Implemented the bloc wich I use 4 files architecture:
            state: announce the state and the variables they need.
            event:  announce the different events.
            bloc: the functions that will be executed with every event.
            screen: the visual representation of the data.
    4) - Created the news repository to make it easier to control the news client
    5) - Creating the local database: 
            Here I stated by trying to implement the floor and drift packages , but retro fit need the analyzer 
            3.0.0 and both the drift and floor are not competiable with that version of analyzer.
            I used another library that called sharedPreffrences and I implemented the local data base with it.
    6) - Took care of endpoints such as no internet connection and made the news widget press able and it will send to user 
            to url,  and if the url cannot be launched it will show a toast with the correct message.
    7) - Little refactoring and removing unneeded prints 
    

