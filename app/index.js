const express = require('express');

const app = express();

// Read port from environment variable
const PORT = process.env.PORT || 3000;

// Root endpoint
app.get('/', (req, res) => {
    res.send('Hello from AWS ECS!');
});

// Health endpoint
app.get('/health', (req, res) => {
    res.status(200).send('OK');
});

// Basic 404 handler
app.use((req, res) => {
    res.status(404).send('Not Found');
});

// Start server
app.listen(PORT, () => {
    console.log(`Application running on port ${PORT}`);
});