Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> canBePlayedIn: aBoardGame for: aSpaceship [

	aBoardGame validatePermanentPlayFor: aSpaceship
]

{ #category : #action }
OverloadCard >> implementOn: aBoardGame [

	^ -2
]

{ #category : #'instance variable' }
OverloadCard >> name [
	^'overload'
]

{ #category : #action }
OverloadCard >> playOn: aBoardGame [ 
	
	Error signal: 'To play card, choose a player'
]

{ #category : #action }
OverloadCard >> playOn: aBoardGame to: aSpaceship [

	aBoardGame permanentCardTo: aSpaceship
]

{ #category : #action }
OverloadCard >> playOn: aBoardGame toSelected: aSpaceshipCard [ 
	
	Error signal: 'To play card, choose a player' .
]
