open Belt

@val
external apiEndpoint: Js.Nullable.t<string> = "process.env.NEXT_PUBLIC_API_ENDPOINT"
let apiEndpoint = apiEndpoint->Js.Nullable.toOption->Option.getWithDefault("")

@val
external apiPublicAccessToken: Js.Nullable.t<string> = "process.env.NEXT_PUBLIC_API_ACCESS_TOKEN"
let apiPublicAccessToken = apiPublicAccessToken->Js.Nullable.toOption->Option.getWithDefault("")

@val external isNode: Js.Nullable.t<string> = "process.env.IS_BROWSER"
let isNode =
  isNode
  ->Js.Nullable.toOption
  ->Option.getWithDefault("false")
  ->bool_of_string_opt
  ->Option.getWithDefault(false)
