## CSC 667 Web Server Project

I'm currently writing the project so it's in a constant state of change.  The master branch 
contains the skeleton and a failing test suite against that skeleton (in as much as I have 
specified them to this point). The goal is for you guinea pigs to play with the project and 
see what you can get done, where it's lacking, etc.

The project is executed on jruby instead of Ruby MRI that we used in class, so you'll need 
to set up your environment to be able to do that (using RBenv or RVM - there's a .rvmrc file 
in the repo, so if you have RVM installed, you should be good to go).

You'll want to work in a branch of your own creation, or a fork - you
are working directly against the repository that I am working against,
so *don't push to master or implementation* - it's not the end of the
world if you do, it'll just take me a minute to fix.

Feel free to file tickets or PRs anywhere you see something lacking!
Use the tools we have, github kicks ass, and it's nice to know what the
fuck you're doing when employers ask you about such things.  :smiley:

## Getting Started

Once your copy of the repo has been created, install the gems specified
in the gem file via bundler:
```
bundle install
```

To run the entire test suite:
```
rspec
```

To run the web server (nothing will happen until you implement...):
```
ruby web_server.rb
```
