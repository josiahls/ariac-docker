FROM osrf/ros:melodic-desktop-full

USER root

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    wget \
    && rm -rf /var/lib/apt/lists/*
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | apt-key add -
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list

# Install the ariac package
RUN apt-get update && apt-get install -y \
        ros-${ROS_DISTRO}-ros-controllers \
        ariac3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN rosdep update

# Create a new user called ariac-user and give them sudo priviledges.
ENV USERNAME ariac-user
RUN adduser --gecos "Development User" --disabled-password $USERNAME
RUN adduser $USERNAME sudo
WORKDIR /home/$USERNAME

ENTRYPOINT ["/bin/bash"]
