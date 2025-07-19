# VoiceCloneLab — The Wizard’s Local Voice Cloning Grimoire

![Status](https://img.shields.io/badge/status-WIP-purple) ![License](https://img.shields.io/badge/license-MIT-green) ![Built With](https://img.shields.io/badge/built_with-Coqui%20TTS-blue)

<p align="center">
  <img src="https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExdGE5czljamZpbDUzajI3aDJ3dGc5YXZxOWI0YWZuOTltdzYzaDBiaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3QO7d0RBoxNd04ueF4/giphy.gif" alt="Wizard at Work" width="300"/>
</p>

> “Why speak the same incantation a thousand times when your digital familiar can speak for you?” — Archmage Mrunmoy

**VoiceCloneLab** is an open-source arcane playground for creating your own local **voice cloning spellbook**.  
Record your own voice — or an enchanted Voicemod-filtered variant — train it on your own machine, and summon spoken words from text, any time you desire. 🔮✨

No cloud, no fees — just pure local wizardry.

I started working on this because I wanted to create video demos of my projects with voice narration. But instead of spending time recording and re-recording my voice, I thought — why not write the narration (which I’m much faster at), and have a magically modified version of my voice do the talking for me? 
<p align="center">
  <img src="https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZWhreW01d2J0eTYzYWQyajI4eXRpdHZxOWRyOXlrenlyeWZyOWJqdiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3rgXBOmTlzyFCURutG/giphy.gif" alt="Evil laugh" width="300"/>
</p>


---

## What is this?

A conjurer’s kit to:
- Capture your natural and Voicemod-filtered voice samples
- Train your own TTS (text-to-speech) models with [Coqui TTS](https://github.com/coqui-ai/TTS)
- Generate spoken incantations from any text
- Runs entirely on your Linux tower — tested on twin GTX 1070 familiars
- 100% local and privacy-safe

---

## Spellbook Layout (Folder Structure)

```plaintext
VoiceCloneLab/
 ├── dataset/            # Your raw voice samples
 │   ├── natural/        # The true voice
 │   └── voicemod/       # The enchanted voice
 ├── configs/            # Ritual configurations for training
 ├── scripts/
 │   ├── train.py        # Cast the training spell
 │   ├── synth.py        # Summon speech from text
 │   ├── server.py       # (Planned) Local REST API familiar
 ├── output/             # Generated audio incantations
 ├── checkpoints/        # Saved model artifacts
 ├── requirements.txt
 ├── README.md
 ├── IDEAS.md
 ├── LICENSE
```

---

## Status: Work in Progress

- [x] Spellbook initialized
- [ ] Test Coqui TTS with pre-trained voices
- [ ] Record the first datasets (natural & enchanted)
- [ ] Write `config.yaml` incantations for each
- [ ] Train the voice clones
- [ ] Summon spoken words from text
- [ ] Document the rituals for future conjurers

---


# More coming soon....
