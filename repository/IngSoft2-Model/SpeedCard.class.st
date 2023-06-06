Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> byTurn [

	^ true
]

{ #category : #action }
SpeedCard >> implementOn: aBoardGame [

	^ 1
]

{ #category : #'instance variable' }
SpeedCard >> name [
	^'speed'.
]

{ #category : #action }
SpeedCard >> playOn: aBoardGame to: aSpaceship [ 
	aBoardGame throwPermanentCardTo: aSpaceship 
]
