#!/bin/bash

# 1. 备份数据
echo "请确保你已经备份了所有重要数据。"
read -p "按回车键继续..."

# 2. 卸载 /dev/sdb1
echo "卸载 /mnt..."
umount /mnt

# 3. 删除 /dev/sdb1 分区
echo "删除 /dev/sdb1 分区..."
parted /dev/sdb --script rm 1

# 4. 扩展 /dev/root 分区
echo "扩展 /dev/root 分区..."
parted /dev/sda --script resizepart 1 100%

# 5. 通知内核重新读取分区表
echo "通知内核重新读取分区表..."
partprobe /dev/sda

# 6. 检查文件系统
echo "检查 /dev/root 文件系统..."
e2fsck -f /dev/root

# 7. 调整文件系统大小
echo "调整 /dev/root 文件系统大小..."
resize2fs /dev/root

echo "完成。无需重启系统。"
