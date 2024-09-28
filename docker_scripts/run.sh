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
        -v /tmp/argus_socket:/tmp/argus_socket \
	-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  	-v "$(pwd)code:/workspace" \
	192.168.1.146:5000/ros2_deepstream:latest
