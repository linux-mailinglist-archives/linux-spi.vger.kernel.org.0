Return-Path: <linux-spi+bounces-3426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DB90CAF2
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85C51F24761
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281A15574D;
	Tue, 18 Jun 2024 11:58:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143FC15573B
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711911; cv=none; b=mhV3h7oyLW1sdbleyz0TI7+T57B/zKnS4vtsOjMejnENrqt+xo8x2jLycKrR2pwVwnZDXkGsQeWJiyd+gAt1W1fNJ+eGCkWcjabnh4VGiFVGbF1ca9CBnMPijK9qYkkrHtHtCFQ4MNdezRXGB4j9lDkZDcYNsqsibPWA6YEaWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711911; c=relaxed/simple;
	bh=UYYaytc/6tmQBr/uhwIaBms+nVRmRGlyzlpUHUR1Fmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCCn3ea899IE8WlFBOV2MS0U8aTFohvGlhqKpVeccqZDxYkj0IvvyR8Zee4muWjkm2iHeyuNI+3xQIz6VfSUZIhZvXs0f2QM+o+zuDngBYEWbBOmy8pHAiR/8HpVtuh2VPpVDz1LpHc50+NC1xCUO2W0UBO+gbAlQuutg9ui0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJXTV-0007Go-Lq; Tue, 18 Jun 2024 13:58:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sJXTT-003Ddk-OE; Tue, 18 Jun 2024 13:58:07 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5EE1F2EB692;
	Tue, 18 Jun 2024 11:58:07 +0000 (UTC)
Date: Tue, 18 Jun 2024 13:58:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan Moring <stefan.moring@technolution.nl>
Cc: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Sebastian Reichel <sre@kernel.org>, 
	Benjamin Bigler <benjamin@bigler.one>, Stefan Bigler <linux@bigler.io>, 
	Carlos Song <carlos.song@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Adam Butcher <adam@jessamine.co.uk>, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
 <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocrhnp3rrb37wajs"
Content-Disposition: inline
In-Reply-To: <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--ocrhnp3rrb37wajs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On 28.06.2023 15:20:39, Stefan Moring wrote:
> In our application we send ~80kB at 10MHz. The total transfer time
> went from ~80ms to 67ms, so that would be a reduction of 15%.
> I tested it on an IMX8MM platform.

I'm currently debugging a problem with spi-imx, HW CS and SPI_CS_WORD on
torvalds/master. The breakage goes back this patch.

I'm wondering what is your setup you have optimized with this patch?
- Are you using HW or GPIO CS?
- What are bits_per_word?
- What's the length of the spi_transfer?

I'm asking because with a 8, 16 or 32 bit-per-word setting, the driver
should use dynamic_burst on the imx8mm, which will overwrite the burst
length in spi_imx_push().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ocrhnp3rrb37wajs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZxdkwACgkQKDiiPnot
vG+b8gf/Ycf4ZA92Vtp4bY6hGmJ8uRZ4rSh9e85QeMtTSPs54TIAAoXvWJDcfUSt
tS/ykcZm12NF0OaFV7GGs6q9Uz9Ps6na861RELcOB4Ct5tv2DYsHpjlGrnRm2Olb
MYoJ7RHyAgIdazeHNj64i+onbqwatnEezvrXE7vHQDTKEFDNxnfKmkVZbGOYKng9
Csv0uq6IoE/Q1jcfOulsgHQJGamXjDWeMQlCe3gIB+IP79eCI1QQElL+Lkh0sL2z
guzekqIkk97cv1jDJwY44lWRZXBcuVKXoR9jz2ui1TALXdfs3Q8CehpkEOo8lBjF
U0ohNqg8BfGBfnmT6UkqDr+81Iv5nQ==
=A6Kf
-----END PGP SIGNATURE-----

--ocrhnp3rrb37wajs--

