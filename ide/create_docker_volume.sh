# vscode 데이터 유지를 위한 도커 볼륨 생성 및 마운트
docker volume create  \
--opt device="/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-apps" \
--opt o=bind --opt type=none devops-cicd-apps

docker volume create  \
--opt device="/mnt/d/GitHub_Action_강의/cloud-ide/ide/storage/devops-cicd-vscode" \
--opt o=bind --opt type=none devops-cicd-vscode

# 볼륨 생성 확인
docker volume ls

# 네트워크 확인
docker network ls
docker network inspect kind