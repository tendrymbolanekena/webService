package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

public final class JpaUtil {
    private static final EntityManagerFactory FACTORY = createFactory();

    private JpaUtil() {
    }

    private static EntityManagerFactory createFactory() {
        Map<String, String> properties = new HashMap<>();
        properties.put("jakarta.persistence.jdbc.url",
                getenv("JPA_URL", "jdbc:postgresql://localhost:5432/test"));
        properties.put("jakarta.persistence.jdbc.user",
                getenv("JPA_USER", "postgres"));
        properties.put("jakarta.persistence.jdbc.password",
                getenv("JPA_PASSWORD", "postgres"));
        return Persistence.createEntityManagerFactory("TestFrameWorkPU", properties);
    }

    public static EntityManager createEntityManager() {
        return FACTORY.createEntityManager();
    }

    private static String getenv(String name, String defaultValue) {
        String value = System.getenv(name);
        return value == null || value.isBlank() ? defaultValue : value;
    }

    public static void close() {
        if (FACTORY.isOpen()) {
            FACTORY.close();
        }
    }
}
