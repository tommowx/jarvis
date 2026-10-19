# Jarvis per macOS — anteprima sperimentale

Questa anteprima è separata dalla release Windows. I pacchetti per Apple Silicon e Intel vengono compilati su runner macOS, con helper Speech Swift e firma ad-hoc. Non è una notarizzazione Apple e non sostituisce le prove su un Mac dell’utente.

## Installazione
Scarica il pacchetto adatto al processore, estrai Jarvis.app e spostalo nella tua cartella Applicazioni. Se macOS lo segnala come sviluppatore non identificato, usa soltanto il normale percorso di autorizzazione previsto da macOS dopo aver verificato la provenienza: nessuno script disabilita Gatekeeper. Se il tuo Mac è gestito da un amministratore, valgono le sue regole.

## Funzioni previste nell’anteprima
Interfaccia animata, testo con modello collegato, memoria interna, importazioni, mappa, ricerca immagini, voce di sistema, riconoscimento Speech macOS italiano o inglese, apertura app, lettura finestre di base, volume, file testuali e backup. Il motore Speech può richiedere rete o risorse linguistiche Apple se il riconoscimento sul dispositivo non è disponibile.

Consenti Microfono e Riconoscimento vocale. Per app e finestre servono i permessi Accessibilità e Automazione richiesti da macOS. Il consenso iniziale di Jarvis non li sostituisce.

## Limiti espliciti
- Microfono, permessi e automazione su un Mac fisico non ancora verificati.
- Niente generatore locale SD-Turbo, lettore PDF/DOCX/XLSX Python o funzioni avanzate del desktop non elencate in questa anteprima.
- Disposizione finestre su monitor, scorciatoie e albero completo dei controlli non ancora portati.
- Auto-modifica richiede sorgenti e dipendenze di sviluppo sul Mac; non è pronta su un’installazione pulita senza questi componenti.
- La chiavetta viene cercata nei volumi montati con cartella Obsidian; la selezione tramite seriale Windows non si applica.

I report di compilazione distinguono compilazione, avvio e prove fisiche non eseguite. Non dichiarare questa anteprima equivalente alla versione Windows.

## Aggiornamento dalla 0.12
La 0.11 non aveva un updater: installa una volta la nuova anteprima. Dalla 0.12 vengono cercati soltanto manifest Mac firmati con la chiave pubblica del progetto, senza elevazione di privilegi. Se la cartella dell’app non è scrivibile, viene segnalato il limite. Il bundle precedente viene conservato e ripristinato se manca la conferma del nuovo avvio. I report Mac-updater descrivono la prova di sostituzione e avvio sul runner Mac; permessi fisici e notarizzazione restano separati.
