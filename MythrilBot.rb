require 'discordrb'
require 'sys/uptime'
require 'json'
require 'open-uri'

#create bot, store login credentials in an environmental variable for security
#bot = Discordrb::Bot.new ENV["BOT_LOGIN"], ENV["BOT_PASS"]
bot = Discordrb::Commands::CommandBot.new token: ENV["BOT_ID"], application_id: ENV[BOT_APP], prefix: '!'

#list of commands
bot.command :commands do |event|
    event.respond "Hello! Here are all the commands I have!"
    event.respond "!ping: Pong it back!"
    event.respond "!pong: You meant ping, right?"
    event.respond "!hi: Hi there!"
    event.respond "!flip: Flips a coin, heads or tails?"
    event.respond "!8ball: Ask a question, see the outcome!"
end

#___________________________COMMANDS LIST______________________________________
bot.command :ping do |event|
    event.respond "Pong! That took: #{Time.now - event.timestamp} nanoseconds."
end

bot.command :pong do |event|
    event.respond "How can I ping if you already ponged?"
end

bot.command :hi do |event|
    event.respond "Hi there, #{event.user.mention}!"
end

bot.command :flip do |event|
    coin = ["heads!", "tails!"].sample
    event.respond "#{event.user.mention} flips a coin... and it lands on #{coin}!"
end

bot.command :roll do |event|
    event.respond "#{event.user.mention} your number is: #{1 + rand(100)}!"
end

bot.command :whois do |event, arg|
    user1 = bot.parse_mention(arg)
    event.respond "User Name: #{user1.name}\n"
    event.respond "#{user1.status}\n"
    event.respond "User ID: #{user1.id}\n"
    
    if user1.voice_channel != nil
        event.respond "Currently in: #{user1.voice_channel.name}"
    end
    
    if user1.game != nil
        event.respond "Playing: #{user1.game}"
    end
end

bot.command :about do |event|
    event << 'Author: Martin (<@95557857449091072>).'
    event << 'Discord: Under Construction.'
    event << 'Website: Under Construction.'
    event << 'Github: <https://goo.gl/6AXKpt>'
end 

bot.command :urban do |event, *args|
    args = args.join(' ')
    
    def get_uri(uri)
        data = open(uri).read
    end
    
    def parse(data)
        define = JSON.parse(data)
    end
    
    def ud_uri(args)
        "http://api.urbandictionary.com/v0/define?term=#{args}"
    end
    
    begin
        event << "**Top result for: **\n"
        event << "**#{args.split.map(&:capitalize).join(' ')} **\n"
        event << parse(get_uri(ud_uri(args)))['list'].first['definition']
    rescue
        event << "Error: Invalid Search."
    end
end   

bot.command :google do |event, *text|
    "http://lmgtfy.com/?q=#{text.join('+')}"                
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
