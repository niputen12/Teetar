defmodule Joken.Token do
  alias Joken.Signer

  @moduledoc """
  This is the data structure that holds the token state.
  """

  @type json_module        :: module
  @type header             :: %{binary => any}
  @type claims             :: %{binary => any}
  @type claim_function_map :: %{binary => function}
  @type error              :: binary
  @type errors             :: [binary]
  @type token              :: binary
  @type signer             :: Signer.t

  @type t :: %__MODULE__{
    json_module: module,
    claims: claims,
    claims_generation: claim_function_map,
    validations: claim_function_map,
    error: error | nil,
    errors: errors,
    token: token | nil,
    signer: signer | nil
  }

  defstruct [json_module: nil,
             header: %{},
             claims: %{},
             claims_generation: %{},
             validations: %{},
             error: nil,
             errors: [],
             token: nil,
             signer: nil]

end
