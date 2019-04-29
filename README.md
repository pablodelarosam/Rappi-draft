# Rappi - Test  


Patrón de arquitectura: MVC

Patrones de comunicación utilizados: Delegate y Notifications

1. Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y
qué clases pertenecen a cual.
2. La responsabilidad de cada clase creada.

La aplicaciòn tiene capas de:

Vista: Todas las interfaces con las que el usuario tiene interacciòn, las clases que involucran dicha capa son: MenuBar, MediaCollectionViewCell, MediaDetailViewController y TrailerViewController
Lógica/Negocio: Donde se establecen todas las reglas que deben cumplirse, las clases involucradas son MoviesCollectionViewController, MediaGenericCell, SeriesCell
Persistencia: Ya que se usa almacenamiento local con Core Data para mantener la aplicaciòn en modo offline, en esta capa usamos la clase DatabaseConnector, y tambien existe persistencia mediante una base de datos en la nube gracias a que usamos una API para conectarnos con dicha base de datos, la clase que se encarga de hacer dicha comunicación es la clase NetworkingClient, y también los modelos de datos  que involucran las clases de : Media, Genre, MediaCategory, Video


3. En qué consiste el principio de responsabilidad única? Cuál es su propósito?
    Es un principio que establece que cada clase solo tiene una única responsabilidad, el propósito de este principio es tener clases, componentes de software y microservicios que son fáciles de entender e implementar y ademàs de preveer efectos inesperados por cambios en un futuro

4. Qué características tiene, según su opinión, un “buen” código o código limpio
    Un buen código es aquel que es capaz de extender su funcionalidad sin necesidad de cambiar el actual código, ademàs de que es fácil de reutilizar, dar mantenimiento y testear
