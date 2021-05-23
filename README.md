# **Pantry Backend**
Pantry [(live)](https://pantry.svrourke.com) is a collaborative grocery list app created to provide a single place my partner and I could keep track of what we need and what we've purchased to solve the problems of forgotten and extra groceries. The full project is a ruby on rails api consumed by a react frontend.

* System dependencies

* Configuration

* Database creation / initialization

## Getting Started
---

> If you would like to spin up your own copy of pantry clone this repo and the [frontend repo](https://github.com) and follow the instructions below for the backend setup, and the instructions on the front end repo for the front end setup.

Clone the repository and run bundle install to install the necessary gems
```
$ git clone https://www.github.com/SVRourke/pantry_backend

$ cd pantry_backend

$ bundle install
```

Next It's time to create the database, to do so run the following command.
```
$ rails db:create db:migrate
```
> note: this app requires postgres to run in production

If you would like to seed the database with some sample data you can do so, this will provide you with some examples of the various functions of the app, lists, friends, friend requests, list invites, items, etc. You can log in with the following credentials email: sam@gmail.com password: password
```
$ rails db:seed
```
Or you can edit db/seeds.rb to change the user credentials

### **A Note about Production**
When running in development the cors configuration defaults to allowing requests from localhost:4000, in production the app requires an environment variable 'ORIGIN' specifying the host the app will be receiving requests from. Without this environment variable the app will not allow requests from any source, additionally the code that bakes the cookies relies on this variable for assigning the cookie domain. 

### **Fire It Up**
Now it's time to start it up, run rails s and you should be ready to start making grocery lists!
```
$ rails s
```
### Built With
* Ruby On Rails
## Deployment
---
* Heroku
## State Of The Project
---
This project was solely created for 2 reasons:
1. It's an app that solves a problem I face and I intend to use it for myself.
2. This is a portfolio project.

I intend to continue development on this project as it is by no means 'finished' in it's current state. I have many ideas for functionality that can be added.  This project is intended to be a showcase of my skills for future employers, so  if you want to contribute I would be honored but I would prefer if you forked it and worked on it for yourself, if someone would like to make a product out of this that is fine I only ask that you contact me to let me know as I would be happy to hear about it.

## Acknowledgements
---
* Blah