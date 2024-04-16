Return-Path: <linux-spi+bounces-2379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299F8A713B
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C443F281E00
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D7131750;
	Tue, 16 Apr 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY5zwYD6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661712D741;
	Tue, 16 Apr 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284473; cv=none; b=oaR8gu3ojwp/rIajrU02CFDCk3aGFmcTioScQjO4dEZu1pYXYHgIwBtVngWiNePcrQziYQXsgjB5YPlY2B0Mvg9WPpM+FRogmKfACOevr8Xv3jX6XtbGnpp/QV+eQJ6SOOVg+yvMgjqOxKPYOIr5uQgF0IwVCcMPUyCVFNglPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284473; c=relaxed/simple;
	bh=Ynyr0iwea5McgiqMi6c2+rFFtE1t8OiGRHxweKIbi9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8IkdGf/GwMq8aZpKdW7GMW8qzuDlL3+poYWKqa7k2u1pn/DD1KsW1CKLU65Aa21vj7pynZT3fbKdRAj9fpcXJq1nmqwQKXbPgisNf2k1R7Q8tXYdtiZNPtlNVvE7sZN1cgTIwTdbpRcvYZWeHEYTUy2OuYL2ZAEBCx5I943cOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY5zwYD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2286C113CE;
	Tue, 16 Apr 2024 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713284472;
	bh=Ynyr0iwea5McgiqMi6c2+rFFtE1t8OiGRHxweKIbi9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY5zwYD6JLWRAjdwOWCqGTX5s17x3u7/IUn3wY1lMsnwH+N71Tj3TzDpHa2mVOFVS
	 rX0Sw8DnZeuo6ZCxmRMyr6eTX/dy8hFeSCynGP5z8l2+MMzUkfrWhbRsnMsJHeCNuS
	 Z4IialeBqloZD1pQz/zYcIZ/lFUnT69aaiOF9BbV3gfiBHm1ukpNbF4QNm4Y6y5WFC
	 ZK9gq0LYGwI4GeRJTyk+sOxWgcxIHWUUZDIZeY9WPsrBSO8G9SgMLqeZnIpjVquQgz
	 yXExwhE1rR3Y9JN4MjH7gEg3xuoVKzmhBGCJ/gsgBfKBcxc8nb2LMS6moNwkanFrXr
	 51/uulMJH9yxw==
Date: Tue, 16 Apr 2024 17:21:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH dt-bindings] spi: renesas,sh-msiof: Add r8a779h0 support
Message-ID: <20240416-carry-bountiful-0bb0c8ca7a4f@spud>
References: <68a4d8ad8638c1133e21d0eef87e8982ddea3dd8.1713279687.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T5ms7aKmqXv6UbMZ"
Content-Disposition: inline
In-Reply-To: <68a4d8ad8638c1133e21d0eef87e8982ddea3dd8.1713279687.git.geert+renesas@glider.be>


--T5ms7aKmqXv6UbMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:11:48PM +0200, Geert Uytterhoeven wrote:
> Document support for the Clock-Synchronized Serial Interface with FIFO
> (MSIOF) in the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Odd $subject :)

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml =
b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index 00acbbb0f65dcf57..49649fc3f95af971 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -54,6 +54,7 @@ properties:
>                - renesas,msiof-r8a779a0      # R-Car V3U
>                - renesas,msiof-r8a779f0      # R-Car S4-8
>                - renesas,msiof-r8a779g0      # R-Car V4H
> +              - renesas,msiof-r8a779h0      # R-Car V4M
>            - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
>                                              # compatible device
>        - items:
> --=20
> 2.34.1
>=20
>=20

--T5ms7aKmqXv6UbMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6ldAAKCRB4tDGHoIJi
0iNqAQCWCOimj0kgeVPlJ2UoO4vDt8rclYzhwHsQ5UnGDzpZrAD+NdXAdHOM4b1e
+C5hM8uoUu9+hq4HZiHnAtdkM3m1jAk=
=JJNn
-----END PGP SIGNATURE-----

--T5ms7aKmqXv6UbMZ--

