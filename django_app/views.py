from django.shortcuts import render
from django.http import HttpResponse
from decouple import config

# Create your views here.
def main(request):
    return HttpResponse(f"Hello. {config("CLOUD_OR_LOCAL_DOCKER")}")
