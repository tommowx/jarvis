# Le 15 aggiunte · beta 0.12

Le prove automatizzate usano dati dimostrativi e profili isolati. Non costituiscono una garanzia di assenza di bug o compatibilità con qualunque progetto/app.

| # | Funzione | Cosa è disponibile e come è stata provata |
|---|---|---|
| 1 | Comprensione | Dizionario esplicito persistente, indizi Whisper e nomi di progetto. Registrazione sintetica mista italiano/inglese trascritta dal motore reale; accuratezza sul microfono personale da provare. |
| 2 | Conversazione | Interruzione anticipata alla rilevazione della voce, frase successiva in coda, ascolto continuo desktop e testo nascosto. Prove del flusso e interfaccia; eco e microfoni reali dipendono dall’hardware. |
| 3 | Lavoro sui progetti | Fino a 6 file per lavoro, sostituzioni esatte, backup, sintassi JS/Python, build .NET se progetto e SDK disponibili, npm test se configurato. Prove su progetto isolato; nessun commit/push automatico. Senza test adatti il report lo dichiara. |
| 4 | Cruscotto | File con date, attività aperte/bloccate, lavori e ricordi. Interfaccia Electron provata con tre progetti dimostrativi. |
| 5 | Memoria correggibile | Ricordi confermati, sostituzioni e disattivazioni con ID/data. Lo storico delle conversazioni è conservato, non cancellato. Prove di persistenza e precedenza. |
| 6 | Backup/ripristino | ZIP con SHA-256, ripristino in cartella nuova, importazione memoria/preferenze/routine; collega progetti ripristinati se mancano quelli locali. Massimo 512 MB e 15.000 file, 300 MB per file; esclusioni nel manifest. Nessuna credenziale o dipendenza installata. |
| 7 | Controllo lavori | Stato animato, Stop per richieste e backup, annullamento delle patch se i file non sono cambiati. I passi esterni già eseguiti non sono magicamente annullabili. |
| 8 | Routine | App e progetti collegati, voce/tema, stato e cruscotto; apertura ChatGPT/Discord tenta i monitor già configurati su Windows. Pausa/ripresa con registro. |
| 9 | Telefono | Associazione QR, controllo testuale, registrazione audio inviata al PC Windows e trascritta; controlli HTTP e origini provati. Il browser deve offrire registrazione/cattura; dettatura tastiera come alternativa. Niente telefonata continua garantita su HTTP né PC spento. |
| 10 | Documenti | Ricerca nel testo indicizzato e nei file testuali dei progetti; risultato con fonte apribile. PDF e altri formati richiedono lettore/importazione supportati. Scansione limitata e dichiarata. |
| 11 | Promemoria contestuali | Una volta alla prossima apertura/uso del progetto; rilevazione finestra ogni 30 secondi quando configurati. Prova di consegna unica. |
| 12 | Monitoraggio | Differenze nei documenti, Git e attività/blocchi; baseline persistente e nessuna notifica se invariati. Non esegue continuamente i test dei progetti senza una richiesta. |
| 13 | Recupero | Routine riprese dal passo salvato senza ripetere quelli completati; lavori interrotti/incerti visibili. I passi con effetto incerto non vengono ripetuti automaticamente. |
| 14 | Modelli | Instradamento general/coding/quick fra connessioni già configurate. Quota di chiamate API persistente, non un preventivo in euro. Nessuna nuova API a pagamento viene collegata automaticamente. |
| 15 | Mac update | Manifest RSA, architettura e SHA-256; firma ad-hoc del bundle, sostituzione con precedente conservato, rollback senza conferma di avvio. Esito delle prove native nei report Mac-updater della release. La 0.11 richiede installare una volta la 0.12 perché non conteneva questo updater. |

## Comandi utili
- Mostra cruscotto / chiudi cruscotto.
- Ricorda che… / correggi il ricordo… / dimentica quel ricordo.
- Quando dico «…» intendo «…».
- Correggi [problema] nel progetto [nome].
- Cerca [testo] nei documenti dei progetti.
- Ricordami [attività] quando apro [progetto].
- Crea una routine lavoro… / iniziamo a lavorare / pausa routine / riprendi routine…
- Fai backup completo / ripristina backup.

Il collegamento account deve essere valido per le richieste AI. Non vengono importate automaticamente chat cloud non accessibili, né aggirati permessi del sistema. I report tecnici restano facoltativi e senza endpoint attivo.
