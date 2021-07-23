# Rappi Challenge

This is a quick, and somehow dirty, implementation of an app that reads from a remote API. 

Given the required functionalities, a regular MVC would be enough. I choose not to go that way and instead use Viper and SwiftUI to challenge myself, and to let you know a little more about my coding style. 

The one and only dependency are a [Swift Package](https://github.com/volonbolon/super-octo-potato) written by myself. It is really simple, and once again, I choose to use it mainly for two reasons. 1. To let you know how I would handle external dependencies in a real app, and 2. do that with my own code instead of someone else. After all, you are trying to assess my code. The library itself is really simple. Perhaps you would like to take a look to check the test unit. There, to test the URL session, I am swapping the protocol (URLProtocol). That's a technique a use a lot, including interfaces with delegates. 

On the app itself, as explained before, I've used Viper. In most of my apps, especially for simpler ones, and ones developed in teams with various levels of seniority, I usually go MMVM, because it is simpler. But this time I choose Viper instead. for the internal communication, I'm using Combine. I have more experience with RXSwift, but I do believe combine is the future. 

Specifically, we have Views (SwiftUI, most of them, following SwiftUI perspective, atomized), Interactors, Presenters, Entities, and Routers. And then we have some dependencies. Perhaps the most important is the repo layer (API Client) that abstracts the data source. Here we have just a network layer, but it would be easy to add a persistent layer too. The layer exposes models, that are consumed by the rest of the app, and sometimes (like in `MovieListPresenter`) mapped to a different model required by the view itself. I used this technique when I need to stitch together a few different sources. The idea is, basically, that the view receives only one type of data (the model) and emits effects. That way is easier to reason about the flow and to debug. 

The interactors are basically PONSOs, not a lot to say about them. 

In the routers, I'm producing the required links to navigates to details. 

The presenters are also in charge of producing the controls to toggle the sources. 

Regarding the view, a neat one would be the remote image view. 

Unfortunately, the URL composed with the videos keys is not embeddable. I have to investigate a little further to embed that in a `AVPlayer` (to my surprise, SwiftUI player view is quite good, and linked with AVKit)

# SRP
The Single-responsibility principle states that every object in a program is responsible for a portion of the code, encapsulating it. By adhering to such convention, objects tend to get slimmer, and they are usually easier to work with and test. The Single Responsibility Principle is closely related to the concepts of coupling and cohesion.  Coupling refers to how inextricably linked different aspects of an application are, while cohesion refers to how closely related the contents of a particular class or package may be. It also stands as the S for the famous mnemonic acronym **SOLID**

* Single-responsibility principle: "There should never be more than one reason for a class to change." In other words, every class should have only one responsibility.
* Open–closed principle: "Software entities ... should be open for extension, but closed for modification."
* Liskov substitution principle: "Functions that use pointers or references to base classes must be able to use objects of derived classes without knowing it." See also design by contract.
* Interface segregation principle: "Many client-specific interfaces are better than one general-purpose interface."
* Dependency inversion principle: "Depend upon abstractions, [not] concretions."

The introduction of Protocol Oriented Programming (see, for instance the definition of interactors as protocols) helps Swift achieve solid status. 
