package anx

trait Functor[F[_]]:
  def map[A, B](fa: F[A])(f: A => B): F[B]

trait EitherInstances:
  def defaultFunctorForEither[X]: Functor[[A] =>> Either[X, A]] =
    new Functor[[A] =>> Either[X, A]]:
      def map[A, B](fa: Either[X, A])(f: A => B): Either[X, B] =
        fa.map(f)
