Return-Path: <linux-spi+bounces-4948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43B984809
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534A428355E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56361A7AD6;
	Tue, 24 Sep 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCCiGp55"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EF1B85F0;
	Tue, 24 Sep 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189554; cv=none; b=MaP8BX0L5J8T/QXKwcTv3mVQ8jfqvmaYUbhLPUYjDYGmi4XeRTUW5uHb6taNBYEMsUEJhE9B0EQS1EQUcD9RZKy7UGtTNmwfg9XXMlAyBIOP0iDyVtN8orbbBo4EW6LbjdWWDBW0MDxlTHa45K/HNfzCbcoxpVNbyrI4R4ECr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189554; c=relaxed/simple;
	bh=keRaJN5JmeP4cnnXSTQ7GucBOsaTPwdcyRxc4LBX160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm4MOvIjQvoP3UdskQSx8afqsFBCEhe40R6aIqh/o08OpIeTu9Xi4+BNDpHblepG+9qcYBxNirXkWv7ZGUJQyWJVUWXynnw8BqwYsy0JBMHVjzNqul3/jZ1B5t7sUEKU4R/Wz+UbjA5LfFQi7Hooxrjt72x2k+krl6bjxtXsIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCCiGp55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CB8C4CEC4;
	Tue, 24 Sep 2024 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727189554;
	bh=keRaJN5JmeP4cnnXSTQ7GucBOsaTPwdcyRxc4LBX160=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCCiGp55YCoqto6GQhdXR/7ya2p+SYO5Z2YwXnD22jI2LPyil/seZusg5f0GSqLOW
	 8bl8gTNnE16Zkxgz/ZzIpJXlhFnbgooDOYUjyKgQJgyQJhLInIIT1AOWHJPqzdKSTU
	 KnNyV5ViGbkQ4SDrGb+hT2GlOBZ9AA8PEIFC5Jq3FnhVxozXJwh57H0NViZowMKDxW
	 KQcxnwH8i/aHt194FHhmmpbigpqSCnoRzdVuFzrfT7ZPSlSFX0T3+eAVSeZHZqVv6O
	 zr2T1fFQwgImTo7nPGnsUKGSfFi/Q9vXot2OirPhQWLv3oePZVBKcwH612/qTH/yfl
	 fZFY+UoNSLWwg==
Date: Tue, 24 Sep 2024 16:52:30 +0200
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, chengminglin@mxic.com.tw,
	leoyu@mxic.com.tw, AlvinZhou <alvinzhou@mxic.com.tw>,
	JaimeLiao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
Message-ID: <ZvLSLt95Hrd7JYj3@finisterre.sirena.org.uk>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-6-alvinzhou.tw@gmail.com>
 <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
 <a87a159e-eff1-45c3-bf26-115d4ca5a9be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RdxPtqe1G7U3rehe"
Content-Disposition: inline
In-Reply-To: <a87a159e-eff1-45c3-bf26-115d4ca5a9be@linaro.org>
X-Cookie: Editing is a rewording activity.


--RdxPtqe1G7U3rehe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 24, 2024 at 03:29:37PM +0100, Tudor Ambarus wrote:
> On 9/24/24 12:38 PM, Mark Brown wrote:

> > Acked-by: Mark Brown <broonie@kernel.org>

> I'm fine with the SPI bits as well. Shall I take the SPI/SPIMEM patches
> through mtd and provide you an immutable tag? I can do that after -rc1
> is out.

> Or you can take them directly through spi/, but I'll need an immutable tag.

If you apply and send me a pull request with the tag that should be
good.

--RdxPtqe1G7U3rehe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmby0ioACgkQJNaLcl1U
h9AqJQf/WnsU8mtfyhIc1dUx0L/KK1z+R/rUY8OIQJxsLZg7e/OKyep//NQjPV0C
6L6xsnHFR5+IvJMbsTyJAQuOxL/G+M4xkUOOYpYgjlMkNPOgrk18ePdUFcWa60q5
dzMkkvH5y2DsBkC/vvedANvFzLjCPgkSUa4TEEe3Qt4yrgKPNeR4ctyVregZr8eK
B/nO7Xhcs/epbXlNc5h8xLwzbVAjPROAIz0hyX0y12z0qYgWbP30ykLsR+D2cycG
R6iv19NkP8wpHBwx/1P4nFfFFFkujgJuHWDVC1anREgfjsnhy2VBK1SsSb1bNidX
pJvlkoC6XYed7tqABVCGiqBn3NJHYQ==
=mo0n
-----END PGP SIGNATURE-----

--RdxPtqe1G7U3rehe--

