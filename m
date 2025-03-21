Return-Path: <linux-spi+bounces-7275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3EA6BD7F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 15:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F0A3AC108
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CE618A6CF;
	Fri, 21 Mar 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXH1KAF8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6D78F44;
	Fri, 21 Mar 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568329; cv=none; b=Xf5DuniTxC9RB5rgitPaKaaF8otZn/wXjWUXgab1hnvAKpiFYaMiitq2bL+l0opgv4rIJZY38iYCfJvXypcpxNp1it7LICtl5RCviPmNvsjDuMGfMGuic0QVIWnwQP9ZLpIGbooo8KRh5uVEQq1vvBbi+2BAkH4gGy8Y9lQRaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568329; c=relaxed/simple;
	bh=P0h5jtDb9D9JmSosnEt90BqPJV1xfVZY/1hVXZHjPiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clCfhjALR45vBBXNT1zg1xhPb6UKVe3oZldnCC0gjVMhhnQ8mBDKIftyF6yEVH62NVL1PUbGYTDVrMRUHDregldur3IXjIbgT19TFPEQ7VwdOOCCGE/266RY5g5PrjfmmCH9GOMr/1PXm5oQbv9FKfqGTG6NfSVgRgTzP8YLRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXH1KAF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFD1C4CEEA;
	Fri, 21 Mar 2025 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742568329;
	bh=P0h5jtDb9D9JmSosnEt90BqPJV1xfVZY/1hVXZHjPiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXH1KAF86dI0rTzXk+jatQNNIIWUcLVFc+yEP9WkBfgrWWAmWQ+/WPowAv8pYy0o0
	 uCDeCK0NBOWZWWTgK2DdA0JysNCsH3Nkc/nk2Q6DOZrZnhUfg5X4I7gaHmWpBMUbHT
	 MawJ5PzRorCxfXiTypigNJZ+hxbklgvxZ4OCOa6MesH0rP+ABWdPIFRH3eJv6NQzCp
	 2wDgQHmMBxF9uEKhJFtM3PZ8Enheb1n7K5Us+HkkVgdWXDnz6zD3Il9T9eKsKBgo8J
	 1TQbRrrD3+Y1EZWT9IzNrwo+zdp1nfpL8Ue+OXeL8Kf1jlePtZvZ2R0WDR5V5OJvUE
	 KzWrEcHvfGd3Q==
Date: Fri, 21 Mar 2025 14:45:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
 <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W0apdjcNUfHtO8pj"
Content-Disposition: inline
In-Reply-To: <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
X-Cookie: Well begun is half done.


--W0apdjcNUfHtO8pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 01:41:52PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 20, 2025, at 19:39, Mark Brown wrote:

> > Yes, like I said elsewhere in the thread 16 is a popular number but I
> > suspect that was the thining there.

> Ok, so do we assume we don't need the GFP_DMA then? That's
> fine with me, but in that case we should probably enable
> swiotlb on all arm32 platforms that may have ZONE_DMA smaller
> than ZONE_NORMAL.

I think that makes sense.

> >> - the way that spi_map_buf_attrs() is written, it actually
> >>   supports addresses from both kmap() and vmalloc() and
> >>   will attempt to correctly map those rather than reject
> >>   the buffer. While this sounds like a good idea, handling
> >>   vmalloc data like this risks stack data corruption
> >>   on non-coherent platforms when failing to map stack
> >>   buffers would be the better response.

> > IIRC that's there to support filesystems on SPI flashes or some other
> > application that uses vmalloc()ed buffers, it's definitely not intended
> > to support data on stack.  If it does anything for stack allocated data
> > that's accidental.

> Ok, then the question is what we should do about callers that pass
> in stack data. I can send a patch that adds a WARN_ONCE() or similar,
> but it would trigger on things like=20

=2E.. (single/double register raw I/O from stack) ...

> which happens in a number of drivers but is harmless as long
> as the driver doesn't actually try to DMA into that buffer.

Hrm, right.  I think that usage is reasonable so we probably should
allow it rather than forcing things to do an allocation for a transfer
that ends up being PIOed anyway almost all the time, OTOH the same API
is also used for large transfers like firmware downloads where we don't
want to trigger a spurious copy.  Having different requirements at
different times would be miserable though so I think we need to just
accept any buffer and then figure it out inside the API, but I've not
fully thought that through yet.

> >> __spi_map_msg() already handles the case of an external
> >> DMA master through ctlr->dma_map_dev, so I think the same
> >> could be used to get a temporary buffer using
> >> dma_alloc_noncoherent() inside of spi_write_then_read()
> >> in place of the kmalloc(, GFP_DMA).

> > That only helps spi_write_then_read() though.

> Right, we'd need to mirror this in other interfaces, either changing
> the existing ones, or adding safer ones that can be used from regmap
> and from drivers that currently allocate their own GFP_DMA buffers
> for this purpose.

Yes, indeed.  I don't have a clear sense for what the best solution is
there yet.  Possibly some libary code for the "I want to DMA this random
memory" use case?

--W0apdjcNUfHtO8pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfde4IACgkQJNaLcl1U
h9ACNgf/UnJAAqqMuXrNklk0ZXkgVc44jS2jqsd7qF+4AgzKNg8WtEOPwCyaI71+
TFxtg+jWhOCQ+B1XJDGJDRqBxd96E/+Z4eZ1jex0PvRRlZBY47eaFihVkX6xIalI
Fl7crg+8PoJC9tqIdO5lPNfELbERQQr/khnrKh791FZl3enqjR7SW3Ue3d1uJbfh
Qif7dcVcLmbJOMgiv3vulmgI6tfE6uvnAWZTqw0UB+Y5UWFWW+Uqy38UCyFsI0EC
l1pRik5/IIm9z4qygQgX0rNY4FrZzwo0g+5dTzbLlZvjW7boI4F1AcAMVG+/hgV1
ToToboagAHN1JkqnfQx6JP/k/i+iSQ==
=/iko
-----END PGP SIGNATURE-----

--W0apdjcNUfHtO8pj--

