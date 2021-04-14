open Utils

@react.component
let make = (~url=?, ~type_=?, ~title=?, ~img=?, ~description=?) => {
  <Next.Head>
    {switch description {
    | None => React.null
    | Some(content) => <meta name="description" content={content} />
    }}
    {switch url {
    | None => React.null
    | Some(content) => <meta key="url" name="og:url" property="og:url" content={content} />
    }}
    {switch type_ {
    | None => React.null
    | Some(content) => <meta name="og:type" key="type" property="og:type" content={content} />
    }}
    {switch title {
    | None => React.null
    | Some(content) => <>
        <title> {content->str} </title>
        <meta name="og:title" key="title" property="og:title" content={content} />
      </>
    }}
    {switch img {
    | None => React.null
    | Some(content) => <meta name="og:image" key="image" property="og:image" content={content} />
    }}
  </Next.Head>
}
