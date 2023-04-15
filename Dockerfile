ARG GOTTY_VERSION=v1.5.0

FROM debian:bullseye-slim AS builder

ARG GOTTY_VERSION

WORKDIR /build

ADD https://github.com/sorenisanerd/gotty/releases/download/${GOTTY_VERSION}/gotty_${GOTTY_VERSION}_linux_arm64.tar.gz gotty-aarch64.tar.gz
ADD https://github.com/sorenisanerd/gotty/releases/download/${GOTTY_VERSION}/gotty_${GOTTY_VERSION}_linux_amd64.tar.gz gotty-x86_64.tar.gz

RUN tar -xzvf "gotty-$(uname -m).tar.gz"
# Use an official Python base image from the Docker Hub
FROM python:3.11-slim

COPY --chmod=+x --from=builder /build/gotty /bin/gotty

# Set environment variables
ENV PIP_NO_CACHE_DIR=yes \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Create a non-root user and set permissions
RUN useradd --create-home appuser
WORKDIR /home/appuser
RUN chown appuser:appuser /home/appuser
USER appuser

# Copy the requirements.txt file and install the requirements
COPY --chown=appuser:appuser requirements.txt .
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --no-cache-dir --user -r requirements.txt

# Copy the application files
COPY --chown=appuser:appuser autogpt ./autogpt

EXPOSE 8080

CMD ["gotty", "--port", "8080", "--permit-write", "--title-format", "AutoGPT Terminal", "bash", "-c", "python -m autogpt"]
