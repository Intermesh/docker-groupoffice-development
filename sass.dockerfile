FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y ruby-sass

# Set up the command arguments
CMD ["-"]
ENTRYPOINT ["sass"]