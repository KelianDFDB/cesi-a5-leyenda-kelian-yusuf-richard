# Projet Leyenda — captioning automatique d'images pour TouNum

Workflow complet, de l'image scannée à la légende :

```
images ──> 1. photo ou pas ? ──> 2. débruitage ──> 3. légende
           (Hybrid MobileNetV2)   (U-Net profond)    (InceptionV3 + 3 GRU, MS COCO)
             non-photo : écartée avec sa classe
```

| Notebook | Livrable | Modèle retenu (`results/`) |
|---|---|---|
| `01_photo_ou_pas.ipynb` | 1 — classification (5 classes : peinture, photo, schéma, croquis, texte) | `Hybrid_MobileNetV2.keras` |
| `02_denoising.ipynb` | 2 — débruitage par auto-encodeurs convolutifs | `denoise_UNet_deep.keras` |
| `03_captioning.ipynb` | 3 — captioning CNN + RNN (d'après Hvass-Labs #22, encodeur InceptionV3) | `caption_Hvass_GRU_InceptionV3.keras` + `caption_Hvass_GRU_InceptionV3_vocab.json` |
| `04_pipeline.ipynb` | 3 — workflow complet sur un dossier (démo de soutenance) | les trois ci-dessus |

## Lancer l'environnement

```bash
make up        # construit et démarre le conteneur (TensorFlow 2.21 + GPU, Jupyter sur http://127.0.0.1:8888, token: dev)
make shell     # shell dans le conteneur
make down
```

Le dossier du projet est monté dans `/workspace`. Les bibliothèques sont dans `requirements.txt`.

## Données

- `data_raw/{Painting,Photo,Schematics,Sketch,Text}/` : images des livrables 1 et 2 (fournies par le pilote).
- `data_raw/Dataset/` : photos bruitées réelles.
- `data_raw/coco/` : MS COCO 2017, **téléchargé automatiquement** par `03_captioning.ipynb` (≈ 19 Go, à faire avant la soutenance).
- `data/` : caches recalculés automatiquement (index des images, vecteurs CNN de COCO). On peut le supprimer.

## Ordre d'exécution

1. `01_photo_ou_pas.ipynb` et `02_denoising.ipynb` (les modèles sont déjà dans `results/` : mettre `RETRAIN` à `False` pour les recharger).
2. `03_captioning.ipynb` : téléchargement de COCO, vecteurs InceptionV3 (une fois), entraînement (environ 1 min 30 par epoch sur RTX 4090), évaluation BLEU. `ENCODER = "VGG16"` permet de comparer avec le choix du tutoriel.
3. `04_pipeline.ipynb` : changer `INPUT_DIR` (et `ANNOTATIONS` si des légendes sont fournies) dans la dernière section, puis exécuter.
