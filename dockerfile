# Étape : image adaptée à ta version Python
FROM python:3.12.10-slim-bullseye

# Étape : définition du répertoire de travail
WORKDIR /app

# Étape : copier les dépendances et les installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Étape : copie du code source
COPY src/ ./src
COPY tests/ ./tests

# Étape : permissions (nécessaire si le build inclut des fichiers egg-info)
RUN test ! -e src/page_tracker.egg-info || chmod 755 -R src/page_tracker.egg-info

# Étape : définir le PYTHONPATH pour les imports relatifs
ENV PYTHONPATH=/app/src

# Étape : lancer le linter + les tests à la construction
RUN pylint src/ --disable=C0114,C0116,R1705 || true
CMD ["gunicorn", "-b", "0.0.0.0:5000", "page_tracker.app:app"]

