# RSLP Form Testing Conducted

In order to create the best form that we can, we conducted various types of testing and used the results from our testing to improve the design, efficiency, and compatibility of our reduced lunch school application form.

### Usability Testing

We conducted extensive usability testing ourselves and even had over 50 people use our form and give us their feedback. We took their feedback to heart and tailored our app to suit the average American applying for reduced school lunches. 

-Animations (Intuitive)
-Form Validation
-Dialogs
-Autocomplete Form
-Minimalist
-Translate
-Accessibility
    -Compatible with voice over plugins
    -High contrast for those with vision problems
-Navigation
-Application Time

For validation:

After trying to submit an invalid form, the first invalid element is focused, allowing the user to correct the field. If another invalid field – that wasn't the first one – was focused before submit, that field is focused instead, allowing the user to start at the bottom if he or she prefers.
Before a field is marked as invalid, the validation is lazy: Before submitting the form for the first time, the user can tab through fields without getting annoying messages – they won't get bugged before having the chance to actually enter a correct value
Once a field is marked invalid, it is eagerly validated: As soon as the user has entered the necessary value, the error message is removed
If the user enters something in a non-marked field, and tabs/clicks away from it (blur the field), it is validated – obviously the user had the intention to enter something, but failed to enter the correct value


### Performance Testing

We expect millions of users to access this form every year, so we collected various metrics for our form so that it can function using a minimal amount of resources.

#### Network Performance

One area we really focused on includes network performance. We measured the size of the initial prototype of our application using Google Chrome's Developer Tools and using our form several times. During these tests, we monitored the size of the files outputted from our server and calculated the average data transfer required for the form. This little experiment showed that for the average user, 493 kB of data needs to be loaded for our form. We decided this was not good enough for the following reasons:

* **Slow Load Times:** Loading that much data would lead to slow loading times, especially for families that don't have access to reliable broadband connections. Using public wifi connections or cell phone wifi hotspots typically have poor latency, and could potentially lead to loading times of up to 30 seconds, which is unacceptable in today's world and would deter many eligible families from completing the form.
* **Increased Server Load:** Assuming that the USDA used our prototype and a similar number of people would apply for reduced school lunches as previous years, the USDA's web servers would need to serve 5 TB of data annually. If there was a tenfold increase in the number of people applying because of an online form, that would mean 50 TB of annual data transfer. This data transfer comes at a huge cost, both financially and in reliability. In monetary terms, the USDA would need to buy more powerful servers and spend more to maintain them. In terms of reliability, transferring more data would put larger loads on the servers, and the form could go down under heavy usage.

In order to tackle the issue, we tried various approaches, but the following techniques were most successful.

* **Compression:** We compressed everything. We took our HTML document layout and removed all the formatting and whitespace so that the file size was minimal, and only data remained. We "compiled" all our Javascript so that we could squeeze the logic of our program into as few lines as possible. We reduced the size of our static assets (images, etc.) by using standard compression algorithms found in common image formats such as png, jpg, and gif.
* **Preloading:** Instead of waiting to load each resource that our program needs to display it, we decided to rewrite our logic to preload everything in the background at once. This reduces the overhead of needing to send multiple requests and waiting on multiple resources, and it minimizes the consequences of poor latency. Instead, everything simply loads at once, and when the user needs to go to a new panel or go back a page, it happens instantaneously.
* **Use of CDNs:** The use of content delivery networks, a globally distributed network of proxy servers hosted by companies such as Google, allow the open source libraries that we use to be downloaded from external servers that are configured to provide maximum speed and minimal latency. As a result, the application is loaded simultaneously from both our servers and CDNs, eliminating the bottleneck of a user's connection speed to our server. The cherry on top is that most websites on the internet also use CDNs to load their libraries, so in most cases, these libraries are already cached on users' computers and no time is wasted loading them.

After making all these optimizations, the final version of our reduced school lunch form uses an astonishingly low 2.9 kB of data, a whopping **99.4% reduction** in the amount of data originally required to load our form.

#### CPU/Memory Performance

Getting our program to load quickly is just part of the battle. Not everybody owns blazing fast state-of-the-art computers, and we spent a lot of time and effort in crafting a form that provides a robust user experience while still performing well on older, slower computers with limited processors and RAM. Our original prototype featured beautiful animations and functionality that could bring older computers to a halt. We have labored to tweak those animations and functionality so that it has a limited resource footprint that can work on any computer without any freezes or slowdowns.

In our original tests, we focused on two major metrics:

1. The time our code spent rendering elements for our form
2. The frame rate of animations

Our results showed that for our two (relatively new) testing devices, 1509 milliseconds were spent rendering elements while filling out the form. On older computers, this value could be up to 5 seconds. During this time, the form is partially unresponsive and heavy CPU activity occurs, which may cause users to abandon the form. We also observed that during animations, the frame rate of our form could drop down to 9 frames per second, a number characteristic of visual stuttering. We aim to keep this value at 60Hz, the standard for websites with animations.

To resolve the issues on this front, we implemented the following strategies.

* **GPU Powered Animations:** Typically, web animations are performed using the CPU (Central Processing Unit, used for general processing). We used the new CSS3 web standards which perform animations using the GPU (Graphics Processing Unit), a chip found in most computers specialized for graphics related processing. This results in buttery smooth animations and leaves the CPU free to do other tasks required by the form.
* **Reduced DOM Queries:** When we want to dynamically change the contents of our page, we use a library called jQuery, which searches for elements on the page and allows us to perform actions on them. When searching for elements, the DOM (document object model), an internal data structure that represents every element on the page is queried for the element we are looking for. Since the DOM is very large (due to the sheer number of elements on the page), querying the DOM is computationally expensive, and we reduced the number of times we queried the DOM by saving our results from previous queries.

Ultimately, we saw a significant improvement after making the above changes. The time spent on rendering dropped to 412 milliseconds, a **73% reduction**. The frame rate was able to consistently stay above 56 frames per second, an **increase of over 500%**.

### Compatibility Testing

We want our form to work with a variety of browsers and conducted sufficient testing to ensure that our form is compatible with all the commonly used browsers and operating systems.

We accomplished this by using our form on Safari, Firefox, Google Chrome, and Internet Explorer and resolving minor inconsistencies in functionality and appearance (such as different spacing, unequal text parsing) so that the form experience is consistent regardless of browser.

We did the same for operating systems, running Mac OS X, Windows, and Ubuntu in a virtual machine and with every combination of browsers and testing whether the form appeared and functioned as expected.

One of the key steps in achieving this compatibility included rewriting a large portion of our CSS code to use browser-specific prefixes to enable certain styling features in all browsers.

We also worked to improve the mobile browser experience. While our form is designed for desktop interfaces, we have seen the recent trends of people relying more and more on their mobile devices, so we conducted testing on the iOS and Android mobile operating systems to ensure that the form also works as expected on those devices.

Finally, we have strived to make our form as future-proof as possible. Thus, we incorporated the latest web standards such as HTML5 and CSS3 so that the technology that our form uses will be here to stay, and nobody needs to worry about it growing obsolete anytime soon.

So whether somebody uses their laptop, a public library computer, their smartphone, or some new device invented 10 years from now, they'd still be able to apply for reduced lunch.

### Correctness Testing

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
