from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, password, **extra_fields)

class User(AbstractBaseUser):
    email = models.EmailField(unique=True)
    name = models.CharField(max_length=50)
    location = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    
    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name', 'location']

    def __str__(self):
        return self.name

    
class State(models.Model):
    state_name = models.CharField(max_length=50)
    direction = models.CharField(max_length=50)

    def __str__(self):
        return self.state_name
    
class Place(models.Model):
    place_name = models.CharField(max_length=100)
    state = models.ForeignKey(State, related_name='places', on_delete=models.CASCADE)
    story = models.TextField()
    image1 = models.ImageField(upload_to='media/')
    image2 = models.ImageField(upload_to='media/')
    image3 = models.ImageField(upload_to='media/')
    
    def __str__(self):
        return self.place_name + "in" + self.state.state_name

class hist_back(models.Model):
    place = models.ForeignKey(Place, related_name='histories', on_delete=models.CASCADE)
    head = models.TextField()
    info = models.TextField()

    def __str__(self):
        return "History of" + self.place.place_name
    
class Nearby_Place(models.Model):
    placename = models.CharField(max_length=100)
    main_place = models.ForeignKey(Place,related_name='nearby_places', on_delete=models.CASCADE)
    desc = models.TextField()

    def __str__(self):
        return self.placename + " nearby " + self.main_place.place_name




