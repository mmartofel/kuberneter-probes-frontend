import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { User } from './user';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable()
export class UserService {

  private usersUrl: string;
  private usersAddUrl: string;

  constructor(private http: HttpClient) {
    // this.usersUrl = 'http://localhost:8080/person/list';
    // this.usersAddUrl = 'http://localhost:8080/person/add';
    this.usersUrl = environment.userListURL;
    this.usersAddUrl = environment.userAddURL;
  }

  public findAll(): Observable<User[]> {
    return this.http.get<User[]>(this.usersUrl);
    console.log("service called");
  }

  public save(user: User) {
    return this.http.post<User>(this.usersAddUrl, user);
  }
}
