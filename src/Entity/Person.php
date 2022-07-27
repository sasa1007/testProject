<?php

namespace App\Entity;

class Person
{
    private ?string $name;

    private ?string $lastName;


    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): Person
    {
        $this->name = $name;
        return $this;
    }


    public function getLastName(): ?string
    {
        return $this->lastName;
    }

    public function setLastName(?string $lastName): Person
    {
        $this->lastName = $lastName;
        return $this;
    }





}