package com.francopocatino.helloapi;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class HelloControllerTest {

  @Autowired
  private TestRestTemplate restTemplate;

  @Test
  void rootReturnsServiceInfo() {
    ResponseEntity<Map> response = restTemplate.getForEntity("/", Map.class);
    assertEquals(HttpStatus.OK, response.getStatusCode());
    assertNotNull(response.getBody());
    assertEquals("hello-api", response.getBody().get("service"));
  }

  @Test
  void livenessProbeIsUp() {
    ResponseEntity<Map> response = restTemplate.getForEntity("/actuator/health/liveness", Map.class);
    assertEquals(HttpStatus.OK, response.getStatusCode());
    assertEquals("UP", response.getBody().get("status"));
  }
}
