#Jam Motion

Fun little hackathon project to play around and jam with your friends, using your phones and gestures!


##Installing

Check out from github then

    npm install

##Starting the server

You need to have node installed, but then it's just

    node app.js


##Client Documentation

A JamNation client can communicate with the server using socketIO and passing specific messages.

###Messages

There are two types of messages: *audio* and *meta*.

Audio messages currently take the following forms:

**Simple Instrument**
Simple instruments are one-note short sounds.

    {instrument: 'cymbal', player: 'alex'}

**Complex Instrument**
Complex instruments require a note parameter.

    {instrument: 'juno', note:'g', player: 'alex'}

**Loop Instrument**
Loop instruments are long-running instruments and require a stop/start command.

    {instrument: 'loop1', command:'start', player: 'alex'}


Meta messages are not yet defined, but will be used for the following use cases:

 * User logs on
 * User switches instrument

###Instruments

####Simple Instrument

 * 'arp'
 * 'cymbal'
 * 'kick'
 * 'snare'
 * 'hbase'
 * 'hhat'

####Complex Instrument

 * 'bass' notes 1,2,3
 * 'fx' notes 1,2,3
 * 'juno' notes 'c', 'e', 'g'

####Loop Instrument

 * 'loop1'
 * 'loop2'

##Roadmap

 * Accelerometer-fed electronic instruments.
