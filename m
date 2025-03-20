Return-Path: <linux-spi+bounces-7251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72835A6A8D2
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 15:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BD13AE8AF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454791DE3DB;
	Thu, 20 Mar 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqJdcrKK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D903155A25;
	Thu, 20 Mar 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481732; cv=none; b=aKeMLMUsGoq8HT/Jo880QKfGpFk8VbPY6kHtCUpEcThJEm8thA3BaVVzOyQLjKpaZ35pcQWUMwrSL8O1WfBe2OGOjQelWBEyBehj+iiLafWwyPIMG3asGU6U74Q5hAaGbLrgLRR0v9uVa32gJ/mkmSlO5SXHTJL604LyGLSJc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481732; c=relaxed/simple;
	bh=BVkZm9JhQzNbawKIJ6yh01PkwdIdPruu66/KDukSFj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwWLw1xr4V3R/xLSL8pdLV/5jwUrrNUpNCWC5U/UkN9e/CkO4jxsVpWzl9+1LF2vrbKNcL6MmLQvBjf5Xu0/FwP7Be3rSbI9coK3gwI9QZ8gfDQzFIOWIuEkzcen2xM8mTtThE5MusSITxpGVwGaZdsKoJvUAbOAyZZqWntJvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqJdcrKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B17C4CEDD;
	Thu, 20 Mar 2025 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481731;
	bh=BVkZm9JhQzNbawKIJ6yh01PkwdIdPruu66/KDukSFj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqJdcrKKtbI1rKBj4OtyqjWCkbpGPYEs+JO8ZGiGVeI+DQxdF8J6CVQTPiF2Q6yIz
	 165o8mz0Qf5rT1qeaXlNUhQqaL6Q922KoOCz65uFBBVlXvvJRry9qVFqQeTD5wkjbi
	 SfztoC9vuF5Gqjn4vAUS35wjJM9mP75WPndM0PX0t/br3/VXvgOPAsAONY3ehP6lJ4
	 E76vCl4s7joP4eLjGh8UA3phPd7tVC5Jugls07E9Uz+fzxX4+IqtRDyqE0aPf6gcKs
	 AQcpwcNsBsaaXEHERBraUuJEIvovMegHWhhvjWdUlvMDGZoGHez48Bz+PcWKiDnSED
	 aS5mI8Gwzn6BA==
Date: Thu, 20 Mar 2025 14:42:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sc2ZYQCapuH8yoJr"
Content-Disposition: inline
In-Reply-To: <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
X-Cookie: Do not fold, spindle or mutilate.


--Sc2ZYQCapuH8yoJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 02:35:41PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 20, 2025, at 13:29, Mark Brown wrote:

> > On a lot of systems most transfers are short and won't be DMAed at all
> > since PIO ends up being more efficient, and most hardware is perfectly
> > happy to DMA to/from wherever so *shrug*.  SPI_BUFSIZ is a maximum of 32
> > bytes which is going to be under the copybreak limit for quite a few
> > controllers, though admittedly 16 is also a popular number, so a lot of
> > the time we don't actually DMA out of it at all.

> I saw the same thing looked at it the other day and got confused
> about why 'local_buf' is allocated with GFP_DMA and 'buf'
> uses plain GFP_KERNEL when they are both used in the same place.

Really we just don't expect the small buffer to be DMAed.

> It also seems that the copy happens in the regmap_bulk_read()
> path but not the regmap_bulk_write(), which just passes down
> the original buffer without copying, as far as I can tell.

Yes, writes don't need to do anything.

> From what I found, there are two scenarios that may depend on
> GFP_DMA today:
>=20
>  a) a performance optimization where allocating from GFP_DMA avoids
>     the swiotlb bounce buffering. This would be the normal case on
>     any 64-bit machine with more than 4GB of RAM and an SPI
>     controller with a 32-bit DMA mask.
>  b) An SPI controller on a 32-bit machine without swiotlb and an
>     effective DMA mask that covers less than the lowmem area.
>     E.g. on Raspberry Pi 4, the brcm,bcm2835-spi lives on a
>     bus with an 1GB dma-ranges translation, but there may be more
>     than 1GB of lowmem with CONFIG_VMSPLIT_2G=3Dy and CONFIG_SWIOTLB=3Dn.
>     Without GFP_DMA that would just end up causing data corruption.

That sounds about right.

> I think we have some corner cases where a driver allocates
> a GFP_DMA buffer, calls spi_write_then_read through regmap,
> which copies the data to the non-GFP_DMA global buffer,
> and then the SPI controller driver calls dma_map_single()
> on that, ending up with a third bounce buffer from
> swiotlb.

I suspect that practically speaking almost everything will be under the
copybreak limit.  Probably we should just make regmap use spi_sync()
with the supplied buffers here and avoid spi_write_then_read().

> I don't know what a good replacement interface would be, but
> ideally there should never be more than one copy here,
> which means that any temporary buffer would need to be
> allocated according to the dma_mask of the underlying
> bus master (dmaengine, spi controller, ...).

Which is a pain because even if you've got the device for the SPI
controller there's no way to discover if it does it's own DMA.

--Sc2ZYQCapuH8yoJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcKTwACgkQJNaLcl1U
h9C1zAf7BsaMYh/FgZiF0WT2/KfwQDMvg9k3WeKVJduqvCT4QlFPeZOTspMdExuy
1cNUs/MVzghfbF4lao9x2E88MS+b8kqbrsEPxBEx/gF85k+Lo6+f97Ck8DjKf3JH
hgNjwy/72onxMdsItTuRUUnu2QEmRQEED6hv4/neaxX2F05UbMXVfEN1it5kilaS
K5GO3eHn8d0hNm3zSopTcX8JrwU/ZB+C5LpKyRxAJqNL1tgtRhqVPm1A8Tg4h8nr
bx36tbWBxsAzSnO1eD8/2L7T0yUnurGO52ZvqC/MXdCOPQON3uuUkWsFh1y3wVh7
ZmZtpioV/+PiMaDekgaV/LgMvb3itg==
=5tYe
-----END PGP SIGNATURE-----

--Sc2ZYQCapuH8yoJr--

