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

In this day and age, social interaction if arguably one of the most important and influential aspects of the digital world, so it's astonishing how little informal discussion is encouraged in existing virtual conference platforms. At Lobby Jump, our goal is to bring people together during those tedious moments between sessions, promoting discussions beyond the scope of the conference to provide a fully immersive digital conference experience. 


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

Ask a Question to Speaker:

* **Actor**: Participant
* **Description**: This use case exists so that the participant can ask questions to the Speaker during the conference.
* **Preconditions and Postconditions**: In order to ask a question to the Speaker, the Participant must first login into the application and select the conference that is occuring in the schedule. Then, the question will be uploaded.

* **Normal Flow**: 
 *The Participant logs in;
 *The Participant selects the time schedule icon;
 *The Participant selects the Conference that is occuring;
 *The Participant inserts a question in the Question area.
 
* **Alternative Flows and Exceptions**:
 *The Participant logs in;
 *The Participant selects the time schedule icon;
 *The Participant selects a Conference that is not occuring;
 *That Conference will no be displayed.
 
 Vote in the Most Interesting Questions:

* **Actor**: Participant
* **Description**: This use case exists so that the participant can vote in the most interesting questions asked during the conference so they are answered with priority.
* **Preconditions and Postconditions**: In order to vote in a question, the Participant must first login into the application and select the conference that is occuring in the schedule. Then, a list with questions will be displayed in the conference page.

* **Normal Flow**: 
 *The Participant logs in;
 *The Participant selects the time schedule icon;
 *The Participant selects the Conference that is occuring;
 *The Participant selects the underlined word "Vote" that is next to the desired question.
 
 Register/ Login:

* **Actor**: User
* **Description**: This use case exists so that the user can register or login.
* **Preconditions and Postconditions**: In order to login, the user needs to be registered and write the correct username and password. In order to register, the user needs to register with a valid email, username and password.

* **Normal Flow**: 
 *The User logs in;
 **OR**
 *The User writes a valid email, username and password;
 *The User logs in;
 
* **Alternative Flows and Exceptions**:
 *The User writes the wrong password while loging in;
 *The User can't log in;
 **OR**
 *The User writes an invalid email or username trying to register;
 *The User is not registered;
 
 Participate in Voice Chats of the Topics of Interest:

* **Actor**: User
* **Description**: This use case exists so that the user can participate in voice chats of the topics of interest.
* **Preconditions and Postconditions**: In order to participate in voice chats, the Participant must first login into the application and select the Room with the topic he is interested in.

* **Normal Flow**: 
 *The User logs in;
 *The User selects the Room with the Topic of Interest;
 
 Choose Topics of Interest:

* **Actor**: User
* **Description**: This use case exists so that the user can choose topics of interest. He can do that by creating a chat room with those topics.
* **Preconditions and Postconditions**: In order to choose the topics of interest, the Participant must first login into the application and select the option to create a chat room.

* **Normal Flow**: 
 *The User logs in;
 *The User selects the option that is used to create a chat room;
 *The User writes the topics he is interested in;
 
 Visualize and Answer the Most Voted Questions:

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can visualize and answer the most voted (or all) questions asked during the conference.
* **Preconditions and Postconditions**: In order to visualize and answer the questions, the Speaker must first login into the application and create or join in the conference room that he previously created. Then the questions will be displayed in the Conference page.

* **Normal Flow**: 
 *The Speaker logs in;
 *The Speaker selects the time schedule icon;
 *The Speaker joins in a previously created conference room or creates one;
 *The Speaker can see the questions ordered by the number of votes and answer them.
 
* **Alternative Flows and Exceptions**:
 *The Speaker logs in;
 *The Speaker selects the time schedule icon;
 *The Speaker joins in a conference room that was not created by him;
 *The Speaker is only allowed to watch the conference as a participant so he can't talk and answer the questions.
 
 Create a Conference Room to Talk about a Topic:

* **Actor**: Speaker
* **Description**: This use case exists so that the speaker can create a conference room.
* **Preconditions and Postconditions**: In order to create a conference room, the Speaker must first login into the application and create one.

* **Normal Flow**: 
 *The Speaker logs in;
 *The Speaker selects the time schedule icon;
 *The Speaker selects the option to create a conference room;
 *The Speaker chooses the name of the Conference (that should be the name of the topic) and the time schedule.
 
 
 
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
Logical Archicture: ![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/Untitled%20Diagram%20-%20cópia.png)
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts;
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
![Alt Text](https://github.com/FEUP-ESOF-2020-21/open-cx-t3g4/blob/master/imagens/PhysicalArch.png)

The high-level physical structure of Lobby Jump can be represented in two main blocks that are connected with each other. Therefore, the users can install Lobby Jump on their smartphones and everytime it is necessary the app connects to the database via HTTPS requests where all the needed information is allocated. 

In this project, we used Flutter, for the framework for the mobile application, and Firebase, for the database, being that it has a simple integration with Flutter.


### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
Regular product increments are a good practice of product management.

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

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.


---

## Evolution - contributions to open-cx

Describe your contribution to open-cx (iteration 5), linking to the appropriate pull requests, issues, documentation.
