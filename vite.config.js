export default {
  server: {
    proxy: {
      '/api': {
        target: 'https://pablo-krcmar.vercel.app',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '/api'),
      },
    },
  },
};
