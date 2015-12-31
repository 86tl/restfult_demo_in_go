package main

import (
	"fmt"
	"encoding/json"
	"github.com/astaxie/beego"
	 "gopkg.in/pg.v3"

)

type UserController struct {
	beego.Controller
}

type RelationController struct {
	beego.Controller
}

type Person struct {
	Name string
}

type User struct {
	Id  int64
	Name string
	Type  string
}

type Relationship struct {
	Id  string
	State string
	Type  string
}

type State struct {
	State string
}


func (this * UserController) Get() {
	db :=DbInit()
	users,err := GetUsers(db)
	if err != nil {
        panic(err)
    }
	fmt.Println(users[0])
	this.Data["json"] = users
	this.ServeJson()
	//this.Ctx.WriteString("hello world")
}

func (this * UserController) Post() {
	var p Person
	//fmt.Println(string(this.Ctx.Input.RequestBody))
	err := json.Unmarshal(this.Ctx.Input.RequestBody, &p)
	if err != nil {
		fmt.Println("error:", err)
	}
	//fmt.Println(p.Name)
	db :=DbInit()
	user,err :=GetUser(db,p.Name)
	if err != nil {
        panic(err)
    }
	//fmt.Println(user)
	 this.Data["json"] = &user
    	 this.ServeJson()
}


func (this *RelationController) Get(){
	user_id := this.GetString(":user_id")
	db :=DbInit()
	rela,err :=GetUserRelationship(db,user_id)
	if err !=nil{
		panic(err)
	}
	this.Data["json"] = &rela
	this.ServeJson()
	//this.Ctx.WriteString(user_id)
}


func (this *RelationController) Put(){
	user_id := this.GetString(":user_id")
	target_id := this.GetString(":other_user_id")
	var p State
	json.Unmarshal(this.Ctx.Input.RequestBody, &p)
	db :=DbInit()
	rela,err :=CheckRelationship(db,user_id,target_id,p.State)  // could return err ===> 'pg: no rows in result set'
	fmt.Println("check ")
	fmt.Println(rela.Id)
	fmt.Println(err)
	if len(rela.Id)>0{
		p.State = CheckMatch(db,user_id, target_id, p.State)
		_,err :=UpdateRelationship(db,user_id, target_id, p.State)
		fmt.Println(err)
		fmt.Println("---update---")

	}else{
		p.State = CheckMatch(db,user_id, target_id, p.State)
		_,err =CreateRelationship(db,user_id, target_id, p.State)
		fmt.Println(err)
		fmt.Println("---create---")
	}
	rela,_ =CheckRelationship(db,user_id,target_id,p.State)
	this.Data["json"] = rela
	this.ServeJson()
	this.Ctx.WriteString("6666")
}

func DbInit()(*pg.DB){
	db := pg.Connect(&pg.Options{
		User:"mark",
		Password:"",
		Host:"127.0.0.1",
		Database:"restful_demo",
	})
	return db
}

func GetUser(db *pg.DB, name string) (*User, error) {
    var user User
    _, err := db.QueryOne(&user, `SELECT * FROM "public"."user" WHERE name = ?`, name)
    return &user, err
}

func GetUsers(db *pg.DB) ([ ]User, error) {
    var users [ ]User
    _, err := db.Query(&users, `SELECT * FROM "public"."user" `)
    return users, err
}

func GetUserRelationship(db *pg.DB,id string)([ ]Relationship, error){
	var rela []Relationship
	_, err := db.Query(&rela,`SELECT target_id as id, "state","type" FROM "public"."relations" where user_id=?`,id)
	return rela,err
}

func CheckRelationship(db *pg.DB,id string, target_id string , state string )(*Relationship, error){
	var rela Relationship
	_, err := db.QueryOne(&rela,`SELECT user_id as id, "state","type" FROM "public"."relations" where user_id=? and target_id=? `,target_id, id)
	return &rela,err
}

func UpdateRelationship(db *pg.DB,id string, target_id string , state string )(*Relationship, error){
	var rela Relationship
	_, err := db.QueryOne(&rela,`UPDATE "public"."relations" SET "state"=? WHERE ("user_id"=? and target_id=? ) `, state, target_id , id)
	return &rela,err
}

func CreateRelationship(db *pg.DB,id string, target_id string , state string )(*Relationship,error){
	var rela Relationship
	_, err := db.QueryOne(&rela,`insert into "public".relations  VALUES('7',?,?,?,'relationship')RETURNING id`,  target_id, id, state)
	return &rela,err
}

func  CheckMatch(db *pg.DB,id string, target_id string , state string)(string){

	 rela , _:= CheckRelationship(db,target_id,id,state)  //reverse to find out the peer of the another user
         if len(rela.Id)>0{
		 if state == rela.State &&  state == "liked"{
			 return "matched"
		 }else{
			 return state
		 }
	 }else{
		return state
	 }

}


func main() {

	beego.Router("/users", &UserController{})
	beego.Router("/users/:user_id/relationships/", &RelationController{})
	beego.Router("/users/:user_id/relationships/:other_user_id", &RelationController{})
	beego.Run()
}