curl -f 127.0.0.1:5000/encrypt ||
curl -f 127.0.0.1:5000/decrypt ||
curl -f -X POST 127.0.0.1:5000/health ||
curl -f 127.0.0.1:5000/health &&
curl -f -X POST 127.0.0.1:5000/encrypt &&
curl -f -X POST 127.0.0.1:5000/decrypt &&
curl -H 'Content-Type: application/json' -d '{"Input": "My string to encrypt","Output": "DKJALDKLKADF===","Status": "success","Message": ""}' 127.0.0.1:5000/encrypt
