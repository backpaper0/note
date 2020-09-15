# SpringでOpenID Connect

認可後のリダイレクトを受け取って処理するクラス。
これがSpring Securityでの認証処理になる。

- `org.springframework.security.oauth2.client.web.OAuth2LoginAuthenticationFilter.OAuth2LoginAuthenticationFilter`
- `org.springframework.security.oauth2.client.oidc.authentication.OidcAuthorizationCodeAuthenticationProvider`
    - `org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient`でアクセストークン・IDトークンの取得を行う
    - `org.springframework.security.oauth2.jwt.JwtDecoder`でIDトークンの検証を行う
    - `org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService`で必要に応じてUserInfo Endpointへアクセスする


`org.springframework.security.oauth2.client.RefreshTokenOAuth2AuthorizedClientProvider`でアクセストークンをリフレッシュしている。
これは`org.springframework.security.oauth2.client.web.method.annotation.OAuth2AuthorizedClientArgumentResolver`から呼ばれている。
