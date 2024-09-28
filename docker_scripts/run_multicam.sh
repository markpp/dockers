xhost +si:localuser:root
docker run -it \
	--rm \
	--privileged \
	--net=host \
	--runtime nvidia \
        --name=ros2_docker \
        --workdir=/workspace/ \
	-e DISPLAY=$DISPLAY \
	--device="/dev/video0:/dev/video0" \
	--device="/dev/video1:/dev/video1" \
        -v /tmp/argus_socket:/tmp/argus_socket \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
	-v "$(pwd)/../host_ws:/workspace/host_ws" \
  	-v "$(pwd)/../code:/workspace/code" \
	ros2_deepstream:eloquent
