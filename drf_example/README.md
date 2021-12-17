# Files

## urls.py

定義網頁的path與功能

1. Import more packages

    ```
    from drf_yasg.views import get_schema_view
    from drf_yasg import openapi
    from rest_framework import permissions
    from rest_framework.routers import SimpleRouter
    ```

2. Add paths

    Ex.
    ```
    urlpatterns = [
        path('admin/', admin.site.urls),
        path('api', views.api),
        path('docs/', schema_view.with_ui('swagger', cache_timeout=None)),
        path('redoc/', schema_view.with_ui('redoc', cache_timeout=0))
    ]
    ```