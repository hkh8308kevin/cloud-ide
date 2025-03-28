# Cloud IDE 환경 구축 가이드(수정중)

## 🚀 실행 가이드: Cloud IDE 환경 구축

아래 단계를 순서대로 따라 하시면 로컬에서 컨테이너 환경의 IDE가 만들어집니다.

---

## 📋 사전 준비 사항

Cloud IDE를 실행하기 전에 아래 도구들이 설치되어 있어야 합니다.

- [Visual Studio Code](https://code.visualstudio.com/) 
- [GitHub Desktop](https://desktop.github.com/) 또는 Git CLI
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (컨테이너 런타임)
- Docker로 실행할 **IDE 컨테이너 이미지** 또는 **Docker Compose 설정 파일**
  
---

### 1️⃣ 💾 VSCode 데이터 유지를 위한 Docker 볼륨 생성

컨테이너 재시작 시에도 **코드 작업 내용과 설정 정보를 유지하기 위해**  
로컬 디렉토리를 Docker 볼륨으로 바인딩합니다.

> 이 경로는 저의 Windows (WSL 또는 Docker Desktop) 환경 기준입니다.  
> 실제 경로는 사용자 환경에 따라 조정하세요.

#### 📦 앱 데이터 볼륨 생성

```bash
docker volume create  \
  --opt device="/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-apps" \
  --opt o=bind \
  --opt type=none \
  devops-cicd-apps
```
#### 🛠️ VSCode 설정 볼륨 생성

```bash
docker volume create  \
  --opt device="/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-vscode" \
  --opt o=bind \
  --opt type=none \
  devops-cicd-vscode
```
---

### 2️⃣ 🐳 Docker 이미지 빌드 및 IDE 실행

IDE 환경의 컨테이너를 만들기 위해 먼저 GitHub 저장소를 클론하고,  
Docker 이미지를 빌드한 뒤 컨테이너로 실행합니다.

---

### 📥 GitHub 저장소 클론

먼저 프로젝트 코드를 로컬에 클론합니다:

```bash
git clone https://github.com/hkh8308kevin/cicd-test.git
cd /mnt/d/GitHub_Action_강의/cloud-ide/ide
```

### 🔧 Docker 이미지 빌드

Dockerfile이 포함된 경로에서 다음 명령어를 실행합니다.

(도커파일을 수정한 다음 이미지를 빌드 한 후 자신의 이미지 공간에 푸시 후 이미지를 사용하실 수 있습니다.)

```bash
docker build -t cloud-ide:latest .
```

### 🚀 IDE 컨테이너 실행

두가지 방법으로 실행 가능합니다.
 
 1.docker run
 ```bash
 docker run -d \
  --name devops-cicd-ide \
  -p 8444:8443 \
  -v devops-cicd-apps:/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-apps \
  -v devops-cicd-vscode:/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-vscode \
  cloud-ide:latest
```
2. docker compose
```bash
docker compoose up -d
```
---
브라우저에서 http://localhost:8444 으로 접속할 수 있습니다.
