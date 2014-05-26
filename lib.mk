REBAR = $(CURDIR)/rebar/rebar

# Create a temporary copy of the rebar config, if it exists, and copy
# our dynamic configuration script into place.  See
# https://github.com/basho/rebar/wiki/Dynamic-configuration for
# details on what is happening here
define rebar-setup
#
# ******** Calling rebar in $@ with dependency processing disabled
test -f $@/rebar.config \
    && cp $@/rebar.config $@/rebarTMP.config \
    || true
cp build/rebar.config.script $@/rebarTMP.config.script
endef

# Clean up our mess
define rebar-teardown
test -f $@/rebarTMP.config \
    && rm $@/rebarTMP.config \
    || true
rm $@/rebarTMP.config.script

endef

# Run the actual rebar build, making sure that ERL_LIBS is properly
# defined.  Setting ERL_LIBS may be deprecated since we might want to
# handle it outside of this script
define rebar-compile
$(rebar-setup)
cd $@ && ERL_LIBS=$(PWD) $(REBAR) -C rebarTMP.config compile
$(rebar-teardown)
endef

# Run the actual rebar escriptize command, making sure that ERL_LIBS
# is properly defined.  Setting ERL_LIBS may be deprecated since we
# might want to handle it outside of this script
define rebar-escriptize
$(rebar-setup)
cd $@ && ERL_LIBS=$(PWD) $(REBAR) -C rebarTMP.config escriptize
$(rebar-teardown)
endef
