## Jazzy JukeBox
A Ruby & ActiveRecord remix of the classic Jukebox - Everyone's favorite way to jam out!!

## Table of contents
General info
Intro Video
Technologies
Setup
Features
Status
Inspiration
Contact
License

## General info
This CLI application allows users to log in or create their very own profiles before starting their musical journey. The user is then able to select from a variety of songs, artists, categories, and publication! After jamming out to the provided youtube links, they can decide to add a review of their expierience from 1-5 as well as view their favorite songs or past reviews.

## Intro Video


## Technologies
* Ruby - version 2.6.1
* ActiveRecord - version 6.0
* Sinatra - version 2.0
* Sinatra-activerecord - version 2.0
* SQLite3 - version 1.4
* Rest-Client
* TTY-Prompt
* TTY-ProgressBar
* TTY-Font

## Setup
To run this project, install it locally by cloning the GitHub repository, going to your terminal and typing the following commands in order:
```zsh
$ git clone (paste git clone url here)
```
```zsh
$ bundle install
```
```zsh
$ rake migrate
```
```zsh
$ rake db:seed
```
```zsh
$ ruby runner.rb
```

<!-- ## Code Examples
```ruby
    def select_song_by_year
        @songselection = @prompt.select(
            "Select a song:", 
            @year_song_list,
            "Back" )
        if @songselection == "Back"
            sort_by_year
        end
        @song_choice = @songs.find {|song| @songselection == song[:title]}
        separate
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        separate
        sleep(2)
        leave_review
    end

    def leave_review
        review_push = @prompt.select("Would you like to leave a review for that song?", %w(Yes No))
        if review_push == "Yes"
            songrating = @prompt.select("Pick a rating - 5 is the best, 1 is the worst:", %w(1 2 3 4 5))
            content = @prompt.ask("What did you think?!")
            Review.create(user: @user, song: @song_choice, rating: songrating, content: content)
            ask_another_song
        elsif review_push == "No"
            ask_another_song
        end
    end
 ````` -->


## Features
* Log in or create your own username and password
* Browse songs based on various attritutes: genre, year, artist, or rating. 
* Return all attributes from the song such as who made it and when.
* Listen to your desired song via a provided youtube link
* Search for songs or artists
* Add songs to the library
* View reviews left by other users
* Create a review for the song you just listened to and store it in our system



To-do list:
* Refactor code as well as add an api

## Status
Project is: available to download and run locally, through GitHub.

## Inspiration
The Jazzy Jukebox was impacted by the creators love for music and was designed to mimick/modernize the old style of the orignal dinner experience(COVID free)

## Contact
Created by [Jordan Panasewicz](https://www.linkedin.com/in/jordan-panasewicz-77a93158/) and [Javaria Brascom](https://www.linkedin.com/in/javaria-brascom-0510991bb/).

Feel free to connect with us using the links above.

## License
[License](https://github.com/JorPan/JazzyJukebox/blob/master/license.txt) 