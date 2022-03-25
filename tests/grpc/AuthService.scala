import scala.concurrent.Future
import io.grpc.{ServerServiceDefinition, Status}
import _root_.auth.*

final class AuthService extends AuthServiceGrpc.AuthService:
  override def signIn(req: SignInReq): Future[SignInResp] = ???
