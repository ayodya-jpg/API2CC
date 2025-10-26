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

        stage('Build Docker Image') {
            steps {
                echo '🏗️  Membangun image Docker...'
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📦 Mengunggah image ke Docker Hub...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }

        stage('Run with Docker Compose') {
            steps {
                echo '🚀 Menjalankan container aplikasi dengan Docker Compose...'
                sh "docker compose -f ${COMPOSE_FILE} up -d"
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
