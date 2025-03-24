# Cloud IDE 환경 구축 가이드(수정중)

## 🚀 실행 가이드: Cloud IDE 환경 구축

아래 단계를 순서대로 따라 하시면 로컬에서 컨테이너 환경의 IDE가 만들어집니다.

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
