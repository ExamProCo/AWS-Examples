import base64
encoded = base64.b64encode(b'Send reinforcements')
print(encoded)
data = base64.b64decode(encoded)
print(data)