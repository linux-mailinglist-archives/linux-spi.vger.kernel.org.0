Return-Path: <linux-spi+bounces-126-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E43803344
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33462B20331
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D96B241F5;
	Mon,  4 Dec 2023 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YC/77p42"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024161EB32
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 12:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F9AC433C9;
	Mon,  4 Dec 2023 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701693827;
	bh=R2mVKL69Z+39BJMZbWbETYTrgi09qrmbgDEFiYTMgiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YC/77p42uDHsv4IjxoGojiLOw6jb2W4fPGez4fTv1gKw15Uc2RmfpdAwscSHRiYVB
	 4KB7Py3EvlS42Yl5sSuc4iRrnxBpNQatqOadYxiigjyMh5DMLERJ/JFom2mJM8ncJ4
	 wYCJc5jY4YhKziu6yqridLJ2p7v3ajuDQRpSlrll9HYP2bWzpRPnEoquG1xMoGX7tb
	 FdrsoBH7woWmK+dC6mo8HFy1kxToT7d5YGdOds9Q7EbUqfxW3XvTH21BBenT9qv+jo
	 wrkPRAbQLhfX/n5CjGliwoi7V620wtJrn088z4oxAC006RXE1OeBT1IQO/O4zCLBSa
	 Fy17YlIQiHmgw==
Date: Mon, 4 Dec 2023 12:43:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <9aa5e049-bd1c-41a6-b9b8-037ebb4f54b8@sirena.org.uk>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
 <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
 <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kx4ZGGc8DcXvnXpO"
Content-Disposition: inline
In-Reply-To: <ZWpoKEcM0ZeYAsBa@dell-precision-5540>
X-Cookie: For office use only.


--Kx4ZGGc8DcXvnXpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 06:11:36PM -0500, Ben Wolsieffer wrote:
> On Fri, Dec 01, 2023 at 09:50:33PM +0000, Mark Brown wrote:
> > On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:

> > This feels like it'd be a good fit for moving to runtime PM - that way
> > we avoid bouncing the controller on and off between messages which is
> > probably better anyway.  The driver already does pinctrl management for
> > the device there.

> Yes, that probably makes sense. There are a few bits that can only be
> configured while the controller is disabled, but it doesn't look like
> that applies to any of the ones set in stm32_spi_prepare_msg().

> I'm a little hesitant to make big changes to the driver since I can only
> test them on an STM32F7 though.

It doesn't seem much more complex than what you're already proposing.

> > It also occurs to me that this isn't going to work for devices which
> > chip select inverted - for them we can't stop driving chip select at all
> > since they need it held high when idle.  There aren't that many such
> > devices and it'd loose us the PM which is rather awkward...  I guess
> > that's an incremental issue with a more invasive fix though.

> The driver only supports GPIO chip select rather than native, so I don't
> think this is a problem. Also, I don't think there's any difference

So mentioning the drive seems a bit confusing then?

> between inverted or uninverted here. They both either need to be driven
> all the time or have pull-up/downs.

It's a lot more likely you'll get away with things one way or another
for a missing pull down.

--Kx4ZGGc8DcXvnXpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtyX0ACgkQJNaLcl1U
h9BmiQf+J4Fy0f2hi8No7l8CL6UF+VDBZtZND51px92ygeK4jYzoFztbrY/KuUuq
axMfX0zqqhPqrkNTIhWSxhE+cyaoLIvbMdXMUDlmDfVpD4OUFMrSCKmAfg/jw3Jp
o0bCBIhnA2OPfza6nU6AlYbxFkDkmZvsze/qBfwSrVJzEFQ0z1CZyzS08PyDehkZ
GikHVyFqpL/ZiwvuJbypJQASg+RhI9pSBssKOpFOJQJtF8ATewbENIh//Ix1PY91
NI747pcM5AlJWU4YLDlPn1uu0f/MNxevfxCblUN5kaJJgy8QtC3TfeBEhCl4Wg6g
aRJcubes95kDlvJH0ffvtJnBc04oPw==
=SHJo
-----END PGP SIGNATURE-----

--Kx4ZGGc8DcXvnXpO--

