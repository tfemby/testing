# Name the portage image
FROM gentoo/portage:latest as portage

# Based on the stage3 image
FROM gentoo/stage3:latest

# Copy the entire porage volume in
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

# Emerge pycargoebuild
RUN emerge -qv app-portage/pycargoebuild

# Set the working directory inside the container
WORKDIR /usr/src

# Copy any source file(s) required for the action
COPY entrypoint.sh .

# Configure the container to be run as an executable
ENTRYPOINT ["/usr/src/entrypoint.sh"]
