pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Compilando e/ou baixando dependências'
                sh 'bundle install'
            }
        }
        stage('Test') {
            steps {
                echo 'Executando testes'
                sh 'rspec -fd'
            }
        }
        stage('UAT') {
            steps {
                echo 'Testes de aceitação'
            }
        }
        stage('Prod') {
            steps {
                echo 'App pronto para produção'
            }
        }
    }
}
