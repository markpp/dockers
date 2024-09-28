xhost +si:localuser:root
docker run -it \
	--rm \
	--net=host \
	--runtime nvidia \
        --name=ros2_docker \
        --workdir=/workspace/ros2_ws \
	-e DISPLAY=$DISPLAY \
	--device="/dev/video0:/dev/video0" \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
	-v ${pwd}/src:/workspace/host_ws/src \
  	-v "$(pwd)/../code:/workspace/code" \
	ros2_deepstream:eloquent
