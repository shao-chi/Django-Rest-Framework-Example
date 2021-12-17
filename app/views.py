# from django.http import JsonResponse
# from django.shortcuts import render
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Students
from .serializers import StudentsSerializer


STATUS_404_NO_STUDENTS = "Student not exists"


# Create your views here.
@swagger_auto_schema(
    method='get',
    manual_parameters=[
        openapi.Parameter(
            'name',
            openapi.IN_QUERY,
            'student name',
            required=True,
            type=openapi.TYPE_STRING
        ),
    ],
    responses={
        200: StudentsSerializer,
        404: STATUS_404_NO_STUDENTS,
    },
    tags=['apis']
)
@api_view(['GET'])
def api(request):
    # name = request.GET['name']

    # students = Students.objects.filter(name=name).first()
    students = Students.objects.all()
    if not students:
        return Response(
            STATUS_404_NO_STUDENTS,
            status=status.HTTP_404_NOT_FOUND
        )
    serializers = StudentsSerializer(instance=students, many=True)

    return Response(serializers.data, status=status.HTTP_200_OK)
