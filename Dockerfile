FROM node:lts-alpine as base
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .

FROM base AS dev
ENV NODE_ENV=development
EXPOSE 4321
CMD ["npm", "run", "astro:dev"]

FROM base AS prod
ENV NODE_ENV=production
RUN npm run astro:build

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD node ./dist/server/entry.mjs
