# Phoenix Project

This is the readme file for the Phoenix project, which is an Elixir application built using the Phoenix framework.

## Project Configuration

The project is configured using the `ManagementServer.MixProject` module in the `mix.exs` file. Here are some important details about the project configuration:

- **Application Name**: `:management_server`
- **Version**: `0.1.0`
- **Elixir Version**: `~> 1.12`
- **Elixir Compiler Paths**: The project uses different compilation paths for different environments. The `:test` environment compiles the "lib" and "test/support" directories, while other environments compile only the "lib" directory.
- **Compilers**: The project uses the `:gettext` compiler in addition to the default compilers provided by Mix.
- **Start Permanent**: The application is set to start permanently (`true`) only in the `:prod` environment.
- **Aliases**: The project defines several aliases for convenience, such as `setup`, `ecto.setup`, `ecto.reset`, and `test`. These aliases are shortcuts for running specific tasks or sets of tasks.

## Dependencies

The project has the following dependencies specified in the `deps` function of the `ManagementServer.MixProject` module:

- `phoenix`: The Phoenix framework version 1.6.16.
- `phoenix_ecto`: Integration between Phoenix and Ecto ORM version 4.4.
- `ecto_sql`: Ecto SQL adapter version 3.6.
- `postgrex`: PostgreSQL driver for Ecto version 0.0.0 or higher.
- `telemetry_metrics`: Telemetry metrics library version 0.6.
- `telemetry_poller`: Telemetry poller library version 1.0.
- `gettext`: Internationalization (i18n) library version 0.18.
- `jason`: JSON serialization library version 1.2.
- `plug_cowboy`: Cowboy adapter for the Plug web server version 2.5.
- `guardian`: Authentication library version 2.3.
- `guardian_db`: Guardian integration with Ecto version 2.0.
- `bcrypt_elixir`: Library for working with Bcrypt password hashing version 3.0.
- `phoenix_swagger`: Phoenix integration with Swagger/OpenAPI version 0.8.2.
- `ex_json_schema`: JSON Schema validation library version 0.7.1.
- `cors_plug`: CORS (Cross-Origin Resource Sharing) Plug middleware version 3.0.

Please refer to the respective documentation for each dependency for more information on their usage.

## Docker Configuration

The project includes a Docker configuration specified in the `docker-compose.yml` file. Here are some details about the Docker configuration:

- **PostgreSQL**: The project uses the official PostgreSQL Docker image version 14.1-alpine. It exposes port 5432 for the database.
- **Environment Variables**: The PostgreSQL container is configured with the `POSTGRES_USER` and `POSTGRES_PASSWORD` environment variables set to "postgres" for both.
- **Volumes**: The PostgreSQL data directory is mounted to a volume named "db" to persist the database data.

## Getting Started

To set up and run the Phoenix project, follow these steps:

1. Make sure you have Elixir and Mix installed on your system.
2. Clone the project repository.
3. Install dependencies by running the following command in the project directory `management_server`:
   ```
   $ mix deps.get
   ```
4. Set up the database by running the following command:

   ```
   $ mix ecto.setup
   ```

   This will create the database, run migrations, and execute the seed data script if provided in `priv/repo/seeds.exs`.

5. Start the Phoenix server by running the following command:

   ```
   $ mix phx.server
   ```

   This will start the server and make the application accessible at `http://localhost:4000`.

6. You can now access the Phoenix application in your web browser. The default routes and functionality provided by Phoenix will be available for testing and development.

## Additional Tasks and Aliases

The project provides some additional tasks and aliases for convenience. Here are a few examples:

- **`mix setup`**: This alias installs project dependencies and performs other setup tasks.
- **`mix ecto.setup`**: This alias creates the database, runs migrations, and executes the seed data script.
- **`mix ecto.reset`**: This alias drops the database and performs the `ecto.setup` task.
- **`mix test`**: This alias creates a test database, runs migrations, and executes tests.

You can execute these tasks and aliases by running the corresponding command in the project directory, prefixed with `mix`. For example, to run the `setup` alias, you would use the command `mix setup`.

Please refer to the Mix documentation for more information on how to define and use aliases.

## Contributing

If you want to contribute to the Phoenix project, you can follow these steps:

1. Fork the repository and clone it to your local machine.
2. Make the necessary changes and additions.
3. Run tests to ensure that everything is working as expected:
   ```
   $ mix test
   ```
4. Commit your changes and push them to your forked repository.
5. Submit a pull request to the main repository, explaining the changes you made and their purpose.

Please make sure to follow the code style and guidelines used in the project and provide appropriate tests for any new functionality or modifications.

## License

The Phoenix project is open-source and released under the [MIT License](LICENSE). Feel free to use, modify, and distribute the code as per the terms of the license.

## Deployment

To deploy the Phoenix project to a production environment, you can follow these general steps:

1. Set up a production server or hosting environment with Elixir and Erlang installed.
2. Clone the project repository onto the server or upload the project files to the hosting environment.
3. Install project dependencies by running the following command in the project directory:
   ```
   $ mix deps.get --only prod
   ```
4. Configure the production environment by updating the necessary configuration files, such as `config/prod.exs` and `config/prod.secret.exs`. Make sure to provide the appropriate database connection details and other relevant settings.
5. Compile the project by running the following command:
   ```
   $ MIX_ENV=prod mix compile
   ```
6. Set up the database by running the following command:
   ```
   $ MIX_ENV=prod mix ecto.setup
   ```
   This will create the production database, run migrations, and execute the seed data script if provided.
7. Build a release of the application by running the following command:
   ```
   $ MIX_ENV=prod mix release
   ```
   This will generate an executable release of the application in the `_build/prod/rel` directory.
8. Start the Phoenix server by running the generated release executable:
   ```
   $ _build/prod/rel/management_server/bin/management_server start
   ```
   Adjust the command according to your application's release name and path.
9. Configure your production web server or reverse proxy (e.g., Nginx or Apache) to forward requests to the Phoenix application running on the specified port (e.g., port 4000).
10. Monitor the server logs and ensure that the application is running correctly in the production environment.

Please note that these are general guidelines, and the deployment process may vary depending on your specific hosting environment and requirements. It's recommended to consult the official documentation of the hosting platform or server setup for detailed deployment instructions.

## Additional Resources

Here are some additional resources that may be helpful for working with the Phoenix framework and Elixir:

- [Phoenix Framework Documentation](https://hexdocs.pm/phoenix/overview.html): Official documentation for the Phoenix framework, providing detailed guides, API references, and examples.
- [Elixir Official Website](https://elixir-lang.org/): The official website of the Elixir programming language, containing resources, tutorials, and documentation.
- [Elixir Forum](https://elixirforum.com/): A community-driven forum where you can ask questions, share ideas, and discuss Elixir and Phoenix-related topics.
- [Elixir School](https://elixirschool.com/): An online learning platform that provides interactive lessons and tutorials for learning Elixir and Phoenix.
- [Elixir Style Guide](https://github.com/christopheradams/elixir_style_guide): A community-driven style guide that defines best practices and conventions for writing Elixir code.

Feel free to explore these resources to deepen your understanding and enhance your development experience with Phoenix and Elixir.
