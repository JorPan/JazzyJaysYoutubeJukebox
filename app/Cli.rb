require_all 'app/models'



class Cli

    def initialize
        @users_name = ''
        @songs = Song.all
        @artists = (@songs.map {|song| song[:artist] }).uniq.sort
        @genres = (@songs.map {|song| song[:genre] }).uniq.sort
        @years = (@songs.all.map { |song| song[:year]}).uniq.sort
        @prompt = TTY::Prompt.new(symbols: {marker: "🎶"})
        @font = TTY::Font.new(:starwars)
        @pastel = Pastel.new(eachline: "\n") 
    end

    def clear
        system "clear"
    end

    def separate
        puts "========================"
    end


    def welcome
        puts @pastel.white.on_green(@font.write("  Welcome  " ))
        sleep(0.5)
        puts @pastel.black.on_yellow(@font.write( "           to the            " ))
        sleep(0.5)
        puts @pastel.white.on_red(@font.write(  " Youtube  " ))
        sleep(0.5)
        puts @pastel.red.on_white(@font.write(  "   Jukebox!   " ))
        sleep(0.5)
    end

    def loading_bar
        bar = TTY::ProgressBar.new(@pastel.black.on_white("Loading [:bar]"), total: 71)
            71.times do
            sleep(0.03)
            bar.advance(1)
            end
            sleep(1)
    end

    def searching_bar
        bar = TTY::ProgressBar.new(@pastel.cyan("Searching [:bar]"), total: 40)
            40.times do
            sleep(0.01)
            bar.advance(1)
            end
            sleep(1)
    end

    def ask_if_username
        has_username = @prompt.yes?("Do you have a username?")
            if has_username == true
                ask_username
            else
                make_user
            end
    end

    def make_user
        @newuser = @prompt.ask("What is your desired username?")
        sleep(1)
        puts "Welcome #{@newuser}"
        @newpassword = @prompt.ask("Enter a password")
        sleep(1)
        @users_name = @prompt.ask("What is your name?", default: ENV["guest"])
        sleep(0.3)
        puts "Hey what up #{@users_name}?!"
        @newuserobject = User.create(name: @users_name, username: @newuser, password: @newpassword)
        @user = User.all.find { |user| user[:name] == @users_name }
    end


    def ask_username
        @username = @prompt.ask("What is your username?")
        check_log_in
    end


    def check_log_in
        @user = User.all.find { |user| user[:username] == @username}
        if @user == nil
            puts "Username not found"
            ask_username
        end
        ask_password
    end

    def ask_password
        passcheck = @prompt.ask("What is your password?")
            if passcheck == @user[:password]
                log_in_user
            else
                puts "Invalid Password"
                ask_password
            end
    end

    def log_in_user
        puts "Welcome back, #{@username}"
        ask_what_to_do
    end

    def ask_what_to_do
        result = @prompt.select("What would you like to do today?", ["Find Music", "View MY Reviews", "View ALL Reviews", "Add Song", "Search", "Exit"])
            if result == "Find Music"
                ask_to_sort
            elsif result == "View MY Reviews"
                check_my_reviews
            elsif result == "View ALL Reviews"
                view_reviews
            elsif result == "Add Song"
                prompt_to_add_song
            elsif result == "Search"
                search_by
            else
                exit
            end
    end

    def prompt_to_add_song
        response = @prompt.yes?("In order to add a song, you'll need to provide a song title, artist name, genre, youtube link, and release year. Do you want to proceed?")
        if response == true
            puts "Thank you for contributing! Please provide accurate information."
            add_song 
        else
            ask_what_to_do
        end
    end

    def add_song
        songtitle = @prompt.ask("What is the song title?")
        artistname = @prompt.ask("Who is the artist?")
        genre = @prompt.ask("What is the genre?")
        youtube = @prompt.ask("Please paste the youtube link directly:")
        year = @prompt.ask("What year was this released? Please provide accurate information!")
        Song.create(title: songtitle, artist: artistname, genre: genre, link: youtube, year: year)
        puts "Thank you for your contribution! You will have to log out and back in to see your added song in the library"
    end

    def check_my_reviews
        @my_reviews = Review.all.select do |review|
            review[:user_id] == @user[:id]
        end
        @allmyreviews = @my_reviews.map do |review|
            id = review[:song_id]
            puts @songs.find_by(id: id)[:title], @songs.find_by(id: id)[:artist], review[:rating], review[:content]
            separate
        end
        @my_reviews
        ask_what_to_do
    end

    def ask_to_sort
        result = @prompt.select("How would you like to sort?", %w(Genre Year Artist Rating Random Back) )
        if result == "Year"
            sort_by_year
        elsif result == "Artist"
            sort_by_artist
        elsif result == "Genre"
            sort_by_genre
        elsif result == "Rating"
            sort_by_rating
        elsif result == "Back"
            ask_what_to_do
        else randomsong
        end
    end

    def search_by
        search_option = @prompt.select("How would you like to search?", ["Search by Artist Name", "Search by Song Title"])
        if search_option == "Search by Artist Name"
            search_by_artist
        else
            search_by_song_name
        end
    end

    def search_by_artist
        @desired_artist = @prompt.ask("Who would you like to search for?")
        searching_artists
    end

    def search_by_song_name
        @desired_song = @prompt.ask("What song would you like to search for?")
        searching_songs
    end

    def searching_artists
        searching_bar
        artist_songs = Song.where artist: "#{@desired_artist}"
        if artist_songs.length >= 1
            artist_songs.map do |song|
                puts song[:title]
                puts song[:artist]
                puts song[:genre]
                puts song[:year]
                # puts song[:link]
                separate
            end
            ask_to_play
        else
            puts "Sorry, we don't have any songs by that artist."
            addsong = @prompt.yes?("Would you like to add a song?")
            if addsong == true
                add_song
            else
                ask_what_to_do
            end
        end
    end

    def searching_songs
        searching_bar
        @song_choice = Song.find_by title: "#{@desired_song}"
        if @song_choice
            puts @song_choice[:title]
            puts @song_choice[:artist]
            puts @song_choice[:genre]
            puts @song_choice[:year]
            puts @song_choice[:link]
            separate
            leave_review
        else
            puts "I'm sorry we didn't find a song with that name."
            addsong = @prompt.yes?("Would you like to add a song?")
            if addsong == true
                add_song
            else
                ask_what_to_do
            end
        end
    end

    def view_reviews
        @all_reviews = []
            Review.all.map do |review|
            Song.all.select do |song|
                if review[:song_id] == song[:id]
                    @all_reviews << song[:title]
                    @all_reviews << song[:artist]
                else
                end
            end
            @all_reviews << review[:rating] 
            @all_reviews << review[:content]
            user = User.find_by id: "#{review[:user_id]}"
            @all_reviews << "Written by: #{user[:username]}" 
            @all_reviews << "========================="
        end
        separate
        puts @all_reviews
        ask_what_to_do
    end


    def sort_by_rating
        @rating_choice = @prompt.select("Filter by rating:",  "5", "4", "3", "2", "1", "Back" )
        if @year_choice == "Back"
            ask_to_sort
        else
        list_rating_songs
        end
    end

    def list_rating_songs
        selected_reviews = Review.all.where("rating = #{@rating_choice} ")
        song_options_by_rating = selected_reviews.map do |review|
            separate
            song = Song.find_by id: "#{review[:song_id]}"
            puts song[:title]
            puts song[:artist]
            user = User.find_by id: "#{review[:user_id]}"
            puts review[:rating]
            puts review[:content]
            puts "Written by: #{user[:username]}"            
        end
        separate
        ask_to_play
    end

    def ask_to_play
        play_song = @prompt.yes?("Would you like to play one of the songs from above?")
            if play_song == true
                ask_which_song
            else
                ask_what_to_do
            end
    end

    def ask_which_song
        choice = @prompt.ask("Which song would you like to play? Just type in the title here:")
        @song_choice = Song.find_by title: "#{choice}"
        separate
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:genre], @song_choice[:year], @song_choice[:link]
        separate
        leave_review
    end

    def sort_by_year
        @year_choice = @prompt.select("Choose a year:",  @years, "Back" )
        if @year_choice == "Back"
            ask_to_sort
        else
        list_year_songs
        end
    end

    def sort_by_artist
        @artist_choice = @prompt.select("Choose an artist:",  @artists, "Back" )
        if @artist_choice == "Back"
            ask_to_sort
        else
        list_artist_songs
        end
    end

    def sort_by_genre 
        @genre_choice = @prompt.select("Choose a genre:",  @genres, "Back" )
        if @genre_choice == "Back"
            ask_to_sort
        else
        list_genre_songs
        end
    end

    def randomsong
        @song_choice = @songs[rand(@songs.length)]
        separate
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        separate
        sleep(2)
        leave_review
    end

    def list_artist_songs
        list_songs_by_artist = @songs.select do |song|
            song[:artist] == @artist_choice
        end
        @artist_song_list = list_songs_by_artist.map { |song| song[:title]}
        select_song_by_artist
    end

    def select_song_by_artist
        @songselection = @prompt.select("Select a song:", @artist_song_list, "Back" )
        if @songselection == "Back"
            sort_by_artist
        end
        @song_choice = @songs.find {|song| @songselection == song[:title]}
        separate
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        separate
        sleep(2)
        leave_review
    end

    def list_genre_songs
        list_songs_by_genre = @songs.select do |song|
            song[:genre] == @genre_choice
        end
        @genre_song_list = list_songs_by_genre.map { |song| song[:title]}
        select_song_by_genre
    end

    def select_song_by_genre
        @songselection = @prompt.select("Select a song:", @genre_song_list, "Back" )
        if @songselection == "Back"
            sort_by_genre
        end
        @song_choice = @songs.find {|song| @songselection == song[:title]}
        separate
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        separate
        sleep(2)
        leave_review
    end

    def list_year_songs
        list_songs_by_year = @songs.select do |song|
            song[:year] == @year_choice
        end
        @year_song_list = list_songs_by_year.map { |song| song[:title]}
        select_song_by_year
    end

    def select_song_by_year
        @songselection = @prompt.select("Select a song:", @year_song_list, "Back" )
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

    def ask_another_song
        another_song = @prompt.select("Would you like to play another song?", %w(Yes No))
        if another_song == "Yes"
            ask_to_sort
        elsif another_song == "No"
            ask_what_to_do
        end
    end


# binding.pry
end
