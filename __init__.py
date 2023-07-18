import subprocess
import importlib
libLst = ["azure-storage-blob","azure-functions"]

for lib in libLst:

    try:

        importlib.import_module(lib)

        print(f"No need to install {lib}. Library is already installed.")

    except ImportError:

        print(f"Installing {lib}")

        subprocess.check_call(["pip", "install", lib])

import subprocess

library_name = "azure-storage-blob"

result = subprocess.check_call(["pip", "install", f"{library_name}"])
print("helllo")

from typing import List

import logging

import azure.functions as func
from azure.storage.blob import BlobServiceClient, BlobClient

logging.info('Python EventHub trigger function processed an event.')

def main(events: List[func.EventHubEvent]):
    logging.info('Python inside main EventHub trigger function processed an event.')
    storage_connection_string = "DefaultEndpointsProtocol=https;AccountName=functionstorage0099;AccountKey=kTLStYh8F+6iJsVCG8z6+9IWwFrZEFdRPcpPXezZDyGsO3Ujfz4MuPSqcuthIyXSihLhktf9inrk+AStdR+Xwg==;EndpointSuffix=core.windows.net"
    blob_service_client = BlobServiceClient.from_connection_string(conn_str=storage_connection_string)
    container_name = "motadata-store"

    # if not container_name.exists():
    #     logging.info('Python container  client.')
    #     container_name.create_container()
        
    for event in events:
        logging.info('Python container  client.')
        event_data = event.get_body().decode('utf-8')
        logging.info('Python EventHub trigger processed an event: %s', event_data)
        
        blob_name = "motadata.json"
        
        blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)
        logging.info('Blob  client.')
        if blob_client.exists():
            logging.info('File exists. Updating file.')
            existing_data = blob_client.download_blob().readall().decode('utf-8')
            logging.info('Python EventHub trigger processed an event: %s', existing_data)
            updated_data = existing_data + "\n" + event_data
        else:
            logging.info('File does not exist. Creating file.')
            updated_data = event_data
        
        blob_client.upload_blob(updated_data, overwrite=True)
        logging.info('Python EventHub Completed uploading event data to storage account')
        
        
