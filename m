Return-Path: <linux-spi+bounces-8868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04478AECE99
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 18:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBAD1726D2
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCE2376EB;
	Sun, 29 Jun 2025 16:19:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452E2367CB
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751213958; cv=none; b=PtIAY37JalxPZN7nyXJVEjoUxv62GFGyOS571avwd2kHQ8iIhpG13qBubTr9/zEouJYZgEc8Ln6t0uCMtjiInhENQY4U2Ve18Ppv0DxIbJUGuECwXqijxT+KSREggW+WDI0om4psbQTVkEjjkbzj2QLgw4WAv2jFCddghbzVsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751213958; c=relaxed/simple;
	bh=0PBv07EZ1n/g11csDhwzTSiHjAG/M37i27Cl0Q9EP50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIgCqLBu+egzlteuZUe5ftQgjMLsuXmqG6nvUO4CL1qnOWtQHjYn8EjpJyXXgQ1jpZv6OY1lz285kwjDTNbTAqa9kCZHB7MB61A6ZfydOh2xtnizm7fRQZOwvul/8Xq3AUqfHbcMCtzfTmYJ7W6Z821s18GOD1V0EUvGYB/58jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uVukB-0006vk-0X; Sun, 29 Jun 2025 18:19:03 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uVukA-005xre-2Q;
	Sun, 29 Jun 2025 18:19:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2E86E433556;
	Sun, 29 Jun 2025 16:18:57 +0000 (UTC)
Date: Sun, 29 Jun 2025 18:18:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH next v2] spi: Raise limit on number of chip selects to 24
Message-ID: <20250629-mysterious-violet-boobook-0b0aee-mkl@pengutronix.de>
References: <20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikx3hyymrh2hqla5"
Content-Disposition: inline
In-Reply-To: <20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--ikx3hyymrh2hqla5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH next v2] spi: Raise limit on number of chip selects to 24
MIME-Version: 1.0

Hello Mark,

I accidentally send this twice, resulting in a v2. They v1 and v2 are
the same. Sorry.

Covering under a brown paper bag,
Marc

On 29.06.2025 18:15:32, Marc Kleine-Budde wrote:
> We have a system which uses 24 SPI chip selects, raise the hard coded
> limit accordingly.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://patch.msgid.link/20250629-spi-increase-number-of-cs=
-v1-1-df791bf4b370@pengutronix.de
> ---
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4789f91dae94..e9ea43234d9a 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -21,7 +21,7 @@
>  #include <uapi/linux/spi/spi.h>
> =20
>  /* Max no. of CS supported per spi device */
> -#define SPI_CS_CNT_MAX 16
> +#define SPI_CS_CNT_MAX 24
> =20
>  struct dma_chan;
>  struct software_node;
>=20
> ---
> base-commit: 3e36c822506d924894ff7de549b9377d3114c2d7
> change-id: 20250627-spi-increase-number-of-cs-deeb23bcd578
>=20
> Best regards,
> --=20
> Marc Kleine-Budde <mkl@pengutronix.de>
>=20
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ikx3hyymrh2hqla5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhhZ2kACgkQDHRl3/mQ
kZxKZAf+PNJUHM5aCUdDcEc55AUltAOpfVXEUhsz9inIGn3Y2Ethyr7l7+a6eaB+
jW2ARpx1HdQMcQoy5lXPc+OtSBgX42+iJ61c46cLTbBmbiEzzTxBi4nt+yaFwM5c
y0NLBJosZfr2ngb25498YySpEk5tC6YMQx+9i2plAWuO2fPjFQmeIKM+XtMoTvP2
ZT+Bqd70RY+4Og1BNY4oA0kFnjy3xeXTkNid/EQdybwsu0jXuqyJ2BiJzvSVnKWp
y+tu0e8ysv4S0GleO7gMLEyWi6564b697VwerujW++XtJ3PV5/VfMMIWMpy+6G7q
Em5VVvO4SkFT0idj/GyViCMBaMr9Vg==
=YbsX
-----END PGP SIGNATURE-----

--ikx3hyymrh2hqla5--

