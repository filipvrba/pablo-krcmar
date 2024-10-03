export default {server: {proxy: {
  "/api": {
    target: "https://pablo-krcmar.vercel.app",
    changeOrigin: true,

    rewrite(path) {
      return path.replace(/^\/api/m, "/api")
    }
  }
}}}