[![Waffle.io - Issues in progress](https://badge.waffle.io/mnhollandplum/little_shop_v2.png?label=in%20progress&title=In%20Progress)](http://waffle.io/mnhollandplum/little_shop_v2)

# Little Shop

Welcome to our e-commerce web application! Using this app visitors can look through an item catalog, add items to their cart, create an account and order items. Registered users can then log in and log out. Merchants can register for our app and sell their items, view all orders associated with their items and order items for themselves as well. Admins have access to the entire app, except for sensitive user information.

## Contribute
If you would like to contribute to this project please clone this project down via or terminal. `git@github.com:mnhollandplum/little_shop_v2.git`
Or visit our Github link: https://github.com/mnhollandplum/little_shop_v2

## What we used/what you’ll need
### Rails

We used rails -v 5.1.6. Please check your rails version before working on the application.
To do this run `rails -v` from your terminal.
If you need to switch your version of rails:
First, uninstall rails `gem uninstall rails`.
Then, install the correct version of rails `gem install rails -v 5.1.6`.

### Gems
To make sure you have all of the updated gems you need, run bundle install and bundle update from your terminal.
* BCrypt
* Capybara
* FactoryBot
* Launchy
To see the page that is being tested, place `save_and_open_page` in your capybara test.

* PostreSQL
To access the created database, run `rake db:{drop,create,migrate,seed}`

* Pry
Place `binding.pry` within your code before you run your tests to see what you have access to.

* RSpec
To check the testing run `rspec` from your terminal.
* ShouldaMatchers

* SimpleCov
To check the the test coverage, use your terminal to open the coverage folder. `open coverage/index.html`.


## Contributors (so far)
Michael Gatewood: mngatewood
Nikki Holland-Plum: mnhollandplum
Jimmy Smith: JSmith23
Tom Nunez: tomjnunez
Ian Douglas: iandouglas
Dione Wilson: dionew1

