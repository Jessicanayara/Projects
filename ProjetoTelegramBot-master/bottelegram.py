import telebot
import quickstart


chave_api=""
bot= telebot.TeleBot(chave_api)

registro_dict = {}

class Registro:
    def __init__(self, data):
        self.data = data
        self.hora = None
        self.info = None


@bot.message_handler(commands=["opcao1"])
def opcao1(message):
    msg = bot.reply_to(message, 'Informe a data:')
    bot.register_next_step_handler(msg, registro_data)


def registro_data(message):
    data = message.text
    user = Registro(data)
    registro_dict[1] = user
    msg = bot.reply_to(message, 'Informe o horario:')
    bot.register_next_step_handler(msg, registro_hora)


def registro_hora(message):
    hora = message.text
    user = registro_dict[1]
    user.hora = hora
    msg = bot.reply_to(message, 'informações do pet ou dono:')
    bot.register_next_step_handler(msg, registro_info)


def registro_info(message):
    info = message.text
    user = registro_dict[1]
    user.info = info
    lista = [user.data, user.hora, user.info]
    quickstart.gravardados(datas=lista)
    bot.send_message(message.chat.id, "Agendamento realizado com sucesso!")

def verificar(message):
    return True

@bot.message_handler(func=verificar)
def resposta(message):
    menu="""Bem-vindo ao agendamento automatico da nossa rede! 
    O que deseja fazer?
    /opcao1 Realizar agendamento 
    /opcao2 Verificar minha agenda
    """
    bot.reply_to(message,menu)

bot.polling()