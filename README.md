# Django REST Framework Example

### Install
```
# install django, drf, drf-yasg
$ pip3 install django djangorestframework drf-yasg

# for CORS
$ pip3 install django-cors-headers
```

### Let's start

* 建立 project
    ```
    # create projects and configs
    # django-admin startproject [project_name] [dir]
    django-admin startproject drf_example .
    ```
    在 [dir] 資料夾底下會出現 `drf_example` 資料夾和 `manage.py`

* 建立 apps
    ```
    django-admin startapp app
    ```
    在 [dir] 資料夾底下多出現一個 `app` 資料夾，之後 API 的功能就會寫在這裡面

### Setting

`drf_example/settings.py`
* `ALLOWED_HOSTS` : 設定可以 access 的 host
    Ex. `ALLOWED_HOSTS = ['*']` 允許所有人
* `INSTALLED_APPS`
    * Add `'app'` (api function)
    * Add `'corsheaders'` (cross origin)
    * Add `'drf_yasg'` (django rest framework)
* `MIDDLEWARE`
    * Add `'corsheaders.middleware.CorsMiddleware'`
    * Remove `'django.middleware.csrf.CsrfViewMiddleware'`
* `CORS_ORIGIN_ALLOW_ALL` : `True`
* `REST_FRAMEWORK` : 
    ```
    {
        'DEFAULT_PARSER_CLASSES': [
            'rest_framework.parsers.JSONParser',
        ],
        'DEFAULT_RENDERER_CLASSES': [
            'rest_framework.renderers.JSONRenderer',
        ],
    }
    ```
* `DATABASES` : database engine and path
* `TIME_ZONE`
    * Set `'Asia/Taipei'`

### Coding

* app/admin.py
* app/models.py
* app/serializers.py
* app/views.py
* drf_example/urls.py

### Migrate

*   建立 DB

    ```
    ./manage.py makemigrations
    ```

*   若 DB 有更動

    ```
    ./manage.py migrate
    ```
    所有更動都會存在 `app/migrations` 資料夾下

### 新增資料

* 進入 python shell

    ```
    ./manage.py shell
    ```

* Add data

    Ex.
    ```
    >>> from app.models import Students
    >>>
    >>> s = Students(name='woonai', age=3)
    >>> s.save()
    >>>
    >>> s = Students(name='meow', age=22)
    >>> s.save()
    >>>
    >>> Students.objects.filter(name='woonai')
    <QuerySet [<Students: woonai>]>
    >>> Students.objects.filter(age=22)
    <QuerySet [<Students: meow>]>
    >>>
    >>> Students.objects.all()
    <QuerySet [<Students: woonai>, <Students: meow>]>
    ```

### 註冊 Super User (admin)

```
./manage.py createsuperuser
```
就可以到 `/admin` 登入

### Run Server

```
./manage.py runserver [ip:port]
```

# Docker

## Build Docker Image
```
docker build . --tag ${tag}
```

### Run Docker Container
```
docker run \
    -p 8001:8000 \
    -it ${tag} \
    ./manage.py runserver 0.0.0.0:8000
```
Then view `https://localhost:8001`

# Kubernetes
Implementation on minikube

### Install
* kubectl `brew install kubectl`
* minikube `brew install minikube`

### 啟動 Minikube
```
minikube start --vm=true --driver=hyperkit
```
- 查看 Minikube 狀態
    
    ```bash
    minikube status
    minikube dashboard
    ```
    
- 停止 minikube 運行
    
    ```bash
    minikube stop
    ```
    
- ssh 進入 minikube
    
    ```bash
    minikube ssh
    ```
    
- 查詢 minikube 對外的 ip
    
    ```bash
    minikube ip
    ```
    
- 測試：執行hello-minikube app
    
    ```bash
    # kubectl run 在 minikube 上運行一個 Google 提供的 hello-minikube docker image
    kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.8 --port=8080
    
    # 讓本機端可以連到hello-minikube
    kubectl expose deployment hello-minikube --type=NodePort
    
    # 取得這個 service 的 url
    minikube service hello-minikube --url
    ```

### 建立 pod
- 執行 `kubectl`
    
    ```bash
    kubectl create -f {YAML_PATH}
    ```
    
- 查看 pod 狀態
    
    ```bash
    kubectl get pods
    kubectl describe pods {POD_NAME}
    ```
    
- 與 Pod 中的 container 互動
    
    ```bash
    # 將 pod 的 port mapping 到本機端上
    kubectl port-forward {POD_NAME} {LOCAL_PORT}:3000
    ```

- 進入 Pod
     kubectl exec --stdin --tty {POD_NAME} -- /bin/bash

### 建立 service
- 用 pod 建 service
    - `expose`
        
        ```bash
        # 將 pod 的 port 與 Kubernetes Cluster 的 port number 做 mapping
        kubectl expose pod {POD_NAME} --type=NodePort --name={SERVICE_NAME}
        
        # 取得 service url
        minikube service {SERVICE_NAME} --url
        ```
        
- 寫 service yaml 建 service (要先 create Pod)
    
    ```bash
    # create Pod 後
    kubectl create -f {SERVICE_YAML_PATH}
    ```
    
- 查看 pod 狀態
    
    ```bash
    kubectl get services
    kubectl describe services {POD_NAME}
    ```
    
- 從外部連線 service
    
    ```bash
    # 取得 url
    minikube service {SERVICE_NAME} --url
    ```
    
- 從 minikube 裡面連線
    
    ```bash
    # 進入 minikube
    minikube ssh
    
    curl <CLUSTER-IP>:<port>
    ```

### 建立 deployment
- 寫 service yaml 建 deployment
    
    ```bash
    kubectl create -f {SERVICE_YAML_PATH}
    
    kubectl get deploy
    kubectl get pods
    
    # 編輯
    kubectl edit deployments {DEPLOYMENT_NAME}
    # 看到我們目前更改過的版本
    kubectl rollout history deployment {DEPLOYMENT_NAME}
    # 指定要 Rollback 到的版本
    kubectl rollout undo deploy --to-revision={}
    
    # 建 service
    kubectl create -f {SERVICE_YAML}
    ```

### 建立 ingress
- 啟用 minikube 的 ingress 功能 `minikube addons enable ingress`
- 寫 service yaml 建 ingress
    
    ```bash
    kubectl create -f {INRGESS_YAML}
    
    kubectl get ingress
    
    # 添加 127.0.0.1 student.api.com
    sudo vim /etc/hosts
    
    # 啟用
    minikube tunnel
    ```

# Reference

* https://cwhu.medium.com/kubernetes-implement-ingress-deployment-tutorial-7431c5f96c3e
* https://github.com/klin0816/django-course/tree/master/django-rest