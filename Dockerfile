# 使用官方 OpenList 镜像作为基础
FROM openlistteam/openlist:latest

# 切换到 root 用户以执行权限修复
USER root

# 创建数据目录并设置正确的权限
# OpenList v4.1.0+ 使用 UID 1001 和 GID 1001 的 openlist 用户
RUN mkdir -p /opt/openlist/data && \
    chown -R 1001:1001 /opt/openlist/data && \
    chmod -R 755 /opt/openlist/data

# 确保配置文件目录也存在（如果需要）
RUN mkdir -p /opt/openlist/config && \
    chown -R 1001:1001 /opt/openlist/config && \
    chmod -R 755 /opt/openlist/config

# 切换回 OpenList 默认用户（UID 1001）
USER 1001:1001

# 健康检查（Railway 推荐配置）
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5244/ping || exit 1

# 容器启动命令（保持与官方镜像一致）
CMD ["./openlist", "--no-prefix", "server"]
