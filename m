Return-Path: <linux-spi+bounces-7259-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D7A6AD31
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 19:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B961896EC8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 18:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B7F226CFB;
	Thu, 20 Mar 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfX0bdIe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9551C69D;
	Thu, 20 Mar 2025 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495965; cv=none; b=q23Ya7g/wd2pw6eaIzuQRGYkdLm7SAwxHjR/yUm3MZ9mDkNcDA+TDsheyWGAJg1xPRy/xYkvYodc1ETfNUcEh2vbltBdCRBQfMjCnxUAyZ7OCeNEyfgRHXJDWQpQd0Hzp13QyKD6EpfPkvUW2wXAKX1pyraSpgngNIqxQkPDejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495965; c=relaxed/simple;
	bh=4vq0GymM7SgTN/yFFLp3H9bZTyLvX6KolE4lSIY4j2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syAHG4VL1Hq+wkQciBJxGlpvK1L1Ek9JnnRHPQ4rozPHDqHvWwp5SzO9oD3/9eVqn52oey7j/WFA7Z989n15cmT9VfnG+GzpEaod05gmtkCz+65PIGgXI2SEtg85iqY7MatZbebS5Om39VYNhXDOH354v5/tQOfTdw/LvHu2LtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfX0bdIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE3C4CEE8;
	Thu, 20 Mar 2025 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742495965;
	bh=4vq0GymM7SgTN/yFFLp3H9bZTyLvX6KolE4lSIY4j2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfX0bdIe2pRgm55uWLBVyIbr2/fp3Sg7Ho+hSsH28ZYW5/d/bedQD3Na+jMXJSUuL
	 nqyhRUDh0BIN3Z3/R6K++mT4Ff+euqzFKOGefsaAcjpu8TUzxf9vGisx0BB/Y32cgW
	 oZ2O2OFLQ6TIb8/mC2QAEabDXR26tl88b8MnbpM6OsCMGtwHlY9MXLPLWGHTmVy7NT
	 Y1BZ7gjFngTmyKMbFZHy01y39nnL38bGJJ6OdnpMmoLwe+McptHhuPkOCHyOECQvVh
	 8MMfxanqB18k79UvMPbevaOr9gXpLb4ry90/UAFwnES8rtlo3STLgsfa6uIkBGAibI
	 XpjpfZg9erUxA==
Date: Thu, 20 Mar 2025 18:39:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0V3B41SexuEhkoa8"
Content-Disposition: inline
In-Reply-To: <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
X-Cookie: Do not fold, spindle or mutilate.


--0V3B41SexuEhkoa8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2025 at 05:30:01PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 20, 2025, at 15:42, Mark Brown wrote:

> > Really we just don't expect the small buffer to be DMAed.

> I looked at a couple of drivers and found many have a copybreak
> limit less than SPI_BUFSIZE

> #define SPI_BUFSIZ      max(32, SMP_CACHE_BYTES)

> drivers/spi/atmel-quadspi.c:#define ATMEL_QSPI_DMA_MIN_BYTES    16
> drivers/spi/spi-at91-usart.c:#define US_DMA_MIN_BYTES       16
> drivers/spi/spi-atmel.c:#define DMA_MIN_BYTES   16
> drivers/spi/spi-davinci.c:#define DMA_MIN_BYTES 16
> drivers/spi/spi-stm32.c:#define SPI_DMA_MIN_BYTES       16
> drivers/spi/spi-imx.c:  .fifo_size = 8,

> so any transfers from 17 to 32 bytes would try to use the
> non-GFP_DMA 'buf' and then try to map that.

Yes, like I said elsewhere in the thread 16 is a popular number but I
suspect that was the thining there.

> >> It also seems that the copy happens in the regmap_bulk_read()
> >> path but not the regmap_bulk_write(), which just passes down
> >> the original buffer without copying, as far as I can tell.

> > Yes, writes don't need to do anything.

> Can you explain why writes are different from reads here?

I think there may have been some context lost there while replying?

> > I suspect that practically speaking almost everything will be under the
> > copybreak limit.  Probably we should just make regmap use spi_sync()
> > with the supplied buffers here and avoid spi_write_then_read().

> I'm a bit lost in that code, but doesn't spi_sync() require
> a buffer that can be passed into dma_map_sg() and (in theory
> at least) GFP_DMA?

Yes, it does - the API is in general that the memory be something we
could DMA, in case the controller wants to.  You'll probably get away
with just passing whatever for small enough transfers, it's much more
common to get a controller that won't DMA than one that must DMA.

I think I'd been under the impression that dma_map_sg() would handle
things similarly to dma_map_single() (it's a bit of a landmine for it
not to...).  It's a very long time since I looked at any of this stuff.

> - the way that spi_map_buf_attrs() is written, it actually
>   supports addresses from both kmap() and vmalloc() and
>   will attempt to correctly map those rather than reject
>   the buffer. While this sounds like a good idea, handling
>   vmalloc data like this risks stack data corruption
>   on non-coherent platforms when failing to map stack
>   buffers would be the better response.

IIRC that's there to support filesystems on SPI flashes or some other
application that uses vmalloc()ed buffers, it's definitely not intended
to support data on stack.  If it does anything for stack allocated data
that's accidental.

> >> I don't know what a good replacement interface would be, but
> >> ideally there should never be more than one copy here,
> >> which means that any temporary buffer would need to be
> >> allocated according to the dma_mask of the underlying
> >> bus master (dmaengine, spi controller, ...).

> > Which is a pain because even if you've got the device for the SPI
> > controller there's no way to discover if it does it's own DMA.

> __spi_map_msg() already handles the case of an external
> DMA master through ctlr->dma_map_dev, so I think the same
> could be used to get a temporary buffer using
> dma_alloc_noncoherent() inside of spi_write_then_read()
> in place of the kmalloc(, GFP_DMA).

That only helps spi_write_then_read() though.

--0V3B41SexuEhkoa8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcYNgACgkQJNaLcl1U
h9CUNAgAgmqdDvtSPAEri5k/nn2bsRFtL1kAGEfNn/ExRezpJvcKyXaTvxpiHXTJ
crdFdWjPjaiTvjt6XafBtMUydJc6bOWqOu0WVymbfUfWmNptou+9AZt4JQY2tK+g
7P0PELr7pAiqcXKPZSz/0QQXfwSiVZG6qgaUmBsasFQN8OCPBblwgEDf5t+eIsG/
C03QL+q6P+csPedPRFrUMxzVWZ4Bm8pXN8j5k4vmWujxdx6JOrOowopp4SunM8ev
S1IjdQ08vFa7d1stCCqi3i0wmw9O4RZ+wzdMEGvblgvVqXsj0IEASjV0BAVvYjka
2tuEqFsBDgvX8v4AxyppEBU3Fu8IXQ==
=JMps
-----END PGP SIGNATURE-----

--0V3B41SexuEhkoa8--

