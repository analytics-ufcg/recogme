class KeyTouch:
    "A class to represent the interaction between a user and a key"

    attempt_id = None
    email = None
    attempt_time = None
    source = None
    keyDown = None
    keyUp = None
    keyValue = None
    keyCode = None

    def __init__(self, rowSplit):
    	self.attempt_id = rowSplit[0]
    	self.email = rowSplit[1]
    	self.attempt_time = rowSplit[2]
    	self.source = rowSplit[3]
    	self.keyDown = rowSplit[4]
    	self.keyUp = rowSplit[5]
    	self.keyValue = rowSplit[6]
    	self.keyCode = rowSplit[7]
