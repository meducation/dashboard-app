[![Build Status](https://travis-ci.org/meducation/front-dashboard-app.png)](https://travis-ci.org/meducation/dashboard-app)
[![Coverage Status](https://coveralls.io/repos/meducation/dashboard-app/badge.png)](https://coveralls.io/r/meducation/dashboard-app)

# Meducation Dashboard Application

A dashboard application to provide metrics that show the pulse of Meducation.

# Getting Started

This is a node application.  You should install [node](http://nodejs.org/) first then:

    npm install
    grunt server watch

This starts up the dashboard at `http://localhost:3000`

## Pushing metrics

The application can receive metrics as POST requests.
For example, to send visitor information create a POST to:

  http://localhost:3000/metrics/traffic

Containing a raw body:

```
  {
  	"Message" : "{\"anon\":1,\"normal\":2,\"premium\":3,\"unique_loggedin_last_hour\":4,\"unique_loggedin_last_day\":5,\"unique_loggedin_last_week\":6,\"unique_loggedin_last_month\":7}"
  }
```

## Contributing

Firstly, thank you!! :heart::sparkling_heart::heart:

Please read our [contributing guide](https://github.com/meducation/dashboard-app/tree/master/CONTRIBUTING.md) for information on how to get stuck in.

## Licence

Copyright (C) 2013 New Media Education Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

A copy of the GNU Affero General Public License is available in [Licence.md](https://github.com/meducation/dashboard-app/blob/master/LICENCE.md)
along with this program.  If not, see <http://www.gnu.org/licenses/>.