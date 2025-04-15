{
  description = "Phoenix Elixir Development Environment with PostgreSQL and LSP";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        erlang = pkgs.erlang_27;
        beamPackages = pkgs.beam.packagesWith erlang;

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            beamPackages.elixir
            beamPackages.hex
            beamPackages.rebar
            pkgs.nodejs_22
            pkgs.postgresql_17
            pkgs.inotifyTools
            pkgs.glibcLocales
            pkgs.yarn
            pkgs.elixir_ls
          ];

          shellHook = ''
            export LANG=en_US.UTF-8
            export MIX_ENV=dev
            export ERL_AFLAGS="-kernel shell_history enabled"
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.hex
            mkdir -p "$MIX_HOME" "$HEX_HOME"

            # PostgreSQL auto-start
            export PGDATA=$PWD/.postgres
            export PGPORT=5432

            if [ ! -d "$PGDATA" ]; then 
              echo "Initializing PostgreSQL database"
              initdb --auth=trust --no-locale --encoding=UTF8 --username=postgres

              echo "unix_socket_directories = '$PGDATA'" >> "$PGDATA/postgresql.conf"

              pg_ctl -D .postgres start -l .postgres/postgres.log
              
              sleep 1
            fi

              echo ""
              echo "PostgreSQL running:"
              echo "  Socket: $PGDATA"
              echo "  Port: $PGPORT"
              echo "  connect: psql -h '$PGDATA' -p $PGPORT"

              trap "pg_ctl stop" EXIT

            # Phoenix-specific tools
            mix archive.install hex phx_new
            mix local.rebar --force
            mix local.hex --force

            # Elixir LSP support setup (ElixirLS)
            export LANG=en_US.UTF-8
            echo "LSP for Elixir is set up with ElixirLS"
            
            # Final environment details
            echo ""
            echo "Development Environment ready"
            echo "Elixir: $(elixir --version)"
            echo "NodeJS: $(node --version)"
            echo "PostgreSQL: $(postgres --version)"
          '';
        };
      });
}
