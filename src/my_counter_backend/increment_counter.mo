import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor Counter {
 type HttpRequest = {
    body: Blob;
    headers: [(Text, Text)];
    method: Text;
    url: Text;
};

type HttpResponse = {
    body: Blob;
    headers: [(Text, Text)];
    status_code: Nat16;
};


    stable var currentValue: Nat = 0;

    public func increment() : async () {
        currentValue += 1;
    };

    public query func get() : async Nat {
        currentValue
    };

    public func set(n: Nat) : async () {
        currentValue := n;
    };

    public query func http_request(arg: HttpRequest) : async HttpResponse {
        let responseBody = "<html><body><h1>Current Count: " # Nat.toText(currentValue) # "</h1></body></html>";
        let response: HttpResponse = {
            body = Text.encodeUtf8(responseBody);
            headers = [("Content-Type", "text/html")];
            status_code = 200;
        };
        return response;
    }
}
