Return-Path: <linux-spi+bounces-119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4558015BE
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 22:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308701C20998
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495D59B6E;
	Fri,  1 Dec 2023 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD7i61Br"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0359B69
	for <linux-spi@vger.kernel.org>; Fri,  1 Dec 2023 21:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFBCC433C8;
	Fri,  1 Dec 2023 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701467438;
	bh=+unD+pWX96Y1kdDVAxBZ7bMp1TVUj6jkcNw1BaPS65Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lD7i61BrsR1vum22JMye1cgGgyHzYmTPfQgHiyBM+gWmfRFwW5q4QNEuKih7ppXrp
	 uEZ6w8Sn/aCMbOHCzDjYS61GrI00spwsDarF8QwEtg6ZcNvTOhnQEJ4Am+0VGTm74d
	 OI8i8fRZAhvc0g2o6LowV9lww1QBS9cNuCYrbuJwM+c2un3x5YTnYd7lB6GCFHXNGB
	 2XyJ61IK/iXVBazsTItz+/BzxQvCh3hKqmJ0NiOI/MXtJLozgAvXE6OwtsDs7VpMYz
	 hfsajJSfby98g4SFgALiefSNMRCjoUSj3/T6XnG/Cmktrixx0Hzbal9bN4/Sc8YAg6
	 W8wGYYNldYDZQ==
Date: Fri, 1 Dec 2023 21:50:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] spi: stm32: enable controller before asserting CS
Message-ID: <b070eb2a-05d7-4e6a-8de9-15179045d192@sirena.org.uk>
References: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YmrIJOCZ+Tf3khLq"
Content-Disposition: inline
In-Reply-To: <20231201214014.2539031-1-ben.wolsieffer@hefring.com>
X-Cookie: The early worm gets the late bird.


--YmrIJOCZ+Tf3khLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 04:40:14PM -0500, Ben Wolsieffer wrote:

> This patch fixes the bug by enabling the controller in prepare_message()
> and disabling it in unprepare_message(), which are called while CS is
> not asserted.

This feels like it'd be a good fit for moving to runtime PM - that way
we avoid bouncing the controller on and off between messages which is
probably better anyway.  The driver already does pinctrl management for
the device there.

> Note that bug is likely not present on the STM32H7, because it supports
> the AFCNTR bit (and this driver sets it), which keeps the SPI pins
> driven even while the controller is disabled.

It also occurs to me that this isn't going to work for devices which
chip select inverted - for them we can't stop driving chip select at all
since they need it held high when idle.  There aren't that many such
devices and it'd loose us the PM which is rather awkward...  I guess
that's an incremental issue with a more invasive fix though.

--YmrIJOCZ+Tf3khLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqVSgACgkQJNaLcl1U
h9BFLQf/UOjz4Pr4wbrh+8Ck/3QreTFHhHy4MfusQ1TVF32f4jX9Nw4JQA/rFs4S
21ni5xP33d8D9cAiNUWJK+a7rYML9TyFbSsHJXso/CMk2OwuFNoUVIs/5NG/e643
Xv8oxmLSchOs7/Es9eBewWXyoyOx44UJZ6Xkm3nTTDFdLcIWO7JXfeB63cI7+Rpe
UrehMBhcaftJmv2P3VCwNCYqz4zkKwJa0f8kBSMN/ypYzA/Q0xCoKEJw5rYQW6CW
yE6AU3uob0Hgs9UT7xONC7GQ1KEnEfrPrSAtSs3ZFNSvV5vmaVubMZklllhGU3cZ
laUraJqW1OZlhresrLnzhF/z4SCtgA==
=1M3S
-----END PGP SIGNATURE-----

--YmrIJOCZ+Tf3khLq--

