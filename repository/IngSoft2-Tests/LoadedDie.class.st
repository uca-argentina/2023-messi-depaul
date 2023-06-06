"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	sequence:		<Object>
	sequenceIndex:		<Object>

    Implementation Points
"
Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'sequenceIndex'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialize }
LoadedDie class >> of: aSequence [
	self validateExistsWith: aSequence.
	^(self new) initializeWith: aSequence.
]

{ #category : #initialize }
LoadedDie class >> validateExistsWith: aSequence [
	(aSequence anySatisfy: [:value | value <= 0]) ifTrue: [ 
		Error signal: 'Cannot create die with value less than 0' ].
]

{ #category : #'instance creation' }
LoadedDie >> initializeWith: aSequence [
	sequence:= aSequence.
	sequenceIndex := 1.
	
	
]

{ #category : #'instance variables' }
LoadedDie >> sequence [
	^ sequence
]

{ #category : #action }
LoadedDie >> throw [
	|value|
        value := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.
        ^ value.
]
