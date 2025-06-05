# Python爬虫完整学习指南

## 1. 网络基础知识

### HTTP协议基础
HTTP是网页通信的基础协议，理解它对爬虫至关重要。

**常用HTTP方法：**
- GET：获取数据（最常用）
- POST：提交数据（表单提交、登录等）

**重要状态码：**
- 200：成功
- 404：页面不存在  
- 403：禁止访问
- 500：服务器错误

**请求头和响应头：**
```python
# 请求头示例
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Accept': 'text/html,application/xhtml+xml',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8'
}
```

### URL结构
```
https://www.example.com:8080/path/to/page?param1=value1&param2=value2#section
[协议]  [域名]        [端口] [路径]      [查询参数]                    [锚点]
```

### Cookie和Session
- Cookie：存储在浏览器中的小数据片段，用于记住用户状态
- Session：服务器端存储的用户会话信息
- 爬虫中用于保持登录状态或模拟用户行为

## 2. HTML/CSS基础

### HTML标签结构
```html
<!DOCTYPE html>
<html>
<head>
    <title>页面标题</title>
</head>
<body>
    <div class="container">
        <h1 id="main-title">主标题</h1>
        <p class="content">段落内容</p>
        <ul>
            <li><a href="link1.html">链接1</a></li>
            <li><a href="link2.html">链接2</a></li>
        </ul>
    </div>
</body>
</html>
```

### 重要HTML属性
- `id`：唯一标识符
- `class`：样式类名
- `href`：链接地址
- `src`：图片或脚本源地址
- `text`：标签内的文本内容

### CSS选择器
```python
# 标签选择器
soup.select('div')          # 所有div标签
soup.select('p')            # 所有p标签

# 类选择器
soup.select('.container')   # class="container"的元素
soup.select('.content')     # class="content"的元素

# ID选择器
soup.select('#main-title')  # id="main-title"的元素

# 组合选择器
soup.select('div.container p')  # div.container下的所有p标签
soup.select('ul li a')          # ul下li下的所有a标签
```

## 3. Python基础巩固

### 异常处理
爬虫中网络请求经常失败，必须处理异常：

```python
import requests
from requests.exceptions import RequestException, Timeout, ConnectionError

def safe_request(url):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()  # 检查HTTP错误
        return response
    except Timeout:
        print("请求超时")
    except ConnectionError:
        print("连接错误")
    except RequestException as e:
        print(f"请求异常: {e}")
    return None
```

### 时间处理
```python
import time
from datetime import datetime

# 控制请求频率，避免被封
time.sleep(1)  # 暂停1秒

# 获取当前时间
now = datetime.now()
timestamp = now.strftime("%Y-%m-%d %H:%M:%S")
```

### 文件操作
```python
import csv
import json

# CSV文件读写
def save_to_csv(data, filename):
    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['标题', '链接', '时间'])  # 表头
        for item in data:
            writer.writerow([item['title'], item['url'], item['time']])

# JSON文件读写
def save_to_json(data, filename):
    with open(filename, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
```

### 正则表达式
```python
import re

text = "价格：￥299.99，原价：￥399.99"

# 提取价格
prices = re.findall(r'￥(\d+\.?\d*)', text)
print(prices)  # ['299.99', '399.99']

# 提取邮箱
email_text = "联系我们：support@example.com 或 info@test.org"
emails = re.findall(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', email_text)
print(emails)  # ['support@example.com', 'info@test.org']
```

## 4. 核心Python库

### requests库详解
```python
import requests

# 基本GET请求
response = requests.get('https://httpbin.org/get')
print(response.status_code)  # 状态码
print(response.text)         # 响应内容
print(response.json())       # JSON格式响应

# 带参数的请求
params = {'q': 'python爬虫', 'page': 1}
response = requests.get('https://example.com/search', params=params)

# 设置请求头
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
}
response = requests.get('https://example.com', headers=headers)

# POST请求
data = {'username': 'user', 'password': 'pass'}
response = requests.post('https://example.com/login', data=data)

# 处理Cookie
session = requests.Session()
session.get('https://example.com/login')  # 自动保存Cookie
session.get('https://example.com/profile')  # 使用保存的Cookie
```

### BeautifulSoup详解
```python
from bs4 import BeautifulSoup
import requests

# 获取并解析网页
response = requests.get('https://example.com')
soup = BeautifulSoup(response.text, 'html.parser')

# 查找单个元素
title = soup.find('title').text
first_p = soup.find('p')
by_class = soup.find('div', class_='content')
by_id = soup.find('div', id='main')

# 查找多个元素
all_links = soup.find_all('a')
all_p = soup.find_all('p')

# CSS选择器
containers = soup.select('div.container')
nav_links = soup.select('nav ul li a')

# 提取属性
for link in soup.find_all('a'):
    href = link.get('href')
    text = link.text.strip()
    print(f"链接：{href}，文本：{text}")

# 提取表格数据
table = soup.find('table')
for row in table.find_all('tr'):
    cells = row.find_all(['td', 'th'])
    row_data = [cell.text.strip() for cell in cells]
    print(row_data)
```

## 5. 实战示例

### 简单新闻爬虫
```python
import requests
from bs4 import BeautifulSoup
import csv
import time

def scrape_news():
    url = 'https://news.example.com'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    }
    
    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        
        soup = BeautifulSoup(response.text, 'html.parser')
        
        # 假设新闻在class='news-item'的div中
        news_items = soup.find_all('div', class_='news-item')
        
        news_data = []
        for item in news_items:
            title = item.find('h3').text.strip()
            link = item.find('a')['href']
            time_elem = item.find('span', class_='time')
            pub_time = time_elem.text.strip() if time_elem else ''
            
            news_data.append({
                'title': title,
                'link': link,
                'time': pub_time
            })
        
        # 保存到CSV
        with open('news.csv', 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=['title', 'link', 'time'])
            writer.writeheader()
            writer.writerows(news_data)
        
        print(f"成功爬取{len(news_data)}条新闻")
        
    except Exception as e:
        print(f"爬取失败：{e}")

# 执行爬虫
scrape_news()
```

## 6. 反爬虫应对策略

### User-Agent轮换
```python
import random

user_agents = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36'
]

def get_random_headers():
    return {'User-Agent': random.choice(user_agents)}

# 使用
response = requests.get(url, headers=get_random_headers())
```

### 请求频率控制
```python
import time
import random

def polite_request(url, min_delay=1, max_delay=3):
    # 随机延迟
    delay = random.uniform(min_delay, max_delay)
    time.sleep(delay)
    
    return requests.get(url, headers=get_random_headers())
```

### 处理验证码和JavaScript
```python
from selenium import webdriver
from selenium.webdriver.common.by import By

# 对于JavaScript渲染的页面
driver = webdriver.Chrome()
driver.get('https://spa-example.com')

# 等待页面加载
time.sleep(3)

# 获取渲染后的HTML
html = driver.page_source
soup = BeautifulSoup(html, 'html.parser')

driver.quit()
```

## 7. 数据处理

### 使用pandas处理数据
```python
import pandas as pd

# 读取爬取的CSV数据
df = pd.read_csv('news.csv')

# 数据清洗
df['title'] = df['title'].str.strip()  # 去除空白
df = df.drop_duplicates(subset=['title'])  # 去重
df = df[df['title'].str.len() > 0]  # 过滤空标题

# 数据分析
print(f"总共{len(df)}条新闻")
print(df['title'].head())

# 保存处理后的数据
df.to_csv('cleaned_news.csv', index=False, encoding='utf-8')
```

## 8. 最佳实践

### 完整的爬虫模板
```python
import requests
from bs4 import BeautifulSoup
import csv
import time
import random
import logging
from urllib.parse import urljoin, urlparse

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class WebScraper:
    def __init__(self, base_url, delay_range=(1, 3)):
        self.base_url = base_url
        self.delay_range = delay_range
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        })
    
    def get_page(self, url):
        """安全地获取页面"""
        try:
            # 控制请求频率
            delay = random.uniform(*self.delay_range)
            time.sleep(delay)
            
            response = self.session.get(url, timeout=10)
            response.raise_for_status()
            return response
        except Exception as e:
            logging.error(f"获取页面失败 {url}: {e}")
            return None
    
    def parse_page(self, html):
        """解析页面，需要子类实现"""
        raise NotImplementedError
    
    def save_data(self, data, filename):
        """保存数据到CSV"""
        if not data:
            return
        
        with open(filename, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=data[0].keys())
            writer.writeheader()
            writer.writerows(data)
        
        logging.info(f"数据已保存到 {filename}")
    
    def run(self):
        """