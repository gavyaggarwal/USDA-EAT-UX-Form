# USDA Reduced Lunch Online Form Design
##### By Gavy Aggarwal and Abirami Kurinchi-Vendhan

### Design

Our design includes a public user-facing interface for parents and guardians to apply for reduced school lunches as well as a password protected school-facing interface for school administrators to view and download the submitted applications.

For testing purposes we have set up a server, and you can view our form online:
* [Application Form for Parents/Guardians](http://eatuxform-gavyaggarwal.rhcloud.com/)
* [Administrator Portal for School Districts](http://eatuxform-gavyaggarwal.rhcloud.com/schools/)
    * Username: **USDA**
    * Password: **Demo**

We have really focused on providing users an easy, intuitive experience by providing features such as:
* Insert Features Here

### Development

Our form was written using CoffeeScript, Jade, and SASS. Our server uses node.js.

To run the server:
* Ensure the `npm` and `git` commands are installed on your computer.
* Download the source code: `git clone http://github.com/gavyaggarwal/USDA-EAT-UX-Form`
* Install dependencies: `npm install`
* Start the server: `npm start`

Future code can be written using either CoffeeScript or Javascript. The Coffee files are found in `/coffee` and `/public_html/coffee`. The Javascript files are found in `/` and `/public_html/js`. If you use CoffeeScript, you can use the Coffee watch feature to auto-compile the Coffee files into Javascript:

`coffee –wc -o public_html/js/ public_html/coffee/*.coffee`

`coffee –wc -o ./ coffee/*.coffee`

Similarly, future code can be written in either Jade or HTML. The Jade files are found in `public_html/jade`, and the HTML files are found in `public_html`. If you use Jade, you can also auto-compile Jade to HTML on save:

`coffee –wc -o public_html/ public_html/jade/*.jade`

We have written our code to be self-documenting, so it should be easy to tweak. Do not hesitate to contact us if you have any further questions.

### Scratch Notes

This will be removed at some point.

LOGIN INSPIRATION: http://demo.geekslabs.com/materialize/v3.1/user-login.html

FEATURES:
-AUTOCOMPLETION FROM BROWSER FOR form
-SECURE way for schools to access results

After trying to submit an invalid form, the first invalid element is focused, allowing the user to correct the field. If another invalid field – that wasn't the first one – was focused before submit, that field is focused instead, allowing the user to start at the bottom if he or she prefers.
Before a field is marked as invalid, the validation is lazy: Before submitting the form for the first time, the user can tab through fields without getting annoying messages – they won't get bugged before having the chance to actually enter a correct value
Once a field is marked invalid, it is eagerly validated: As soon as the user has entered the necessary value, the error message is removed
If the user enters something in a non-marked field, and tabs/clicks away from it (blur the field), it is validated – obviously the user had the intention to enter something, but failed to enter the correct value
