from django.shortcuts import render
from django.http import HttpResponse
from decouple import config

import os
from azure.keyvault.secrets import SecretClient
from azure.identity import DefaultAzureCredential

# Create your views here.
def main(request):
    key_vault_name = "aks-keyvault-i2r"
    key_vault_uri = f"https://{key_vault_name}.vault.azure.net"

    credential = DefaultAzureCredential(managed_identity_client_id="07cbe53e-b376-49c0-ac68-73f64a6adf25")
    client = SecretClient(vault_url=key_vault_uri, credential=credential)

    retrieved_secret = client.get_secret("mysecret")

    return HttpResponse(f"Hello. {config('CLOUD_OR_LOCAL_DOCKER')}, mysecret: {retrieved_secret.value}")
