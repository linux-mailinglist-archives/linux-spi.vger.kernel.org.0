Return-Path: <linux-spi+bounces-11860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F8CB4817
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 03:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F543008FA2
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 02:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5A296BD2;
	Thu, 11 Dec 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaKlWRsg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99973292938;
	Thu, 11 Dec 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765418774; cv=none; b=qd+7BBL72tznmgYWJc5Jaoo44Mc2SvUM5WxUN36vMcMEgf7zJ9DZJtGIrLSSEoJ0MgpBH1GtfzoJclnBuMH5qm6rUZaKTirXUGJROVX6S1nIl0hzPmcSm+2VoI7jnoBxk4RAscGmet7hdz562DDUxui/tNsSxMOcoxEagLk+TZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765418774; c=relaxed/simple;
	bh=5C17/+Bb9Zn4/BTp8r9Bzr0kO9d1R7kDEKS8scbMZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0CLNHngPht6u+5s22Rr63d09XjYfwGmOQzJKj5QmVhFxBNZ4MSOu2hVkyXt2m+m7VslTdsSZkyFo8ZsNMSOnj9kXlODofpUDkUvKhWhJ2v7uN72oAqVL9DjOZ8ORDvjVt3qWEkEmYXmf/Sb9o6Ff25BAIqMXuQ+e+9ycMRC+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaKlWRsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6D1C4CEF1;
	Thu, 11 Dec 2025 02:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765418774;
	bh=5C17/+Bb9Zn4/BTp8r9Bzr0kO9d1R7kDEKS8scbMZBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaKlWRsgaZMEQ3sAbjrhdmbo7Ifn8gz4EHFeb5IRl86OyYsuw02ww+O+fU7VU85xT
	 XClN2u0uw86aXycwqvEGyKHnqyboep5MPzoP6OK6LG24A3A/pC8vxNe2vfUw+2OyNS
	 N+ySoWBck8Cy2IjZVCTOOTnH1L8QpIJ2XbkMCXp5MO5sWTEbCxnZz1q3dSkVWiodF/
	 Sx604uYupFFxaGIY+uQor2CpOBMw23gR1gJ//IjJxJdg89sGXDeJFOciYrFTebP5Qp
	 g3g3iHqUZ36ocgjQbRCN6iCwiDPegnplpp4WHlgSTLSj2SB8vA5wi6a8snZtkiKL7A
	 JzWgWx83YMYSw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BFE5B1ACB974; Thu, 11 Dec 2025 02:06:11 +0000 (GMT)
Date: Thu, 11 Dec 2025 11:06:11 +0900
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Walle <mwalle@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC 5/8] spi: spi-mem: Create a secondary read operation
Message-ID: <aTonE4REBDfaWBQo@sirena.co.uk>
References: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
 <20251205-winbond-v6-18-rc1-cont-read-v1-5-01bc48631c73@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zAseFASQ0wTIorCg"
Content-Disposition: inline
In-Reply-To: <20251205-winbond-v6-18-rc1-cont-read-v1-5-01bc48631c73@bootlin.com>
X-Cookie: It's clever, but is it art?


--zAseFASQ0wTIorCg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 05, 2025 at 08:38:56PM +0100, Miquel Raynal wrote:

> The choice of defining two variables named primary and secondary instead
> of using an array of templates is on purpose, to simplify the reading. I
> find less obvious the use of an array here but this is personal taste.

This makes sense to me:

Acked-by: Mark Brown <broonie@kernel.org>

Feel free to carry both these patches along with the rest of the
series, if/when you do end up applying it a signed tag would probably be
a good idea in case there's some collision with other SPI work.

--zAseFASQ0wTIorCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmk6JxIACgkQJNaLcl1U
h9DT+Af9GQygkqGyABqwCLIlDQKKXFBWkb7slRPX13S3gBENffalZQq+07eKnE2I
YxGLcOc/dTeiSV0L2VK/LUDH2K2W245kRaO4kf/v824LA9nO+/ZsuEVyTgYBcLAL
GLDeQ5+iYupJM0S0np5bVj9UcxFrhIezHvyFEqPtVtmcGvDnkKLl1nGnFxKD7ilH
wnWyYmg0N/lVfxhL1KEqwYfUs/Rtp+2K8TFFZPTygl1jbZxlBcOWX1YJpaNrd1Qb
VQvx8UdjYY8O9xTTGVq/ONSNAHOLhSu6srDsy/gMyiY8Gdewu16WQU0aD4CkSGZX
pPZTP5ZtFZrQexyW/GPEHm3JYyUhMw==
=w/f0
-----END PGP SIGNATURE-----

--zAseFASQ0wTIorCg--

