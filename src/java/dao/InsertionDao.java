package dao;

import jakarta.persistence.EntityManager;
import util.JpaUtil;
import java.util.List;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.NoResultException;
import java.util.ArrayList;

public class InsertionDao {

    public <T> T insert(T entity) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            manager.getTransaction().begin();
            manager.persist(entity);
            manager.flush();
            manager.getTransaction().commit();
            return entity;
        } catch (RuntimeException exception) {
            if (manager.getTransaction().isActive()) {
                manager.getTransaction().rollback();
            }
            throw exception;
        } finally {
            manager.close();
        }
    }

    public <T> T update(T entity) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            manager.getTransaction().begin();
            T updatedEntity = manager.merge(entity);
            manager.flush();
            manager.getTransaction().commit();
            return updatedEntity;
        } catch (RuntimeException exception) {
            if (manager.getTransaction().isActive()) {
                manager.getTransaction().rollback();
            }
            throw exception;
        } finally {
            manager.close();
        }
    }

    public <T> void delete(T entity) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            manager.getTransaction().begin();
            manager.remove(manager.contains(entity) ? entity : manager.merge(entity));
            manager.flush();
            manager.getTransaction().commit();
        } catch (RuntimeException exception) {
            if (manager.getTransaction().isActive()) {
                manager.getTransaction().rollback();
            }
            throw exception;
        } finally {
            manager.close();
        }
    }

    public <T> void deleteById(Class<T> entityClass, Object id) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            manager.getTransaction().begin();
            T entity = manager.find(entityClass, id);
            if (entity != null) {
                manager.remove(entity);
            }
            manager.flush();
            manager.getTransaction().commit();
        } catch (RuntimeException exception) {
            if (manager.getTransaction().isActive()) {
                manager.getTransaction().rollback();
            }
            throw exception;
        } finally {
            manager.close();
        }
    }

    public <T> T findById(Class<T> entityClass, Object id) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            return manager.find(entityClass, id);
        } finally {
            manager.close();
        }
    }

    public <T> List<T> findAll(Class<T> entityClass) {
        EntityManager manager = JpaUtil.createEntityManager();

        try {
            CriteriaBuilder builder = manager.getCriteriaBuilder();
            CriteriaQuery<T> query = builder.createQuery(entityClass);

            Root<T> root = query.from(entityClass);
            query.select(root);

            return manager.createQuery(query).getResultList();

        } finally {
            manager.close();
        }
    }


    public <T> T find(Class<T> entityClass, List<String> fieldNames, List<Object> values) {
        if (fieldNames == null || values == null || fieldNames.size() != values.size()) {
            throw new IllegalArgumentException("fieldNames et values doivent être non nuls et de même taille.");
        }

        EntityManager manager = JpaUtil.createEntityManager();
        try {
            CriteriaBuilder builder = manager.getCriteriaBuilder();
            CriteriaQuery<T> query = builder.createQuery(entityClass);
            Root<T> root = query.from(entityClass);

            List<Predicate> predicates = new ArrayList<>();
            for (int i = 0; i < fieldNames.size(); i++) {
                String fieldName = fieldNames.get(i);
                Object value = values.get(i);

                if (value == null) {
                    predicates.add(builder.isNull(root.get(fieldName)));
                } else {
                    predicates.add(builder.equal(root.get(fieldName), value));
                }
            }

            if (!predicates.isEmpty()) {
                query.where(builder.and(predicates.toArray(new Predicate[0])));
            }

            return manager.createQuery(query).getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            manager.close();
        }
    }


}
