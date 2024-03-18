FROM nginx
RUN echo "build started"
COPY index.html /usr/share/nginx/html
RUN echo "build completed"
