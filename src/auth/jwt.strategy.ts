import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Request } from 'express';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(private prisma: PrismaService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET || 'your-secret-key',
    });
  }

async validate(payload: any) {
  console.log('JWT Payload:', payload);
  const user = await this.prisma.user.findUnique({ where: { email: payload.email } });
  if (!user) {
    throw new UnauthorizedException();
  }
  return { id: user.id, email: user.email, username: user.username };
}
}