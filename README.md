# USDA Reduced Lunch Online Form Design
### Gavy Aggarwal & Abirami Kurinchi-Vendhan

*****

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
** Table of Contents **

- [Design](#design)
  - [Online Access](#online-access)
  - [Features](#features)
    - [Minimalist Interface](#minimalist-interface)
    - [Helpful Animations](#helpful-animations)
    - [Form Validation](#form-validation)
    - [Guidance Tooltips](#guidance-tooltips)
    - [Contact Autocomplete](#contact-autocomplete)
    - [Easy Navigation Flow](#easy-navigation-flow)
- [Development](#development)
  - [Running the Application](#running-the-application)
  - [Editing the Application](#editing-the-application)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

*****

### Design

Our design includes a public user-facing interface for parents and guardians to apply for reduced school lunches as well as a password protected school-facing interface for school administrators to view and download the submitted applications.

#### Online Access

For testing purposes we have set up a server, and you can view our form online:
* [Application Form for Parents/Guardians](http://reducedlunch.tk)
* [Administrator Portal for School Districts](http://reducedlunch.tk/schools)
    * Username: **USDA**
    * Password: **Demo**

#### Features

We have really focused on providing users an easy, intuitive experience by providing features such as a minimalist interface, helpful animations, form validation, guidance tooltips, autocomplete, easy navigation flow, submission preview, translation support, and accessibility compatibility.

##### Minimalist Interface

When users our form, they are greeted by a simple yet powerful interface that displays the relevant information front and center in a crisp, readable font and brightly colored buttons that are easily clickable. A thin, unobstructive header indicates that the form is for the reduced school lunch program and contains a progress bar, and a footer contains relevant links, leaving most of the screen for what the user is here for: filling out the form. We avoid using unnecessary images, which tend to be distracting and remove focus from the form elements. Instead, we pull off a modern look and feel by adopting a bicolor theme and lots of subtle elements such as shadows and font effects.

##### Helpful Animations

Sleek animations augment our minimalist interface by increasing user experience. Moving the cursor over clickable buttons cause them to light up and appear "deeper", informing users that they can click there. Activating a text field causes it to change color and retains a text label so that users know where they are typing and what the field is asking for. Having horizontally sliding panels leads to the illusion that progress is being made quickly and the form is going by fast.

##### Form Validation

Before allowing users to continue to different sections of the form, we ensure that the information they enter is valid. We do this in a nonintrusive manner that doesn't overwhelm the user with a bunch of red "invalid entries" messages. Instead, we wait for users to enter text and only highlight it as invalid when they have entered something that is incorrect. When users try to continue, but have a mistake in their form, we highlight that mistake and scroll directly to the textfield with that mistake, so they can resolve it and continue instead of having to guess what's wrong.

##### Guidance Tooltips

Our application uses many guidance tooltips to provide additional definitions, clarifications, and advice to users filling out the form. Whenever the user gets to a section that we think is potentially confusing, we display a small tooltip in the top right of the screen with a helpful message. When they move on to another section, the tooltip disappears so the form doesn't get cluttered. What sets our tooltips apart is the fact that they are contextually aware. For example, when the user arrives at the field to enter their address, we automatically display a reassuring message that their address is not required or if a user is about to click a checkbox, we'll show a definition of what the checkbox means. This is significantly better than the standard approach which requires the user to hover over certain text in which they need to go out of their way to access the tooltip while our method guarantees that they see it.

##### Contact Autocomplete

We configured our form to work with the autocomplete feature on many browsers, allowing browsers to automatically fill out some form fields, saving users' time and making their job easier.

##### Easy Navigation Flow

We have made it very easy for users to navigate through our form and go back to change things. 

*****

### Development

Our form was written using CoffeeScript, Jade, and SASS. Our server uses node.js.

#### Running the Application

To run the server:
* Ensure the `npm` and `git` commands are installed on your computer.
* Download the source code using `git clone`
* Install dependencies using `npm install`
* Start the server using `npm start`

```
git clone https://github.com/gavyaggarwal/USDA-EAT-UX-Form
cd USDA-EAT-UX-Form
npm install
npm start
```

#### Editing the Application

All of our logic resides in the [main.coffee](public_html/coffee/main.coffee) and [app.coffee](coffee/app.coffee) files, and we have documented these two files thoroughly. To continue developing our application in Coffee, you can run the following two commands in separate terminal prompts to auto-compile the Coffee files into Javascript.

```
coffee –wc -o public_html/js/ public_html/coffee/*.coffee
coffee –wc -o ./ coffee/*.coffee
```

Since Coffee ultimately compiles to Javascript, it is also possible to develop this application by editing the [main.js](public_html/js/main.js) and [app.js](app.js) files. However, keep in mind that these files may be a bit messy since they were generated by a computer.

We also have two Jade files, which contain the markup of the page layout for our form ([index.jade](public_html/jade/index.jade)) and for the school district login page ([login.jade](public_html/jade/login.jade)). This code is pretty simple and self-documenting, but complex parts are explained in comments. The following command enables auto-compilation of Jade files for our project.

```
jade –wc -o public_html/ public_html/jade/*.jade
```

Similarly, Jade compiles to HTML, so the code can also be edited by directly changing the HTML of [index.html](public_html/index.jade) and [login.html](public_html/login.jade).

If you encounter any issues getting the project to run, please do not hesitate to contact us.
