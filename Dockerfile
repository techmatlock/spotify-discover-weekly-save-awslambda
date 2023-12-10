FROM public.ecr.aws/lambda/python:3.11.2023.12.05.16-arm64

WORKDIR ${LAMBDA_TASK_ROOT}

COPY . ${LAMBDA_TASK_ROOT}

ENV SPOTIPY_CLIENT_ID="73294f1a3db54ceda0e0fe5874b702ba"
ENV SPOTIPY_CLIENT_SECRET="328584b4a98f481aa4dc44493a307736"
ENV SPOTIPY_REDIRECT_URI="http://localhost:8080"
ENV USERNAME="12139181856"
ENV SCOPE="playlist-read-private playlist-modify-private playlist-modify-public"
ENV CACHE_PATH=".cache-mark"

RUN pip3 install -r requirements.txt

CMD ["lambda_function.handler"]

