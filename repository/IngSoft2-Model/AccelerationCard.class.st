Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> byTurn [

	^ true
]

{ #category : #action }
AccelerationCard >> canBePlayedIn: boardGame [

	boardGame validatePermanentPlay.
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
	aBoardGame throwPermanentCard 
]
