module Locale = {
  type t = string
}

module GetServerSideProps = {
  module Req = {
    type t
  }

  module Res = {
    type t

    @bs.send external setHeader: (t, string, string) => unit = "setHeader"
    @bs.send external write: (t, string) => unit = "write"
    @bs.send external end_: t => unit = "end"
  }

  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  type context<'props, 'params> = {
    params: Js.t<'params>,
    query: Js.Dict.t<string>,
    req: Req.t,
    res: Res.t,
  }

  type t<'props, 'params> = context<'props, 'params> => Js.Promise.t<{"props": 'props}>
}

module GetStaticProps = {
  type params = {locale: string, locales: array<string>, defaultLocale: string, path: string}

  type req<'props> = {props: 'props}

  // See: https://github.com/zeit/next.js/blob/canary/packages/next/types/index.d.ts
  // type context<'props, 'previewData> = {
  //   params: params,
  //   preview: option<bool>, // preview is true if the page is in the preview mode and undefined otherwise.
  //   previewData: Js.t<'previewData>,
  //   query: Js.Dict.t<string>,
  //   req: Js.Nullable.t<req<'props>>,
  // }

  type t<'props> = params => Js.Promise.t<req<'props>>
}

module GetStaticPaths = {
  // 'params: dynamic route params used in dynamic routing paths
  // Example: pages/[id].js would result in a 'params = { id: string }
  type pageLevel1 = string
  type pageLevel2 = string
  type pageLevel3 = string

  /* * to Nextjs, this is a dynamic object and the `xPage` properties here are only really needed by next based on w/e the route needs (the name of the prop is the exact same as the dyanmic file or directory name w/in the /pages dir). So pageLevel3 also needs it's ancestor page info (section and subSection), but pageLevel1 only needs itself. However, we're using one type here so that PageUtils.buildPath can be used by all pages */
  type path = {
    pageLevel1: pageLevel1,
    pageLevel2: pageLevel2,
    pageLevel3: pageLevel3,
    locale: string,
    defaultLocale: string,
    locales: array<string>,
  }

  type staticProp = {params: path, locale: string}

  type params__staticPaths = {
    pageLevel1: pageLevel1,
    pageLevel2: pageLevel2,
    pageLevel3: pageLevel3,
    locale: string,
    defaultLocale: string,
    locales: array<string>,
  }

  type return<'params> = {
    paths: array<staticProp>,
    fallback: bool,
  }

  type path__pageLevel1 = {pageLevel1: pageLevel1}

  type path__pageLevel2 = {
    pageLevel2: pageLevel2,
    pageLevel1: pageLevel1,
  }

  type path__pageLevel3 = {
    pageLevel3: pageLevel3,
    pageLevel2: pageLevel2,
    pageLevel1: pageLevel1,
  }

  type params__staticProps<'path> = {
    locales: array<string>,
    defaultLocale: string,
    locale: string,
    params: 'path,
  }

  type t<'params, 'path> = params__staticProps<'path> => Js.Promise.t<return<'params>>
}

module Link = {
  @module("next/link") @react.component
  external make: (
    ~href: string=?,
    ~_as: string=?,
    ~prefetch: bool=?,
    ~replace: option<bool>=?,
    ~shallow: option<bool>=?,
    ~passHref: option<bool>=?,
    ~children: React.element,
    ~locale: Locale.t=?,
  ) => React.element = "default"
}

module Router = {
  /*
      Make sure to only register events via a useEffect hook!
 */
  module Events = {
    type t

    @bs.send
    external on: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "on"

    @bs.send
    external off: (
      t,
      @string
      [
        | #routeChangeStart(string => unit)
        | #routeChangeComplete(string => unit)
        | #hashChangeComplete(string => unit)
      ],
    ) => unit = "off"
  }

  type query = {
    pageLevel1: option<string>,
    pageLevel2: option<string>,
    pageLevel3: option<string>,
  }

  type router = {
    route: string,
    pathname: string,
    asPath: string,
    events: Events.t,
    query: query,
    isFallback: bool,
    locale: Locale.t,
    isReady: bool,
    locales: array<Locale.t>,
    defaultLocale: Locale.t,
  }

  type pushParams = {locale: Locale.t}

  @bs.send external push: (router, string, pushParams) => unit = "push"

  @module("next/router") external useRouter: unit => router = "useRouter"
  @bs.send external replace: (router, string) => unit = "replace"
}

module Head = {
  @module("next/head") @react.component
  external make: (~children: React.element) => React.element = "default"
}

module Error = {
  @module("next/error") @react.component
  external make: (~statusCode: int, ~children: React.element) => React.element = "default"
}

module Dynamic = {
  @deriving(abstract)
  type options = {
    @optional
    ssr: bool,
    @optional
    loading: unit => React.element,
  }

  @module("next/dynamic")
  external dynamic: (unit => Js.Promise.t<'a>, options) => 'a = "default"

  @val external \"import": string => Js.Promise.t<'a> = "import"
}

module Document = {
  @module("next/document") @react.component
  external make: (~children: React.element) => React.element = "default"

  module Head = {
    @module("next/document") @react.component
    external make: (~children: React.element) => React.element = "Head"
  }

  module Html = {
    @module("next/document") @react.component
    external make: (~children: React.element) => React.element = "Html"
  }

  module Main = {
    @module("next/document") @react.component
    external make: (~children: React.element=?) => React.element = "Main"
  }

  module NextScript = {
    @module("next/document") @react.component
    external make: (~children: React.element=?) => React.element = "NextScript"
  }
}
