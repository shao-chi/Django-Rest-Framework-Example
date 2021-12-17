# Django REST Framework Example

## Install
```
# install django, drf, drf-yasg
$ pip3 install django djangorestframework drf-yasg

# for CORS
$ pip3 install django-cors-headers
```

## Let's start

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

## Setting

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
* `DATABASES` : database engine and path
* `TIME_ZONE`
    * Set `'Asia/Taipei'`

## Coding

* app/admin.py
* app/models.py
* app/serializers.py
* app/views.py
* drf_example/urls.py

## Migrate

*   建立 DB

    ```
    ./manage.py makemigrations
    ```

*   若 DB 有更動

    ```
    ./manage.py migrate
    ```
    所有更動都會存在 `app/migrations` 資料夾下

## 新增資料

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

## 註冊 Super User (admin)

```
./manage.py createsuperuser
```
就可以到 `/admin` 登入

## Run Server

```
./manage.py runserver [ip:port]
```

## Reference

* https://github.com/klin0816/django-course/tree/master/django-rest