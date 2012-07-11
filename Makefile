
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
