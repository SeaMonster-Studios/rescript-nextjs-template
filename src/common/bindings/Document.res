type className = {@meth "replace": (string, string) => unit}

type element = {"className": className, @meth "setAttribute": (string, string) => unit}

@val @return(nullable) @scope("document")
external querySelector: string => option<element> = "querySelector"
