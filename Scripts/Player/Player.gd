extends KinematicBody2D

#Констатнты для физики
const SPEED = 200
const ACCELERATION = 15
const FRICTION = 15

#Создаем пустой вектор для направления персонажа
var velocity = Vector2.ZERO


"""Функция, которая обрабатывает все физ. процессы"""
func _physics_process(delta):
	#Создаем еще один пустой вектор для считывания нажатия кнопок
	var input_vector = Vector2.ZERO
	
	#Считываем кнопки и заносим их в вектора
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector.normalized()
	
	#Делаем проверку - нажата ли клавиша
	if input_vector != Vector2.ZERO:
		#Если нажата, то к вектору добавляем число векторов от нажатия кнопок
		#Для плавного передвижения мы сначала добавляем скольжение умноженное на fps
		velocity += input_vector * ACCELERATION * delta
		#Потом добавляем еще к вектору передвижения скорость
		velocity = velocity.clamped(SPEED * delta)
	else:
		#Если не нажата, то оставляем вектор на нуле
		#Но создаем небольшое ускорение, из-за чего персонаж скользит после окончания передвижения
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#Двигаем персонажа после всех манипуляций
	move_and_collide(velocity)
