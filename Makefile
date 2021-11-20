up:
	@docker compose up -d
	@docker exec reserva-voos-elixir bash -c "mix deps.get"

make install:
	@docker exec reserva-voos-elixir bash -c "mix deps.get"