include build/lib.mk

TARGETS = $(shell ls | egrep -v ^build$)

.PHONY: all $(TARGETS)

all: $(TARGETS)

erldns: rebar lager recon folsom cowboy poolboy hottub jsx dns
	$(rebar-compile)

lager: rebar goldrush
	$(rebar-compile)

goldrush: rebar
	$(rebar-compile)

recon: rebar
	$(rebar-compile)

folsom: rebar bear meck
	$(rebar-compile)

bear: rebar
	$(rebar-compile)

meck: rebar
	$(rebar-compile)

cowboy: rebar cowlib ranch
	$(rebar-compile)

cowlib: rebar
	$(rebar-compile)

ranch: rebar
	$(rebar-compile)

poolboy: rebar
	$(rebar-compile)

hottub: rebar
	$(rebar-compile)

jsx: rebar
	$(rebar-compile)

dns: rebar base32
	$(rebar-compile)

base32: rebar
	$(rebar-compile)

rebar_vsn_plugin: rebar
	$(rebar-compile)

relx: rebar rebar_vsn_plugin neotoma erlware_commons erlydtl getopt
	$(rebar-compile)
	$(rebar-escriptize)

neotoma: rebar
	$(rebar-compile)

erlware_commons: rebar rebar_vsn_plugin
	$(rebar-compile)

merl:
	ERLC_FLAGS=+debug_info make -e -C merl

erlydtl: rebar merl eunit_formatters
	test -L $@/deps/merl \
	    || mkdir -p $@/deps; \
	       ln -fs ../../merl $@/deps/merl
	$(rebar-compile)

getopt: rebar
	$(rebar-compile)

eunit_formatters: rebar
	$(rebar-compile)

rebar:
	cd rebar && ./bootstrap debug

sync: rebar
	$(rebar-compile)

exec: rebar
	$(rebar-compile)

gproc: rebar
	$(rebar-compile)

percept2: rebar
	$(rebar-compile)

ibrowse: rebar
	$(rebar-compile)

yaws: rebar ibrowse
	$(rebar-compile)
	cd yaws && erlc +debug_info -o ebin contrib/*.erl

riakc: rebar riak_pb
	$(rebar-compile)

riak_pb: rebar protobuffs
	$(rebar-compile)

protobuffs: rebar meck
	$(rebar-compile)

mimeparse: mimeparse/ebin/mimeparse.beam
mimeparse/ebin/mimeparse.beam: mimeparse/mimeparse.erl
	mkdir -p mimeparse/ebin
	cd mimeparse && erlc +debug_info -o ebin mimeparse.erl

jiffy: rebar
	$(rebar-compile)

uuid:
	cd uuid && make

epistula: rebar
	$(rebar-compile)
