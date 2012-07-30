Logmanager
==========

Irgendwo das Archiv entpacken.  Es reicht eigentlich auf jeder Maschine nur
einmal Logmanager zu installieren und es für jeden Zweck gleichzeitig zu
verwenden.
Pro Benutzer gibt es eine Config-file `~/.lmtab`,
siehe dazu `lmtab.example`.

Tests werden bei jeder Änderung empfohlen:

  # env -i ./logmanager -N

Es sollten die meisten Umgebungsvariablenprobleme dadurch entdeckt
werden können.  Siehe hierzu das `fuser`-Problem weiter unten.

Um den Logmanager einmal rennen zu lassen reicht:

  # ./logmanager

Weitere Informationen gibt es via `./logmanager -h`.

Cronjob
-------

Es reicht eine Zeile als Cronjob:

  0  3  *  *  * exec LOGMANAGER_PATH/logmanager

`exec` sorgt dafür,  dass die Shell,  die den logmanager startet ersetzt
wird,  statt dass sie den logmanager aufruft und dann wartet.
Diese Shell wird garnicht benötigt,  hat also keinen Nachteil.

fuser
-----

`fuser` ist ein Programm zum Abfragen,  ob eine Datei von einem Prozess
noch benötigt wird.  Dieses ist **unbedingt** erforderlich.
Es kommt leider auch vor,  dass dieses nicht gefunden werden kann,
etwa wenn es in `/usr/sbin` (einige Solaris-Maschinen),  installiert ist.
In diesem Falle muss dieser Pfad bekannt gegeben werden.
Hierzu ist etwa diese Zeile in der `~/.lmtab` hilfreich:

	PATH=${PATH}:/usr/sbin
