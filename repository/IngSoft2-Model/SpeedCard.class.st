Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> canBePlayedIn: aBoardGame for: aSpaceship [ 
	aBoardGame validatePermanentPlayFor: aSpaceship
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
SpeedCard >> playOn: aBoardGame [

	Error signal: 'To play card, choose a player'
]

{ #category : #action }
SpeedCard >> playOn: aBoardGame to: aSpaceship [ 
	aBoardGame permanentCardTo: aSpaceship 
]

{ #category : #action }
SpeedCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'To play card, choose a player'.
]
