FROM debian:jessie

# Disable prompts on apt-get install
ENV DEBIAN_FRONTEND noninteractive

# Install latest stable LibreOffice
RUN apt-get update -qq \
    && apt-get install -y -q libreoffice \
    && apt-get remove -q -y libreoffice-gnome

# Cleanup after apt-get commands
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb /var/cache/apt/*cache.bin

# Write stdin to 'input_file'
CMD cat - > input_file \
    # Convert 'input_file' to pdf
    && libreoffice --invisible --headless --nologo --convert-to pdf --outdir $(pwd) input_file \
    # Send converted file to stdout
    && cat input_file.pdf
