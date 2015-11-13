require 'discordrb'

#create bot, store login credentials in an environmental variable for security
bot = Discordrb::Bot.new ENV["BOT_LOGIN"], ENV["BOT_PASS"]

#list of commands
bot.message(with_text: "!commands") do |event|
  event.respond "Hello! Here are all the commands I have!"
  event.respond "!ping: Pong it back!"
  event.respond "!pong: You meant ping, right?"
  event.respond "!hi: Hi there!"  
end

#___________________________COMMANDS LIST______________________________________
bot.message(with_text: "!ping") do |event|
  event.respond "Pong!"
end

bot.message(with_text: "!pong") do |event|
  event.respond "How can I ping if you already ponged?"
end

bot.message(with_text: "!hi") do |event|
  event.respond "Hi there!"
end
#__________________________________END COMMANDS_______________________________


#_______________________________RUN___________________________________________
bot.run