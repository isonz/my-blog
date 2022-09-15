# Containerd 的使用

下载地址 : https://github.com/containerd/containerd/releases    
参考文献 : https://www.cnblogs.com/lvzhenjiang/p/15147993.html

---

帮助：

	ctr

查看版本：

	ctr version

查看插件列表
		
	ctr plugin ls

拉取镜像：

	ctr image pull docker.io/wangyanglinux/myapp:v1

列出本地镜像

	ctr image ls
	
检测本地镜像

	ctr image check

重新打标签

	ctr image tag docker.io/wangyanglinux/myapp:v1 harbor.k8s.local/course/wangyangmyapp:alpine

删除镜像

	ctr image rm docker.io/wangyanglinux/myapp:v1

将镜像挂载到主机目录
	
	ctr image mount docker.io/library/nginx:alpine /mnt
	tree -L 1 /mnt

将镜像从主机目录上卸载

	ctr image unmount /mnt

将镜像导出为压缩包

	ctr image export nginx.tar.gz docker.io/library/nginx:alpine

从压缩包导入镜像

	ctr image import nginx.tar.gz

创建容器

	ctr container create docker.io/wangyanglinux/myapp:v1 wangyangMyapp

列出容器
	
	ctr container ls

查看容器详细配置,类似于 docker inspect 功能。

	ctr container info nginx

删除容器

	ctr container rm nginx

通过 Task 来启动容器

	ctr task start -d nginx
	
查看正在运行的容器

	ctr task ls

进入容器:  必须要指定 --exec-id 参数，这个 id 可以随便写，只要唯一就行。
	
	ctr task exec --exec-id 0 -t nginx sh

暂停容器

	ctr task pause nginx

恢复容器

	ctr task resume nginx
	
杀死容器: 没有 stop 容器的功能，只能暂停或者杀死容器.

	ctr task kill nginx

删除任务

	ctr task rm nginx
	
获取容器的内存、CPU 和 PID 的限额与使用量

	ctr task metrics nginx
	
查看容器中所有进程在宿主机中的 PID， 其中第一个 PID 3984 就是我们容器中的1号进程
	
	ctr task ps nginx
	
	PID     INFO
	3984    -
	4029    -

查看命名空间

	ctr ns ls
	
	NAME    LABELS
	default

ctr 默认使用的是 default 空间。  
同样也可以使用 ns create 命令创建一个命名空间：

	ctr ns create test
	ctr ns ls

使用 remove 或者 rm 可以删除 namespace

	ctr ns rm test
	
	test

	ctr ns ls

	NAME    LABELS
	default

可以在操作资源的时候指定 namespace，比如查看 test 命名空间的镜像，可以在操作命令后面加上 -n test 选项：

	ctr -n test image ls

	REF TYPE DIGEST SIZE PLATFORMS LABELS


我们知道 Docker 其实也是默认调用的 containerd，事实上 Docker 使用的 containerd 下面的命名空间默认是 moby，而不是 default，所以假如我们有用 docker 启动容器，那么我们也可以通过 ctr -n moby 来定位下面的容器：

	ctr -n moby container ls

同样 Kubernetes 下使用的 containerd 默认命名空间是 k8s.io，所以我们可以使用 ctr -n k8s.io 来查看 Kubernetes 下面创建的容器。

