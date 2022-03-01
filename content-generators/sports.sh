#curl --location --request POST 'https://oauth2.elenasport.io/oauth2/token' \
#    --header 'Content-Type: application/x-www-form-urlencoded' \
#    --header 'Authorization: Basic MmYwdWNtMzRvOGhzNW81OGJxM200cmY2YjU6djVtZGkxbzNmdmY3NzgxMDk0aHM3Y2psMWU2NDE2MXBsbmFxMHJsYWRpcDV2bGZpb2xw' \
#    --data-urlencode 'grant_type=client_credentials' > cache

cat cache | jq