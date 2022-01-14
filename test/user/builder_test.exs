defmodule FlightBooking.User.BuilderTest do
  use ExUnit.Case

  alias FlightBooking.User.Builder
  alias FlightBooking.User.User
  alias FlightBooking.User.Agent, as: UserAgent

  setup_all do
    UserAgent.start_link(%{})

    user = %User{
      id: "abc",
      name: "Victor Moraes",
      email: "email@test.com",
      cpf: "12345678910"
    }

    {:ok, user: user}
  end

  describe "build/4" do
    test "Criar um usuário com dados válidos sucesso", setup do
      expected_user = setup[:user]

      response = Builder.build(expected_user.name, expected_user.email, expected_user.cpf)

      assert response == {:ok, "Usuário salvo ou atualizado"}

      user = UserAgent.get(expected_user.cpf)

      assert expected_user.name == user.name
      assert expected_user.email == user.email
      assert expected_user.cpf == user.cpf
    end

    test "Erro de cpf inválido", setup do
      user = %{setup[:user] | cpf: "123"}

      response = Builder.build(user.name, user.email, user.cpf)

      assert response == {:error, "Cpf inválido"}
    end

    test "Erro de email inválido", setup do
      user = %{setup[:user] | email: "123"}

      response = Builder.build(user.name, user.email, user.cpf)

      assert response == {:error, "E-mail inválido"}
    end

    test "Erro de email sem ser string", setup do
      user = %{setup[:user] | email: 123}

      response = Builder.build(user.name, user.email, user.cpf)

      assert response == {:error, "Parametros inválidos"}
    end

    test "Erro de cpf sem ser string", setup do
      user = %{setup[:user] | cpf: 123}

      response = Builder.build(user.name, user.email, user.cpf)

      assert response == {:error, "Parametros inválidos"}
    end
  end
end
