Return-Path: <linux-spi+bounces-2807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FF8C24F6
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB61F25751
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2024 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9DB85C7A;
	Fri, 10 May 2024 12:33:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20612C2ED
	for <linux-spi@vger.kernel.org>; Fri, 10 May 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344386; cv=none; b=Z7wMkXU3bSM3DpmL0iZAPwYWz5RSuIAKduc+wJzN7BIKjbTWp4//lx8ad/AvvTt6jYOfWhBuxh3S6S4GD08U3Y71iTxpinYGCjryV4MXg2bjrrwtVyGSwji3WOcXMZVYKrlzPEeuafyxWXP5t8T3W1DBDWzplQ7c6S6wrHruEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344386; c=relaxed/simple;
	bh=p3FXyHOQzqFmoQSnCB5ECR3npK/GsqyfzSxfbFpSGG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmqw9jbuOBmqxMVLZTC/fTT1QMW270RohBsBZN0lxxHOovQ39YuuKvjv3wQ0M2B1dLtHgDp39kATcV4xDt1LG6Ae3kSh+AaJ4hyYP9GdSDjpq8gTLoygJghAr3UW+qT53/1XklpNxp6ZkeW/xNejRrqBYcaxIeUk9h4dC9F9k6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5PQo-0002v4-C6; Fri, 10 May 2024 14:32:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5PQm-000d8e-8G; Fri, 10 May 2024 14:32:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5PQm-001zvV-0V;
	Fri, 10 May 2024 14:32:56 +0200
Date: Fri, 10 May 2024 14:32:56 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: imx@lists.linux.dev, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Fabio Estevam <festevam@gmail.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: Don't expect DMA for i.MX{25, 35, 50, 51, 53}
 cspi devices
Message-ID: <a342h4qn2qkmeimbuanyqh6pxbpqvz7artmodnltcxtbzeo6qn@iyth4xit622f>
References: <20240508095610.2146640-2-u.kleine-koenig@pengutronix.de>
 <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34j2p23xuz2tn5tz"
Content-Disposition: inline
In-Reply-To: <ZjuB1Rjyu1ooYvDi@akranes.kaiser.cx>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--34j2p23xuz2tn5tz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Wed, May 08, 2024 at 03:44:53PM +0200, Martin Kaiser wrote:
> Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):
> > While in commit 2dd33f9cec90 ("spi: imx: support DMA for imx35") it was
> > claimed that DMA works on i.MX25, i.MX31 and i.MX35 the respective
> > device trees don't add DMA channels. The Reference manuals of i.MX31 and
> > i.MX25 also don't mention the CSPI core being DMA capable. (I didn't
> > check the others.)
>=20
> If I'm not mistaken, the imx25 reference manual
>=20
> https://www.nxp.com/docs/en/reference-manual/IMX25RM.pdf
>=20
> does say that CSPI has DMA support. Section 18.1.1 (Features) lists DMA a=
s one
> of the features. There's also DMA events (section 3) for CSPI-1/2/3 RX, T=
X.

Oh indeed. I don't know what made me claim that DMA isn't mentioned in
the reference manual. Maybe I looked at the i2c chapter.

I now did:

diff --git a/arch/arm/boot/dts/nxp/imx/imx25.dtsi b/arch/arm/boot/dts/nxp/i=
mx/imx25.dtsi
index 4a85684deff8..710b28a41bae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx25.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx25.dtsi
@@ -190,6 +190,8 @@ spi1: spi@43fa4000 {
 				reg =3D <0x43fa4000 0x4000>;
 				clocks =3D <&clks 78>, <&clks 78>;
 				clock-names =3D "ipg", "per";
+				dmas =3D <&sdma 8 1 0>, <&sdma 9 1 0>;
+				dma-names =3D "rx", "tx";
 				interrupts =3D <14>;
 				status =3D "disabled";
 			};
@@ -229,6 +231,8 @@ spi3: spi@50004000 {
 				interrupts =3D <0>;
 				clocks =3D <&clks 80>, <&clks 80>;
 				clock-names =3D "ipg", "per";
+				dmas =3D <&sdma 34 1 0>, <&sdma 35 1 0>;
+				dma-names =3D "rx", "tx";
 				status =3D "disabled";
 			};
=20
@@ -257,6 +261,8 @@ spi2: spi@50010000 {
 				reg =3D <0x50010000 0x4000>;
 				clocks =3D <&clks 79>, <&clks 79>;
 				clock-names =3D "ipg", "per";
+				dmas =3D <&sdma 6 1 0>, <&sdma 7 1 0>;
+				dma-names =3D "rx", "tx";
 				interrupts =3D <13>;
 				status =3D "disabled";
 			};

And spi still works. I see an issue, but I think that's orthogonal to
adding DMA. Will send a formal patch when I debugged that.

Thanks for your feedback,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--34j2p23xuz2tn5tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY+E/cACgkQj4D7WH0S
/k6S6Af+NhNWUC65ORkPzGHcNzgRIMATb6fopM3JGyAy5eCkpiyWVOSlyrxzb0RR
99xOYyTzI20zDMcHoNkZB+/1FAW6rogVEUKmxc0XqYgiIqcWl3tvP1ip8bN6FQ3X
3rshJcmcii2Cnl1xjbj5Rj62Bh07WP2mMhLCkoxnp5m9f4bgsHT2OJErmEwfww5H
twVz3fMrUIG4mT5mGqRseX762dS2OGNyxxuuLMQNFTVOutwsrjMYgoV1Bqp4xAWU
AR1g17y/Fka4LTAbt9+g+5vHELOeSqUZVRMoqNCDzYcjelNLZ5r5Zd/Gr7X3TTvd
/8rU3/2/wOy+TbtDjlUE7YXuEvC++Q==
=D8mb
-----END PGP SIGNATURE-----

--34j2p23xuz2tn5tz--

