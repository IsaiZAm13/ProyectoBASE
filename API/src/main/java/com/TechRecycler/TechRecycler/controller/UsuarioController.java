package com.TechRecycler.TechRecycler.controller;

import com.TechRecycler.TechRecycler.model.*;
import com.TechRecycler.TechRecycler.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @PostMapping("/agregar")
    public Usuario agregarUsuario(@RequestBody Usuario usuario) {
        return usuarioService.agregarUsuario(usuario);
    }

    @GetMapping("/consultar/{id}")
    public Optional<Usuario> consultarUsuario(@PathVariable String id) {
        return usuarioService.consultarUsuario(id);
    }

    @PutMapping("/asignarPuntos/{id}")
    public Usuario asignarPuntos(@PathVariable String id, @RequestParam int puntos) {
        return usuarioService.asignarPuntos(id, puntos);
    }

    @PutMapping("/quitarPuntos/{id}")
    public Usuario quitarPuntos(@PathVariable String id, @RequestParam int puntos) {
        return usuarioService.quitarPuntos(id, puntos);
    }

    @GetMapping("/todos")
    public List<Usuario> obtenerTodosUsuarios() {
        return usuarioService.obtenerTodosUsuarios();
    }
}
