# openCX-LobbyJump Development Report

Welcome to the documentation pages of the LobbyJump of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP):

* Business modeling
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

Diogo Filipe Martins
Lara Médicis
Mariana Soares
Mário Sousa
Pedro Vale

---

## Product Vision

Traditional conference meetings have promoted social interaction outside of oficial events for many years, and why not bring that to the digital world, where the concept of social media is already so heavily ingrained? Lobby Jump’s goal is to provide an informal digital space where conference participants are able to form ties in chatrooms especially dedicated to their favourite topics, encouraging relationships just as strong as the ones we build face to face.

---
## Elevator Pitch

In this day and age, social interaction is arguably one of the most important and influential aspects of the digital world, so it's astonishing how little informal discussion is encouraged in existing virtual conference platforms. At Lobby Jump, our goal is to bring people together during those tedious moments between sessions, promoting discussions beyond the scope of the conference to provide a fully immersive digital conference experience. 


---
## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram

Create a use-case diagram in UML with all high-level use cases possibly addressed by your module.

Give each use case a concise, results-oriented name. Use cases should reflect the tasks the user needs to be able to accomplish using the system. Include an action verb and a noun.

Briefly describe each use case mentioning the following:

* **Actor**. Name only the actor that will be initiating this use case, i.e. a person or other entity external to the software system being specified who interacts with the system and performs use cases to accomplish tasks.
* **Description**. Provide a brief description of the reason for and outcome of this use case, or a high-level description of the sequence of actions and the outcome of executing the use case.
* **Preconditions and Postconditions**. Include any activities that must take place, or any conditions that must be true, before the use case can be started (preconditions). Describe also the state of the system at the conclusion of the use case execution (postconditions).

* **Normal Flow**. Provide a detailed description of the user actions and system responses that will take place during execution of the use case under normal, expected conditions. This dialog sequence will ultimately lead to accomplishing the goal stated in the use case name and description. This is best done as a numbered list of actions performed by the actor, alternating with responses provided by the system.
* **Alternative Flows and Exceptions**. Document other, legitimate usage scenarios that can take place within this use case, stating any differences in the sequence of steps that take place. In addition, describe any anticipated error conditions that could occur during execution of the use case, and define how the system is to respond to those conditions.

![Alt Text](https://media.discordapp.net/attachments/757916505068404796/779361541602279424/Diagrama_em_branco.png?width=856&height=935)


**Register/ Login:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can register or login.
* **Preconditions and Postconditions**: In order to login, the participant needs to be registered and write the correct username and password. In order to register, the participant needs to register with a valid email, username and password.

* **Normal Flow**: 
   * **Login**
   * The Participant writes the correct email and password;
   * The Participant logs in;
   * **OR**
   * **Register**
   * The Participant writes a valid email and password;
   * The Participant logs in;
 
* **Alternative Flows and Exceptions**:
   * **Login**
   * The Participant writes the wrong password while loging in;
   * The Participant can't log in;
   * **OR**
   * **Register**
   * The Participant writes an invalid email trying to register;
   * The Participant is not registered;
   
   
   
**Create a Conference Room to Talk about a Topic:**

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can create a conference room.
* **Preconditions and Postconditions**: In order to create a conference room, the Speaker must first login into the application and create one.

* **Normal Flow**: 
   * The Speaker logs in;
   * The Speaker selects the Create Meeting button;
   * The Speaker chooses the name of the Conference and selects 5 topics he thinks the participants are interested in.
   
   
   
   
 **Choose Topics of Interest:**

* **Actor**: Participant
* **Description**: This use case exists so that the user can choose topics of interest.
* **Preconditions and Postconditions**: In order to choose the topics of interest, the Participant must first login into the application and join a meeting. Then he must choose 3 of the 5 topics of interest provided by the Speaker.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the join meeting button;
   * The Participant chooses 3 of the 5 topics os interest provided by the Speaker;
   
   
   
 **Participate in Voice Chats of the Topics of Interest:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can participate in voice chats of the topics of interest.
* **Preconditions and Postconditions**: In order to participate in voice chats, the participant must first login into the application, join a meeting, select 3 of the 5 topics he is interested in and wait till the end of the conference.

* **Normal Flow**: 
  * The Participant logs in;
  * The Participant selects the join chat room button;
  * The Participant selects the Chat Room he is interested in.
  * **OR**
  * The Participant logs in;
  * The Participant selects the join meeting button;
  * The Participant chooses 3 of the 5 topics os interest provided by the Speaker;
  * The Participant wait for the conference to end;
  * The Participant selects the join char room button in the main menu;
  * The Participant selects the chat room with the topics he voted in the beginning of the conference (if it is available).
  
  

**Ask a Question to Speaker:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can ask questions to the Speaker during the conference.
* **Preconditions and Postconditions**: In order to ask a question to the Speaker, the Participant must first login into the application and join the conference that is occuring. Then, the question must be written in the conference chat and it will be uploaded.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the Join Meeting button;
   * The Participant writes the Conference ID;
   * The Participant sends a question in the chat.
 
* **Alternative Flows and Exceptions**:
   * The Participant logs in;
   * The Participant selects the Join Meeting button;
   * The Participant writes a wrong Conference ID;
   * That Participant doesn't join the Conference.
   
   
 
 **Vote in the Most Interesting Questions:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can vote in the most interesting questions asked during the conference so they are answered with priority.
* **Preconditions and Postconditions**: In order to vote in a question, the Participant must first login into the application and select the conference that is occuring in the schedule. Then, a list with questions will be displayed in the conference page.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the time schedule icon;
   * The Participant selects the Conference that is occuring;
   * The Participant selects the underlined word "Vote" that is next to the desired question.

 

   
 **Visualize and Answer the Most Voted Questions:**

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can visualize and answer the most voted (or all) questions asked during the conference.
* **Preconditions and Postconditions**: In order to visualize and answer the questions, the Speaker must first login into the application and create a conference room. Then the questions will be displayed in the Conference chat.

* **Normal Flow**: 
   * The Speaker logs in;
   * The Speaker creates a Conference;
   * The Speaker can see the questions in the chat and answer them.

* **Alternative Flows and Exceptions**:
   * The Speaker logs in;
   * The Speaker joins a Conference that was not created by him;
   * The Speaker is only allowed to watch the conference as a participant so he can't answer the questions.
 
 
 
### User stories

As a user (participant or speaker):
* As a user, I want to register my account, so that I can access the system;
* As a user, I want to log in to my account, so that I can access the system;
* As a user, I want to log out my account, so that I can terminate my session;
* As a user, I can request a password reminder, so that I can log in if I forget mine;
* As a user, I want to edit my account, so that I can update my personal information;
* As a user, I want to see the list of available conferences, so that I can choose one; 
* As a user, I want to choose chatrooms dedicated to my favorite topics, so that I can discuss about them;
* As a user, I want to see my own time schedule, so that I can know what to attend;
* As a user, I want to talk to another user through direct messages, so that I can discuss with him;
* As a user, I want to choose tags related to the topics that I’m interested in, so that I can discuss about them;
* As a user, I want to be able to talk when it’s my turn, so that I can give my point;
* As a user, I want to hear other users one at a time, so that I can know their point;

As a participant:
* As a participant, I want to be able to ask questions to the speaker, so that I can expose my doubts;
* As a participant, I want to vote on the most interesting questions, so that they can be answered;

As a speaker:
* As a speaker, I want to see the most interesting questions, so that I can answer it;
* As a speaker, I want to create a conference room, so that I can talk about a topic.


**INVEST in good user stories**.
You may add more details after, but the shorter and complete, the better. In order to decide if the user story is good, please follow the [INVEST guidelines](https://xp123.com/articles/invest-in-good-stories-and-smart-tasks/).

**User interface mockups**.
[App Mockups](https://xd.adobe.com/view/3a8c6e96-b688-49b7-b6e0-85f1fcdcfaf6-6fdf/) In Progress

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in Gherkin), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).

### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/Problem%20Domain.png)

Our App concepts are easy to understand. The class **Participant** represents the user, that may or may not be a Speaker. A Participant can send a direct message to other user, which is represented by its connection with the class **DirectMessage**. 
The Participant is also connected to the class **Questions**, being that this connection expresses the possibility that each user has to ask questions during the conference where it can be chosen to be answered, and to the class **Conference**, that is related to the participation in the conference. 



## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization.

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them.

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/Untitled%20Diagram%20-%20cópia.png)

The high-level logical structure of our code has a Model-View-Controller software design pattern.

The Model package is where the app's data information can be found, containing data related to the user and the topics of interest, conferences and questions asked during them, chat rooms and direct messages. This data will be displayed in the View.

The View package represents the concrete display of the app frames, widgets and data to the user that can be seen in the screen of the smartphone device.

The Controller generates functionalities according to the actions executed by the user, sending and updating the data to display in the View and updating the data in the Model.


### Physical architecture
![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/PhysicalArch.png)

The high-level physical structure of Lobby Jump can be represented in two main blocks that are connected with each other. Therefore, the users can install Lobby Jump on their smartphone devices and everytime it is necessary the app connects to the database via HTTPS requests where all the needed information is allocated. 

In this project, we used Flutter, for the framework for the mobile application, and Firebase, for the database, being that it has a simple integration with Flutter.


### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation

A few aspects of the code and the regular product increments can be found [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/releases)

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.

A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

Our team adopted the following project management tool:

  * [Github Projects](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/projects/1)



---

## Evolution - contributions to open-cx

Describe your contribution to open-cx (iteration 5), linking to the appropriate pull requests, issues, documentation.
