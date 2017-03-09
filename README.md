# BeTrained

Jonathan Thom

A coach-to-athlete workout logging application. Coaches can invite athletes to join, then post training sessions for them. Athletes can reply, and coaches can add notes back.

Cool features include a mailer (for the invite), user authentication and home-spun authorization, search, lots of AJAX, and the ability to add links to text inputs.

### Set Up

Deployed at [betrained.us](http://betrained.us/)

Or, you get it up and running through the following steps:

1. Clone it.
2. ```bundle install```
3. ```postgres```
4. ```rake db:setup```
5. If you want to send email in development, you'll be good to go. But if you want to use it in production, you'll need to set up an SMTP server as described [here.](http://www.jonathanthom.com/blog/Getting%20the%20Action%20Mailer%20to%20Actually%20Mail%20(with%20Mailgun))
6. ```rails s```

### Tech

Ruby on Rails

jQuery

Cool gems: Devise, Auto_HTML, Decent_Exposure, Materialize-Sass

### License

MIT
