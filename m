Return-Path: <linux-spi+bounces-5139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF70993F1F
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26A81F21086
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6C416BE2A;
	Tue,  8 Oct 2024 06:26:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F051DD54F
	for <linux-spi@vger.kernel.org>; Tue,  8 Oct 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368782; cv=none; b=Arhu8kyfs/dh5RanU5nt9cnI72LbLKeTWqFe/jv3FTtkHj0VwyoNEe71vRBSOSZkMIs9dGWVTzENGNw0b1T9jSxgnRH4UoLv4/e8BiikIpy8sRriXxQU6ign7JjPgxdL4j9Y/6OjwaPVH8yG8VeVR41UO+Kdz2DrW+gAI7/FMsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368782; c=relaxed/simple;
	bh=lqYaNcqtVepOIuuSpfuiyW0eNbgHanTYGOWQD+Is+4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1xDua4m3m22akD51sTkRu6ogL3azylBv/jMWrklUyV4lGz87VivkbUlDCheKcUPu8mCbR+DzV285jEZnB159EAEBSYSKodWUWzK90ERSwtK+eg1s0TZLhvbYSSxk8d4tViVsqx2tZx7gYeaS5L4YeigFGm9auOZAEERLSyhytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sy3fN-0004R0-TV; Tue, 08 Oct 2024 08:25:53 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sy3fM-000IpO-PL; Tue, 08 Oct 2024 08:25:52 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 61D5B34BC03;
	Tue, 08 Oct 2024 06:25:52 +0000 (UTC)
Date: Tue, 8 Oct 2024 08:25:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: olteanv@gmail.com, broonie@kernel.org, frank.li@nxp.com, 
	shawnguo@kernel.org, imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Subject: Re: Fix Sparse warnings
Message-ID: <20241008-impossible-mysterious-salmon-e1b8bd-mkl@pengutronix.de>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m76gvo6wf7koh3h5"
Content-Disposition: inline
In-Reply-To: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


--m76gvo6wf7koh3h5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.10.2024 11:25:44, Hardevsinh Palaniya wrote:
> Change in v2:
>=20
> in patch 2/2:
> 	- Use ioread32be instead of readl
> 	- Use iowrite32be instead of writel
>=20
> Note: Drop 2 patches(patch 2/4 & 4/4) from the last version
> link to v1: https://lore.kernel.org/linux-spi/20240927132944.19285-1-hard=
evsinh.palaniya@siliconsignals.io/T/#t

Have you checked the code on real hardware or compared the generated
code on the asm level?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--m76gvo6wf7koh3h5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcE0G0ACgkQKDiiPnot
vG+PQAf9GwlhPnZmNolWI3x7cGcC7LjESczq90RAySFHLZRtw1+IFWnou5DVB3p7
LOn04JuUjsqRGikffBKgOkkAQ5VtDEmvxKxSCjQdy6gVtvj1QsT4GZspTKsae1qw
C9BPtuGydIF19+2GVn4pA2WfC+w0q7S3Dt5im+DVFOmpAMzyqPFPXeNddoUKiLi8
COARbxjPm4TP0S1C4B97vpDJH8zy7Y8bTqjljKAWYPvKaxFDlhSNZ6eMjhHLK166
qUQ/tW2mMZP9Db9FSkY2EgzdaxlVziQ4cN0ZKWMZQse1j9KfDIF8dsgx2jv+DwZK
h1CCNkz3t9415KfWBxZ5sYiVcYmHSQ==
=ig3r
-----END PGP SIGNATURE-----

--m76gvo6wf7koh3h5--

