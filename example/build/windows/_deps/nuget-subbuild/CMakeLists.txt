# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.20.21032501-MSVC_2)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(nuget-populate NONE)



include(ExternalProject)
ExternalProject_Add(nuget-populate
                     "UPDATE_DISCONNECTED" "False" "URL" "https://dist.nuget.org/win-x86-commandline/v6.0.0/nuget.exe" "URL_HASH" "SHA256=04eb6c4fe4213907e2773e1be1bbbd730e9a655a3c9c58387ce8d4a714a5b9e1" DOWNLOAD_NO_EXTRACT YES
                    SOURCE_DIR          "E:/Codes/Flutter/open_street_map_search_and_pick/example/build/windows/_deps/nuget-src"
                    BINARY_DIR          "E:/Codes/Flutter/open_street_map_search_and_pick/example/build/windows/_deps/nuget-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
)


ExternalProject_Get_Property(nuget-populate DOWNLOADED_FILE)
get_filename_component(dlFileName "${DOWNLOADED_FILE}" NAME)

ExternalProject_Add_Step(nuget-populate copyfile
  COMMAND    "F:/Program Files (x86)/Microsoft Visual Studio/2019/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin/cmake.exe" -E copy_if_different
             "<DOWNLOADED_FILE>" "E:/Codes/Flutter/open_street_map_search_and_pick/example/build/windows/_deps/nuget-src"
  DEPENDEES  patch
  DEPENDERS  configure
  BYPRODUCTS "E:/Codes/Flutter/open_street_map_search_and_pick/example/build/windows/_deps/nuget-src/${dlFileName}"
  COMMENT    "Copying file to SOURCE_DIR"
)

