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
        result = @prompt.select("What would you like to do today?", ["Play Music", "Check My Reviews", "View All Reviews", "Add Song", "Exit"])
            if result == "Play Music"
                ask_to_sort
            elsif result == "Check My Reviews"
                check_my_reviews
            elsif result == "View All Reviews"
                view_reviews
            elsif result == "Add Song"
                prompt_to_add_song
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
            puts "================"
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

    def view_reviews
        hello = []
            Review.all.map do |review|
            Song.all.select do |song|
                if review[:song_id] == song[:id]
                    hello << song[:title]
                    hello << song[:artist]
                else
                end
            end
            hello << review[:rating] 
            hello << review[:content]
            hello << "========================="
        end
        puts "==========================="
        puts hello
    end


    def sort_by_rating
        Review.all 
        binding.pry

    end

    def sort_by_year
        @year_choice = @prompt.select("Choose a year:",  @years )
        list_year_songs
    end

    def sort_by_artist
        @artist_choice = @prompt.select("Choose an artist:",  @artists )
        list_artist_songs
    end

    def sort_by_genre 
        @genre_choice = @prompt.select("Choose a genre:",  @genres )
        list_genre_songs
    end

    def randomsong
        @song_choice = @songs[rand(@songs.length)]
        puts "==========================="
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        puts "==========================="
        sleep(3)
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
        @songchoice = @prompt.select("Select a song:", @artist_song_list, "Back" )
        if @songchoice == "Back"
            sort_by_artist
        end
        @song_choice = @songs.find {|song| @songchoice == song[:title]}
        puts "==========================="
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        puts "==========================="
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
        @songchoice = @prompt.select("Select a song:", @genre_song_list, "Back" )
        if @songchoice == "Back"
            sort_by_genre
        end
        @song_choice = @songs.find {|song| @songchoice == song[:title]}
        puts "==========================="
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        puts "==========================="
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
        @songchoice = @prompt.select("Select a song:", @year_song_list, "Back" )
        if @songchoice == "Back"
            sort_by_year
        end
        @song_choice = @songs.find {|song| @songchoice == song[:title]}
        puts "==========================="
        puts @song_choice[:artist], @song_choice[:title], @song_choice[:year], @song_choice[:genre], @song_choice[:link]
        puts "==========================="
        sleep(2)

        leave_review
    end

    def leave_review
        review_push = @prompt.select("Would you like to leave a review?", %w(Yes No))
        if review_push == "Yes"
            songrating = @prompt.select("Pick a rating", %w(1 2 3 4 5))
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
