%raw("import('../src/common/styles/app.css')")

// If you need globally initialized data or state, this is the entry for that. Checkout this rescript-nextjs template for reference, https://github.com/ryyppy/rescript-nextjs-template

type pageProps

module PageComponent = {
  type t = React.component<pageProps>
}

type props = {
  @as("Component")
  component: PageComponent.t,
  pageProps: pageProps,
}

let default = (props: props): React.element => {
  let {component, pageProps} = props

  let content = React.createElement(component, pageProps)

  React.useEffect0(() => {
    switch Document.querySelector("body") {
    | None => ()
    | Some(body) => Js.Global.setTimeout(() => body["setAttribute"]("style", ""), 100)->ignore
    }
    None
  })

  <ApolloClient.React.ApolloProvider client=Api.CraftCms.client>
    content
  </ApolloClient.React.ApolloProvider>
}
