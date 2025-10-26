pipeline {
    agent any

    environment {
        COMPOSE_FILE = 'docker-compose.yaml'
        IMAGE_NAME = 'ayodyawasesa/mobile2cc'
        CONTAINER_APP = 'mobile2cc'
        DOCKERHUB_CREDENTIALS = credentials('tugas2komputasi')
    }

    stages {
        stage('Checkout Source') {
            steps {
                echo '🔄 Mengambil source code dari GitHub...'
                git branch: 'main', url: 'https://github.com/ayodya-jpg/API2CC.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📦 Menginstall dependencies React Native...'
                bat 'docker compose run --rm reactnative npm install --unsafe-perm'
            }
        }

        stage('Start App') {
            steps {
                echo '🚀 Menjalankan container React Native...'
                bat 'docker compose up -d reactnative'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🏗️ Membangun image Docker...'
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📤 Mengunggah image ke Docker Hub...'
                script {
                    bat """
                    docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%
                    docker tag ${CONTAINER_APP} %IMAGE_NAME%:latest
                    docker push %IMAGE_NAME%:latest
                    """
                }
            }
        }

        stage('Run with Docker Compose') {
            steps {
                echo '🚀 Menjalankan container aplikasi dengan Docker Compose...'
                bat "docker compose -f ${COMPOSE_FILE} up -d"
            }
        }

        stage('Post-Build') {
            steps {
                echo '✅ Build dan Deploy selesai! Aplikasi berhasil dijalankan.'
            }
        }
    }

    post {
        success {
            echo '🎉 Pipeline berhasil dijalankan dan image telah dipush ke Docker Hub.'
        }
        failure {
            echo '❌ Build gagal! Cek log pipeline untuk melihat kesalahan.'
        }
    }
}
