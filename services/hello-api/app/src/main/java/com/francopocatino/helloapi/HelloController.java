package com.francopocatino.helloapi;

import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

  @GetMapping("/")
  public Map<String, String> root() {
    return Map.of(
      "service", "hello-api",
      "version", System.getenv().getOrDefault("APP_VERSION", "dev")
    );
  }
}
