# This file is no longer strictly necessary as we will use the `UUIDv7`
# module provided by the :uuidv7 package directly in our Ecto Schemas.
# However, if you wish to have a central alias or custom behavior,
# we can keep a simple delegation here.

defmodule QLCore.Types.UUIDv7 do
  @moduledoc """
  Delegates to the specialized `uuidv7` library.

  In your Ecto schemas, you can now use:
  @primary_key {:id, UUIDv7, autogenerate: true}
  """

  # We delegate to the library's implementation to keep our domain clean
  # while benefiting from the library's optimized Ecto.Type callbacks.
  defdelegate cast(value), to: UUIDv7
  defdelegate load(value), to: UUIDv7
  defdelegate dump(value), to: UUIDv7
  defdelegate generate(), to: UUIDv7
  defdelegate autogenerate(), to: UUIDv7
  defdelegate type(), to: UUIDv7
end
