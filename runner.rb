require_relative 'config/environment'
require_all 'app/models'



app = Cli.new
app.welcome
app.loading_bar
app.ask_if_username
10.times do app.ask_what_to_do
end


binding.pry
0
