# MakeAQuiz

In this README you will find an overall introduction to the design principles used for this app.

I've tried documenting the individual parts in the actual files as well but you can find the same concepts/description here so...whatever suits you 😅

## General Introduction ℹ️
The app is made using 
- SwiftUI 
- Swift Concurrency
- Swift Packages for modularization.
- Swift 6
- Xcode 16.2

And targets iOS 17 because why not...no reason to limit myself here!

You can:
- Select your quiz category from a list of QuizCategories, and then select difficulty and quiz type (multiple or true/false).
- Based on that, 10 questions will be fetched and you can then answer them, one by one. After each question you are told if you were right or wrong.
- Once the quiz is over you see a sorry looking screen with your score and can then start over.


## Getting up and running 🏃
Clone the repo and open it in Xcode. That should hopefully be it.


## What Have I Focused on? 👀
I've spent most of my time setting up a decent (to me at least) structure in the app. As mentioned above you can see a list of QuizCategories and take a quiz and that's about it.

I have not spent too much time on UI, not because it is not interesting but time was limited...and I'm a moron when it comes to making things look pretty on a screen anyway so there's that too :)

### What is Missing?
That also means that things are missing. No bonus goals are implemented and as mentioned...the UI is lackluster. If you came for bells and whistels...you'll be disappointed, sorry.

## Architecture 🏗️
The architecture is - I hope - fairly standard, but with some additional bits and pieces I've learned over the years. 

I tried finding an online UML editor or something to create a diagram but it was too much work and using PlantUML for instance would also add another hours worth of work and I've already spent way too much time so ...I can make a drawing on a whiteboard maybe :)

### Overall Architecture
The architecture is layered. From top to bottom you will find:

- Views
- ViewModels
- Managers
- Repositories

Layers higher in the hierachy can access lower layers but lower layers has no knowledge about higher layers.

I'm using a `ViewModel` for each of the `View`s, so for instance you will find:

- `QuizCategoriesView`
- `QuizCategoriesView+ViewModel`

The contract between these two is that the `View` creates the `ViewModel` and the `ViewModel` then maintains data, fetches data from a `Manager` and so on.

Speaking of `Manager`s, these are responsible for fetching data, which they do via a `Repository`. The `Repository` can communicate with the Open Trivia API.

The `Manager` and `Repository` are defined as `Protocol`s so you can change them for different implementations if so needed (\*cough\* unittests \*cough\*)

Let's dive into _even_ more details shall we!

### Using Swift Packages for Layers
If you look at the `Modules` Swift Package you will see that I have defined three libraries here:

- `Core`: Which holds "foundational" things that should be avaiable to all.
- `QuizFeature`: Which holds the actual feature. The idea is to have a library for each feature and then have - almost - all code relevant for this feature located here. Note that I said almost...you could imagine defining a `SharedUI` library as well for instance that could be used across several Features. The `QuizFeature` has a dependency to the `QuizManager` library.
- `QuizManager`: Which holds the Manager and the Repository. You could argue that maybe the `Manager` and the `Repository` should be in separate layers/libraries and I wouldn't argue with you :)

The idea is to have as little code as possible in the "app" itself and as much as possible in individual Swift Package libraries. The advantage is that you can build, work on and test the individual libraries isolated.

### Repositories
Next stop on our tour is the `Repository` layer (in the `QuizManager` folder). You will only find a single `QuizRepository` here, defined as a `Protocol`. The "live" implementation is in `NetworkQuizRepository` (feel free to come up with a better name). Here I use a URLSession to fetch the actual data from the API.

#### Models (DTOs and UI)
Still inside the `QuizManager`, you will also find a folder named `Models`, which contains "DTO" structs for all the data we fetch from the API.

The idea behind the DTO structs is that they are `Decodable` `struct`s that 1:1 mimics naming from the API and doesn't do any fancy mapping, conversion or anything.

If a `ViewModel` higher in the chain needs UI specific models, that part is done by the `Manager` who - if needed - can convert and use the "UIModels".

### Managers
This brings us to `Managers`. The idea is that a `Manager` is the one that is reponsible for ensuring that "the outside world" can get valid data. That is...if you want a list of QuizCategories; you ask the `QuizManager`, if you want to fetch a specific Quiz; you ask the `QuizManager`.

Again, the "contract" is defined in the `QuizManager` `Protocol` and the concrete "live" implementation can be found in `LiveQuizManager` which is an `Actor` to ensure proper concurrency handling.

#### Typed Identifiers
Another detail in the Model objects is that I've choosen to introduce a `QuizCategoryId` type here as I find it reduces the risk of you comparing say a TicketID with a PersonID just because they are both Strings.

And continuing...they are not Strings right? I mean, you wouldn't lowercase an ID, or reverse it, or merge it with another ID.

This is not my idea...see [Pointfree's Tagged library](https://github.com/pointfreeco/swift-tagged) for instance. I've just created a simplified wrapper here but I could just as well have used their library in a larger project

### ViewModels
Last - almost - stop on this tour is the `ViewModel`s which I've already touched upon above so here I just want to mention that they are `MainActor`s so they can run `async` code on the main thread.

I like to use `enum`s for a lot of things in my view models. Here you can see that I have enums for representing

- ViewState: Which state is our view currently in?
- Action: Which "actions" can you perform on the view
- SheetState: Which sheets can be presented from this view

My ViewModels are definded as `@StateObject`s as they are the ones responsible for instantiating the data. I have not yet switched to the new `Observation` macros.

### Dependencies
One final piece to the puzzle. Now we have all the individual parts but we still need to start it all up and tell the `View` which `Manager` to use, so that the `View` can pass that `Manager` to it's `ViewModel` who can then start fetching data with it.

If you take a look at the `Dependencies enum` you will see that I have a set of `live` dependencies. You could also have `mock`/`preview` dependencies here and the idea is then that you can switch these as you see fit during development.

You could - maybe - put this in a separate library so you could use it in the individual Feature libraries as well...maybe next time.

## Outro 👋
Thank god! We're at the end...you still here? I hope the above has helped you understand what my intention was.

Have fun!
