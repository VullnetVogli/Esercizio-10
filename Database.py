from datetime import datetime
import hashlib
from cryptography import fernet
from mysql.connector import errorcode
from mysql import connector
from pathlib import Path
from cryptography.fernet import Fernet

class Database():

    def __init__(self):

        self.dati = {}

        # Dal file di configurazione leggo i dati e li salvo
        #self.registrazione = Registrazione()

        #self.dati = self.registrazione.dati

        # Effettuo il login al database
        self.connessione = self.log_in()

        self.cursore = self.connessione.cursor(True)

    # Metodo per collegarmi al database
    def log_in(self):
        
        try:
            
            return connector.connect(host = 'localhost', user = 'root', password = 'root', database = '5AI_VOGLI')

        except connector.errors.Error as eccezione:
            
            if eccezione.errno == errorcode.CR_CONN_HOST_ERROR:

                print('Indirizzo IP non valido!')

            elif eccezione.errno == errorcode.ER_BAD_DB_ERROR:
    
                print('Database non trovato!')

            elif eccezione.errno == errorcode.ER_ACCESS_DENIED_ERROR:
    
                print('Password o nome utente non validi!')
            
            else:

                print('Si è verificato un errore', eccezione.errno)

            quit()

    def login(self, idProprietario: int):
        
        self.cursore.execute('select * from proprietario where idProprietario = {}'.format(idProprietario))
        
        proprietario = self.cursore.fetchone()
        
        if proprietario == None:
            
            return -1
        
        else:
            
            return proprietario[0]
        
    def register(self, nomeUtente: str):
        
        self.cursore.execute('select * from proprietario where idProprietario = {}'.format(idProprietario))
        
        if self.cursore.fetchone() != None:
        
            return -1
        
        else:
        
            self.cursore.execute('insert into proprietario values({}, "{}", "{}")'.format(idProprietario, nomeUtente, Fernet.generate_key().decode('UTF-8')))
        
            self.connessione.commit()
        
            return 0
        
    def addBuilding(self, *args):
        
        self.cursore.execute('insert into edificio values(null, "{}", {}, {}, "{}", {})'.format(*args[0]))
       
        self.connessione.commit()
        
    def printBuildings(self, idProprietario: int):
        
        self.cursore.execute('select * from edificio where idProprietario = {}'.format(idProprietario))
        
        return self.cursore.fetchall()
        
        
        