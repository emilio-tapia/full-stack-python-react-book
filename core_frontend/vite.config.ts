import { defineConfig, UserConfig } from 'vite';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), tailwindcss()],
  test: {
    // 👋 add the line below to add jsdom to vite
    environment: 'jsdom',
    // hey! 👋 over here
    globals: true,
    setupFiles: './src/utils/test.setup.ts', // assuming the test folder is in the root of our project
    // browser: {
    //   enabled: true,
    //   provider: 'playwright',
    //   instances: [{ browser: 'chromium' }],
    // },
  },
} as UserConfig);
