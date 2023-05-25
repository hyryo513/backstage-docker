


FROM amazonlinux:latest

ARG APP_NAME

ENV APP_NAME=${APP_NAME}

RUN yum install -y nodejs

RUN yum groupinstall -y "Development Tools"

RUN npm install -g yarn

RUN echo $APP_NAME | npx --yes @backstage/create-app@latest

COPY app-config.yaml $APP_NAME

COPY entrypoint.sh entrypoint.sh

RUN chmod 755 entrypoint.sh

RUN cd $APP_NAME && yarn backstage-cli versions:bump

RUN yum groupremove -y "Development Tool"

ENTRYPOINT [ "./entrypoint.sh" ]

EXPOSE 3000 7007