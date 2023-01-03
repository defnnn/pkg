package main

import (
	"fmt"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

func replay(e *echo.Echo, app string) {
	replay_path(e, app, fmt.Sprintf("/%s/*", app))
}

func replay_path(e *echo.Echo, app string, path string) {
	send_replay := func(c echo.Context) error {
		req := c.Request()

		if strings.HasSuffix(req.Header.Get("x-ben"), ".fly.dev") {
			c.Response().Header().Set("fly-replay", fmt.Sprintf("app=%s", app))
			return c.NoContent(http.StatusConflict)
		}

		return c.NoContent(http.StatusForbidden)
	}

	e.GET(path, send_replay)
	e.POST(path, send_replay)
}

func main() {
	e := echo.New()

	replay_path(e, "defn", "/*")

	e.Logger.Fatal(e.Start(":8001"))
}
