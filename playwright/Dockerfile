FROM mcr.microsoft.com/playwright:v1.53.1

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 9323
CMD ["npx", "playwright", "test", "--ui", "--host=0.0.0.0"]
