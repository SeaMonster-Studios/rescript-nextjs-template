open Utils

%raw("require('./PageError.module.css')")

@react.component
let make = (~error="404", ~button=React.null) => {
  <div className="page-404 w-full flex flex-col items-center justify-center bg-blue h-screen">
    <h1 className="font-bold text-6xl"> {error->str} </h1> button
  </div>
}

let default = make
