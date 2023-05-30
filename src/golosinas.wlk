// Sabores
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


//Golosinas
class Bombon {
	var peso = 15
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class BombonDuro inherits Bombon {
	override method mordisco() {peso = 0.max(peso - 1)}
	method gradoDeDureza() {
		if(peso > 12){
			return 3
		}
		else if(peso.between(8,12)){
			return 2	
		}
		else {
			return 1
		}
	}
}

class Alfajor {
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
}

class Caramelo {
	var peso = 5

	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = 0.max(peso - 1) }
	method sabor() { return frutilla }
	method libreGluten() { return true }
}

class CarameloSabor inherits Caramelo {
	var property sabor
}

class CarameloRelleno inherits Caramelo {
	var sabor = self.sabor()
	override method mordisco() {super() sabor = chocolate}
	override method sabor() = sabor
	override method precio() { return 13 }
}

class Chupetin {
	var peso = 7
	
	method precio() { return 2 }
	method peso() { return peso }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() { return naranja }
	method libreGluten() { return true }
}

class Oblea {
	var peso = 250
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() {
		if (peso >= 70) {
			peso = peso * 0.5
		} else { 
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() { return vainilla }
	method libreGluten() { return false }
}

class ObleaCrujiente inherits Oblea {
	var mordiscos = 0
	
	override method mordisco() {
		if(peso >= 70 and mordiscos < 3) {
			peso = 0.max(peso - (peso * 0.5 + 3))
			mordiscos += 1
		} 
		else if(peso < 70 and mordiscos < 3){ 
			peso = 0.max(peso - ((peso * 0.25) + 3))
			mordiscos += 1
		}
		else if(peso >= 70) {
			peso = peso * 0.5
		}
		else {
			peso = peso - (peso * 0.25)
		}
	}
	method estaDebil() = mordiscos > 3 
}

class Chocolatin {
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() { return chocolate }
	method libreGluten() { return false }

}

class ChocolatinVIP inherits Chocolatin {
	const property humedad
	
	override method peso() = 0.max(pesoInicial * (1 + humedad))
}

class ChocolatinPremium inherits ChocolatinVIP {
	override method humedad() = humedad * 0.5
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const property sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return if(self.libreGluten()) 7 else 10 }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
