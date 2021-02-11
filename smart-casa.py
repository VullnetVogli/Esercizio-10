import json
from datetime import datetime
from Database import Database
from random import uniform
from time import sleep

class smartCasa():

    TOPIC_DB = 'smart-db/temperature'

    URL = 'demo.thingsboard.io'

    INTERVALLO = 1

    def __init__(self):

        self.database = Database('smart-casa')  # mi serve perché da qui, smart-db riceve i dati che invio

        self.dispositivi = []

        self.inizializza_dispositivi()

    def get_temperatura(self, cifre_dopo_virgola: int):

        return round(uniform(0, 40), cifre_dopo_virgola)

    def inizializza_dispositivi(self):

        # Ogni stanza della quale vorrei le notifiche avrà un dispositivo che misura la temperatura, quindi creerò tanti dispositivi quanto sono le stanze con il flag notifiche
        for stanza in self.login.get_dati()['casa']['stanze']:
            
            if self.login.get_dati()['casa']['stanze'][stanza]['notifiche']:
                
                print('-----', stanza, '-----')

                dati_dispositivo = {
                    'idProprietario': self.login.get('idProprietario'),
                    'casa': self.login.get_dati()['casa']['nome'],
                    'stanza': stanza
                }

                self.dispositivi.append(Dispositivo(dati_dispositivo))
            
    def start(self):

        while True:

            # Per ogni dispositivo nella casa
            for dispositivo in self.dispositivi:

                # Creo un dizionario dei dati da mandare
                dati_dispositivo = {
                    'temperatura': self.login.chiave.encrypt(self.get_temperatura(cifre_dopo_virgola = 1)),
                    'data': str(datetime.now().date()),
                    'ora': str(datetime.now().time()),
                    'idStanza': self.login.get_dati()['casa']['stanze'][dispositivo.stanza]['idStanza']
                }

                dispositivo.notifica_proprietario(dati_dispositivo)    # Pubblica nel topic del dispositivo così che arrivi al proprietario

                dispositivo.notifica_database(dati_dispositivo)        # Pubblica nel topic del database così che salvi i dati

                dispositivo.notifica_thingsboard(dati_dispositivo)     # Pubblica nel topic di thingsboard così posso visualizzare i dati

                sleep(self.INTERVALLO)

if __name__ == '__main__':

    try:

        smartCasa().start()

    except KeyboardInterrupt:

        print('\nEsecuzione terminata!\n')
       