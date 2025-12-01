FROM openlistteam/openlist:latest

# 必须使用 root 执行权限设置
USER root

# 关键：设置 777 权限，确保 UID 1001 可写
# Railway 卷挂载时机在容器启动后，运行时无法修改权限
RUN mkdir -p /opt/openlist/data && \
    chmod -R 777 /opt/openlist/data && \
    chown -R 1001:1001 /opt/openlist/data

# 安装 su-exec（用于启动时切换用户）
RUN apk add --no-cache su-exec

# 创建启动脚本（简化版）
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "🔧 Starting OpenList on Railway..."' >> /entrypoint.sh && \
    echo 'mkdir -p /opt/openlist/data' >> /entrypoint.sh && \
    echo 'exec su-exec 1001:1001 "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

# 切换回应用用户（Railway 可能强制覆盖此设置）
USER 1001:1001

ENTRYPOINT ["/entrypoint.sh"]
CMD ["./openlist", "--no-prefix", "server"]
