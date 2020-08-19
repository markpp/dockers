import os
import shutil
import json
import argparse

def make_user_script(name, scripts):

    # user script. creates non root user and calls other initialization scripts
    user = os.path.join("output", name, 'user.sh')
    with open(user, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("USER_ID=${LOCAL_USER_ID:-9001}\n")        
        f.write("echo 'Starting with username : markpp and UID : $USER_ID'\n")
        f.write("useradd -s /bin/bash -u $USER_ID -o -c '' -m markpp\n")
        f.write("export HOME=/home/markpp\n")

        f.write("su markpp bash -c ")
        for script in scripts:
            f.write("'/usr/local/bin/{}.sh';".format(script))
        f.write("'bash'")

def make_scripts(name):
    build = os.path.join("output", name, 'build.sh')
    with open(build, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("docker build --network=host -t docker{}:latest .\n".format(name))

    run = os.path.join("output", name, 'run.sh')
    with open(run, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("xhost +local:\n")
        f.write("docker run -it --net=host \\\n")
        f.write("  --volume=/dev:/dev \\\n")
        f.write("  --name=docker{} \\\n".format(name))
        f.write("  --workdir=/home/$USER \\\n")
        f.write("  -e LOCAL_USER_ID=`id -u $USER` \\\n")
        f.write("  -e DISPLAY=$DISPLAY \\\n")
        f.write("  -e QT_GRAPHICSSYSTEM=native \\\n")
        f.write("  -e CONTAINER_NAME=docker{}-dev \\\n".format(name))
        f.write("  -v \"/tmp/.X11-unix:/tmp/.X11-unix\" \\\n")
        f.write("  -v \"$(pwd)/catkin_ws:/home/catkin_ws\" \\\n")
        f.write("  -v \"$(pwd)/$USER:/home/$USER\" \\\n")
        f.write("  docker{}:latest\n".format(name))

    resume = os.path.join("output", name, 'resume.sh')
    with open(resume, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("docker start docker{}\n".format(name))

    cmd = os.path.join("output", name, 'cmd.sh')
    with open(cmd, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("docker exec -it docker{} bash\n".format(name))

    connect = os.path.join("output", name, 'connect.sh')
    with open(connect, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("docker attach docker{} bash\n".format(name))

    stop = os.path.join("output", name, 'stop.sh')
    with open(stop, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("docker stop docker{}\n".format(name))

    clear = os.path.join("output", name, 'clear.sh')
    with open(clear, 'w') as f:
        f.write("#!/bin/bash\n")
        f.write("docker stop docker{}\n".format(name))
        f.write("docker rm docker{}\n".format(name))


def make_readme():
    readme = os.path.join("output", name, 'README.md')
    with open(readme, 'w') as f:
        f.write("# Docker image for xx using xx and xx\n")
        f.write("It is based on a Ubuntu 18.04 distribution and cuda 10.0.\n")
        f.write("\n")
        f.write("## Getting up and running\n")
        f.write("### Step 1: Place the contents in an appropriate location\n")
        f.write("```\n")
        f.write("git clone\n")
        f.write("```\n")
        f.write("\n")
        f.write("### Step 2: Build the docker image\n")
        f.write("It can take a while, a lot of things are being included. Only has to be done when the dockerfile has been changed.\n")
        f.write("```\n")
        f.write("cd docker && sh build.sh\n")
        f.write("```\n")
        f.write("\n")
        f.write("### Step 3: run docker\n")
        f.write("Look at run.sh and make sure that the folders are mapped as you want. If the container is already running, use the clean.sh script.\n")
        f.write("```\n")
        f.write("sh run.sh # gives you a cmdline to the container\n")
        f.write("```\n")
        f.write("\n")


def write_dockerfile(name, components, gpu=False, ubuntu="18.04"):
    scripts = []
    dockerfile = os.path.join("output", name, 'Dockerfile')
    with open(dockerfile, 'w') as f:
        if gpu:
            f.write("FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu{}\n".format(ubuntu))
        else:
            f.write("FROM ubuntu:{}\n".format(ubuntu))
        f.write("\n")

        f.write("LABEL maintainer \"Mark - Auto generated\"\n")
        f.write("\n")

        f.write("ENV DEBIAN_FRONTEND=noninteractive\n")
        f.write("\n")

        for comp in components:
            df_path = os.path.join("components", comp + '.Dockerfile')
            print(df_path)
            with open(df_path, 'r') as c:
                for line in c:
                    f.write(line)
                f.write("\n")
            # copy accompanying shell script if it exists
            sh_path = os.path.join("components", comp + '.sh')
            print(sh_path)
            if os.path.exists(sh_path):
                scripts.append(comp.split('/')[-1])
                shutil.copy(sh_path, os.path.join("output", name))
                print("copied {}".format(sh_path))
                #f.write("COPY {}.sh /usr/local/bin/\n".format(name))

        f.write("RUN rm -rf /var/lib/apt/lists/*\n")
        f.write("\n")

        #f.write("WORKDIR /home\n")
        for script in scripts:
            f.write("COPY {}.sh /usr/local/bin/\n".format(script))
        f.write("\n")


        make_user_script(name, scripts)
        f.write("COPY user.sh /usr/local/bin/\n")

        f.write("CMD bash -C ")
        f.write("'/usr/local/bin/user.sh'")



if __name__ == '__main__':
    """
    Main function for executing the .py script.
    Command:
        -c path/to/config
    """
    #python clean_junk_frames.py -p /Volumes/WD1TBNTFS/MTBdata/test -e 8
    # construct the argument parser and parse the arguments
    ap = argparse.ArgumentParser()
    ap.add_argument("-c", "--config", type=str, default="configs/data_capture.json",
                    help="Path to config file")
    args = vars(ap.parse_args())

    name = os.path.basename(args["config"]).split('.')[0]

    with open(args["config"], "r") as read_file:
        config = json.load(read_file)

    components = []
    for key in list(config['components'].keys())[:]: # top level
        for i, modules in enumerate(config['components'][key]): # bottom level
            k = [list(modules.keys())][0][0]
            components.append("{}/{}".format(key, config['components'][key][i][k]))

    # make sure that the output folder exists
    if not os.path.exists(os.path.join("output", name)):
        os.makedirs(os.path.join("output", name))

    write_dockerfile(name, components, config['gpu'], config['ubuntu'])

    make_scripts(name)

    make_readme()
