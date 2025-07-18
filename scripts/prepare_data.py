import os
import glob
import csv

def create_metadata_csv(dataset_path, output_filename="metadata.csv"):
    """
    Creates metadata.csv for a single-speaker TTS dataset.

    Assumes:
    - WAV files are in dataset_path/wavs/
    - Corresponding transcript .txt files are in dataset_path/
    - Output is dataset_path/metadata.csv
    - Format: id|raw_text|normalized_text (raw == normalized for now)
    """

    wavs_dir = os.path.join(dataset_path, "wavs")
    output_filepath = os.path.join(dataset_path, output_filename)

    if not os.path.isdir(wavs_dir):
        print(f"Error: WAVs directory not found at {wavs_dir}")
        return

    print(f"Looking for WAVs in: {wavs_dir}")
    print(f"Looking for TXT transcripts in: {dataset_path}")

    wav_files = sorted(glob.glob(os.path.join(wavs_dir, "*.wav")))
    if not wav_files:
        print(f"No WAV files found in {wavs_dir}.")
        return

    entries = []

    for wav_path in wav_files:
        base_id = os.path.splitext(os.path.basename(wav_path))[0]  # Strip ".wav"
        txt_path = os.path.join(dataset_path, f"{base_id}.txt")

        if os.path.isfile(txt_path):
            with open(txt_path, 'r', encoding='utf-8') as f:
                text = f.read().strip()

            # Write ID|raw|normalized (same value for both text fields)
            entries.append([base_id, text, text])
        else:
            print(f"Warning: No matching .txt for {base_id}.wav — skipping.")

    if not entries:
        print("No valid audio-transcript pairs found.")
        return

    with open(output_filepath, 'w', encoding='utf-8') as f:
        for entry in entries:
            f.write("|".join(entry) + "\n")

    print(f"✅ metadata.csv created at {output_filepath} with {len(entries)} entries.")

if __name__ == "__main__":
    # Set dataset path to ./dataset/natural/
    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(current_dir)
    dataset_path = os.path.join(project_root, "dataset", "natural")

    create_metadata_csv(dataset_path)
