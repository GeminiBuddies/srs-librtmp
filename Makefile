.PHONY: default _default install help clean destroy server srs_ingest_hls librtmp utest _prepare_dir  srs_mp4_parser srs_hls_ingester
.PHONY: clean_srs clean_modules clean_st clean_openssl clean_ffmpeg clean_nginx clean_cherrypy
.PHONY: st

# install prefix.
SRS_PREFIX=/usr/local/srs
__REAL_INSTALL=$(DESTDIR)$(SRS_PREFIX)

default:
	$(MAKE) _default

_default: server srs_ingest_hls librtmp utest __modules  srs_mp4_parser srs_hls_ingester
	@bash objs/_srs_build_summary.sh

help:
	@echo "Usage: make <help>|<clean>|<destroy>|<server>|<librtmp>|<utest>|<install>|<uninstall>"
	@echo "     help               display this help menu"
	@echo "     clean              cleanup project and all depends"
	@echo "     destroy            Cleanup all files for this platform in objs/Platform-Linux-5.8.0-SRS3"
	@echo "     server             build the srs(simple rtmp server) over st(state-threads)"
	@echo "     librtmp            build the client publish/play library, and samples"
	@echo "     utest              build the utest for srs"
	@echo "     install            install srs to the prefix path"
	@echo "     uninstall          uninstall srs from prefix path"
	@echo "To clean special module:"
	@echo "     clean_st           Clean depend st-srs in objs/Platform-Linux-5.8.0-SRS3/st-srs"
	@echo "     clean_openssl      Clean depend openssl in objs"
	@echo "     clean_ffmpeg       Clean depend ffmpeg in objs"
	@echo "@remark all modules will auto genearted and build"
	@echo "For example:"
	@echo "     make"
	@echo "     make help"

doclean:
	(cd objs && rm -rf srs srs_utest  srs_mp4_parser srs_hls_ingester)
	(cd objs && rm -rf src/* include lib)
	(mkdir -p objs/utest && cd objs/utest && rm -rf *.o *.a)
	(cd research/librtmp && make clean)
	(cd research/api-server/static-dir && rm -rf crossdomain.xml forward live players)

clean: clean_srs clean_modules
	@echo "You can clean each some components, see make help"

destroy: clean_st clean_openssl clean_ffmpeg clean_nginx clean_cherrypy
	(cd objs && rm -rf Platform-Linux-5.8.0-SRS3)

clean_srs:
	(cd objs && rm -rf srs srs_utest)
	(cd objs/Platform-Linux-5.8.0-SRS3 && rm -rf src/* include/* lib/* utest/*)

clean_modules:
	(cd objs && rm -rf  srs_mp4_parser srs_hls_ingester)

clean_st:
	(cd objs/Platform-Linux-5.8.0-SRS3/st-srs && make clean)

clean_openssl:
	(cd objs/Platform-Linux-5.8.0-SRS3 && rm -rf openssl*)

clean_ffmpeg:
	(cd objs/Platform-Linux-5.8.0-SRS3 && rm -rf ffmpeg)

clean_nginx:
	(cd objs && rm -rf nginx)

clean_cherrypy:
	(cd research/librtmp && make clean)
	(cd research/api-server/static-dir && rm -rf crossdomain.xml forward live players)

__modules: server

server: _prepare_dir
	@echo "Ingore srs(simple rtmp server) for srs-librtmp"

srs_mp4_parser: _prepare_dir server
	@echo "Ingore the srs_mp4_parser for srs-librtmp"

srs_hls_ingester: _prepare_dir server
	@echo "Ingore the srs_hls_ingester for srs-librtmp"

uninstall: 
	@echo "Disable uninstall for srs-librtmp"

install: 
	@echo "Disable install for srs-librtmp"

librtmp: server
	@echo "Building the client publish/play library."
	$(MAKE) -f objs/Makefile librtmp
	@echo "Building the srs-librtmp example."
	(cd research/librtmp && $(MAKE) EXTRA_CXXFLAGS="" nossl)

utest: server
	@echo "Ignore utest for it's disabled."

# the ./configure will generate it.
_prepare_dir:
	@mkdir -p objs
	@mkdir -p objs/src/core
	@mkdir -p objs/src/kernel
	@mkdir -p objs/src/protocol
	@mkdir -p objs/src/libs
	@mkdir -p objs/include
	@mkdir -p objs/lib
