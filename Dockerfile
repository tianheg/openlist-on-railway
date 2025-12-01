FROM openlistteam/openlist:latest

USER root

# 安装 su-exec（用于切换用户）
RUN apk add --no-cache su-exec

# 复制 entrypoint 脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 创建基础目录结构
RUN mkdir -p /opt/openlist/data && \
    chown -R 1001:1001 /opt/openlist/data

# 确保 entrypoint 可执行
USER 1001:1001

# 设置 entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# 保持与官方镜像相同的启动命令
CMD ["./openlist", "--no-prefix", "server"]
