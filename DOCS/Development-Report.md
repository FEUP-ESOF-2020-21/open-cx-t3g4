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

![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/UseCaseDiagram.png)



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
   

**Log Out:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can log out.
* **Preconditions and Postconditions**: In order to logout, the participant must first login into the application.

* **Normal Flow**: 
   * The Participant writes the correct email and password;
   * The Participant logs in;
   * The Participant selects the "Logout" text in the right corner of the top of the main menu page;
   

**See Available Conferences**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can see the available conferences.
* **Preconditions and Postconditions**: In order to see the available conferences, the Participant must first login into the application.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the See Available Conferences button in the main menu page;
 
 
 
 **Create a Conference Room to Talk about a Topic:**

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can create a conference room.
* **Preconditions and Postconditions**: In order to create a conference room, the Speaker must first login into the application and create one.

* **Normal Flow**: 
   * The Speaker logs in;
   * The Speaker selects the Create Meeting button in the main menu page;
   * The Speaker writes the name and subject of the Conference and selects 5 topics he thinks the participants are interested in.
   
   

**Participate in Conferences**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can participate in the available conferences.
* **Preconditions and Postconditions**: In order to see the available conferences, the Participant must first login into the application.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the See Available Conferences button in the main menu page;
   * The Participant chooses a conference that is in the available conferences list;
   * The Participant chooses 3 of the 5 topics os interest provided by the Speake;
   * The Participant selects the "Join Meeting" button.
   
   
   
**Choose Topics of Interest:**

* **Actor**: Participant
* **Description**: This use case exists so that the user can choose topics of interest.
* **Preconditions and Postconditions**: In order to choose the topics of interest, the Participant must first login into the application and join a meeting. Then he must choose 3 of the 5 topics of interest provided by the Speaker.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the See Available Conferences button;
   * The Participant joins in a Conference;
   * The Participant chooses 3 of the 5 topics os interest provided by the Speaker;
   
   
   
 **Participate in Voice Chats of the Topics of Interest:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can participate in voice chats of the topics of interest.
* **Preconditions and Postconditions**: In order to participate in voice chats, the participant must first login into the application, join a meeting, select 3 of the 5 topics he is interested in and wait till the end of the conference or exit it.

* **Normal Flow**: 

  * The Participant logs in;
  * The Participant selects the See Available Conferences button;
  * The Participant joins in a Conference;
  * The Participant chooses 3 of the 5 topics os interest provided by the Speaker;
  * The Participant selects the "Join Meeting" button;
  * The Participant wait for the conference to end or exits the conference;
  * The Participant selects the chat room with the topic he is interested in.
  
  

**Ask a Question to Speaker:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can ask questions to the Speaker during the conference.
* **Preconditions and Postconditions**: In order to ask a question to the Speaker, the Participant must first login into the application and join the conference that is occuring. Then, the question must be written in the conference chat and it will be uploaded.

* **Normal Flow**: 
   * The Participant logs in;
   * The Participant selects the See Available Conferences button;
   * The Participant joins in a Conference;
   * The Participant selects the chat balloon icon;
   * The Participant sends a question in the chat.
   

   
 **Visualize and Answer Questions:**

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can visualize and answer the  questions asked during the conference.
* **Preconditions and Postconditions**: In order to visualize and answer the questions, the Speaker must first login into the application and create a conference room. Then the questions will be displayed in the Conference chat.

* **Normal Flow**: 
   * The Speaker logs in;
   * The Speaker selects the Create Meeting button;
   * The Speaker chooses the name of the Conference and selects 5 topics he thinks the participants are interested in.
   * The Speaker selects the chat balloon icon;
   * The Speaker can see the questions in the chat and answer them.
   

**Send Direct Messages to Other Users:**

* **Actor**: Participant
* **Description**: This use case exists so that the participant can send direct messages to other users in the voie chats.
* **Preconditions and Postconditions**: In order to send direct messages to other users in the voice chats, the participant must first login into the application, join a meeting, select 3 of the 5 topics he is interested in, wait till the end of the conference or exit it, and join in one of the available chat rooms that are displayed

* **Normal Flow**: 
  * The Participant logs in;
  * The Participant selects the See Available Conferences button;
  * The Participant joins in a Conference;
  * The Participant chooses 3 of the 5 topics os interest provided by the Speaker;
  * The Participant selects the "Join Meeting" button;
  * The Participant wait for the conference to end or exits the conference;
  * The Participant selects the chat room with the topic he is interested in.
  * The Participant selects the chat balloon icon;
  * The Participant send direct messages in the chat to other users.
   

 
 
### User stories


**User Story Map:**
![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/UserStoryMap.png)


As a participant:
* As a participant, I want to register my account, so that I can access the system;
* As a participant, I want to log in to my account, so that I can access the system;
* As a participant, I want to log out my account, so that I can terminate my session;
* As a participant, I want to choose chatrooms dedicated to my favorite topics, so that I can discuss about them;
* As a participant, I want to talk to another user through direct messages, so that I can discuss with him;
* As a participant, I want to choose tags related to the topics that I’m interested in, so that I can discuss about them;
* As a participant, I want to be able to ask questions to the speaker, so that I can expose my doubts;

* As a participant, I want to be able to ask questions to the speaker, so that I can expose my doubts;
* As a participant, I can request a password reminder, so that I can log in if I forget mine;
* As a participant, I want to edit my account, so that I can update my personal information;
* As a participant, I want to see the list of available conferences, so that I can choose one; 
* As a participant, I want to see my own time schedule, so that I can know what to attend;
* As a participant, I want to be able to talk when it’s my turn, so that I can give my point;
* As a participant, I want to hear other users one at a time, so that I can know their point;


As a speaker:
* As a speaker, I want to see the most interesting questions, so that I can answer it;
* As a speaker, I want to create a conference room, so that I can talk about a topic.


The User Stories, its interface mockups, acceptance tests and Value and Effort can be seen in [Here](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/projects/1)



### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts and relationships involved of the problem domain addressed by your module.

![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/PblDomain.png)

Our App concepts are easy to understand. 
* The class **Participant** represents the user, that may or may not be a Speaker. A Participant has a name and a password as attributes and he can watch as many conferences as he desires (one at a time).
* The **Conference** can be watched by an unlimited number of Participants and it has an associated ID. During the Conference, a Participant can ask all the **Questions** he wants to ask. 
* The Conference is previously created by the **Speaker**, who can create all the conferences he wants and select 5 **InterestTopics**, that he believes the Participants are interest in, before their beginning.
* The Participants can choose up to 3 Interest Topics provided by the Speaker when they join the Conference and the **Chat Rooms** with the most voted topics as themes will be created. The Participants can also join in an unlimited number os Chat Rooms (one at a time).
* The Chat Rooms can have an unlimited number of Participants and during those chat rooms they are able to talk through **Direct Messages**.



## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization.

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them.

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/LogicslArchit.png)

The high-level logical structure of our code can be represented in two main packages: the **Models** and the **Views and Controllers**.

The **Models** package is where the app's data information can be found, containing data related to the conferences, participants, chat rooms and their attributes. This data will be displayed in the **Views and Controllers** package.

The **Views and Controllers** package represents the concrete display of the app frames, widgets and data to the user that can be seen in the screen of the smartphone device, and also generates functionalities according to the actions executed by the user, updating the data in the **Models**.


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

The acceptance tests can be found in the description of each user story (under the mockups) in [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/projects/1)

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
