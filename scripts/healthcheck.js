#!/usr/bin/env node

/**
 * Deya v3.0 Health Check
 * Comprehensive system health monitoring
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const os = require('os');

const CHECKS = {
    system: [],
    services: [],
    security: [],
    performance: []
};

function checkDiskSpace() {
    try {
        const output = execSync('df -h /', { encoding: 'utf8' });
        const match = output.match(/(\d+)%/);
        const usage = match ? parseInt(match[1]) : 0;
        
        return {
            name: 'Disk Space',
            status: usage > 90 ? 'warning' : usage > 95 ? 'critical' : 'ok',
            value: `${usage}% used`,
            recommendation: usage > 90 ? 'Clean up disk space' : null
        };
    } catch {
        return { name: 'Disk Space', status: 'unknown', value: 'N/A' };
    }
}

function checkMemory() {
    const total = os.totalmem();
    const free = os.freemem();
    const used = ((total - free) / total * 100).toFixed(1);
    
    return {
        name: 'Memory',
        status: used > 90 ? 'warning' : used > 95 ? 'critical' : 'ok',
        value: `${used}% used (${(free / 1024 / 1024 / 1024).toFixed(1)}GB free)`,
        recommendation: used > 90 ? 'Consider upgrading RAM' : null
    };
}

function checkNodeVersion() {
    const version = process.version;
    const major = parseInt(version.slice(1).split('.')[0]);
    
    return {
        name: 'Node.js',
        status: major >= 18 ? 'ok' : 'critical',
        value: version,
        recommendation: major < 18 ? 'Upgrade to Node.js 18+' : null
    };
}

function checkEnvFile() {
    const envPath = path.join(__dirname, '..', '.env');
    const exists = fs.existsSync(envPath);
    
    if (!exists) {
        return {
            name: '.env File',
            status: 'critical',
            value: 'Missing',
            recommendation: 'Create .env from .env.example'
        };
    }
    
    const content = fs.readFileSync(envPath, 'utf8');
    const hasKeys = content.includes('API_KEY') || content.includes('TOKEN');
    
    return {
        name: '.env File',
        status: hasKeys ? 'ok' : 'warning',
        value: hasKeys ? 'Configured' : 'Empty',
        recommendation: !hasKeys ? 'Add API keys to .env' : null
    };
}

function checkFFmpeg() {
    try {
        const version = execSync('ffmpeg -version', { encoding: 'utf8' }).split('\n')[0];
        return {
            name: 'FFmpeg',
            status: 'ok',
            value: version.split(' ')[2] || 'Installed'
        };
    } catch {
        return {
            name: 'FFmpeg',
            status: 'warning',
            value: 'Not installed',
            recommendation: 'Install FFmpeg for video features'
        };
    }
}

function checkPermissions() {
    const envPath = path.join(__dirname, '..', '.env');
    
    if (!fs.existsSync(envPath)) {
        return { name: 'File Permissions', status: 'ok', value: 'N/A' };
    }
    
    const stats = fs.statSync(envPath);
    const mode = stats.mode;
    const isReadableByOthers = mode & 0o044;
    
    return {
        name: 'File Permissions',
        status: isReadableByOthers ? 'warning' : 'ok',
        value: isReadableByOthers ? '.env readable by others' : 'Secure',
        recommendation: isReadableByOthers ? 'Run: chmod 600 .env' : null
    };
}

function runChecks() {
    console.log('🌺 Deya v3.0 Health Check');
    console.log('==========================\n');
    
    // System checks
    CHECKS.system.push(checkDiskSpace());
    CHECKS.system.push(checkMemory());
    CHECKS.system.push(checkNodeVersion());
    
    // Service checks
    CHECKS.services.push(checkFFmpeg());
    CHECKS.services.push(checkEnvFile());
    
    // Security checks
    CHECKS.security.push(checkPermissions());
    
    // Display results
    let warnings = 0;
    let critical = 0;
    
    Object.entries(CHECKS).forEach(([category, checks]) => {
        console.log(`\n📋 ${category.toUpperCase()}`);
        console.log('-'.repeat(40));
        
        checks.forEach(check => {
            const icon = check.status === 'ok' ? '✅' : 
                        check.status === 'warning' ? '⚠️' : '❌';
            console.log(`${icon} ${check.name}: ${check.value}`);
            
            if (check.status === 'warning') warnings++;
            if (check.status === 'critical') critical++;
            
            if (check.recommendation) {
                console.log(`   💡 ${check.recommendation}`);
            }
        });
    });
    
    // Summary
    console.log('\n' + '='.repeat(40));
    console.log(`Summary: ${CHECKS.system.length + CHECKS.services.length + CHECKS.security.length} checks`);
    console.log(`✅ OK: ${Object.values(CHECKS).flat().filter(c => c.status === 'ok').length}`);
    console.log(`⚠️  Warnings: ${warnings}`);
    console.log(`❌ Critical: ${critical}`);
    
    if (critical > 0) {
        console.log('\n🔴 Critical issues found! Please fix before using Deya.');
        process.exit(1);
    } else if (warnings > 0) {
        console.log('\n🟡 Some warnings found. Deya will work but some features may be limited.');
    } else {
        console.log('\n🟢 All checks passed! Deya is ready.');
    }
}

if (require.main === module) {
    runChecks();
}

module.exports = { runChecks, CHECKS };
