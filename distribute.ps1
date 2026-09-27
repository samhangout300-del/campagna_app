# --- CONFIGURAZIONE ---
# Percorso del tuo file APK (usa i backslash per Windows)
$APK_PATH = ".\build\app\outputs\flutter-apk\app-release.apk"

# ID della tua app Android in Firebase
$APP_ID = "1:589816305171:android:810ae9c7fff2b3ad3b91e6"

# Lista di email dei tester separate da virgola
$TESTER_GROUPS = "Eremiti"

# Note di rilascio
$RELEASE_NOTES = "Nuova build automatica creata da Windows!"
# ----------------------

Write-Host "Avvio del caricamento su Firebase App Distribution..." -ForegroundColor Cyan

# Esecuzione del comando Firebase CLI (l'accento grave ` serve per andare a capo in PowerShell)
firebase appdistribution:distribute $APK_PATH `
    --app $APP_ID `
    --groups $TESTER_GROUPS `
    --release-notes $RELEASE_NOTES

# Controllo dell'esito
if ($LASTEXITCODE -eq 0) {
    Write-Host "APK distribuito con successo ai tuoi tester!" -ForegroundColor Green
} else {
    Write-Host "Si è verificato un errore durante la distribuzione dell'APK." -ForegroundColor Red
    exit $LASTEXITCODE
}
