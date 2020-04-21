# yacht_provider

This is a prototype project to investigate using an abstract repository to cater for being able to use different technologies to store data.

It will have one model for a yacht and will include the CRUD actions against that model. Necessary screens will be built to perform the actions.

Initially it will cater for storing the data in memory, in a local sqlite database and remotely in firebase.
The Provider state management package will be used.

It will also contain a robust sample folder structure for a medium sized app.

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

## Provider

Within the application folder a yachts.dart file defines a class that implements ChangeNotifier. This class maintains a list of all the yachts which will be used by the user interface for updates.
