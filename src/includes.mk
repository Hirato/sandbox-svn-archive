override CXXFLAGS+= -Wall -fsigned-char -fno-exceptions -fno-rtti
override ENET_CFLAGS+= -g -O2

PLATFORM= $(shell uname -s)
PLATFORM_PREFIX=debug

STRIP=
ifeq (,$(findstring -g,$(CXXFLAGS)))
ifeq (,$(findstring -pg,$(CXXFLAGS)))
	STRIP=strip
	PLATFORM_PREFIX=sandbox
endif
endif

MV=mv

ifeq ($(shell uname -m),x86_64)
	MACHINENAME?=64
endif

ifeq ($(shell uname -m),i686)
	MACHINENAME?=32
endif

ifeq ($(shell uname -m),i586)
	MACHINENAME?=32
endif

ifeq ($(shell uname -m),i486)
	MACHINENAME?=32
endif

# assume 64bit if in doubt
MACHINENAME?=64

INCLUDES= -Ishared -Iengine -Ienet/include
CLIENT_INCLUDES= $(INCLUDES) -I/usr/X11R6/include `sdl2-config --cflags`
CLIENT_LIBS= $(ENET_OBJS) -L/usr/X11R6/lib `sdl2-config --libs` -lSDL2_image -lSDL2_mixer -lz -lGL -lX11

SERVER_INCLUDES= -DSTANDALONE $(INCLUDES)
SERVER_LIBS= $(ENET_OBJS) -lz
MASTER_LIBS= $(SERVER_LIBS)

LAUNCHER_LIBS= `wx-config --libs`
LAUNCHER_FLAGS= `wx-config --cxxflags`

PLATFORM_TYPE=windows

ifeq ($(PLATFORM),SunOS)
	CLIENT_LIBS+= -lsocket -lnsl -lX11
	SERVER_LIBS+= -lsocket -lnsl
	PLATFORM_TYPE=unix
endif

ifeq ($(PLATFORM),Linux)
	CLIENT_LIBS+= -lrt
	PLATFORM_TYPE=unix
endif

CLIENT_OBJS= \
	shared/crypto.o \
	shared/geom.o \
	shared/glemu.o \
	shared/stream.o \
	shared/tools.o \
	shared/zip.o \
	engine/aa.o \
	engine/bih.o \
	engine/blend.o \
	engine/client.o	\
	engine/command.o \
	engine/console.o \
	engine/decal.o \
	engine/dynlight.o \
	engine/grass.o \
	engine/light.o \
	engine/main.o \
	engine/material.o \
	engine/movie.o \
	engine/normal.o	\
	engine/octa.o \
	engine/octaedit.o \
	engine/octarender.o \
	engine/pvs.o \
	engine/physics.o \
	engine/rendergl.o \
	engine/renderlights.o \
	engine/rendermodel.o \
	engine/renderparticles.o \
	engine/rendersky.o \
	engine/rendertext.o \
	engine/renderva.o \
	engine/server.o	\
	engine/serverbrowser.o \
	engine/shader.o \
	engine/sound.o \
	engine/texture.o \
	engine/ui.o \
	engine/water.o \
	engine/world.o \
	engine/worldio.o

FPSCLIENT_OBJS = \
	fpsgame/ai.o \
	fpsgame/client.o \
	fpsgame/entities.o \
	fpsgame/fps.o \
	fpsgame/monster.o \
	fpsgame/movable.o \
	fpsgame/render.o \
	fpsgame/scoreboard.o \
	fpsgame/server.o \
	fpsgame/waypoint.o \
	fpsgame/weapon.o

SSPCLIENT_OBJS = \
	sspgame/ssp.o \
	sspgame/sspent.o \
	sspgame/sspentities.o \
	sspgame/sspweapons.o \
	sspgame/sspmonster.o \
	sspgame/ssprender.o \
	sspgame/sspstubs.o

RPGCLIENT_OBJS = \
	rpggame/rpg.o \
	rpggame/rpgaction.o \
	rpggame/rpgai.o \
	rpggame/rpgcamera.o \
	rpggame/rpgchar.o \
	rpggame/rpgconfig.o \
	rpggame/rpgcontainer.o \
	rpggame/rpgeffect.o \
	rpggame/rpgentities.o \
	rpggame/rpggui.o \
	rpggame/rpghud.o \
	rpggame/rpgio.o \
	rpggame/rpgitem.o \
	rpggame/rpgobstacle.o \
	rpggame/rpgplatform.o \
	rpggame/rpgproj.o \
	rpggame/rpgscript.o \
	rpggame/rpgstats.o \
	rpggame/rpgstatus.o \
	rpggame/rpgstubs.o \
	rpggame/rpgrender.o \
	rpggame/rpgreserved.o \
	rpggame/rpgtest.o \
	rpggame/rpgtrigger.o \
	rpggame/waypoint.o

MOVIECLIENT_OBJS= \
	moviecube/action.o \
	moviecube/characterinfo.o \
	moviecube/client.o \
	moviecube/clientmode.o \
	moviecube/control.o \
	moviecube/entities.o \
	moviecube/mapentities.o \
	moviecube/movable.o \
	moviecube/moviecube.o \
	moviecube/render.o \
	moviecube/camera.o \
	moviecube/server.o

ENET_OBJS= \
	enet/callbacks.o \
	enet/host.o \
	enet/list.o \
	enet/packet.o \
	enet/peer.o \
	enet/protocol.o \
	enet/unix.o \
	enet/win32.o

KRSCLIENT_OBJS = \
	krsgame/krs.o \
	krsgame/krsai.o \
	krsgame/krsents.o \
	krsgame/krshud.o \
	krsgame/krsrender.o \
	krsgame/krsstubs.o \
	krsgame/krsscript.o \
	krsgame/waypoint.o

PZLCLIENT_OBJS = \
	pzlgame/pzl.o \
	pzlgame/pzlents.o \
	pzlgame/pzlhud.o \
	pzlgame/pzlrender.o \
	pzlgame/pzlstubs.o \
	pzlgame/pzlscript.o

CLIENT_PCH = \
	shared/cube.h.gch \
	engine/engine.h.gch \
	fpsgame/game.h.gch \
	sspgame/sspgame.h.gch \
	rpggame/rpggame.h.gch \
	moviecube/game.h.gch \
	krsgame/krsgame.h.gch \
	pzlgame/pzlgame.h.gch

SERVER_OBJS= \
	shared/crypto-standalone.o \
	shared/stream-standalone.o \
	shared/tools-standalone.o \
	engine/command-standalone.o \
	engine/server-standalone.o \
	engine/worldio-standalone.o

FPSSERVER_OBJS = \
	fpsgame/entities-standalone.o \
	fpsgame/server-standalone.o

MOVIESERVER_OBJS= \
	moviecube/server-standalone.o \
	moviecube/entities-standalone.o

MASTER_OBJS= \
	shared/crypto-standalone.o \
	shared/stream-standalone.o \
	shared/tools-standalone.o \
	engine/command-standalone.o \
	engine/master-standalone.o

LAUNCHER_OBJS= \
	launcher/pasl.o \
	launcher/paslapp.o

ifeq (unix,$(PLATFORM_TYPE))
	ENET_XCFLAGS := $(shell ./check_enet.sh $(CC) $(CFLAGS))
endif

default: all

all: client server

$(ENET_OBJS): CFLAGS += $(ENET_CFLAGS) $(ENET_XCFLAGS) -Ienet/include -Wno-error

pasl:   $(LAUNCHER_OBJS)
	$(CXX) $(CXXFLAGS) -o launch $(LAUNCHER_OBJS) $(LAUNCHER_LIBS)
	$(MV) launch ../launcher
ifneq (,$(STRIP))
	$(STRIP) ../launcher
endif
	chmod +x ../launcher

clean:
	$(RM) $(ENET_OBJS) $(SERVER_OBJS) $(FPSSERVER_OBJS) $(MOVIESERVER_OBJS) $(CLIENT_PCH) $(CLIENT_OBJS) $(SSPCLIENT_OBJS) $(RPGCLIENT_OBJS) $(FPSCLIENT_OBJS) $(MOVIECLIENT_OBJS) $(KRSCLIENT_OBJS) $(PZLCLIENT_OBJS) $(LAUNCHER_OBJS) $(MASTER_OBJS) $(PLATFORM_PREFIX)_server_* $(PLATFORM_PREFIX)_client_*


$(LAUNCHER_OBJS): CXXFLAGS += $(LAUNCHER_FLAGS)

%.h.gch: %.h
	$(CXX) $(CXXFLAGS) -o $(subst .h.gch,.tmp.h.gch,$@) $(subst .h.gch,.h,$@)
	$(MV) $(subst .h.gch,.tmp.h.gch,$@) $@

%-standalone.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $(subst -standalone.o,.cpp,$@)

$(CLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES)

$(filter shared/%,$(CLIENT_OBJS)): $(filter shared/%,$(CLIENT_PCH))
$(filter engine/%,$(CLIENT_OBJS)): $(filter engine/%,$(CLIENT_PCH))

$(SSPCLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Isspgame
$(SSPCLIENT_OBJS): $(filter sspgame/%,$(CLIENT_PCH))

$(FPSCLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Ifpsgame
$(FPSCLIENT_OBJS): $(filter fpsgame/%,$(CLIENT_PCH))

$(RPGCLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Irpggame
$(RPGCLIENT_OBJS): $(filter rpggame/%,$(CLIENT_PCH))

$(MOVIECLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Imoviecube
$(MOVIECLIENT_OBJS): $(filter moviecube/%,$(CLIENT_PCH))

$(KRSCLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Ikrsgame
$(KRSCLIENT_OBJS): $(filter krsgame/%,$(CLIENT_PCH))

$(PZLCLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES) -Ipzlgame
$(PZLCLIENT_OBJS): $(filter pzlgame/%,$(CLIENT_PCH))

$(SERVER_OBJS): CXXFLAGS += $(SERVER_INCLUDES)
$(filter-out $(SERVER_OBJS),$(MASTER_OBJS)): CXXFLAGS += $(SERVER_INCLUDES)

$(FPSSERVER_OBJS): CXXFLAGS += -Ifpsgame $(SERVER_INCLUDES)
$(MOVIESERVER_OBJS): CXXFLAGS += -Imoviecube $(SERVER_INCLUDES)

shared/cube2font.o: shared/cube2font.c
	$(CXX) $(CXXFLAGS) -c -o $@ $< `freetype-config --cflags`


client: client-fps client-krs client-movie client-rpg client-ssp #client-pzl
server: server-fps server-movie

client-fps:$(ENET_OBJS) $(CLIENT_OBJS) $(FPSCLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_fps $(CLIENT_OBJS) $(FPSCLIENT_OBJS) $(CLIENT_LIBS)

client-ssp:$(ENET_OBJS) $(CLIENT_OBJS) $(SSPCLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_ssp $(CLIENT_OBJS) $(SSPCLIENT_OBJS) $(CLIENT_LIBS)

client-rpg:$(ENET_OBJS) $(CLIENT_OBJS) $(RPGCLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_rpg $(CLIENT_OBJS) $(RPGCLIENT_OBJS) $(CLIENT_LIBS)

client-movie:$(ENET_OBJS) $(CLIENT_OBJS) $(MOVIECLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_movie $(CLIENT_OBJS) $(MOVIECLIENT_OBJS) $(CLIENT_LIBS)

client-krs:$(ENET_OBJS) $(CLIENT_OBJS) $(KRSCLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_krs $(CLIENT_OBJS) $(KRSCLIENT_OBJS) $(CLIENT_LIBS)

client-pzl:$(ENET_OBJS) $(CLIENT_OBJS) $(PZLCLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_client_$(MACHINENAME)_pzl $(CLIENT_OBJS) $(PZLCLIENT_OBJS) $(CLIENT_LIBS)

server-fps: $(ENET_OBJS) $(SERVER_OBJS) $(FPSSERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_server_$(MACHINENAME)_fps $(SERVER_OBJS) $(FPSSERVER_OBJS) $(SERVER_LIBS)

server-movie: $(ENET_OBJS) $(SERVER_OBJS) $(MOVIESERVER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_server_$(MACHINENAME)_movie $(SERVER_OBJS) $(MOVIESERVER_OBJS) $(SERVER_LIBS)

master: $(ENET_OBJS) $(MASTER_OBJS)
	$(CXX) $(CXXFLAGS) -o $(PLATFORM_PREFIX)_master $(MASTER_OBJS) $(MASTER_LIBS)


install: all
	$(MV) $(PLATFORM_PREFIX)_{client,server}_$(MACHINENAME)* ../bin/
ifneq (,$(STRIP))
	strip ../bin/$(PLATFORM_PREFIX)_{client,server}_$(MACHINENAME)*
endif
	chmod +x ../bin/$(PLATFORM_PREFIX)_{client,server}_$(MACHINENAME)*

cube2font: shared/cube2font.o
	$(CXX) $(CXXFLAGS) -o cube2font shared/cube2font.o `freetype-config --libs` -lz

depend:
	makedepend -fincludes.mk -Y -Ienet/include $(subst .o,.c,$(ENET_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine $(subst .o,.cpp,$(CLIENT_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine -Ifpsgame $(subst .o,.cpp,$(FPSCLIENT_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine -Isspgame $(subst .o,.cpp,$(SSPCLIENT_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine -Irpggame $(subst .o,.cpp,$(RPGCLIENT_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine -Ikrsgame $(subst .o,.cpp,$(KRSCLIENT_OBJS))
	makedepend -fincludes.mk -a -Y -Ishared -Iengine -Imoviecube $(subst .o,.cpp,$(MOVIECLIENT_OBJS))
	makedepend -fincludes.mk -a -o.h.gch -Y -Ishared -Iengine -Ifpsgame -Irpggame -Isspgame -Imoviecube -Ikrsgame $(subst .h.gch,.h,$(CLIENT_PCH))
	makedepend -fincludes.mk -a -o-standalone.o -Y -Ishared -Iengine -DSTANDALONE $(subst -standalone.o,.cpp,$(SERVER_OBJS))
	makedepend -fincludes.mk -a -o-standalone.o -Y -Ishared -Iengine -Ifpsgame -DSTANDALONE $(subst -standalone.o,.cpp,$(FPSSERVER_OBJS))
	makedepend -fincludes.mk -a -o-standalone.o -Y -Ishared -Iengine -Imoviecube -DSTANDALONE $(subst -standalone.o,.cpp,$(MOVIESERVER_OBJS))
	makedepend -fincludes.mk -a -o-standalone.o -Y -Ishared -Iengine -DSTANDALONE $(subst -standalone.o,.cpp,$(filter-out $(SERVER_OBJS), $(MASTER_OBJS)))

engine/engine.h.gch: shared/cube.h.gch
fpsgame/game.h.gch: shared/cube.h.gch
rpggame/rpggame.h.gch: shared/cube.h.gch
sspgame/sspgame.h.gch: shared/cube.h.gch
krsgame/krsgame.h.gch: shared/cube.h.gch
moviecube/game.h.gch: shared/cube.h.gch
pzlgame/pzlgame.h.gch: shared/cube.h.gch

# DO NOT DELETE

enet/callbacks.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/callbacks.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/callbacks.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/host.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/host.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/host.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/list.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/list.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/list.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/packet.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/packet.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/packet.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/peer.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/peer.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/peer.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/protocol.o: enet/include/enet/utility.h enet/include/enet/time.h
enet/protocol.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/protocol.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/protocol.o: enet/include/enet/list.h enet/include/enet/callbacks.h
enet/unix.o: enet/include/enet/enet.h enet/include/enet/unix.h
enet/unix.o: enet/include/enet/types.h enet/include/enet/protocol.h
enet/unix.o: enet/include/enet/list.h enet/include/enet/callbacks.h

shared/crypto.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/crypto.o: shared/command.h shared/glexts.h shared/glemu.h
shared/crypto.o: shared/iengine.h shared/igame.h
shared/geom.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/geom.o: shared/command.h shared/glexts.h shared/glemu.h
shared/geom.o: shared/iengine.h shared/igame.h
shared/glemu.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/glemu.o: shared/command.h shared/glexts.h shared/glemu.h
shared/glemu.o: shared/iengine.h shared/igame.h
shared/stream.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/stream.o: shared/command.h shared/glexts.h shared/glemu.h
shared/stream.o: shared/iengine.h shared/igame.h
shared/tools.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/tools.o: shared/command.h shared/glexts.h shared/glemu.h
shared/tools.o: shared/iengine.h shared/igame.h
shared/zip.o: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
shared/zip.o: shared/command.h shared/glexts.h shared/glemu.h
shared/zip.o: shared/iengine.h shared/igame.h
engine/aa.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/aa.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/aa.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/aa.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/bih.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/bih.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/bih.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/bih.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/blend.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/blend.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/blend.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/blend.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/client.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/client.o: shared/ents.h shared/command.h shared/glexts.h
engine/client.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/client.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/client.o: engine/texture.h engine/model.h
engine/command.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/command.o: shared/ents.h shared/command.h shared/glexts.h
engine/command.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/command.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/command.o: engine/texture.h engine/model.h
engine/console.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/console.o: shared/ents.h shared/command.h shared/glexts.h
engine/console.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/console.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/console.o: engine/texture.h engine/model.h
engine/decal.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/decal.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/decal.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/decal.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/dynlight.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/dynlight.o: shared/ents.h shared/command.h shared/glexts.h
engine/dynlight.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/dynlight.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/dynlight.o: engine/texture.h engine/model.h
engine/grass.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/grass.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/grass.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/grass.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/light.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/light.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/light.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/light.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/main.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/main.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/main.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/main.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/material.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/material.o: shared/ents.h shared/command.h shared/glexts.h
engine/material.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/material.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/material.o: engine/texture.h engine/model.h
engine/movie.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/movie.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/movie.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/movie.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/normal.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/normal.o: shared/ents.h shared/command.h shared/glexts.h
engine/normal.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/normal.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/normal.o: engine/texture.h engine/model.h
engine/octa.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/octa.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/octa.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/octa.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/octaedit.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/octaedit.o: shared/ents.h shared/command.h shared/glexts.h
engine/octaedit.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/octaedit.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/octaedit.o: engine/texture.h engine/model.h
engine/octarender.o: engine/engine.h shared/cube.h shared/tools.h
engine/octarender.o: shared/geom.h shared/ents.h shared/command.h
engine/octarender.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/octarender.o: shared/igame.h engine/world.h engine/octa.h
engine/octarender.o: engine/light.h engine/bih.h engine/texture.h
engine/octarender.o: engine/model.h
engine/pvs.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/pvs.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/pvs.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/pvs.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/physics.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/physics.o: shared/ents.h shared/command.h shared/glexts.h
engine/physics.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/physics.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/physics.o: engine/texture.h engine/model.h engine/mpr.h
engine/rendergl.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/rendergl.o: shared/ents.h shared/command.h shared/glexts.h
engine/rendergl.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/rendergl.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/rendergl.o: engine/texture.h engine/model.h
engine/renderlights.o: engine/engine.h shared/cube.h shared/tools.h
engine/renderlights.o: shared/geom.h shared/ents.h shared/command.h
engine/renderlights.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/renderlights.o: shared/igame.h engine/world.h engine/octa.h
engine/renderlights.o: engine/light.h engine/bih.h engine/texture.h
engine/renderlights.o: engine/model.h
engine/rendermodel.o: engine/engine.h shared/cube.h shared/tools.h
engine/rendermodel.o: shared/geom.h shared/ents.h shared/command.h
engine/rendermodel.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/rendermodel.o: shared/igame.h engine/world.h engine/octa.h
engine/rendermodel.o: engine/light.h engine/bih.h engine/texture.h
engine/rendermodel.o: engine/model.h engine/ragdoll.h engine/animmodel.h
engine/rendermodel.o: engine/vertmodel.h engine/skelmodel.h engine/hitzone.h
engine/rendermodel.o: engine/md2.h engine/md3.h engine/md5.h engine/obj.h
engine/rendermodel.o: engine/smd.h engine/iqm.h
engine/renderparticles.o: engine/engine.h shared/cube.h shared/tools.h
engine/renderparticles.o: shared/geom.h shared/ents.h shared/command.h
engine/renderparticles.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/renderparticles.o: shared/igame.h engine/world.h engine/octa.h
engine/renderparticles.o: engine/light.h engine/bih.h engine/texture.h
engine/renderparticles.o: engine/model.h engine/explosion.h
engine/renderparticles.o: engine/lensflare.h engine/lightning.h
engine/rendersky.o: engine/engine.h shared/cube.h shared/tools.h
engine/rendersky.o: shared/geom.h shared/ents.h shared/command.h
engine/rendersky.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/rendersky.o: shared/igame.h engine/world.h engine/octa.h
engine/rendersky.o: engine/light.h engine/bih.h engine/texture.h
engine/rendersky.o: engine/model.h
engine/rendertext.o: engine/engine.h shared/cube.h shared/tools.h
engine/rendertext.o: shared/geom.h shared/ents.h shared/command.h
engine/rendertext.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/rendertext.o: shared/igame.h engine/world.h engine/octa.h
engine/rendertext.o: engine/light.h engine/bih.h engine/texture.h
engine/rendertext.o: engine/model.h
engine/renderva.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/renderva.o: shared/ents.h shared/command.h shared/glexts.h
engine/renderva.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/renderva.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/renderva.o: engine/texture.h engine/model.h
engine/server.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/server.o: shared/ents.h shared/command.h shared/glexts.h
engine/server.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/server.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/server.o: engine/texture.h engine/model.h
engine/serverbrowser.o: engine/engine.h shared/cube.h shared/tools.h
engine/serverbrowser.o: shared/geom.h shared/ents.h shared/command.h
engine/serverbrowser.o: shared/glexts.h shared/glemu.h shared/iengine.h
engine/serverbrowser.o: shared/igame.h engine/world.h engine/octa.h
engine/serverbrowser.o: engine/light.h engine/bih.h engine/texture.h
engine/serverbrowser.o: engine/model.h
engine/shader.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/shader.o: shared/ents.h shared/command.h shared/glexts.h
engine/shader.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/shader.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/shader.o: engine/texture.h engine/model.h
engine/sound.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/sound.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/sound.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/sound.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/texture.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/texture.o: shared/ents.h shared/command.h shared/glexts.h
engine/texture.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/texture.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/texture.o: engine/texture.h engine/model.h engine/scale.h
engine/ui.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/ui.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/ui.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/ui.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/ui.o: engine/textedit.h
engine/water.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/water.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/water.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/water.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/world.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/world.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
engine/world.o: shared/iengine.h shared/igame.h engine/world.h engine/octa.h
engine/world.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
engine/worldio.o: engine/engine.h shared/cube.h shared/tools.h shared/geom.h
engine/worldio.o: shared/ents.h shared/command.h shared/glexts.h
engine/worldio.o: shared/glemu.h shared/iengine.h shared/igame.h
engine/worldio.o: engine/world.h engine/octa.h engine/light.h engine/bih.h
engine/worldio.o: engine/texture.h engine/model.h

fpsgame/ai.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/ai.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
fpsgame/ai.o: shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/client.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/client.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/client.o: shared/glemu.h shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/client.o: fpsgame/capture.h fpsgame/ctf.h fpsgame/collect.h
fpsgame/entities.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/entities.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/entities.o: shared/glemu.h shared/iengine.h shared/igame.h
fpsgame/entities.o: fpsgame/ai.h
fpsgame/fps.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/fps.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
fpsgame/fps.o: shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/monster.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/monster.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/monster.o: shared/glemu.h shared/iengine.h shared/igame.h
fpsgame/monster.o: fpsgame/ai.h
fpsgame/movable.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/movable.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/movable.o: shared/glemu.h shared/iengine.h shared/igame.h
fpsgame/movable.o: fpsgame/ai.h
fpsgame/render.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/render.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/render.o: shared/glemu.h shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/scoreboard.o: fpsgame/game.h shared/cube.h shared/tools.h
fpsgame/scoreboard.o: shared/geom.h shared/ents.h shared/command.h
fpsgame/scoreboard.o: shared/glexts.h shared/glemu.h shared/iengine.h
fpsgame/scoreboard.o: shared/igame.h fpsgame/ai.h
fpsgame/server.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/server.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/server.o: shared/glemu.h shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/server.o: fpsgame/capture.h fpsgame/ctf.h fpsgame/collect.h
fpsgame/server.o: fpsgame/extinfo.h fpsgame/aiman.h
fpsgame/waypoint.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/waypoint.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/waypoint.o: shared/glemu.h shared/iengine.h shared/igame.h
fpsgame/waypoint.o: fpsgame/ai.h
fpsgame/weapon.o: fpsgame/game.h shared/cube.h shared/tools.h shared/geom.h
fpsgame/weapon.o: shared/ents.h shared/command.h shared/glexts.h
fpsgame/weapon.o: shared/glemu.h shared/iengine.h shared/igame.h fpsgame/ai.h

sspgame/ssp.o: sspgame/sspgame.h shared/cube.h shared/tools.h shared/geom.h
sspgame/ssp.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
sspgame/ssp.o: shared/iengine.h shared/igame.h
sspgame/sspent.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/sspent.o: shared/geom.h shared/ents.h shared/command.h
sspgame/sspent.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/sspent.o: shared/igame.h
sspgame/sspentities.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/sspentities.o: shared/geom.h shared/ents.h shared/command.h
sspgame/sspentities.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/sspentities.o: shared/igame.h
sspgame/sspweapons.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/sspweapons.o: shared/geom.h shared/ents.h shared/command.h
sspgame/sspweapons.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/sspweapons.o: shared/igame.h
sspgame/sspmonster.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/sspmonster.o: shared/geom.h shared/ents.h shared/command.h
sspgame/sspmonster.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/sspmonster.o: shared/igame.h
sspgame/ssprender.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/ssprender.o: shared/geom.h shared/ents.h shared/command.h
sspgame/ssprender.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/ssprender.o: shared/igame.h
sspgame/sspstubs.o: sspgame/sspgame.h shared/cube.h shared/tools.h
sspgame/sspstubs.o: shared/geom.h shared/ents.h shared/command.h
sspgame/sspstubs.o: shared/glexts.h shared/glemu.h shared/iengine.h
sspgame/sspstubs.o: shared/igame.h

rpggame/rpg.o: rpggame/rpggame.h shared/cube.h shared/tools.h shared/geom.h
rpggame/rpg.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
rpggame/rpg.o: shared/iengine.h shared/igame.h
rpggame/rpgaction.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgaction.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgaction.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgaction.o: shared/igame.h
rpggame/rpgai.o: rpggame/rpggame.h shared/cube.h shared/tools.h shared/geom.h
rpggame/rpgai.o: shared/ents.h shared/command.h shared/glexts.h
rpggame/rpgai.o: shared/glemu.h shared/iengine.h shared/igame.h
rpggame/rpgcamera.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgcamera.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgcamera.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgcamera.o: shared/igame.h
rpggame/rpgchar.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgchar.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgchar.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgchar.o: shared/igame.h
rpggame/rpgconfig.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgconfig.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgconfig.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgconfig.o: shared/igame.h
rpggame/rpgcontainer.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgcontainer.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgcontainer.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgcontainer.o: shared/igame.h
rpggame/rpgeffect.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgeffect.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgeffect.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgeffect.o: shared/igame.h
rpggame/rpgentities.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgentities.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgentities.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgentities.o: shared/igame.h
rpggame/rpggui.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpggui.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpggui.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpggui.o: shared/igame.h
rpggame/rpghud.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpghud.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpghud.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpghud.o: shared/igame.h
rpggame/rpgio.o: rpggame/rpggame.h shared/cube.h shared/tools.h shared/geom.h
rpggame/rpgio.o: shared/ents.h shared/command.h shared/glexts.h
rpggame/rpgio.o: shared/glemu.h shared/iengine.h shared/igame.h
rpggame/rpgitem.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgitem.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgitem.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgitem.o: shared/igame.h
rpggame/rpgobstacle.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgobstacle.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgobstacle.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgobstacle.o: shared/igame.h
rpggame/rpgplatform.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgplatform.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgplatform.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgplatform.o: shared/igame.h
rpggame/rpgproj.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgproj.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgproj.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgproj.o: shared/igame.h
rpggame/rpgscript.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgscript.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgscript.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgscript.o: shared/igame.h
rpggame/rpgstats.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgstats.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgstats.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgstats.o: shared/igame.h
rpggame/rpgstatus.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgstatus.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgstatus.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgstatus.o: shared/igame.h
rpggame/rpgstubs.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgstubs.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgstubs.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgstubs.o: shared/igame.h
rpggame/rpgrender.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgrender.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgrender.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgrender.o: shared/igame.h
rpggame/rpgreserved.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgreserved.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgreserved.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgreserved.o: shared/igame.h
rpggame/rpgtest.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgtest.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgtest.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgtest.o: shared/igame.h
rpggame/rpgtrigger.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/rpgtrigger.o: shared/geom.h shared/ents.h shared/command.h
rpggame/rpgtrigger.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/rpgtrigger.o: shared/igame.h
rpggame/waypoint.o: rpggame/rpggame.h shared/cube.h shared/tools.h
rpggame/waypoint.o: shared/geom.h shared/ents.h shared/command.h
rpggame/waypoint.o: shared/glexts.h shared/glemu.h shared/iengine.h
rpggame/waypoint.o: shared/igame.h

krsgame/krs.o: krsgame/krsgame.h shared/cube.h shared/tools.h shared/geom.h
krsgame/krs.o: shared/ents.h shared/command.h shared/glexts.h shared/glemu.h
krsgame/krs.o: shared/iengine.h shared/igame.h
krsgame/krsai.o: krsgame/krsgame.h shared/cube.h shared/tools.h shared/geom.h
krsgame/krsai.o: shared/ents.h shared/command.h shared/glexts.h
krsgame/krsai.o: shared/glemu.h shared/iengine.h shared/igame.h
krsgame/krsents.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/krsents.o: shared/geom.h shared/ents.h shared/command.h
krsgame/krsents.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/krsents.o: shared/igame.h
krsgame/krshud.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/krshud.o: shared/geom.h shared/ents.h shared/command.h
krsgame/krshud.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/krshud.o: shared/igame.h engine/engine.h engine/world.h engine/octa.h
krsgame/krshud.o: engine/light.h engine/bih.h engine/texture.h engine/model.h
krsgame/krsrender.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/krsrender.o: shared/geom.h shared/ents.h shared/command.h
krsgame/krsrender.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/krsrender.o: shared/igame.h
krsgame/krsstubs.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/krsstubs.o: shared/geom.h shared/ents.h shared/command.h
krsgame/krsstubs.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/krsstubs.o: shared/igame.h
krsgame/krsscript.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/krsscript.o: shared/geom.h shared/ents.h shared/command.h
krsgame/krsscript.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/krsscript.o: shared/igame.h
krsgame/waypoint.o: krsgame/krsgame.h shared/cube.h shared/tools.h
krsgame/waypoint.o: shared/geom.h shared/ents.h shared/command.h
krsgame/waypoint.o: shared/glexts.h shared/glemu.h shared/iengine.h
krsgame/waypoint.o: shared/igame.h

moviecube/action.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/action.o: shared/geom.h shared/ents.h shared/command.h
moviecube/action.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/action.o: shared/igame.h moviecube/mapentities.h
moviecube/action.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/action.o: moviecube/control.h moviecube/action.h
moviecube/characterinfo.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/characterinfo.o: shared/geom.h shared/ents.h shared/command.h
moviecube/characterinfo.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/characterinfo.o: shared/igame.h moviecube/mapentities.h
moviecube/characterinfo.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/characterinfo.o: moviecube/control.h moviecube/action.h
moviecube/client.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/client.o: shared/geom.h shared/ents.h shared/command.h
moviecube/client.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/client.o: shared/igame.h moviecube/mapentities.h
moviecube/client.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/client.o: moviecube/control.h moviecube/action.h
moviecube/clientmode.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/clientmode.o: shared/geom.h shared/ents.h shared/command.h
moviecube/clientmode.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/clientmode.o: shared/igame.h moviecube/mapentities.h
moviecube/clientmode.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/clientmode.o: moviecube/control.h moviecube/action.h
moviecube/control.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/control.o: shared/geom.h shared/ents.h shared/command.h
moviecube/control.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/control.o: shared/igame.h moviecube/mapentities.h
moviecube/control.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/control.o: moviecube/control.h moviecube/action.h
moviecube/entities.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/entities.o: shared/geom.h shared/ents.h shared/command.h
moviecube/entities.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/entities.o: shared/igame.h moviecube/mapentities.h
moviecube/entities.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/entities.o: moviecube/control.h moviecube/action.h
moviecube/mapentities.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/mapentities.o: shared/geom.h shared/ents.h shared/command.h
moviecube/mapentities.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/mapentities.o: shared/igame.h moviecube/mapentities.h
moviecube/mapentities.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/mapentities.o: moviecube/control.h moviecube/action.h
moviecube/movable.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/movable.o: shared/geom.h shared/ents.h shared/command.h
moviecube/movable.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/movable.o: shared/igame.h moviecube/mapentities.h
moviecube/movable.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/movable.o: moviecube/control.h moviecube/action.h
moviecube/moviecube.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/moviecube.o: shared/geom.h shared/ents.h shared/command.h
moviecube/moviecube.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/moviecube.o: shared/igame.h moviecube/mapentities.h
moviecube/moviecube.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/moviecube.o: moviecube/control.h moviecube/action.h
moviecube/render.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/render.o: shared/geom.h shared/ents.h shared/command.h
moviecube/render.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/render.o: shared/igame.h moviecube/mapentities.h
moviecube/render.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/render.o: moviecube/control.h moviecube/action.h
moviecube/camera.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/camera.o: shared/geom.h shared/ents.h shared/command.h
moviecube/camera.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/camera.o: shared/igame.h moviecube/mapentities.h
moviecube/camera.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/camera.o: moviecube/control.h moviecube/action.h
moviecube/server.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/server.o: shared/geom.h shared/ents.h shared/command.h
moviecube/server.o: shared/glexts.h shared/glemu.h shared/iengine.h
moviecube/server.o: shared/igame.h moviecube/mapentities.h
moviecube/server.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/server.o: moviecube/control.h moviecube/action.h
moviecube/server.o: moviecube/servmode.h moviecube/extinfo.h
moviecube/server.o: moviecube/botmgr.h

shared/cube.h.gch: shared/tools.h shared/geom.h shared/ents.h
shared/cube.h.gch: shared/command.h shared/glexts.h shared/glemu.h
shared/cube.h.gch: shared/iengine.h shared/igame.h
engine/engine.h.gch: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
engine/engine.h.gch: shared/command.h shared/glexts.h shared/glemu.h
engine/engine.h.gch: shared/iengine.h shared/igame.h engine/world.h
engine/engine.h.gch: engine/octa.h engine/light.h engine/bih.h
engine/engine.h.gch: engine/texture.h engine/model.h
fpsgame/game.h.gch: shared/cube.h shared/tools.h shared/geom.h shared/ents.h
fpsgame/game.h.gch: shared/command.h shared/glexts.h shared/glemu.h
fpsgame/game.h.gch: shared/iengine.h shared/igame.h fpsgame/ai.h
sspgame/sspgame.h.gch: shared/cube.h shared/tools.h shared/geom.h
sspgame/sspgame.h.gch: shared/ents.h shared/command.h shared/glexts.h
sspgame/sspgame.h.gch: shared/glemu.h shared/iengine.h shared/igame.h
rpggame/rpggame.h.gch: shared/cube.h shared/tools.h shared/geom.h
rpggame/rpggame.h.gch: shared/ents.h shared/command.h shared/glexts.h
rpggame/rpggame.h.gch: shared/glemu.h shared/iengine.h shared/igame.h
moviecube/game.h.gch: shared/cube.h shared/tools.h shared/geom.h
moviecube/game.h.gch: shared/ents.h shared/command.h shared/glexts.h
moviecube/game.h.gch: shared/glemu.h shared/iengine.h shared/igame.h
moviecube/game.h.gch: moviecube/mapentities.h moviecube/clientmode.h
moviecube/game.h.gch: moviecube/modeinfo.h moviecube/control.h
moviecube/game.h.gch: moviecube/action.h
krsgame/krsgame.h.gch: shared/cube.h shared/tools.h shared/geom.h
krsgame/krsgame.h.gch: shared/ents.h shared/command.h shared/glexts.h
krsgame/krsgame.h.gch: shared/glemu.h shared/iengine.h shared/igame.h
pzlgame/pzlgame.h.gch: shared/cube.h shared/tools.h shared/geom.h
pzlgame/pzlgame.h.gch: shared/ents.h shared/command.h shared/glexts.h
pzlgame/pzlgame.h.gch: shared/glemu.h shared/iengine.h shared/igame.h

shared/crypto-standalone.o: shared/cube.h shared/tools.h shared/geom.h
shared/crypto-standalone.o: shared/ents.h shared/command.h shared/iengine.h
shared/crypto-standalone.o: shared/igame.h
shared/stream-standalone.o: shared/cube.h shared/tools.h shared/geom.h
shared/stream-standalone.o: shared/ents.h shared/command.h shared/iengine.h
shared/stream-standalone.o: shared/igame.h
shared/tools-standalone.o: shared/cube.h shared/tools.h shared/geom.h
shared/tools-standalone.o: shared/ents.h shared/command.h shared/iengine.h
shared/tools-standalone.o: shared/igame.h
engine/command-standalone.o: engine/engine.h shared/cube.h shared/tools.h
engine/command-standalone.o: shared/geom.h shared/ents.h shared/command.h
engine/command-standalone.o: shared/iengine.h shared/igame.h engine/world.h
engine/server-standalone.o: engine/engine.h shared/cube.h shared/tools.h
engine/server-standalone.o: shared/geom.h shared/ents.h shared/command.h
engine/server-standalone.o: shared/iengine.h shared/igame.h engine/world.h
engine/worldio-standalone.o: engine/engine.h shared/cube.h shared/tools.h
engine/worldio-standalone.o: shared/geom.h shared/ents.h shared/command.h
engine/worldio-standalone.o: shared/iengine.h shared/igame.h engine/world.h

fpsgame/entities-standalone.o: fpsgame/game.h shared/cube.h shared/tools.h
fpsgame/entities-standalone.o: shared/geom.h shared/ents.h shared/command.h
fpsgame/entities-standalone.o: shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/server-standalone.o: fpsgame/game.h shared/cube.h shared/tools.h
fpsgame/server-standalone.o: shared/geom.h shared/ents.h shared/command.h
fpsgame/server-standalone.o: shared/iengine.h shared/igame.h fpsgame/ai.h
fpsgame/server-standalone.o: fpsgame/capture.h fpsgame/ctf.h
fpsgame/server-standalone.o: fpsgame/collect.h fpsgame/extinfo.h
fpsgame/server-standalone.o: fpsgame/aiman.h

moviecube/server-standalone.o: moviecube/game.h shared/cube.h shared/tools.h
moviecube/server-standalone.o: shared/geom.h shared/ents.h shared/command.h
moviecube/server-standalone.o: shared/iengine.h shared/igame.h
moviecube/server-standalone.o: moviecube/mapentities.h moviecube/clientmode.h
moviecube/server-standalone.o: moviecube/modeinfo.h moviecube/control.h
moviecube/server-standalone.o: moviecube/action.h moviecube/servmode.h
moviecube/server-standalone.o: moviecube/extinfo.h moviecube/botmgr.h
moviecube/entities-standalone.o: moviecube/game.h shared/cube.h
moviecube/entities-standalone.o: shared/tools.h shared/geom.h shared/ents.h
moviecube/entities-standalone.o: shared/command.h shared/iengine.h
moviecube/entities-standalone.o: shared/igame.h moviecube/mapentities.h
moviecube/entities-standalone.o: moviecube/clientmode.h moviecube/modeinfo.h
moviecube/entities-standalone.o: moviecube/control.h moviecube/action.h

engine/master-standalone.o: shared/cube.h shared/tools.h shared/geom.h
engine/master-standalone.o: shared/ents.h shared/command.h shared/iengine.h
engine/master-standalone.o: shared/igame.h
