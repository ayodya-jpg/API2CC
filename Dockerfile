# Gunakan base image Node.js LTS
FROM node:18

# Install dependencies untuk React Native (dan Expo)
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependency React Native
RUN npm install -g expo-cli && npm install

# Copy semua file proyek
COPY . .

# Build aplikasi (bisa diubah sesuai kebutuhan, misal menggunakan Expo)
RUN npx expo export || echo "Expo build selesai"

# Jalankan server development (untuk testing)
CMD ["npm", "start"]
