# Bước 1: Build ứng dụng
FROM node:18 AS build
WORKDIR /app

# Sao chép package.json và package-lock.json trước để tối ưu cache
COPY package.json package-lock.json ./
RUN npm install

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng Next.js
RUN npm run build

# Bước 2: Chạy ứng dụng Next.js
FROM node:18 AS runtime
WORKDIR /app

# Sao chép file build từ bước trước
COPY --from=build /app ./

# Expose port 3000 (Next.js mặc định chạy cổng này)
EXPOSE 3000

# Chạy ứng dụng
CMD ["npm", "start"]
