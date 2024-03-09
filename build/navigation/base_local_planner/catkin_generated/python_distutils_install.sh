#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/raphael/Documents/Project/workspace/src/navigation/base_local_planner"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/raphael/Documents/Project/workspace/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/raphael/Documents/Project/workspace/install/lib/python3/dist-packages:/home/raphael/Documents/Project/workspace/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/raphael/Documents/Project/workspace/build" \
    "/usr/bin/python3" \
    "/home/raphael/Documents/Project/workspace/src/navigation/base_local_planner/setup.py" \
    egg_info --egg-base /home/raphael/Documents/Project/workspace/build/navigation/base_local_planner \
    build --build-base "/home/raphael/Documents/Project/workspace/build/navigation/base_local_planner" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/raphael/Documents/Project/workspace/install" --install-scripts="/home/raphael/Documents/Project/workspace/install/bin"
