# 丽华的博客

一个基于 Jekyll 的个人技术博客，用于记录研究生学习旅程和技术分享。

## 🚀 快速开始

### 本地开发

1. **安装依赖**
   ```bash
   bundle install --path vendor/bundle
   ```

2. **启动本地服务器**
   ```bash
   bundle exec jekyll serve --livereload
   ```

3. **访问博客**
   打开浏览器访问: http://localhost:4000/lihualan.github.io/

### 构建生产版本

```bash
bundle exec jekyll build
```

构建后的文件将生成在 `_site` 目录中。

## 📁 项目结构

```
lihualan.github.io/
├── _config.yml          # Jekyll 配置文件
├── _posts/              # 博客文章目录
├── _pages/              # 静态页面目录
├── assets/              # 静态资源
│   └── css/
│       └── custom.css   # 自定义样式
├── Gemfile              # Ruby 依赖管理
└── README.md           # 项目说明
```

## ✍️ 写新文章

### 创建新文章

1. 在 `_posts/` 目录下创建新的 Markdown 文件
2. 文件名格式: `YYYY-MM-DD-title.md`
3. 在文件开头添加 Front Matter:

```markdown
---
layout: post
title: "文章标题"
date: 2025-01-01 12:00:00 +0800
categories: [技术, 学习]
tags: [python, 机器学习, 教程]
---

文章内容...
```

### Front Matter 说明

- `layout`: 布局模板 (post, page, home)
- `title`: 文章标题
- `date`: 发布日期
- `categories`: 文章分类
- `tags`: 文章标签
- `description`: 文章描述 (可选)

## 🎨 自定义样式

### 修改主题颜色

编辑 `assets/css/custom.css` 文件中的 CSS 变量:

```css
:root {
  --primary-color: #2563eb;    /* 主色调 */
  --secondary-color: #1e40af;  /* 次要色调 */
  --accent-color: #3b82f6;     /* 强调色 */
  --text-color: #1f2937;       /* 文字颜色 */
  --background: #ffffff;       /* 背景色 */
}
```

### 添加自定义样式

在 `assets/css/custom.css` 中添加新的 CSS 规则。

## 📝 添加新页面

1. 在 `_pages/` 目录下创建新的 Markdown 文件
2. 添加 Front Matter:

```markdown
---
layout: page
title: "页面标题"
permalink: /page-url/
---

页面内容...
```

## 🔧 配置说明

### _config.yml 主要配置

- `title`: 网站标题
- `author`: 作者姓名
- `description`: 网站描述
- `url`: 网站 URL
- `baseurl`: 基础 URL (GitHub Pages 需要)
- `theme`: 使用的主题
- `plugins`: 启用的插件

### 插件功能

- `jekyll-feed`: 生成 RSS 订阅
- `jekyll-seo-tag`: SEO 优化
- `jekyll-sitemap`: 生成网站地图
- `jekyll-archives`: 文章归档
- `jekyll-paginate`: 分页功能

## 🌐 部署到 GitHub Pages

1. **推送代码到 GitHub**
   ```bash
   git add .
   git commit -m "Update blog"
   git push origin main
   ```

2. **自动部署**
   GitHub Pages 会自动构建和部署你的博客

3. **访问博客**
   访问: https://alilan.github.io/lihualan.github.io/

## 📚 常用命令

```bash
# 安装依赖
bundle install --path vendor/bundle

# 本地开发
bundle exec jekyll serve --livereload

# 构建生产版本
bundle exec jekyll build

# 清理构建文件
bundle exec jekyll clean

# 检查语法错误
bundle exec jekyll doctor
```

## 🛠️ 故障排除

### 常见问题

1. **依赖安装失败**
   ```bash
   # 使用本地安装
   bundle install --path vendor/bundle
   ```

2. **端口被占用**
   ```bash
   # 指定其他端口
   bundle exec jekyll serve --port 4001
   ```

3. **构建失败**
   ```bash
   # 检查语法
   bundle exec jekyll doctor
   ```

## 📖 学习资源

- [Jekyll 官方文档](https://jekyllrb.com/docs/)
- [GitHub Pages 文档](https://pages.github.com/)
- [Liquid 模板语言](https://shopify.github.io/liquid/)
- [Markdown 语法](https://www.markdownguide.org/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个博客！

## 📄 许可证

MIT License

---

**Happy Blogging! 🎉** 