# My Dockerfile's setting is for my personal use. You can modify it for your consistence.
# freak_ipr@NoSpaceAvailable

FROM python:3.8-slim

# install wget and unzip, option -y is to accept any question from apt-get when installing packages automatically
RUN  apt-get update && apt-get -y install wget unzip && \
     wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
     tar xvzf ngrok-v3-stable-linux-amd64.tgz -C /usr/local/bin && \
     ngrok config add-authtoken 2ZiOTwdH0oxXl47DRfNVGExEhRD_7B5fvQdfiXANGXGFKqBDV

# working directory
WORKDIR /RCEchall

COPY myfirstchall/requirements.txt .

# --no-cache-dir to avoid caching for reinstall purpose, -r means install packages in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# /myfirstchall means that this dir is the endpoint, myfirstchall/ means that maybe there is a path to another file or dir
COPY /myfirstchall .
COPY flag.txt .

# port to listen to
EXPOSE 5000

# run main.py and host ngrok
CMD [ "bash", "-c", "python main.py && ngrok http 5000" ]
