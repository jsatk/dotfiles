import $ivy.{
  `org.typelevel::cats-effect:3.1.0`,
  `org.typelevel::cats-core:2.1.1`,
  `io.catbird::catbird-finagle:21.2.0`,
  `com.twitter::finagle-http:22.4.0`
}

import cats._, cats.data._, cats.implicits._, com.twitter.util.Future
import io.catbird.util._
import scala.language.postfixOps
import scala.language.higherKinds
