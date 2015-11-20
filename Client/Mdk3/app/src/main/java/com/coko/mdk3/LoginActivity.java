package com.example.user.mdk3;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.user.mdk3.utility.SessionManager;

import java.util.HashMap;
import java.util.Map;


public class LoginActivity extends AppCompatActivity {

    private static final String TAG = "loginActivity";
    private EditText nameEditText, passwordEditText;
    private Button loginButton;
    private TextView linkSignupText,nameErrorMessageText,passwordErrorMessageText;

    SessionManager session;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        session = new SessionManager(getApplicationContext());

        nameEditText = (EditText) findViewById(R.id.input_name);
        nameErrorMessageText = (TextView) findViewById(R.id.name_warning_message);
        passwordEditText = (EditText) findViewById(R.id.input_password);
        passwordErrorMessageText = (TextView) findViewById(R.id.password_warning_message);
        loginButton = (Button) findViewById(R.id.login_btn);
        linkSignupText = (TextView) findViewById(R.id.link_signup);


        loginButton.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View view){
                login();
            }
        });

        linkSignupText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(LoginActivity.this, SignUpActivity.class);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();

        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void login(){

        final String name = nameEditText.getText().toString();
        final String password = passwordEditText.getText().toString();

        if(!validate(name, password)){
            loginButton.setEnabled(true);
            return;
        }

        loginButton.setEnabled(false);

        final ProgressDialog progressDialog = new ProgressDialog(LoginActivity.this,R.style.AppTheme);
        progressDialog.setIndeterminate(true);
        progressDialog.setMessage("Authenticating...");
        progressDialog.show();

        new Handler().postDelayed(
                new Runnable(){
                    public void run(){
                        progressDialog.dismiss();
                        executeLogin(name,password);
                    }
                },3000
        );
    }

    public boolean validate(String name, String password){
        boolean isValid = true;

        if(name.isEmpty()){
            isValid = false;
            nameEditText.setError("This field is mandatory");
        }
        else{
            nameEditText.setError(null);
        }
        if(password.isEmpty()){
            isValid = false;
            passwordEditText.setError("This field is mandatory");
        }else{
            passwordEditText.setError(null);
        }

        return isValid;
    }
    public void executeLogin(String name, String password){
        boolean isSuccess = true;
        // TODO : Implement authentication through firebase
        // isSuccess = callService()

        if(isSuccess){
            Map sessionMap = new HashMap();
            sessionMap.put("nama",name);
            sessionMap.put("nik",password);
            session.setLoginSession(sessionMap);

            Intent intent = new Intent(LoginActivity.this, MainActivity.class);
            startActivity(intent);
        }else{
            Toast.makeText(getApplicationContext(),"Login Failed", Toast.LENGTH_LONG).show();
        }

    }
}
