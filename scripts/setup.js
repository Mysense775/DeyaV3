#!/usr/bin/env node

/**
 * Deya v3.0 Setup Script
 * Initializes the environment and validates configuration
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🌺 Deya v3.0 Setup\n');

// Check Node.js version
const nodeVersion = process.version;
const majorVersion = parseInt(nodeVersion.slice(1).split('.')[0]);

if (majorVersion < 18) {
    console.error('❌ Node.js 18+ required. Current:', nodeVersion);
    process.exit(1);
}
console.log('✅ Node.js:', nodeVersion);

// Check Python
let pythonVersion;
try {
    pythonVersion = execSync('python3 --version', { encoding: 'utf8' }).trim();
    console.log('✅ Python:', pythonVersion);
} catch {
    console.error('❌ Python 3 not found');
    process.exit(1);
}

// Check FFmpeg
try {
    const ffmpegVersion = execSync('ffmpeg -version', { encoding: 'utf8' }).split('\n')[0];
    console.log('✅ FFmpeg:', ffmpegVersion);
} catch {
    console.warn('⚠️  FFmpeg not found. Video features will be limited.');
}

// Create directories
const dirs = ['memory', 'skills', 'workspace', 'logs', 'tmp'];
dirs.forEach(dir => {
    const dirPath = path.join(__dirname, '..', dir);
    if (!fs.existsSync(dirPath)) {
        fs.mkdirSync(dirPath, { recursive: true });
        console.log('📁 Created:', dir);
    }
});

// Check .env
const envPath = path.join(__dirname, '..', '.env');
const envExamplePath = path.join(__dirname, '..', '.env.example');

if (!fs.existsSync(envPath)) {
    if (fs.existsSync(envExamplePath)) {
        fs.copyFileSync(envExamplePath, envPath);
        console.log('📝 Created .env from example');
        console.log('⚠️  Please edit .env and add your API keys');
    } else {
        console.error('❌ .env.example not found');
    }
} else {
    console.log('✅ .env exists');
}

// Check core files
const coreFiles = ['SOUL.md', 'IDENTITY.md', 'USER.md'];
coreFiles.forEach(file => {
    const filePath = path.join(__dirname, '..', file);
    if (!fs.existsSync(filePath)) {
        console.warn('⚠️  Missing core file:', file);
    } else {
        console.log('✅ Core file:', file);
    }
});

console.log('\n🎉 Setup complete!');
console.log('\nNext steps:');
console.log('1. Edit .env with your API keys');
console.log('2. Run: npm start');
console.log('3. Start chatting with Deya!\n');
