#!/bin/bash

#sox wav/test.wav -r 16000 -c 1 test.wav
ffmpeg -loglevel panic -i wav/*.wav -ar 16000 -b 16k -ac 1 test.wav

python ../vad/py-webrtcvad-master/example.py 3 test.wav >> log/tmp.log

bin/HCopy -C cfg/hcopy_sph_75.cfg test.wav_nosil.wav test.mfc

mv test.mfc data/prm/

bin/NormFeat --config cfg/NormFeat_energy_HTK.cfg --inputFeatureFilename data/test.lst --featureFilesPath data/prm/ >> log/tmp.log

bin/EnergyDetector  --config cfg/EnergyDetector_HTK.cfg --inputFeatureFilename data/test.lst --featureFilesPath data/prm/  --labelFilesPath  data/lbl/ >> log/tmp.log

bin/NormFeat --config cfg/NormFeat_HTK.cfg --inputFeatureFilename data/test.lst --featureFilesPath  data/prm/   --labelFilesPath  data/lbl/ >> log/tmp.log

ls gmm/ | grep -v world |xargs -n2 | sed 's/^/test /' > ndx/test.ndx

rm res/target-seg_gmm.res

bin/ComputeTest --config cfg/ComputeTest_GMM.cfg &> log/ComputeTest.cfg

rm data/prm/test.* data/lbl/test.lbl ndx/test.ndx wav/*.wav

mv test.wav speech/$(date +%F-%H:%M).wav

python compare_voice.py res/target-seg_gmm.res

