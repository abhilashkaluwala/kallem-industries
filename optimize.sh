#!/bin/bash

# Kallem Industries Website Optimization Script
# This script helps optimize and prepare the website for deployment

echo "🚀 Kallem Industries Website Optimization Script"
echo "================================================"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Node.js is installed
if ! command_exists node; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command_exists npm; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Build and optimize
echo "🔧 Building and optimizing..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build completed successfully"
else
    echo "❌ Build failed"
    exit 1
fi

# Minify CSS
echo "🎨 Minifying CSS..."
npm run minify-css

if [ $? -eq 0 ]; then
    echo "✅ CSS minified successfully"
else
    echo "⚠️  CSS minification failed (continuing...)"
fi

# Minify JavaScript
echo "⚡ Minifying JavaScript..."
npm run minify-js

if [ $? -eq 0 ]; then
    echo "✅ JavaScript minified successfully"
else
    echo "⚠️  JavaScript minification failed (continuing...)"
fi

# Run performance analysis
echo "📊 Running performance analysis..."
npm run lighthouse

if [ $? -eq 0 ]; then
    echo "✅ Performance analysis completed"
    echo "📄 Lighthouse report generated: lighthouse-report.html"
else
    echo "⚠️  Performance analysis failed (continuing...)"
fi

# Check file sizes
echo "📏 Checking file sizes..."
echo "CSS file size:"
ls -lh styles.css
if [ -f "styles.min.css" ]; then
    echo "Minified CSS file size:"
    ls -lh styles.min.css
fi

echo "JavaScript file size:"
ls -lh script.js
if [ -f "script.min.js" ]; then
    echo "Minified JavaScript file size:"
    ls -lh script.min.js
fi

# Check image sizes
echo "🖼️  Checking image sizes..."
echo "Product images:"
ls -lh assets/images/products/*.jpg 2>/dev/null | head -10

echo "Client logos:"
ls -lh assets/images/clients/*.png 2>/dev/null | head -5

# Create deployment package
echo "📦 Creating deployment package..."
if [ -d "dist" ]; then
    rm -rf dist
fi

mkdir -p dist
cp -r *.html dist/
cp -r products/ dist/
cp -r assets/ dist/
cp styles.css dist/
cp script.js dist/
cp robots.txt dist/
cp sitemap.xml dist/

# Copy minified files if they exist
if [ -f "styles.min.css" ]; then
    cp styles.min.css dist/
fi
if [ -f "script.min.js" ]; then
    cp script.min.js dist/
fi

echo "✅ Deployment package created in 'dist' directory"

# Summary
echo ""
echo "🎉 Optimization completed successfully!"
echo "======================================"
echo "📁 Deployment files are in the 'dist' directory"
echo "🌐 Ready for deployment to:"
echo "   - GitHub Pages"
echo "   - Netlify"
echo "   - Vercel"
echo "   - Any static hosting provider"
echo ""
echo "📊 Next steps:"
echo "   1. Test the website locally: npm run dev"
echo "   2. Deploy to your chosen platform"
echo "   3. Monitor performance with Lighthouse"
echo ""
echo "📚 For deployment instructions, see DEPLOYMENT.md" 