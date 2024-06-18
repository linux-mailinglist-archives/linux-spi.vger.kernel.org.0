Return-Path: <linux-spi+bounces-3435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A641290D7F2
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4331F233F3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189EF48788;
	Tue, 18 Jun 2024 16:00:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864046B91
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726406; cv=none; b=hUUDcftUbiBALoNC20tH38EYlGBItilCBB3nGYQM6QK+pXrhczaMvGBlt+OnAiKX33Uh4JVS5xeFpg7hVcjpO03hYJbKGFUrxvGpP/JvPk4krCmrZcQ2aKQV66uVQK5aum2Hau0cecL3arpF0o9vSHV6hxYqd2PW8dfMvrWknUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726406; c=relaxed/simple;
	bh=YfmNsKQrdFIhymJvhNwj8WBsPYQaKjuSTOSBbLkNdP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItuOPm99Wl1K0ZELk1cKublBJltWUh/UlAUOurlgcGItpYFBagJZdPUX6fYmL8Bm1EoIVXISG9o17yUhXnj873xhS33aqgjAYa0GyTjDLlCn8BmTIFi7e4C2ilIdSEsQKkcC6JfXXZcXEloyTn8so7HSw6WPJDl+AtUkXfSvvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJbFF-0001yh-AL; Tue, 18 Jun 2024 17:59:41 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJbFB-003GHr-2h; Tue, 18 Jun 2024 17:59:37 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B828E2EB9D2;
	Tue, 18 Jun 2024 15:59:36 +0000 (UTC)
Date: Tue, 18 Jun 2024 17:59:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan Moring <stefan.moring@technolution.nl>
Cc: Adam Butcher <adam@jessamine.co.uk>, 
	Benjamin Bigler <benjamin@bigler.one>, Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de, 
	linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>, linux-spi@vger.kernel.org, 
	Thorsten Scherer <T.Scherer@eckelmann.de>, broonie@kernel.org, Clark Wang <xiaoning.wang@nxp.com>, 
	linux-imx@nxp.com, kernel@pengutronix.de, Sebastian Reichel <sre@kernel.org>, 
	shawnguo@kernel.org, Carlos Song <carlos.song@nxp.com>, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <20240618-mature-private-peccary-29f0b6-mkl@pengutronix.de>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
 <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
 <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5dplvlwecvagwxu"
Content-Disposition: inline
In-Reply-To: <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--z5dplvlwecvagwxu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2024 13:58:07, Marc Kleine-Budde wrote:
> Hi Stefan,
>=20
> On 28.06.2023 15:20:39, Stefan Moring wrote:
> > In our application we send ~80kB at 10MHz. The total transfer time
> > went from ~80ms to 67ms, so that would be a reduction of 15%.
> > I tested it on an IMX8MM platform.
>=20
> I'm currently debugging a problem with spi-imx, HW CS and SPI_CS_WORD on
> torvalds/master. The breakage goes back this patch.
>=20
> I'm wondering what is your setup you have optimized with this patch?
> - Are you using HW or GPIO CS?
> - What are bits_per_word?
> - What's the length of the spi_transfer?
>=20
> I'm asking because with a 8, 16 or 32 bit-per-word setting, the driver
> should use dynamic_burst on the imx8mm, which will overwrite the burst
> length in spi_imx_push().

This patch, even with all the fixes on top of it (torvalds/master)
breaks the HW CS + SPI_CS_WORD support which was added in 6e95b23a5b2d
("spi: imx: Implement support for CS_WORD").

I think this also breaks the support for bits-per-word !=3D multiple of 8
bits. For these transfers the in-memory wordsizes are powers of two
bytes (e.g. 20 bit samples use 32 bits) [1] and via the burst length
configuration only the bits-per-word number of bits are shifted out.

[1] https://elixir.bootlin.com/linux/v6.9/source/include/linux/spi/spi.h#L1=
44

| 	if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
| 		ctrl |=3D (spi_imx->target_burst * 8 - 1)
| 			<< MX51_ECSPI_CTRL_BL_OFFSET;
| 	else {
| 		if (spi_imx->usedma) {
| 			ctrl |=3D (spi_imx->bits_per_word - 1)
| 				<< MX51_ECSPI_CTRL_BL_OFFSET;
| 		} else {
| 			if (spi_imx->count >=3D MX51_ECSPI_CTRL_MAX_BURST)
| 				ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
| 						<< MX51_ECSPI_CTRL_BL_OFFSET;
| 			else
| 				ctrl |=3D (spi_imx->count / DIV_ROUND_UP(spi_imx->bits_per_word,
| 						BITS_PER_BYTE) * spi_imx->bits_per_word - 1)
| 						<< MX51_ECSPI_CTRL_BL_OFFSET;
| 		}
| 	}

Consider a message with bits-per-word =3D 9 consisting of 4 words. It uses
4 word x 2 bytes/word =3D 8 bytes of memory. This boils down to a burst
length of 36 bits. Which means the spi-imx sends the first 36 bits from
the 64 bits of memory, this is clearly wrong.

This patch (15a6af94a277 ("spi: Increase imx51 ecspi burst length based
on transfer length")) is wrong and the 4 fixes on top of it don't
finally fix it. I can send a series of 5 reverts, or a manually revert
the burst length calculation to the original value in one patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z5dplvlwecvagwxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZxruQACgkQKDiiPnot
vG8H1Qf8CsAhg/kHYuztF587L2y+5Kn+hX4YQkorzpboDrGh93rN0zZmV2a1Cw4G
aqIitN+nIH3W2ITT6s4fKv4tW8+oO+FWHmL3ZIHEXlY/sJAOC4X6c7lfcKynyIxP
Hnv9+wSrx0ybmW4rbQeRhJNNMSVNfgR/Lde0YxxJV4QgnT+94bhJqpdLL1tcYzEB
37YolPA/fWxx/pgoowkEwkUqnWtE/jrVTmObZ8+XXD+6BQvsBWtwiobF6cNisX1l
QdlpDXUB+CGbNKrvIeVrSbTj9sG0AX/UFhDkS1USKwM/YC75r7oRVk53st6qTfm9
2MA/LgwpCmUJvutqlWat0uB3PCNycQ==
=2b2U
-----END PGP SIGNATURE-----

--z5dplvlwecvagwxu--

