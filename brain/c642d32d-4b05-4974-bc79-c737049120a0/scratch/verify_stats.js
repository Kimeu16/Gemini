import axios from 'axios';

const API_URL = 'http://localhost:3000/api'; // Standard backend port

async function verifyStats() {
    try {
        console.log('Fetching stats overview...');
        // We'll need a token, but let's see if we can at least reach the server
        // Actually, without a token this will fail, but we can verify the server is up.
        const response = await axios.get(`${API_URL}/stats/overview`);
        console.log('Response Status:', response.status);
        console.log('Stats Keys:', Object.keys(response.data.data));
    } catch (error) {
        if (error.response && error.response.status === 401) {
            console.log('Server is UP (Returned 401 as expected without auth)');
        } else {
            console.error('Error reaching server:', error.message);
        }
    }
}

verifyStats();
