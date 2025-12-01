# OpenList on Railway
# Based on official OpenList image with Railway volume permission fixes

FROM openlist/openlist:latest

# Install su-exec for user switching (if not already present)
USER root
RUN apk add --no-cache su-exec || true

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set data directory
ENV OPENLIST_DATA_DIR=/opt/openlist/data

# Expose default OpenList port
EXPOSE 5244

# Use custom entrypoint that fixes Railway volume permissions
ENTRYPOINT ["/entrypoint.sh"]

# Run OpenList server
CMD ["/opt/openlist/openlist"]

