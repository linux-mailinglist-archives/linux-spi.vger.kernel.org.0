Return-Path: <linux-spi+bounces-7597-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913E1A899D1
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CE116973C
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96127FD68;
	Tue, 15 Apr 2025 10:21:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367828B51D
	for <linux-spi@vger.kernel.org>; Tue, 15 Apr 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712466; cv=none; b=QgMsYEx8TAgj/NHAi4oiaP0xRaxwEMBAknFwjx8eRReA+gFssuTJ4xgOO5mZ9jm5zjOmtou2kR8kfeAFMKTkLnfAYipqnBIEBksFSc1bfZdCAHiG8HBU3Aw3+s16ZLq+Oz6RyAY8rr0w5cXnvAlX7THB/f+N78kVdLCTIuifNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712466; c=relaxed/simple;
	bh=ysjcld4I1d/TEaaccvq+g9ufZqs0JEJ/wvx67sEcKBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPSHqWrN2GZyn2Dkhmx3bw7bK4CP/KN/WhiL4X3S01WhM6xOmvFcrs8U32XYwbuR9X0LNv6EZHAzeNNg0lx9nbeXPQO9MrEFf5j6HgAUG82RyxyHxQkQBRmmxaquZWALMlYMj3C4lHAvfOE4IQuAbdJNM1UmDT1MvHpOA0mBZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dPD-0004Ii-B1; Tue, 15 Apr 2025 12:20:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dPC-000P2J-0G;
	Tue, 15 Apr 2025 12:20:38 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A99013F9BB4;
	Tue, 15 Apr 2025 10:20:37 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:20:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remove RZ/N1S bindings
Message-ID: <20250415-glittering-dangerous-coati-1c90b1-mkl@pengutronix.de>
References: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sc425bfm6fmj3k36"
Content-Disposition: inline
In-Reply-To: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--sc425bfm6fmj3k36
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: remove RZ/N1S bindings
MIME-Version: 1.0

On 11.04.2025 21:47:57, Wolfram Sang wrote:
> Except for these four quite random bindings, no further upstream
> activity has been observed in the last 8 years. So, remove these
> fragments to reduce maintenance burden.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sc425bfm6fmj3k36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmf+MvIACgkQDHRl3/mQ
kZzTpQgAlPTcKlZ2xk6+ME/4NOQ2N/EBzvg7QNZBqJfusX9dxxdc0o4dklimbHdf
epiZ9f5sw+DLcWQxm4Ll7LB/jzW4XyMC+lZkS57AiOSpCCuLMunyjhld7Nv/3Q7+
PsHh0sBe7xvdxw1f3vLL0+nmG9TS3SosuqUZZMczwmN0Q6fPcUMEBN5W+X7+MIvM
3NghO/IjopmjQiDZSveHzXCpLuW/JRQOSUpad9+Fuyh1T4In4mBrPCQ/JtyFNGSk
QzTN8PYPuiT2xDQ5CRTm9PKr9Do9XRc+JAYSUdt5F3MV5XVfuG3ouBnoXVnkkCM0
lufydvGLYi+EcDGT/so8Kc7TSirIrg==
=erlw
-----END PGP SIGNATURE-----

--sc425bfm6fmj3k36--

