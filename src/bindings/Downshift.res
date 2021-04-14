type highlightedIndex = int
type isOpen = bool

@bs.module("downshift") @bs.scope("useSelect")
external stateChangeTypes: {
  "MenuKeyDownArrowDown": string,
  "MenuKeyDownArrowUp": string,
  "MenuKeyDownEscape": string,
  "MenuKeyDownHome": string,
  "MenuKeyDownEnd": string,
  "MenuKeyDownEnter": string,
  "MenuKeyDownCharacter": string,
  "MenuBlur": string,
  "ItemMouseLeave": string,
  "ItemMouseMove": string,
  "ItemHover": string,
  "ItemClick": string,
  "ToggleButtonKeyDownCharacter": string,
  "ToggleButtonKeyDownArrowDown": string,
  "ToggleButtonKeyDownArrowUp": string,
  "ToggleButtonClick": string,
  "FunctionToggleMenu": string,
  "FunctionOpenMenu": string,
  "FunctionCloseMenu": string,
  "FunctionSetHighlightedIndex": string,
  "FunctionSelectItem": string,
  "FunctionClearKeysSoFar": string,
  "FunctionReset": string,
} = "stateChangeTypes"

@ocaml.doc("State changes can be used in a state reducer like so:
 *   let stateReducer = (_state, actionAndChanges) => {
    switch (actionAndChanges##_type) {
    | x when x == Downshift.stateChangeTypes##\"FunctionOpenMenu\" =>
      // Do something here
      actionAndChanges##changes;
    | _ => actionAndChanges##changes
    };
  };
")
type toggleButtonProps = {
  "aria-expanded": bool,
  "aria-haspopup": string,
  "aria-labelledby": string,
  "id": string,
  @bs.meth
  "onClick": ReactEvent.Mouse.t => unit,
  @bs.meth
  "onKeyDown": ReactEvent.Keyboard.t => unit,
  "ref": ReactDOMRe.domRef,
}

type labelProps = {"id": string, "htmlFor": string}

type menuProps = {
  "aria-labelledby": string,
  "id": string,
  @bs.meth
  "onBlur": ReactEvent.Focus.t => unit,
  @bs.meth
  "onKeyDown": ReactEvent.Keyboard.t => unit,
  @bs.meth
  "onMouseLeave": ReactEvent.Mouse.t => unit,
  "ref": ReactDOMRe.domRef,
  "role": string,
  "tabIndex": int,
}

type itemProps = {
  "role": string,
  "id": string,
  @bs.meth
  "onClick": ReactEvent.Mouse.t => unit,
  @bs.meth
  "onMouseMove": ReactEvent.Mouse.t => unit,
  "ref": ReactDOMRe.domRef,
}

@bs.deriving(abstract)
type createGetItemPropsParams<'i> = {
  @bs.optional
  index: highlightedIndex,
  @bs.optional
  item: 'i,
  @bs.optional
  isActive: bool,
  @bs.optional
  isSelected: bool,
}

module UseSelect = {
  type state<'i> = {
    "highlightedIndex": highlightedIndex,
    "isOpen": bool,
    "keysSoFar": string,
    "selectedItem": Js.Nullable.t<'i>,
  }

  type actionAndChanges<'i> = {
    "changes": state<'i>,
    "_type": string,
    "props": {
      "items": array<'i>,
      "initialSelectedItem": 'i,
      @bs.meth
      "itemToString": 'i => string,
      @bs.meth
      "getA11ySelectionMessage": unit => string,
      @bs.meth
      "getA11yStatusMessage": unit => string,
      @bs.meth
      "scrollIntoView": (ReactDOMRe.domRef, ReactDOMRe.domRef) => unit,
      @bs.meth
      "stateReducer": (state<'i>, state<'i>) => state<'i>,
    },
  }

  @bs.deriving(abstract)
  type params<'i> = {
    items: array<'i>,
    @bs.optional
    initialSelectedItem: 'i,
    @bs.optional
    itemToString: 'i => string,
    @bs.optional
    onSelectedItemChange: state<'i> => unit,
    @bs.optional
    stateReducer: (state<'i>, actionAndChanges<'i>) => state<'i>,
    @bs.optional
    initialIsOpen: isOpen,
    @bs.optional
    initialHighlightedIndex: highlightedIndex,
    @bs.optional
    defaultSelectedItem: 'i,
    @bs.optional
    defaultIsOpen: isOpen,
    @bs.optional
    defaultHighlightedIndex: highlightedIndex,
    @bs.optional
    getA11yStatusMessage: unit => string,
    @bs.optional
    getA11ySelectionMessage: unit => string,
    @bs.optional
    onHighlightedIndexChange: state<'i> => unit,
    @bs.optional
    onIsOpenChange: state<'i> => unit,
    @bs.optional
    onStateChange: state<'i> => unit,
    @bs.optional
    highlightedIndex: highlightedIndex,
    @bs.optional
    selectedItem: 'i,
    @bs.optional
    id: string,
    @bs.optional
    labelId: string,
    @bs.optional
    menuId: string,
    @bs.optional
    toggleButtonId: string,
    @bs.optional
    getItemId: string,
    @bs.optional
    circularNavigation: bool,
  }

  type value<'i> = {
    "isOpen": isOpen,
    "selectedItem": Js.Nullable.t<'i>,
    "highlightedIndex": highlightedIndex,
    @bs.meth
    "getToggleButtonProps": unit => toggleButtonProps,
    @bs.meth
    "getLabelProps": unit => labelProps,
    @bs.meth
    "getMenuProps": unit => menuProps,
    @ocaml.doc("Usage: getItemProps(createGetItemPropsParams(~index=0, ())) ") @bs.meth
    "getItemProps": createGetItemPropsParams<'i> => itemProps,
    @bs.meth
    "toggleMenu": unit => unit,
    @bs.meth
    "selectItem": 'i => unit,
    @bs.meth
    "openMenu": unit => unit,
    @bs.meth
    "closeMenu": unit => unit,
    @bs.meth
    "reset": unit => unit,
    @bs.meth
    "setHighlightedIndex": highlightedIndex => unit,
  }

  @bs.module("downshift")
  external use: params<'i> => value<'i> = "useSelect"

  @@ocaml.doc("Usage: use(params(~items=options, ())); ")
}

module UseMultiSelect = {
  type state<'i> = {
    "highlightedIndex": highlightedIndex,
    "isOpen": bool,
    "keysSoFar": string,
    "selectedItems": Js.Nullable.t<array<'i>>,
  }

  type actionAndChanges<'i> = {
    "changes": state<'i>,
    "_type": string,
    "props": {
      "items": array<'i>,
      "initialSelectedItem": 'i,
      @bs.meth
      "itemToString": 'i => string,
      @bs.meth
      "getA11ySelectionMessage": unit => string,
      @bs.meth
      "getA11yStatusMessage": unit => string,
      @bs.meth
      "scrollIntoView": (ReactDOMRe.domRef, ReactDOMRe.domRef) => unit,
      @bs.meth
      "stateReducer": (state<'i>, state<'i>) => state<'i>,
    },
  }

  @bs.deriving(abstract)
  type params<'i> = {
    items: array<'i>,
    @bs.optional
    initialSelectedItems: array<'i>,
    @bs.optional
    itemToString: 'i => string,
    @bs.optional
    onSelectedItemsChange: state<'i> => unit,
    @bs.optional
    setSelectedItems: state<'i> => unit,
    @bs.optional
    stateReducer: (state<'i>, actionAndChanges<'i>) => state<'i>,
    @bs.optional
    defaultSelectedItems: array<'i>,
    @bs.optional
    getA11yRemovalMessage: unit => string,
    @bs.optional
    onStateChange: state<'i> => unit,
    @bs.optional
    selectedItems: array<'i>,
  }

  type value<'i> = {
    "activeIndex": highlightedIndex,
    "selectedItems": Js.Nullable.t<array<'i>>,
    @bs.meth
    "addSelectedItem": 'i => unit,
    @bs.meth
    "getDropdownProps": toggleButtonProps => toggleButtonProps,
    @ocaml.doc("Usage: getItemProps(createGetItemPropsParams(~index=0, ())) ") @bs.meth
    "getSelectedItemProps": createGetItemPropsParams<'i> => itemProps,
    @bs.meth
    "removeSelectedItem": 'i => unit,
    @bs.meth
    "reset": unit => unit,
    @bs.meth
    "selectItems": array<'i> => unit,
    @bs.meth
    "setActiveIndex": highlightedIndex => unit,
    @bs.meth
    "setSelectedItems": array<'i> => unit,
  }

  @bs.module("downshift")
  external use: params<'i> => value<'i> = "useMultipleSelection"

  @@ocaml.doc("Usage: use(params(~items=options, ())); ")
}
