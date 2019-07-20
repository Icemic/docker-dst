#! /bin/sh


# Update server files with steamcmd
# ./steamcmd/steamcmd.sh +login anonymous \
#                        +force_install_dir /steam \
#                        +app_update 343050 \
#                        +exit

# CD into dedicated server bin path
# Against good practice the server binary seems to use paths
# relative to the CWD and not the server's path.
cd /steam/bin
./dontstarve_dedicated_server_nullrenderer \
                        -persistent_storage_root /dst
