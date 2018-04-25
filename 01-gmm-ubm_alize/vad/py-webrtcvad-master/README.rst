
The VAD that Google developed for the `WebRTC <https://webrtc.org/>`_
project is reportedly one of the best available, being fast, modern
and free.

How to use it
-------------

0. Install the webrtcvad module::

    pip install webrtcvad

1. Create a ``Vad`` object::

    import webrtcvad
    vad = webrtcvad.Vad()

2. Optionally, set its aggressiveness mode, which is an integer
   between 0 and 3. 0 is the least aggressive about filtering out
   non-speech, 3 is the most aggressive. (You can also set the mode
   when you create the VAD, e.g. ``vad = webrtcvad.Vad(3)``)::

    vad.set_mode(1)

3. Give it a short segment ("frame") of audio. The WebRTC VAD only
   accepts 16-bit mono PCM audio, sampled at 8000, 16000, 32000 or 48000 Hz.
   A frame must be either 10, 20, or 30 ms in duration::

    # Run the VAD on 10 ms of silence. The result should be False.
    sample_rate = 16000
    frame_duration = 10  # ms
    frame = b'\x00\x00' * (sample_rate * frame_duration / 1000)
    print 'Contains speech: %s' % (vad.is_speech(frame, sample_rate)


See `example.py

##################################################################################
To run:-

python example.py 2 leak-test.wav


###################################################################################
