require_relative 'config/environment'
require_all 'app/models'



artists = (Song.all.map {|song| song[:artist] }).uniq
genres = (Song.all.map {|song| song[:genre] }).uniq
years = (Song.all.map { |song| song[:year]}).uniq.sort
prompt = TTY::Prompt.new

app = Cli.new
app.welcome
app.loading_bar
app.clear
app.ask_if_username
10.times do app.ask_what_to_do
end


binding.pry
0
