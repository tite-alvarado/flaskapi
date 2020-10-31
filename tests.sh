curl -f localhost:5000/encrypt ||
curl -f localhost:5000/decrypt ||
curl -f -X POST localhost:5000/health ||
curl -f -H 'Content-Type: application/json' -d '{"test":"value"}' localhost:5000/encrypt ||
curl -f -H 'Content-Type: application/json' -d '{"test":"value"}' localhost:5000/decrypt ||
curl -f localhost:5000/health &&
curl -f -H 'Content-Type: application/json' -d '{"Input":"This is a functional test"}' localhost:5000/encrypt &&
curl -f -H 'Content-Type: application/json' -d '{"Input":"VGhpcyBpcyBhIGZ1bmN0aW9uYWwgdGVzdA=="}' localhost:5000/decrypt
