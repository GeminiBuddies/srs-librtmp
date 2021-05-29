.PHONY: default _default install help clean destroy server srs_ingest_hls librtmp utest _prepare_dir  srs_mp4_parser srs_hls_ingester
.PHONY: clean_srs clean_modules clean_st clean_openssl clean_ffmpeg clean_nginx clean_cherrypy
.PHONY: st

# install prefix.
SRS_PREFIX=/usr/local/srs
__REAL_INSTALL=$(DESTDIR)$(SRS_PREFIX)

default:
	$(MAKE) _default

_default: librtmp
	@bash objs/_srs_build_summary.sh

help:
	@echo "Usage: make <help>|<librtmp>"
	@echo "     help               display this help menu"
	@echo "     clean              cleanup project and all depends"
	@echo "     librtmp            build the client publish/play library, and samples"
	@echo "@remark all modules will auto genearted and build"
	@echo "For example:"
	@echo "     make"
	@echo "     make help"

doclean:
	(cd objs && rm -rf src/* include lib)
	(cd research/librtmp && make clean)

librtmp: _prepare_dir
	@echo "Building the client publish/play library."
	$(MAKE) -f objs/Makefile librtmp
	@echo "Building the srs-librtmp example."
	(cd research/librtmp && $(MAKE) EXTRA_CXXFLAGS="" ssl)

# the ./configure will generate it.
_prepare_dir:
	@mkdir -p objs
	@mkdir -p objs/src/core
	@mkdir -p objs/src/kernel
	@mkdir -p objs/src/protocol
	@mkdir -p objs/src/libs
	@mkdir -p objs/include
	@mkdir -p objs/lib
