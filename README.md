# Safe and Strong v2 (Vercel, Next, ReScript)

This is a NextJS based template with following setup:

- Full Tailwind config & basic css scaffold (+ production setup w/ purge-css & cssnano)
- [ReScript](https://rescript-lang.org) + React
- Basic ReScript Bindings for Next
- Preconfigured Dependencies: `reason-react`

## Development

0. `yarn fetch:schema` - fetch the craftcms graphql schema
0. `yarn dev` - start the dev server

## Vercel Deployments

- Each time you push any code to `prod` or `staging` branches, a new build will occur w/in vercel. This is configured via Vercel's _Ignored Build Step_ feature that we control via `./ignored-build-step.sh`
- You can also create one-off deployments via the cli, [see here](#Vercel-CLI-for-one-off-(and-regular)-deployments).

## Environment Variables in Vercel
- `.env` is used in all environments
- `.env.development` is used when `next dev` is being run
- `.env.production` is used when `next start` is being run
- `.env.local` is optional and any variable defined within it will override any matching environment variable from the other `.env*` files
- Prefix `NEXT_PUBLIC_` for any variable you need to expose client-side

[Read more here](https://nextjs.org/docs/basic-features/environment-variables)

## Vercel CLI for one-off (and regular) deployments

- Install globally, `npm i -g vercel`
- Login with `vercel` (use your GitHub email address since that is how you created your account). If you have not been invited to the SeaMonster Studios org on vercel then you cannot manage deploys. You can request access, or ask someone who does have access to create a preview deploy and/or publish.
- After you are logged in, running `vercel` now will allow you to deploy a preview new version of the site.

## Tips

### Filenames with special characters

ReScript > 8.3 now supports filenames with special characters: e.g. `pages/blog/[slug].res`.
If you can't upgrade yet, you can create a e.g. `pages/blog/[slug].js` file, a `re_pages/blog_slug.re` file and then reexport the React component within the `[slug].js` file.

We recommend upgrading to the newest ReScript (bs-platform) version as soon as possible to get the best experience for Next!

### Fast Refresh & ReScript

Make sure to create interface files (`.resi`) for each `page/*.res` file, or use %%private() for let bindings other than the `default` let binding...

Fast Refresh requires you to **only export React components**, and it's easy to unintenionally export other values than that.

## Useful commands

Build CSS seperately via `postcss` (useful for debugging)

```
# Devmode
postcss styles/main.css -o test.css

# Production
NODE_ENV=production postcss styles/main.css -o test.css
```

## Test production setup with Next

```
# Make sure to uncomment the `target` attribute in `now.json` first, before you run this:
yarn build
PORT=3001 npm start
```

## GraphQL & Data

We're using reason-apollo-client to get data from Shopify.

reason-apollo-client examples: https://github.com/reasonml-community/reason-apollo-client/tree/master/EXAMPLES

Shopify API Queryable Objects: https://shopify.dev/docs/storefront-api/reference/object


Shopify API examples in use (these are in JS and within their SDK so are only useful for seeing the data structures:
- Query: https://github.com/Shopify/js-buy-sdk/blob/master/src/graphql/productConnectionQuery.graphql
- Fragment: https://github.com/Shopify/js-buy-sdk/blob/master/src/graphql/ProductFragment.graphql

### Graphiql Explorer

Altair is a cross-platform graphiql explorer that can be helpful when testing out queries (https://altair.sirmuel.design/docs/)

To make it work with a Shopify store add the following headers:
- X-Shopify-Storefront-Access-Token: (access token retreived from private shopify app, bottom of the screen and not the app password)
- Accept: application/json

#### Install
Linux:
```
snap install altair
```
macOS:
```
brew cask install altair-graphql-client
```

## The Stack
- NextJS UI Framework
- ReScript & React
- CMS: GraphCMS
- Backend: GraphCMS & Shopify GraphQL APIs
- Serverless Framework (AWS Lambdas) if custom business logic is needed on the backend

### Setup a new project

1. Clone repo
2. Create GraphCMS project
3. Copy `.env.local.example` to `.env.local`
    1. NEXT_PUBLIC_SHOPIFY_STORE (example: project-seaotter.myshopify.com) 
    2. NEXT_PUBLIC_SHOPIFY_STOREFRONT_ACCESS_TOKEN (Get this from making a private app in Shopify that has access to the storefront API, it's at the bottom of the private app screen and is NOT the app password).
    3. NEXT_PUBLIC_SHOPIFY_STOREFRONT_VERSION (You can change this to a different version if you'd like to, or just leave it)
    4. GRAPHCMS_ENDPOINT
    5. GRAPHCMS_ACCESS_TOKEN (Get the token by going to Settings > API keys in your GraphCMS project.)




