package com.TechRecycler.TechRecycler.repository;

//import com.tu_paquete.model.Usuario;
import com.TechRecycler.TechRecycler.model.*;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UsuarioRepository extends MongoRepository<Usuario, String> {
}