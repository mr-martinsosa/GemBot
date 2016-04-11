require 'discordrb'

#create bot, store login credentials in an environmental variable for security
bot = Discordrb::Bot.new ENV["BOT_LOGIN"], ENV["BOT_PASS"]

#list of commands
bot.message(with_text: "!commands") do |event|
  event.respond "Hello! Here are all the commands I have!"
  event.respond "!ping: Pong it back!"
  event.respond "!pong: You meant ping, right?"
  event.respond "!hi: Hi there!"
  event.respond "!flip: Flips a coin, heads or tails?"
  event.respond "!8ball: Ask a question, see the outcome!"
end

#___________________________COMMANDS LIST______________________________________
bot.message(with_text: "!ping") do |event|
  event.respond "Pong!"
end

bot.message(with_text: "!pong") do |event|
  event.respond "How can I ping if you already ponged?"
end

bot.message(with_text: "!hi") do |event|
  event.respond "Hi there, #{event.user.mention}!"
end

bot.message(with_text: "!flip") do |event|
 coin = ["heads!", "tails!"].sample
 event.respond "#{event.user.mention} flips a coin... and it lands on #{coin}"
end

bot.message(with_text: "!8ball") do |event|
 event.respond ["As I see it, yes", "It is certain", "It is decidedly so", "Most likely", "Outlook good", "Signs point to yes", "Without a doubt", "Yes", "Yes – definitely", "You may rely on it", "Reply hazy, try again", "Ask again later", "Better not tell you now", "Cannot predict now", "Concentrate and ask again", "Don't count on it", "My reply is no", "My sources say no", "Outlook not so good", "Very doubtful"].sample
end
#__________________________________END COMMANDS_______________________________

#__________________________________BOT MENTION________________________________
bot.mention do |event|
 event.respond ["Hmmm, sounds like it might work #{event.user.mention}?" , "Seems possible, #{event.user.mention}.", "I don't get it, #{event.user.mention}.", "Have you tried something else, #{event.user.mention}?", "Try asking someone else, #{event.user.mention}",  "Might be true, #{event.user.mention}."].sample
end


#_______________________________RUN___________________________________________
bot.run
