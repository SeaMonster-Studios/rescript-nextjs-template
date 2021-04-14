open Belt

type window<'a> = Js.t<'a>

// a server-side safe way to get the window object
let getWindow: unit => Js.Nullable.t<window<'a>> = %raw(`
    function() {
      if (typeof window !== "undefined") {
        return window
      } else {
        return null
      }
    }
  `)

let str = React.string

let classNames = classNames => classNames->Js.Array2.joinWith(" ")

let mapNullDefault = (item, mapper) => item->Option.mapWithDefault(React.null, mapper)

let mapStr = item => item->Option.getWithDefault("")

let fromPromise: (
  Js.Promise.t<'a>,
  Result.t<'a, Js.Promise.error> => Js.Promise.t<'b>,
) => Js.Promise.t<'b> = (promise, callback) =>
  promise
  |> Js.Promise.then_((response: 'a) => callback(Ok(response)))
  |> Js.Promise.catch(error => callback(Error(error)))

let withOptionalClass = (className, maybeClassName) => {
  maybeClassName->Option.mapWithDefault(className, cn => classNames([className, cn]))
}

let logApolloError = (error: ApolloClient__Errors.ApolloError.t) => {
  Js.log(`GQL errors on ${error.name} with message: ${error.message}`)
  error.networkError->Option.mapWithDefault((), error => Js.log2(`GQL Network Error`, error))
  Js.log2(`GQL graphQLErrors:`, error.graphQLErrors)
  error.stack->Option.mapWithDefault((), error => Js.log2(`GQL Stack Error`, error))
}
