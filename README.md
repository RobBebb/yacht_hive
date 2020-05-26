# yacht_hive

This is a prototype project to investigate using Hive.

## Folder Structure

The folder structure will have a high level folder for each feature. In this case there is only one, yachts. There will also be a high level folder for shared code. This will be called core.

The core folder is broken down into:

* database - common code to access a sqlite database.

Each feature folder is broken down into:

* application - contains the business logic of the app. It performs the interaction between the presentation layer and the infrastructure layer. It should not contain any presentation code or database specific code.
* domain - contains the data model for the feature .
* infrastructure - contains the repository for the feature. This is where database, network and device functions will be performed.
* presentation - contains the user interface code. This folder is broken down into a screens folder that contains a file for each screen and a widgets folder that will contain ...widgets (building blocks for the screens).

## Repository

As mentioned earlier, an abstract repository will be used to allow us to define multiple data storage technologies.

I have named the methods in the abstract repository using SQL related names. Most probably because my background is in DB2 (IBM relational database management system).

The names I have used are:

* selectYachts - get back a list of all yachts from the data store
* insertYacht - add a yacht to the data store. This will return a yacht that includes the id
* selectYacht - get back one yacht based on it's id
* updateYacht - change the details of a yacht
* deleteYacht - remove a yacht from the data  store based on it's id

## Error Processing

I see most of the error processing happening in the infrastructure layer. This is where all the processing that deals with external packages will take place.

I expect to be using the DARTZ package for error handling. Refer to these tutorials for more details [Reso Coder - Handle Errors Part 1](https://resocoder.com/2019/12/11/proper-error-handling-in-flutter-dart-1-principles/) and [Reso Coder - Functional Error Handling Part 2](https://resocoder.com/2019/12/14/functional-error-handling-in-flutter-dart-2-either-task-fp/) and [Codemagic Architecture](https://blog.codemagic.io/flutter-tutorial-app-arhitecture-beginners/)
