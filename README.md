# Classification-of-movements-using-EMG-signals-Feature-selection-

extraction.m
Preprocesses EMG signals using notch and band-pass filters. Buffers signals and extracts features from each channel.

feat.m
Computes 50+ time-domain, frequency-domain, and statistical features from buffered EMG segments.

exhaustive.m
Performs exhaustive evaluation and selection of features across multiple datasets.

classification.m
Trains and tests ANN classifiers with cross-validation for EMG-based movement recognition.

s1.mat
Sample EMG dataset for one subject containing multiple movement recordings.

sbestfeatallsubj.mat
Precomputed features from all subjects used for classification and model evaluation.
