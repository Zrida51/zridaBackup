#!/bin/bash

# Datum ermitteln
DATE=$(date +%Y%m%d)

# Zielordner komprimieren
tar czvf /home/$USER/home_$DATE.tar.gz /home
tar czvf /home/$USER/etc_$DATE.tar.gz /etc

# Archivnamen anpassen
ARCHIVE_NAME=$(date +%d-%m-%Y_%H-%M-%S).tar.gz
mv /home/$USER/home_$DATE.tar.gz /home/$USER/backup/home_$ARCHIVE_NAME
mv /home/$USER/etc_$DATE.tar.gz /home/$USER/backup/etc_$ARCHIVE_NAME

# Paketliste erstellen
dpkg --get-selections > /home/$USER/backup/package-list_$ARCHIVE_NAME

# Ausgaben für Logs
echo "Backup-Skript gestartet"
echo "Zielordner komprimiert"
echo "Archive in Backup-Verzeichnis verschoben"
echo "Paketliste erstellt"
echo "Backup-Skript beendet"
