cmake_minimum_required(VERSION 3.10.1)
project(empty-argv-segfault-check CXX)

add_executable(${PROJECT_NAME} main.cc)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 11)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)

configure_file(segfault_detect.sh.cmake segfault_detect.sh @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/segfault_detect.sh DESTINATION bin)

