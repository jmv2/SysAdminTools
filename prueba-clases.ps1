class prueba {
    [String]$nombre
    [int]$edad

    [string] nuevaPrueba([String]$n_nombre, [int]$n_edad){

        $this.nombre = $n_nombre
        $this.edad = $n_edad

        return "Nombre: " + $this.nombre + "y edad: " + $this.edad
    }
}