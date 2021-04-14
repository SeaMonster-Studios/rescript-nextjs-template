# SeaMonster Studios ReScript-NextJS Template

This is a NextJS based template with following setup:

- Full Tailwind config & basic css scaffold (+ production setup w/ purge-css & cssnano)
- [ReScript](https://rescript-lang.org) + React
- Basic ReScript Bindings for Next
- Preconfigured Dependencies: `reason-react`

## Stack

- [Vercel](https://vercel.com/docs)
- [NextJS](https://nextjs.org/docs/getting-started)
- [ReScript](https://rescript-lang.org/docs/manual/latest/introduction)
- [TailwindCSS](https://tailwindcss.com/docs)

## Development

0. `yarn fetch:schema` - fetch the graphql schema
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

