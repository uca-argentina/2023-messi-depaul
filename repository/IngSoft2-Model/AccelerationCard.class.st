Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> canBePlayedIn: aBoardGame for: aSpaceship [

	aBoardGame validatePermanentPlayFor: aSpaceship
]

{ #category : #action }
AccelerationCard >> implementOn: aBoardGame [ 
	^1
]

{ #category : #'instance variable' }
AccelerationCard >> name [
	^'acceleration'
]

{ #category : #action }
AccelerationCard >> playOn: aBoardGame [ 
	aBoardGame permanentCard 
]

{ #category : #action }
AccelerationCard >> playOn: aBoardGame to: aSpaceship [

	Error signal: 'You cannot choose a player for acceleration card.'
]
