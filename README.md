## LINK TO APP https://ping-pong-challenge.herokuapp.com/
## Original submission to this challenge still available in original_submission branch


## Getting Started

1. Run `bundle`
2. Run `rake db:migrate`
3. Run `rake db:seed`
4. Run `rails s`
5. Create a new account

## Description

The purpose of this app is to allow users to track their ping pong games and to show the current leaderboard of players in the office.

Once logged in, users can log games against other opponents, see the history of their games and see the current leaderboard.

A leaderboard keeps track of the rankings of a group of players or teams over time.  This is an [example of a leaderboard in the context of socccer](http://www.fifa.com/fifa-world-ranking/ranking-table/men/), this is an [example of a leaderboard](https://ratings.fide.com/top.phtml?list=men), in the context of chess, this is an [example of an Elo ranking](https://github.com/rgho/elo.rb) implemented in Ruby.

The framework of the app already allows users to register and sign in. Your task is to implement the abilty for players to log games, see their results and update the rank of the ping pong leaderboard. Mock ups for all UI to be developed are in the app already.  Please replace the mocks with your implementation.
