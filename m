Return-Path: <linux-spi+bounces-7246-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1F0A6A644
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 13:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEB118941C5
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173B221DA6;
	Thu, 20 Mar 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqOY3rH5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADC212FB3;
	Thu, 20 Mar 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473796; cv=none; b=u3v4vGg9ZemQRDVM3dUUz4/2ajo0BU0UAcds2sRwgh/ATCQmAJ3yvzk+V4F4tbX8VJYqJ0m+3vP189rw6mdSFMUroeeK6vlAVnOhfzh5m0E7NUZmjwv3Q4GrQRjtxs85j9pK8HKl7Ee9S5WdrLyNOCyrKdKhAhcapeXIs9HdVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473796; c=relaxed/simple;
	bh=nd/erHLbMJLcow57EhIHLUTaFJYObNTLwgDvjqx+U2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZZiQd7JJ88SUk3BdxhQPC/KWP0Uq50ABz0k2opKsuQbKRg9Or+RPU8XZ8zoCP5vhnROhaDsb/QgN0+ZQQL0uUXdA6PzpGh2jXW8xGqSanLhAbOoXvefMhDU9CMSnCtt1Dm/IRpKyaccrEUW06eN31KbDwJF/TngklxWK4Fz/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqOY3rH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3481AC4CEDD;
	Thu, 20 Mar 2025 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742473796;
	bh=nd/erHLbMJLcow57EhIHLUTaFJYObNTLwgDvjqx+U2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqOY3rH5X+ScE4ema1O9tJ2LzHxeneHsUuqIqwQWuCKK2h+6y9BLYSPKyA9g6S5rG
	 YGC/c6aLZP/ri3DnzoGxhr/bHLglCHLHi1NpvS1AO2L8WQRAx1J79aKiNahD+gfg/+
	 nGo35cJcEksRDqikXjSZQjo3cL0wrzSodhkE/bT8oNHivmz6+yHtXEVUl/VuA08+5Y
	 tLJArJY/2DurGFu9sKmKOHOml7tUBPpO2U/yIBIVA71k57FgLaZLFA6uMo4nhSWYjp
	 IxLQV3FHLr5zkWAa6RPOTOIw2+yA2QTpLc6JZeKKjVNNVsw027TodpUEKFiMsm/aJn
	 dNZmVgDgnOutQ==
Date: Thu, 20 Mar 2025 12:29:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="08tU5mLquA0dUnfy"
Content-Disposition: inline
In-Reply-To: <20250320124330.480d652d@mordecai.tesarici.cz>
X-Cookie: Do not fold, spindle or mutilate.


--08tU5mLquA0dUnfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2025 at 12:43:30PM +0100, Petr Tesarik wrote:
> Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Sun, 27 Jan 2013 14:35:04 +0800, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > > Use GFP_DMA in order to ensure that the memory we allocate for transfers
> > > in spi_write_then_read() can be DMAed. On most platforms this will have
> > > no effect.

> > Applied, thanks.

> I'm sorry to revive such an old thread, but I'm trying to clean up DMA
> zone use in preparation of killing the need for that zone entirely, and
> this use looks fishy to me. I'm curious if it solves a real-world issue.

Copying in Arnd who was muttering about this stuff the other day.  Since
the original patch was over a decade ago I have absolutely no
recollection of the circumstances around the change.  I imagine I was
running into issues on some customer platform.

> First, the semantics of GFP_DMA can be confusing. FWIW allocating with
> GFP_DMA does *not* mean you get a buffer that can be directly passed to
> a DMA controller (think of cache coherency on arm, or memory encryption
> with confidential computing).

I'm not sure what you're thinking of with cache coherency there?  The
usual issues are around the DMA controller not being able to address the
memory.

> Second, this code path is taken only if transfer size is greater than
> SPI_BUFSIZ, or if there is contention over the pre-allocated buffer,
> which is initialized in spi_init() without GFP_DMA:

> 	buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);

> IIUC most transfers use this buffer, and they have apparently worked
> fine for the last 10+ years...

On a lot of systems most transfers are short and won't be DMAed at all
since PIO ends up being more efficient, and most hardware is perfectly
happy to DMA to/from wherever so *shrug*.  SPI_BUFSIZ is a maximum of 32
bytes which is going to be under the copybreak limit for quite a few
controllers, though admittedly 16 is also a popular number, so a lot of
the time we don't actually DMA out of it at all.

> What about reverting commit 2cd94c8a1b41 ("spi: Ensure memory used for
> spi_write_then_read() is DMA safe"), unless you have strong evidence
> that it is needed?

The whole goal there is to try to avoid triggering another copy to do
the DMA so just reverting rather than replacing with some other
construct that achieves the same goal doesn't seem great.  I think
possibly we should just not do the copy at all any more and trust the
core to DTRT with any buffers that are passed in, I think we've got
enough stuff in the core though I can't remember if it'll copy with
things allocated on the stack well.  I'd need to page the status back
in.

--08tU5mLquA0dUnfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcCj8ACgkQJNaLcl1U
h9AzjQf+Iuj6dcmYWT5G7FoLOAsHbT2rH2g5VTJ0JmMLJjODhH2BH32FOZccRs8V
1Adt22moAaIpMvFSZ2ZMbFtvwT/p+KorBss+SOdYSF0tm22838AUO+9+BKUHq7o5
JchWUxMvz0AoEwXdH/kFdwNV0re7L3HW6xA/MOd+olrLx4d55R90UtfxYhTvNbds
rhEzopVVTm4nZ2gSYF2QXakLXHAvDrJY/+Alnx8/3WeO0HAC1+3+XFjO9wbbv71L
PDI3nHZJ6arU29oTV3b2Ygu7qPfcRIG+OW7+TdmO0JNmjMqHp1MsQs2g2qh2pIGG
VjuPntM6hY8yN0RvrkcjJT+hquQa4w==
=ADoM
-----END PGP SIGNATURE-----

--08tU5mLquA0dUnfy--

