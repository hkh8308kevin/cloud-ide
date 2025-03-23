# Docker build를 사용해도 되지만 buildx기능을 활용하여 다양한 아키텍처(amd64,arm64)와 운영체제에 대한 이미지 빌드를 할 수 있음
# show build version
docker buildx version

# 빌더 인스턴스를 생성하고 이를 현재 세션에서 사용하도록 설정
docker buildx create --name mybuilder --use

# 현재 시스템의 아키텍처에 맞는 이미지 생성
docker build -t hkh8308/cloud-ide .

# 빌더 인스턴스를 사용하여  다른 아키텍처형으로 이미지 빌드를 함 / 위에서  -use를 사용했기 때문에 --build 생략 가능
docker buildx build  --builder mybuilder --platform linux/amd64,linux/arm64  -t hkh8308/cloud-ide --push .
docker buildx build  --platform linux/amd64,linux/arm64  -t hkh8308/cloud-cicd --push .