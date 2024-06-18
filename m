Return-Path: <linux-spi+bounces-3439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C290D8C9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467E91F24CDE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4F145341;
	Tue, 18 Jun 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taJAruR1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A9142652;
	Tue, 18 Jun 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727112; cv=none; b=F6WSLWHhECaZieihFn9dwtSR8WGmB01MJ/FdGRTHqzRdG494KicEsR2202jmvMrJB5I/cLjCJgq4SSWvo28nrw6ZqSrwc8nJ5EDniL3FBoZILFs4Fj9yQ25L+McxxMcfH++aeAn1dp4vA+/JHTIpNQYaGMyQoltx8z5EeFdNnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727112; c=relaxed/simple;
	bh=+eJ/D0My0YrU0w5PvL3S5QzVlmK+i5KwqfGDEFVVvM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf3NhAPKVPaIpQEdtRZDrIlZwtP6/DbQuUfsQSuiWn7uGNQnUBiyyVU5KNn5pBeC9oScx1CZDpEXaMmHgjWhf/hSzx8PFdJMECrGGMHnpSTBuDdtfA57TQuEwFuHXZUBqd9DbUuXLNb2/aW3cfbWdWEmLPP4jSDUbxCOhv+WKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taJAruR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E488C4AF1D;
	Tue, 18 Jun 2024 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727111;
	bh=+eJ/D0My0YrU0w5PvL3S5QzVlmK+i5KwqfGDEFVVvM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taJAruR1igm0wIms3Y2t513NyvzD6NWtt0gBrxs24PUhmhc8X4IZt26mpy92Ez4/W
	 ieD6Ol0OK6TrBiL8W+DkFPNscrlS949GFrqlH4XehNm8xiLUSuvqcQofO2nCvyEvdb
	 pWOzFMkrUJzhDcS13EoJ8pMGS1mu9bzr4faqela120Nl74JkZFIB7h8EoiZpJ+I9CK
	 sYN+2wpjHgPw3ZEydhiG9FfONkZRaINhWY5OA45s6bc4iV7Qb7zfah5e5ZYVBOKW9K
	 ct+AMt0odzZerJGnjojq5F592LP6Rii39lDcj0R+FkN5DpPnrRjRrTIi2t+t91wrIG
	 1KK3zXzoL3KvA==
Date: Tue, 18 Jun 2024 17:11:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stefan Moring <stefan.moring@technolution.nl>,
	Adam Butcher <adam@jessamine.co.uk>,
	Benjamin Bigler <benjamin@bigler.one>,
	Fabio Estevam <festevam@gmail.com>, s.hauer@pengutronix.de,
	linux-kernel@vger.kernel.org, Stefan Bigler <linux@bigler.io>,
	linux-spi@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>,
	Clark Wang <xiaoning.wang@nxp.com>, linux-imx@nxp.com,
	kernel@pengutronix.de, Sebastian Reichel <sre@kernel.org>,
	shawnguo@kernel.org, Carlos Song <carlos.song@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <00ea22f4-8c39-4f82-81f7-e76a87ace559@sirena.org.uk>
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
 <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
 <CAB3BuKDcg=7Umxv4yUTDVsQ3X_ash6iFmz-3XaENfni2=R_LCw@mail.gmail.com>
 <20240618-oxpecker-of-ideal-mastery-db59f8-mkl@pengutronix.de>
 <20240618-mature-private-peccary-29f0b6-mkl@pengutronix.de>
 <cd8d89d3-c304-4eb6-897f-b423e8196ef2@sirena.org.uk>
 <20240618-prehistoric-amphibian-firefly-a9b2d2-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3/054iokxb+MZLWU"
Content-Disposition: inline
In-Reply-To: <20240618-prehistoric-amphibian-firefly-a9b2d2-mkl@pengutronix.de>
X-Cookie: If you can read this, you're too close.


--3/054iokxb+MZLWU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2024 at 06:06:02PM +0200, Marc Kleine-Budde wrote:
> On 18.06.2024 17:02:22, Mark Brown wrote:

> > A single revert should be fine and is probably clearer.

> thanks for your quick answer. What about the Fixes-tag? Just the
> original patch?

> Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")

Either way should be fine there, so long as the original patch is
mentioned.  It shouldn't do any harm to mention the others too though.

--3/054iokxb+MZLWU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZxscAACgkQJNaLcl1U
h9BpCQgAgdiR6LCgZnD2PI6txPPzp9lfR7j/2BH43uvbUWFcKLL8bpzBjOBQx3Tk
g9zDIXOskYqXzdn7+y/60gQWBvvVw+l6w5DTo1I65RUVTcPowJAbOrBLPSZPmdqw
od40BS97CUhRgYk/OITELvj+GoUXND7Lhxy7ZtPrEJkUO+yvUkwQqdda7PQCTr5D
9zrW4uKvaGDl66QpvmzLYE37Ih3j+Jn21z4nMZMvDTQmTT8zDAv+QlYLzR2jfpFJ
fV0bNOWdmRRWicyM6T9jjao6N3fYnt3V47WslRkgOhm9RENEAXZw7ssTFLuF4v0N
vHzDfHV3R03Moxymk4PoxzhokqWtcw==
=HoFk
-----END PGP SIGNATURE-----

--3/054iokxb+MZLWU--

