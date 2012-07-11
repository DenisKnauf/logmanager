
logmanager.tar: logmanager logarchiver logcompressor logcleaner Makefile
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
	echo $</ \*.log 60 > $@.tmp
	mv $@.tmp $@

testdir/.prepare: testdir testdir/.lmtab
	for f in `seq 1 10` ; do touch $</logfile$$f.log || exit 1 ; done
	touch $</no_log
	touch $</no.log.txt
	touch $@

test: testdir/.prepare testdir/.lmtab
	./logmanager -nc testdir/.lmtab
	./logmanager -Nc testdir/.lmtab
