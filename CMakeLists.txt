#
# Lua bindings for libnfnetlink
#
cmake_minimum_required(VERSION 2.8)

project(lua-nfnetlink C)

set(BUILD_SHARED_LIBS TRUE)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(INSTALL_CMOD share/lua/cmod CACHE PATH "Directory to install Lua binary modules (configure lua via LUA_CPATH)")

set(COMMON_CFLAGS "${CFLAGS}")
set(COMMON_LDFLAGS)
set(COMMON_LIBS)

## Lua 5.1.x
include(FindLua51)
if(NOT ${LUA51_FOUND})
    message(FATAL_ERROR "The FindLua51 module could not find lua :-(")
endif()
set(COMMON_LIBS "${COMMON_LIBS};${LUA_LIBRARIES}")

## LibNfnetlink
include(FindPkgConfig)
pkg_search_module(NFNETLINK REQUIRED libnfnetlink)
set(COMMON_CFLAGS "${COMMON_CFLAGS} ${NFNETLINK_CFLAGS}")
set(COMMON_LDFLAGS "${COMMON_LDFLAGS} ${NFNETLINK_LDFLAGS}")
set(COMMON_LIBS "${COMMON_LIBS};${NFNETLINK_LIBRARIES}")

## LuaNativeObjects
include(LuaNativeObjects)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                    ${CMAKE_CURRENT_BINARY_DIR}
                    ${LUA_INCLUDE_DIR})

## LuaNfnetlink
set(LUA_NFNETLINK_SRC
	nfnetlink.nobj.lua
)

if(${USE_PRE_GENERATED_BINDINGS})
	set(LUA_NFNETLINK_SRC src/pre_generated-nfnetlink.nobj.c)
else()
	# Generate Lua bindings.
	GenLuaNativeObjects(LUA_NFNETLINK_SRC)
endif()

add_library(lua-nfnetlink MODULE ${LUA_NFNETLINK_SRC})
target_link_libraries(lua-nfnetlink ${COMMON_LIBS})
set_target_properties(lua-nfnetlink PROPERTIES PREFIX "")
set_target_properties(lua-nfnetlink PROPERTIES COMPILE_FLAGS "${COMMON_CFLAGS}")
set_target_properties(lua-nfnetlink PROPERTIES OUTPUT_NAME nfnetlink)

install(TARGETS lua-nfnetlink
        DESTINATION "${INSTALL_CMOD}")

