# Usa una imagen base oficial de Python
FROM python:3.6

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo requirements.txt al directorio de trabajo
COPY requirements.txt .

# Instala las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código fuente de la aplicación al directorio de trabajo
COPY . .

# Ejecuta el script de Python cuando se inicie el contenedor
CMD ["python3", "main.py"]
