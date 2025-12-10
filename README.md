# Classification-of-movements-using-EMG-signals-Feature-selection-

## File Descriptions

| File | Description |
|------|-------------|
| **extraction.m** | Preprocesses EMG signals using notch and band-pass filters. Buffers signals and extracts features from each channel. |
| **feat.m** | Computes 50+ time-domain, frequency-domain, and statistical features from buffered EMG segments. |
| **exhaustive.m** | Performs exhaustive evaluation and selection of features across multiple datasets. |
| **classification.m** | Trains and tests ANN classifiers with cross-validation for EMG-based movement recognition. |
