sudo docker build -t $build_name ~/docker_build
sudo docker create -it --name $container_name --shm-size 8G --gpus all $build_name
