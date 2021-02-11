from re import T
from telebot import TeleBot
from Database import Database

TOKEN = '1641424704:AAFu_ehEkL7ROUnopenSQl02ZCPCnJiH19I'

bot = TeleBot(token = TOKEN, threaded = True)

database = Database()
  
@bot.message_handler(commands = ['registrati'], content_types = 'text')
def registrati(message):
    
    if database.register(idProprietario = message.from_user.id, nomeUtente = message.from_user.first_name) == -1:
        
        bot.send_message(chat_id = message.chat.id, text = 'Sei già registrato!')
        
    else:
        
        bot.send_message(chat_id = message.chat.id, text = 'Registrazione effettuata!')
    
@bot.message_handler(commands = ['aggiungiEdificio'], content_types = 'text')
def aggiungiEdificio(message):
    
    a = message.text.split()[1::]
    
    a.append(message.from_user.id)
    
    database.addBuilding(a)
  
@bot.message_handler(commands = ['stampaEdifici'], content_types = 'text')
def stampaEdifici(message):
    
    edifici = database.printBuildings(idProprietario = message.from_user.id)
    
    for edificio in edifici:
        
        bot.send_message(chat_id = message.chat.id, text = 'Indirizzo: {}, numero civico: {}, città: {}, nome: {}'.format(*edificio[1:-1]))

bot.polling(interval = 1, none_stop = True)