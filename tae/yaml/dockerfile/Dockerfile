# 베이스 이미지 설정
FROM python:3.9

# 앱 디렉토리 생성
WORKDIR /app

# 앱 의존성 설치 (Flask)
RUN pip install Flask

# 앱 소스 추가
COPY app.py .

# Flask 애플리케이션 실행
CMD ["python", "app.py"]

