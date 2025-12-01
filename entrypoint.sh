#!/bin/sh

# 在 Railway 卷挂载后修复权限
# OpenList v4.1.0+ 使用 UID 1001 和 GID 1001

echo "🔧 Fixing permissions for Railway volume..."

# 确保数据目录存在
mkdir -p /opt/openlist/data

# 修复权限（必须 root 用户执行）
if [ "$(id -u)" = "0" ]; then
    # 递归修复整个数据目录的属主
    chown -R 1001:1001 /opt/openlist/data
    
    # 确保目录可写
    chmod -R 755 /opt/openlist/data
    
    echo "✅ Permissions fixed for UID 1001"
    
    # 切换回普通用户执行主程序
    exec su-exec 1001:1001 "$@"
else
    # 非 root 用户直接执行（备用）
    echo "⚠️ Not running as root, skipping permission fix"
    exec "$@"
fi
