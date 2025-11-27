Return-Path: <linux-spi+bounces-11632-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE541C8FDE3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A55C4E6F49
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730062FB08C;
	Thu, 27 Nov 2025 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ1ZxC6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB22F9D8C;
	Thu, 27 Nov 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764266710; cv=none; b=uQnb5Dwb63syw9AjYWHzYY+jkbPGflcNizP06eGn9ktMZcPk4Ji1dCU4pcXjQWRQkKnqVJsxF0gB1CTqg2JfABf1kAbRV3V0AW5TJMSu4PH/ZyNs/yMSN2NeZ8n7W0Yq8YJoOwogbBIgQmal8UKULZebhYDRB9hIX1lJ6uogotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764266710; c=relaxed/simple;
	bh=5hssZviGJf0nMK/6zRLEpW0s1B6xq4uXHzLRpeOsEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOBvjWj7VBNFKw3pYDEzLRpADz473c65PI8yR1Ow6b1Anhf3iy3QXS4drTsLEPYXkLfx+i7LAlxMeyfivZgMrDcSb2dUcn0/LvPgCg2P+842umRsPd3tRyafkHFtYApOdAK92tPIhTLIRycjz4Nz95Pozar1Q0Vg4W57lPkdAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ1ZxC6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE9BC4CEF8;
	Thu, 27 Nov 2025 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764266707;
	bh=5hssZviGJf0nMK/6zRLEpW0s1B6xq4uXHzLRpeOsEQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJ1ZxC6HqX2AF9zWUgTj8iM/Yyyrpc0rR5cD5BYheOZsdq7HTGubVBi4Em99eKmC/
	 f7Rnb6vJZJE9WCyTYhhQNZvE6kaKuCNu4C6P+GeQslwIlHgPQewk+WDkx7gLGwM4ri
	 wNDhRW6M4NwcuQbejFz24SJJuYbPQ7wwjeTIZOXznTMUZ2/iM7Ne3syhPH16SKflQA
	 1mkDiz5YyFgVaMvN9Phq8CzQvASfsgnbcG8R73YUG2ABE4OjBbjz08jyrrj9FqaJq4
	 al05znvdfe2995pGyqr/9ek53x646Ot0b5LqFnE34extpLk/NJKEGsXJ+1eH04XPNE
	 yFjMEdmiTY0iA==
Date: Thu, 27 Nov 2025 18:05:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	david laight <david.laight@runbox.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley - M52691 <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v2 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Message-ID: <20251127-pliable-magnetism-c59c560e49ad@spud>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-3-andriy.shevchenko@linux.intel.com>
 <20251126092145.2f8e4c8d@pumpkin>
 <720a960d-797b-4404-90ab-e0c75c12a151@sirena.org.uk>
 <aSbu4BA8pohsYSQ8@smile.fi.intel.com>
 <48d3b29b-1010-4749-aef0-c66a72f1d8fa@microchip.com>
 <aSiBF9nStZzUNGLA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u52HAkzTFL23lPlC"
Content-Disposition: inline
In-Reply-To: <aSiBF9nStZzUNGLA@smile.fi.intel.com>


--u52HAkzTFL23lPlC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 06:49:27PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 04:08:25PM +0000, Prajna Rajendra Kumar wrote:
> > On 26/11/2025 12:13, Andy Shevchenko wrote:
> > > On Wed, Nov 26, 2025 at 12:05:22PM +0000, Mark Brown wrote:
> > > > On Wed, Nov 26, 2025 at 09:21:45AM +0000, david laight wrote:
>=20
> ...
>=20
> > > > > I'm not sure I don't prefer the version with one writeb() call.
> > > > > How about:
> > > > >              writeb(spi->tx_buf ? *spi->tx_buf++ : 0xaa,
> > > > >                      spi->regs + MCHP_CORESPI_REG_TXDATA);
> > > > Please don't abuse the ternery operator like this, just write normal
> > > > conditional statements.
> > > FWIW, that's what my patch does already :-)
> >=20
> > Thanks for the series. However, this particular patch appears to
> > introduce a regression. The SPI controller reads an incorrect
> > Device ID from the=A0peripheral.
>=20
> Hmm... This is interesting. The only thing I see is missed dummy byte rea=
d in
> case of TX only transfers. Is this what you have?

Seems very likely, the hardware is pretty simple, so it has no concept
of whether bytes it receives are useful or any ability to operate on
transfers and discard data from the FIFOs when a new one starts. That's
why the unconditional read is there to make sure the rx FIFO is kept in
sync.

--u52HAkzTFL23lPlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaSiSzwAKCRB4tDGHoIJi
0m71AP9AZ5f4G5DwB8y1MQ3BumEBFgbGFF3Wa0Wl8Rme0MCBMgEAuCCHifmlgR1A
w/5Zcmt1jZ4fRzMdkmLPQjPvHJicxgA=
=lhwn
-----END PGP SIGNATURE-----

--u52HAkzTFL23lPlC--

