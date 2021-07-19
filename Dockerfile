# FROM ubuntu:18.04
FROM rocker/tensorflow

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
# RUN apt-get install -y --no-install-recommends apt-utils
# RUN apt-get install dialog apt-utils -y
RUN apt-get install --yes curl
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --yes nodejs
# RUN apt-get install --yes nodejs \ 
#     npm

# Install Linux Libraries
RUN apt-get install -y default-jre
RUN apt-get install -y libssl-dev libjpeg-dev libmagick++-dev && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y curl
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libmagick++-dev
RUN apt-get install -y libnss3



# Install python an pip
RUN apt-get update
RUN apt-get install -y python3
RUN apt-get update
RUN apt-get install -y python3-pip



# Install pip dependencies
RUN pip3 install h5py
RUN pip3 install keras
RUN pip3 install tensorflow

# Install R  dependencies
RUN Rscript -e "install.packages('remotes', repo = 'https://cloud.r-project.org')"
RUN Rscript -e "install.packages(c('curl','xml2','roxygen2','abind', 'magrittr', 'stringr', 'httr', 'jpeg', 'png', 'purrr', 'progress','magick'))"
RUN Rscript -e "install.packages(c('plumber', 'yaml', 'base64enc', 'remotes'))"
RUN Rscript -e "remotes::install_github('rstudio/reticulate')"
RUN Rscript -e "remotes::install_github('rstudio/tensorflow')"
RUN Rscript -e "remotes::install_github('rstudio/keras')"
RUN Rscript -e "remotes::install_github('decryptr/decryptrModels')"
RUN Rscript -e "remotes::install_github('decryptr/decryptr')"







ENV NODE_ENV=production

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY app/package.json /usr/src/app/

RUN npm install --production

COPY app/ .

EXPOSE 3001

CMD ["node", "app.js"]