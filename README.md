# USDA-EAT-UX-Form

LOGIN INSPIRATION: http://demo.geekslabs.com/materialize/v3.1/user-login.html

FEATURES:
-AUTOCOMPLETION FROM BROWSER FOR form
-SECURE way for schools to access results

After trying to submit an invalid form, the first invalid element is focused, allowing the user to correct the field. If another invalid field – that wasn't the first one – was focused before submit, that field is focused instead, allowing the user to start at the bottom if he or she prefers.
Before a field is marked as invalid, the validation is lazy: Before submitting the form for the first time, the user can tab through fields without getting annoying messages – they won't get bugged before having the chance to actually enter a correct value
Once a field is marked invalid, it is eagerly validated: As soon as the user has entered the necessary value, the error message is removed
If the user enters something in a non-marked field, and tabs/clicks away from it (blur the field), it is validated – obviously the user had the intention to enter something, but failed to enter the correct value
