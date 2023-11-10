#!/bin/bash

# Prüfen, ob das Skript mit root-Rechten gestartet wurde
if [ "$EUID" -ne 0 ]; then
  echo "Dieses Skript benötigt root-Rechte. Bitte starten Sie es mit sudo."
  exit 1
fi

# Den Nutzer warnen, dass alle Daten überschrieben werden
echo "Achtung: Dieses Skript wird alle Daten auf Ihrem System überschreiben. Sind Sie sicher, dass Sie fortfahren möchten? (y/n)"
read answer

# Nur weitermachen, wenn y eingegeben wurde
if [ "$answer" = "y" ]; then
  # Das aktuellste Backup heraussuchen
  LATEST_BACKUP=$(ls -t /home/$USER/backup/home_*.tar.gz | head -n 1)

  # Das Archiv extrahieren
  tar xzvf $LATEST_BACKUP -C /

  # Die Pakete erneut installieren
  dpkg --set-selections < /home/$USER/backup/package-list_$(basename $LATEST_BACKUP)
  apt-get dselect-upgrade

  # Ausgaben für Logs
  echo "Restore-Skript gestartet"
  echo "Aktuellstes Backup ausgewählt: $LATEST_BACKUP"
  echo "Archive extrahiert"
  echo "Pakete installiert"
  echo "Restore-Skript beendet"
else
  # Bei n oder anderer Eingabe abbrechen
  echo "Restore-Skript abgebrochen"
  exit 0
fi
