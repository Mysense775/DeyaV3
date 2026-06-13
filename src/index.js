#!/usr/bin/env node

/**
 * Deya v3.0 — Main Entry Point
 * AI-Ассистент для Бизнеса и Креатива
 */

require('dotenv').config();

const express = require('express');
const winston = require('winston');
const cron = require('node-cron');

// Configure logging
const logger = winston.createLogger({
    level: process.env.LOG_LEVEL || 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
        new winston.transports.File({ filename: 'logs/combined.log' })
    ]
});

// Initialize Express
const app = express();
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
    res.json({
        status: 'ok',
        version: '3.0.0',
        timestamp: new Date().toISOString(),
        uptime: process.uptime()
    });
});

// API routes
app.get('/api/skills', (req, res) => {
    // Return list of active skills
    res.json({
        skills: [
            'video-content',
            'article-writer',
            'design-studio',
            'auto-posting',
            'seo-promotion',
            'email-marketing',
            'chatbot-builder',
            'ecommerce-manager',
            'business-automation',
            'content-manager',
            'code-master',
            'ai-assistant',
            'analytics-reports',
            'healthcheck'
        ]
    });
});

app.post('/api/chat', async (req, res) => {
    const { message, session_id } = req.body;
    
    logger.info('Chat request', { session_id, message: message.substring(0, 100) });
    
    // TODO: Integrate with OpenClaw runtime
    res.json({
        response: 'Deya is initializing...',
        session_id,
        timestamp: new Date().toISOString()
    });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    logger.info(`🌺 Deya v3.0 started on port ${PORT}`);
    console.log(`🌺 Deya v3.0 is running on http://localhost:${PORT}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
    logger.info('SIGTERM received, shutting down gracefully');
    process.exit(0);
});

process.on('SIGINT', () => {
    logger.info('SIGINT received, shutting down gracefully');
    process.exit(0);
});
