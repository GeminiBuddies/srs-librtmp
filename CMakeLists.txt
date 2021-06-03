cmake_minimum_required(VERSION 3.0)
project(srs-librtmp)

file(GLOB_RECURSE LIBRTMP_SRC src *.cpp)

add_library(srs-librtmp STATIC ${LIBRTMP_SRC})
target_include_directories(srs-librtmp PRIVATE ./include.private)
target_include_directories(srs-librtmp PUBLIC ./include)

add_subdirectory(research/librtmp ./tools/)
