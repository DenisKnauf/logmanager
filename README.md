Excuse, no english help text, yet.
But see lmtab.example for an example.

English:

Logmanager
==========

Dependencies
------------

You need a posix-shell and fuser.

Install
-------

Untar archive or checkout repository.
You only need one logmanager per machine, all users can use this at the same time.

It is not important to add it to PATH or move files to /usr/local/bin or something like that.

Per user you need the configfile `~/.lmtab`. See also `lmtab.example`.

Everytime you change something, you should run a test:

	env -i ./logmanager -N

This will do nothing, but shows, what will happen.

Attantion: Also if this command will not fail, it is possible, that logmanager as cronjob will fail.
You should test logmanager as cronjob with testfiles first.
If it works, you can use logmanager.
Possible errors are: fuser not found. You need changes to `~/.lmtab` for setting PATH.

Cronjob
-------

It is enough to add logmanager to crontab as user, you will run it:

	0 3 * * * exec /path/to/logmanager

This will run logmanager everytime at 3:00. It will use his `~/.lmtab`.

-------------------------------------------------------------------------------

Deutsch:

Logmanager
==========

Irgendwo das Archiv entpacken.  Es reicht eigentlich auf jeder Maschine nur
einmal Logmanager zu installieren und es für jeden Zweck gleichzeitig zu
verwenden.
Pro Benutzer gibt es eine Config-file `~/.lmtab`,
siehe dazu `lmtab.example`.

Tests werden bei jeder Änderung empfohlen:

	env -i ./logmanager -N

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
