pipeline{
  agent any
  stages{
    stage("Maven Build"){
      steps{
        echo "This is Jenkinsfile demo"
      }
    }
    stage("Dev Deploy"){
      when {
        branch "develop"
      }
      steps{
        echo "Deploying to dev"
      }
    }
    stage("Test Deploy"){
      when {
        branch "test"
      }
      steps{
        echo "deploying to test"
      }
    }
    stage("Prod Deploy"){
      when {
        branch "main"
      }
      steps{
        echo "deploying to prod"
      }
    }
  }
}
