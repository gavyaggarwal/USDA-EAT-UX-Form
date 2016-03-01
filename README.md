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
    - [Submission Preview](#submission-preview)
    - [Translation Support](#translation-support)
    - [Accessibility Support](#accessibility-support)
    - [Cross-Platform Compatibility](#cross-platform-compatibility)
- [Development](#development)
  - [Running the Application](#running-the-application)
  - [Editing the Application](#editing-the-application)
- [Testing](#testing)
  - [Usability Testing](#usability-testing)
    - [Testing Process](#testing-process)
    - [Mobile Support](#mobile-support)
    - [Helpful Links](#helpful-links)
    - [Eligibility Panel](#eligibility-panel)
    - [Tooltips](#tooltips)
    - [Time Optimization](#time-optimization)
    - [Panel Layout](#panel-layout)
  - [Performance Testing](#performance-testing)
    - [Network Performance](#network-performance)
    - [CPU/Memory Performance](#cpumemory-performance)
  - [Compatibility Testing](#compatibility-testing)
  - [Correctness Testing](#correctness-testing)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

*****

### Design

Our design includes a public user-facing interface for parents and guardians to apply for reduced school lunches as well as a password protected school-facing interface for school administrators to view and download the submitted applications.

#### Online Access

For testing purposes we have set up a server, and you can view our form online here:
* [Application Form for Parents/Guardians](http://reducedlunch.tk)
* [Administrator Portal for School Districts](http://reducedlunch.tk/schools)
    * Username: **USDA**
    * Password: **Demo**

#### Features

We have really focused on providing users an easy, intuitive experience by providing features such as a minimalist interface, helpful animations, form validation, guidance tooltips, autocomplete, easy navigation flow, submission preview, translation support, accessibility support, and cross-platform compatibility.

##### Minimalist Interface

When users arrive to our form, they are greeted by a simple yet powerful interface that displays the relevant information front and center in a crisp, readable font with brightly colored buttons that are easily clickable. A thin, unobstructive header indicates that the form is for the reduced school lunch program and contains a progress bar, and a footer contains relevant links, leaving most of the screen for what the user is here for: filling out the form. We avoid using unnecessary images, which tend to be distracting and remove focus from the form elements. Instead, we pull off a modern look and feel by adopting a bicolor theme and lots of subtle elements such as shadows and font effects.

##### Helpful Animations

Sleek animations augment our minimalist interface by increasing user experience. Moving the cursor over clickable buttons cause them to light up and appear "deeper", informing users that they can click there. Activating a text field causes it to change color and retains a text label so that users know where they are typing and what the field is asking for. Having horizontally sliding panels leads to the illusion that progress is being made quickly and the form is going by fast.

##### Form Validation

Before allowing users to continue to different sections of the form, we ensure that the information they enter is valid. We do this in a nonintrusive manner that doesn't overwhelm the user with a bunch of red "invalid entries" messages. Instead, we wait for users to enter text and only highlight it as invalid when they have entered something that is incorrect. When users try to continue, but have a mistake in their form, we highlight that mistake and scroll directly to the textfield with that mistake, so they can resolve it and continue instead of having to guess what's wrong.

##### Guidance Tooltips

Our application uses many guidance tooltips to provide additional definitions, clarifications, and advice to users filling out the form. Whenever the user gets to a section that we think is potentially confusing, we display a small tooltip in the top right of the screen with a helpful message. When they move on to another section, the tooltip disappears so the form doesn't get cluttered. What sets our tooltips apart is the fact that they are contextually aware. For example, when the user arrives at the field to enter their address, we automatically display a reassuring message that their address is not required or if a user is about to click a checkbox, we'll show a definition of what the checkbox means. This is significantly better than the standard approach which requires the user to hover over certain text in which they need to go out of their way to access the tooltip while our method guarantees that they see it, making the contained information essentially unavoidable.

##### Contact Autocomplete

We configured our form to work with the autocomplete feature on many browsers, allowing browsers to automatically fill out some form fields, saving users' time and making their job easier.

##### Easy Navigation Flow

We have made it very easy for users to navigate through our form and go back to change things. We accomplished this by using a robust data model that is very flexible and allows us to replace information already collected and dynamically change the path of the flow being taken. As a result, users can go back at any time and easily change any of the information they entered. Additionally, a progress bar at the top of the form indicates what portion of the form is left and gives users an idea of what more to expect. Also, another small, but helpful feature in our navigation is the ability to use not only the buttons on the form to navigate, but also the back buttons on their browsers. This prevents situations in which users mistakenly click the back button and lose progress on the form.

##### Submission Preview

We have provided a nice way to see all the information entered in the form before submitting it. This not only allows parents to verify what they've entered before submitting the form, but also a way to see what provided information school districts will be reviewing. Upon submission of the form, they can download this information as a printable PDF for their records.

##### Translation Support

We are aware that English isn't the primary language for a significant portion of families applying for reduced school lunches. Thus, we designed our website to support multiple languages. Since most non-english speakers have translation plugins installed on their browsers to translate websites realtime, we tested our form with many of these commercial tools to ensure that it works in languages such as Spanish.

##### Accessibility Support

We made our form user friendly for people with disabilities by adhering to accessibility standards and maintaining compatibility with accessibility tools found on commercial computers. We maintained a high contrast ratio in the colors we used so that people with poor vision can still use our form. We also configured the UI elements so that they work with switch control, an alternative input method for those that can't operate keyboards and mice.

##### Cross-Platform Compatibility

We made sure our form works on many browsers, many operating-systems, on desktops, on laptops, on tablets, on smart phones. See the [Compatibility Testing](#compatibility-testing) portion of this document for more info on how we accomplished that.

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

*****

### Testing

In order to create the best form that we can, we conducted various types of testing and used the results from our testing to improve the design, efficiency, and compatibility of our reduced lunch school application form.

#### Usability Testing

We conducted extensive usability testing ourselves and received feedback from over 50 people. We took their feedback to heart and tailored our app to suit the average American applying for reduced school lunches. Most of our usability testing consisted of 6 targeted rounds of tests in which we asked 3 people (different people each time) to step through the progression of our form and highlight areas they felt could be better. We looked for areas that spurred confusion, hesitation, unease, boredom, exasperation -- you get the idea. Based on feedback from each round, we made appropriate changes to our website and focused on these areas in our interviews in subsequent rounds. We repeated the process until we reached a product that we and our users had no complaints about. Here are some of the highlights of the changes we made to improve our user experience.

##### Testing Process
We watched as the individual filled out the form, timing how long they spent on each panel, noting what definitions/clarifications they needed the most and which ones they didn’t need, how often they regressed in the application progress, and any mistakes that were made. Following the application submission, we asked them if there was anything notable that they wished had been different, among a few other questions that helped us better understand their experience.

##### Mobile Support
When we analyzed the traffic from our testing group, we saw that over a quarter of users used mobile devices even though we instructed them to use a desktop browser. The trend is no different in the real world. Consumer reports have shown that for the past few years, internet usage has been dramatically shifting in favor of mobile devices like smart phones and tablets. In low income households, this effect is even more pronounced. We respected this trend and took steps to make our form compatible with mobile devices by overhauling the entire user interface. Instead of small, hard-to-click links, we used large clickable buttons that could be easily pressed from a touchscreen. We made our design responsive so that our UI elements automatically adjust to the smaller width of mobile screens.

##### Helpful Links
We provided our testers with a URL, a brief introduction, gratitude in the form of candy to thank them for their time, and not much else. For most, it was either the first time that they had even heard of the program or they knew little to nothing about it. Suffice to say, they had a lot of questions about the program itself. We realized a lot of users would be in the same boat. So to ensure that they stayed well informed, we decided to include informative links at the bottom of our website.

##### Eligibility Panel
We wanted to introduce our applicants to the eligibility categories in the first panel by having them choose what category they believe they fall under. We subtly informed users of the “Why?” behind different sections of the form, like income and assistance program participation -- making them more likely to answer correctly, realizing the stakes. Feedback on this addition was incredibly positive and users said that familiarization with the categories early on helped them fill out the remainder of the form with confidence.

##### Tooltips
A majority of the assistance and clarification provided by our form comes in the form of tooltips. Originally, we had designed the tooltips to appear after the user hovers over a tooltip icon. As we watched users interact with our website, we realized they often chose not to expend the energy to move the mouse over to the icons if they thought they knew what they were doing. We wanted to prevent unintentional reporting errors by making the tooltips unavoidable. If the user wants to fill out a field and they enter it or mouse-over it, the tooltip will automatically show up and provide the user with helpful tips, suggestions, and definitions. Furthermore, we elected to employ tooltips in place of utilizing in line text on the page since the additional animation would garner the users attention, forcing them to read the definition and stay informed.

##### Time Optimization
One of the most informative aspects of our testing process was timing our users as they completed the form. We focused on the net time it took to submit the application, as well as the individual amount of time spent on each panel. We stratified our data into two groups: those who had to fill out income information and those who didn't, since one is more time consuming. We found that people spent more time on pages that had graphics. While we had initially incorporated images into our design for aesthetics, it was proving to be counterproductive as they distracted our users, without offering any useful attributes. As a result, we transformed our design into a minimalist aesthetic so users could focus their attention on the clearly presented essentials.

##### Panel Layout
We found that people were always in a hurry to get to the next step, progress, and finish the application. But large panels with several input fields made it seem like an impossible task for them. So we split up the application into several panels that were short and sweet. Users felt more satisfied filling out 6 fields spread over 3 panels instead of filling out 6 fields on one panel. We also used horizontally sliding panels because users felt they appeared to be moving faster than vertically sliding panels. By making the form seem less tedious, we ended up with happier users that exited the process feeling more positive about the application.

These were just a few of the major alterations we made to our product. There were smaller changes that stemmed from user testing. Based on feedback, we fixed wording that was confusing, added definitions for clarification, changed UI elements to make the experience more intuitive, added the ability to download a readable version of the application for the user’s records, and more.

#### Performance Testing

We expect millions of users to access this form every year, so we collected various metrics for our form so that it can function using a minimal amount of resources.

##### Network Performance

One area we really focused on includes network performance. We measured the size of the initial prototype of our application using Google Chrome's Developer Tools and using our form several times. During these tests, we monitored the size of the files outputted from our server and calculated the average data transfer required for the form. This little experiment showed that for the average user, 493 kB of data needs to be loaded for our form. We decided this was not good enough for the following reasons:

* **Slow Load Times:** Loading that much data would lead to slow loading times, especially for families that don't have access to reliable broadband connections. Using public wifi connections or cell phone wifi hotspots typically have poor latency, and could potentially lead to loading times of up to 30 seconds, which is unacceptable in today's world and would deter many eligible families from completing the form.
* **Increased Server Load:** Assuming that the USDA used our prototype and a similar number of people would apply for reduced school lunches as previous years, the USDA's web servers would need to serve 5 TB of data annually. If there was a tenfold increase in the number of people applying because of an online form, that would mean 50 TB of annual data transfer. This data transfer comes at a huge cost, both financially and in reliability. In monetary terms, the USDA would need to buy more powerful servers and spend more to maintain them. In terms of reliability, transferring more data would put larger loads on the servers, and the form could go down under heavy usage.

In order to tackle the issue, we tried various approaches, but the following techniques were most successful.

* **Compression:** We compressed everything. We took our HTML document layout and removed all the formatting and whitespace so that the file size was minimal, and only data remained. We "compiled" all our Javascript so that we could squeeze the logic of our program into as few lines as possible. We reduced the size of our static assets (images, etc.) by using standard compression algorithms found in common image formats such as png, jpg, and gif.
* **Preloading:** Instead of waiting to load each resource that our program needs to display it, we decided to rewrite our logic to preload everything in the background at once. This reduces the overhead of needing to send multiple requests and waiting on multiple resources, and it minimizes the consequences of poor latency. Instead, everything simply loads at once, and when the user needs to go to a new panel or go back a page, it happens instantaneously.
* **Use of CDNs:** The use of content delivery networks, a globally distributed network of proxy servers hosted by companies such as Google, allow the open source libraries that we use to be downloaded from external servers that are configured to provide maximum speed and minimal latency. As a result, the application is loaded simultaneously from both our servers and CDNs, eliminating the bottleneck of a user's connection speed to our server. The cherry on top is that most websites on the internet also use CDNs to load their libraries, so in most cases, these libraries are already cached on users' computers and no time is wasted loading them.

After making all these optimizations, the final version of our reduced school lunch form uses an astonishingly low 2.9 kB of data, a whopping **99.4% reduction** in the amount of data originally required to load our form.

##### CPU/Memory Performance

Getting our program to load quickly is just part of the battle. Not everybody owns blazing fast state-of-the-art computers, and we spent a lot of time and effort in crafting a form that provides a robust user experience while still performing well on older, slower computers with limited processors and RAM. Our original prototype featured beautiful animations and functionality that could bring older computers to a halt. We have labored to tweak those animations and functionality so that it has a limited resource footprint that can work on any computer without any freezes or slowdowns.

In our original tests, we focused on two major metrics:

1. The time our code spent rendering elements for our form
2. The frame rate of animations

Our results showed that for our two (relatively new) testing devices, 1509 milliseconds were spent rendering elements while filling out the form. On older computers, this value could be up to 5 seconds. During this time, the form is partially unresponsive and heavy CPU activity occurs, which may cause users to abandon the form. We also observed that during animations, the frame rate of our form could drop down to 9 frames per second, a number characteristic of visual stuttering. We aim to keep this value at 60Hz, the standard for websites with animations.

To resolve the issues on this front, we implemented the following strategies.

* **GPU Powered Animations:** Typically, web animations are performed using the CPU (Central Processing Unit, used for general processing). We used the new CSS3 web standards which perform animations using the GPU (Graphics Processing Unit), a chip found in most computers specialized for graphics related processing. This results in buttery smooth animations and leaves the CPU free to do other tasks required by the form.
* **Reduced DOM Queries:** When we want to dynamically change the contents of our page, we use a library called jQuery, which searches for elements on the page and allows us to perform actions on them. When searching for elements, the DOM (document object model), an internal data structure that represents every element on the page is queried for the element we are looking for. Since the DOM is very large (due to the sheer number of elements on the page), querying the DOM is computationally expensive, and we reduced the number of times we queried the DOM by saving our results from previous queries.

Ultimately, we saw a significant improvement after making the above changes. The time spent on rendering dropped to 412 milliseconds, a **73% reduction**. The frame rate was able to consistently stay above 56 frames per second, an **increase of over 500%**.

#### Compatibility Testing

We want our form to work with a variety of browsers and conducted sufficient testing to ensure that our form is compatible with all the commonly used browsers and operating systems.

We accomplished this by using our form on Safari, Firefox, Google Chrome, and Internet Explorer and resolving minor inconsistencies in functionality and appearance (such as different spacing, unequal text parsing) so that the form experience is consistent regardless of browser.

We did the same for operating systems, running Mac OS X, Windows, and Ubuntu in a virtual machine and with every combination of browsers and testing whether the form appeared and functioned as expected.

One of the key steps in achieving this compatibility included rewriting a large portion of our CSS code to use browser-specific prefixes to enable certain styling features in all browsers.

We also worked to improve the mobile browser experience. While our form is designed for desktop interfaces, we have seen the recent trends of people relying more and more on their mobile devices, so we conducted testing on the iOS and Android mobile operating systems to ensure that the form also works as expected on those devices.

Finally, we have strived to make our form as future-proof as possible. Thus, we incorporated the latest web standards such as HTML5 and CSS3 so that the technology that our form uses will be here to stay, and nobody needs to worry about it growing obsolete anytime soon.

So whether somebody uses their laptop, a public library computer, their smartphone, or some new device invented 10 years from now, they'd still be able to apply for reduced lunch.

#### Correctness Testing

Building our application was the easy part. Testing for bugs after was much harder. We tackled this issue by creating several test cases for different form use case scenarios. In our [test_cases.coffee](public_html/coffee/test_case.coffee) file, we have defined the following test cases:

* The parent fills out the form but leaves out the optional contact information.
* All students fall under the foster/runaway/migrant category.
* A household has multiple amount of children.
* A household has multiple adult household members.
* A family participates in a Federal Assistance Program.
* Nobody in the household has a social security number.
* The parent answers the optional racial and ethnicity questions.

For each of these scenarios, we conducted tests on the front-end and back-end.

On the front-end side, we filled out the form many times and ensured that our conditional logic worked. Here are some of the many things that we checked for:

* If the user leaves an optional field blank, the form validation allows him/her to continue to the next section.
* If all students are foster/runaway/migrant, the user skips forward and doesn't have to enter any financial information. Conversely, if some but not all students are foster/runaway/migrant, financial information is requested.
* If there are multiple children, the form easily allows addition and removal of these children. Then, income information is requested for each child. Also, since there must be at least one child, ensure that the user has filled out information for at least one child.
* If there are multiple household members, they can be added and removed, and users can enter income information for multiple adults.
* If the family participates in an assistance program, ensure that a textfield appears so they can input their case number when they mark the "Yes" option. Also, ensure that if they enter in the wrong thing, they can go back and change it.
* If nobody has a social security number, allow the form to still be submitted. If somebody does have a social security number, ask for the name and the last 4 digits.

In addition to this thorough qualitative testing, we also performed more quantitative studies. In addition to the  interface of our form that end users see, we have an internal data model that stores all the data collected from the form in a format computers can easily process. We tested that it was operating in sync with the user interface by entering data in the form corresponding to the 7 test cases described above. Then, we extracted the contents of our data model and performed comparisons between the actual and expected values. Our results showed no disparities and that our form and data model were working properly.

Likewise, we followed a similar procedure for backend testing. We took the 7 test cases and pumped them into our PDF generation algorithm to assert that the PDFs being created are accurate. We were able to verify all the PDFs, indicating that the form is being saved correctly and being sent to school districts without anything missing.

These correctness tests that we conducted ensure that we are following the guidelines set forth by the USDA and that we properly collect and store information on the required criteria.
