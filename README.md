# Cold Is Not Frozen

The mobile front-end for an application focused on registering the temperature of isolated ambients like bedrooms, refrigerators and swimming pools.

- The data is collected through an Arduino based hardware with internet connection, using a temperature sensor;
- The data is sent to a Hasura Postgresql database on the cloud;
- The data is fetched using Hasura's GraphQL endpoint and exhibited in this mobile application;
- This project utilizes Clean Architecture concepts.