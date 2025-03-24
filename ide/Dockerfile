FROM linuxserver/code-server:latest

# 비대화식 모드 및 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Asia/Seoul"
ENV PUID=0
ENV PGID=1000

# code-server 작업 디렉토리 생성
RUN mkdir /code && chown 1000:1000 /code

# 1. 업데이트 및 업그레이드
RUN apt-get update && apt-get -y upgrade

# 2. 기본 패키지 설치 (Node.js, npm은 제외)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common \
        wget \
        unzip \
        net-tools \
        vim \
        iputils-ping \
        openjdk-17-jdk \
        python3 \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 3. Node.js 설치 (NodeSource 스크립트로 Node.js 16.x 설치)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    node -v && npm -v

# 4. Dart-Sass 설치
RUN npm install -g sass

# 5. Hugo 설치
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v0.145.0/hugo_extended_0.145.0_linux-amd64.tar.gz -o hugo.tar.gz && \
    tar -xzf hugo.tar.gz -C /usr/local/bin && \
    rm hugo.tar.gz

# 6. Jupyter와 ipykernel 설치
RUN pip install --no-cache-dir --break-system-packages jupyter ipykernel

# 7. JDK 환경 변수 설정
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# 8. Docker CLI 설치
RUN apt-get update && install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

# 9. AWS CLI 설치 (amazon/aws-cli 이미지에서 복사)
COPY --from=amazon/aws-cli /usr/local/aws-cli/v2 /usr/local/aws-cli/v2
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws && \
    ln -s /usr/local/aws-cli/v2/current/bin/aws_completer /usr/local/bin/aws_completer

# 10. Terraform 설치
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && apt-get clean

# 11. Kubectl 설치
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' \
    | tee /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y kubectl

# 12. Kubectx & Kubens 설치
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
    ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
    ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# 13. k9s 설치
RUN curl -fsSL https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz \
    | tar xz && mv k9s /usr/local/bin/ && chmod +x /usr/local/bin/k9s
