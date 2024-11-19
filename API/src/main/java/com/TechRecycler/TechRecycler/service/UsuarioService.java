package com.TechRecycler.TechRecycler.service;

import com.TechRecycler.TechRecycler.model.*;
import com.TechRecycler.TechRecycler.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Usuario agregarUsuario(Usuario usuario) {
        usuario.setPuntaje(0); // Puntaje inicial en 0
        return usuarioRepository.save(usuario);
    }

    public Optional<Usuario> consultarUsuario(String id) {
        return usuarioRepository.findById(id);
    }

    public Usuario asignarPuntos(String id, int puntos) {
        Usuario usuario = usuarioRepository.findById(id).orElseThrow();
        usuario.setPuntaje(usuario.getPuntaje() + puntos);
        return usuarioRepository.save(usuario);
    }

    public Usuario quitarPuntos(String id, int puntos) {
        Usuario usuario = usuarioRepository.findById(id).orElseThrow();
        usuario.setPuntaje(Math.max(usuario.getPuntaje() - puntos, 0));
        return usuarioRepository.save(usuario);
    }

    public List<Usuario> obtenerTodosUsuarios() {
        return usuarioRepository.findAll();
    }
}
