# -*- coding: utf-8 -*-
"""
智能编码转换脚本
检测并修复 GB2312/GBK 编码的中文文件，转换为 UTF-8 with BOM
"""

import os
import chardet
from pathlib import Path

def detect_and_fix_encoding(file_path):
    """检测并修复文件编码"""
    
    # 读取原始字节
    with open(file_path, 'rb') as f:
        raw_bytes = f.read()
    
    # 使用 chardet 检测编码
    detection = chardet.detect(raw_bytes)
    detected_encoding = detection['encoding']
    confidence = detection['confidence']
    
    print(f"  检测到的编码：{detected_encoding} (置信度：{confidence:.2f})")
    
    # 尝试多种编码
    encodings_to_try = [
        ('GB2312', 'gb2312'),
        ('GBK', 'gbk'),
        ('GB18030', 'gb18030'),
        ('UTF-8', 'utf-8'),
        ('UTF-8-SIG', 'utf-8-sig'),
        ('Big5', 'big5')
    ]
    
    best_content = None
    best_encoding = None
    
    for enc_name, enc_python in encodings_to_try:
        try:
            # 尝试解码
            content = raw_bytes.decode(enc_python)
            
            # 检查是否包含"锟斤拷"乱码字符 (UTF-8 错误解码的特征)
            if '锟斤拷' in content:
                print(f"  - {enc_name}: 包含乱码字符，跳过")
                continue
            
            # 检查是否包含可读的中文
            has_chinese = any('\u4e00' <= char <= '\u9fff' for char in content)
            
            if has_chinese:
                print(f"  ✓ {enc_name}: 找到可读中文")
                best_content = content
                best_encoding = enc_name
                break
            else:
                # 如果没有中文，也接受这个解码结果
                if best_content is None:
                    best_content = content
                    best_encoding = enc_name
                    
        except UnicodeDecodeError as e:
            print(f"  - {enc_name}: 解码失败 - {e}")
            continue
        except Exception as e:
            print(f"  - {enc_name}: 错误 - {e}")
            continue
    
    if best_content is not None:
        # 保存为 UTF-8 with BOM
        with open(file_path, 'w', encoding='utf-8-sig') as f:
            f.write(best_content)
        print(f"  ✓ 文件已转换为 UTF-8 with BOM (源编码：{best_encoding})")
        return True
    else:
        print(f"  ✗ 无法找到合适的编码")
        return False

def main():
    source_dir = r"d:\GuoJinf\WorkSpace\elecShare\SoftWare Git Repository\BWHPU"
    
    # 获取所有 .pas 文件
    pas_files = list(Path(source_dir).glob("*.pas"))
    
    print(f"找到 {len(pas_files)} 个 .pas 文件")
    print("=" * 60)
    
    success_count = 0
    fail_count = 0
    
    for pas_file in pas_files:
        print(f"\n处理文件：{pas_file.name}")
        try:
            if detect_and_fix_encoding(pas_file):
                success_count += 1
            else:
                fail_count += 1
        except Exception as e:
            print(f"  ✗ 处理失败：{e}")
            fail_count += 1
    
    print("\n" + "=" * 60)
    print(f"处理完成！成功：{success_count}, 失败：{fail_count}")

if __name__ == "__main__":
    main()
