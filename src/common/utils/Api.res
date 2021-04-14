module CraftCms = {
  let headers = {"Authorization": `Bearer ${Env.apiPublicAccessToken}`}

  let httpLink = ApolloClient.Link.HttpLink.make(
    ~uri=_ => `${Env.apiEndpoint}/api`,
    ~headers=Obj.magic(headers),
    (),
  )

  let client = {
    open ApolloClient
    make(
      ~cache=ApolloClient.Cache.InMemoryCache.make(),
      ~connectToDevTools=true,
      ~defaultOptions=DefaultOptions.make(
        ~mutate=DefaultMutateOptions.make(~awaitRefetchQueries=true, ~errorPolicy=All, ()),
        ~query=DefaultQueryOptions.make(~fetchPolicy=NetworkOnly, ~errorPolicy=All, ()),
        ~watchQuery=DefaultWatchQueryOptions.make(~fetchPolicy=NetworkOnly, ~errorPolicy=All, ()),
        (),
      ),
      ~link=httpLink,
      (),
    )
  }
}
