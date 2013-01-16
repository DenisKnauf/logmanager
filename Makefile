
logmanager.tar: logmanager logarchiver logcompressor logcleaner Makefile lmtab.example README.md
	pax -w -s '!^!logmanager/!' -f $@ -- $^

%.tar.gz: %.tar
	gzip -c < $< > $@
%.tar.lzma: %.tar
	lzma -c < $< > $@
%.tar.xz: %.tar
	xz -c < $< > $@
%.tar.bz2: %.tar
	bzip2 -c < $< > $@

testdir:
	mkdir $@

testdir/.lmtab: testdir
	echo ./ \*.log 60 > $@.tmp
	mv $@.tmp $@

testdir/.prepare: testdir testdir/.lmtab
	touch $</aaaaaaaaaaaaa.log
	for f in 1 2 3 4 5 6 7 8 9 10 ; do touch $</"logfile-$$f-`date +%Y%m%d%H%M%S`.log" || exit 1 ; done
	touch $</no_log
	touch $</no.log.txt
	touch $@
.PHONY: testdir/.prepare

test: testdir/.prepare testdir/.lmtab
	cd testdir ; env -i HOME="$$HOME" ../logmanager -nc .lmtab
	cd testdir ; env -i HOME="$$HOME" ../logmanager -Nc .lmtab
	cd testdir ; env -i HOME="$$HOME" ../logmanager -c .lmtab
