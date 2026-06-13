#!/usr/bin/env node

/**
 * Deya v3.0 Backup Script
 * Creates encrypted backups of memory and configuration
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const crypto = require('crypto');

const BACKUP_DIR = path.join(__dirname, '..', 'backups');
const MEMORY_DIR = path.join(__dirname, '..', 'memory');
const CONFIG_FILES = ['.env', 'SOUL.md', 'IDENTITY.md', 'USER.md'];

function createBackup() {
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const backupPath = path.join(BACKUP_DIR, `deya-backup-${timestamp}`);
    
    console.log('🌺 Deya Backup');
    console.log('================');
    
    // Create backup directory
    if (!fs.existsSync(BACKUP_DIR)) {
        fs.mkdirSync(BACKUP_DIR, { recursive: true });
    }
    fs.mkdirSync(backupPath, { recursive: true });
    
    // Backup memory
    if (fs.existsSync(MEMORY_DIR)) {
        console.log('📦 Backing up memory...');
        execSync(`cp -r ${MEMORY_DIR} ${backupPath}/`);
    }
    
    // Backup config files
    console.log('⚙️  Backing up configuration...');
    CONFIG_FILES.forEach(file => {
        const filePath = path.join(__dirname, '..', file);
        if (fs.existsSync(filePath)) {
            fs.copyFileSync(filePath, path.join(backupPath, file));
        }
    });
    
    // Create archive
    const archivePath = `${backupPath}.tar.gz`;
    console.log('🗜️  Creating archive...');
    execSync(`tar -czf ${archivePath} -C ${BACKUP_DIR} ${path.basename(backupPath)}`);
    
    // Encrypt if key available
    const encryptionKey = process.env.ENCRYPTION_KEY;
    if (encryptionKey) {
        console.log('🔐 Encrypting backup...');
        const iv = crypto.randomBytes(16);
        const cipher = crypto.createCipheriv('aes-256-gcm', Buffer.from(encryptionKey, 'hex'), iv);
        
        const input = fs.readFileSync(archivePath);
        const encrypted = Buffer.concat([cipher.update(input), cipher.final()]);
        const authTag = cipher.getAuthTag();
        
        fs.writeFileSync(`${archivePath}.enc`, Buffer.concat([iv, authTag, encrypted]));
        fs.unlinkSync(archivePath);
        
        console.log(`✅ Encrypted backup: ${archivePath}.enc`);
    } else {
        console.log(`✅ Backup created: ${archivePath}`);
    }
    
    // Cleanup old backups (keep last 10)
    const backups = fs.readdirSync(BACKUP_DIR)
        .filter(f => f.startsWith('deya-backup-'))
        .sort()
        .reverse();
    
    if (backups.length > 10) {
        console.log('🧹 Cleaning old backups...');
        backups.slice(10).forEach(backup => {
            fs.unlinkSync(path.join(BACKUP_DIR, backup));
            console.log(`  Removed: ${backup}`);
        });
    }
    
    console.log('\n🎉 Backup complete!');
}

// Run if called directly
if (require.main === module) {
    createBackup();
}

module.exports = { createBackup };
