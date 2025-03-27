Return-Path: <linux-spi+bounces-7344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD3A7353D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118091883E49
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28941537C6;
	Thu, 27 Mar 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnzToYv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56F14D2B7;
	Thu, 27 Mar 2025 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087825; cv=none; b=bThpLuehLetB3sKrsddIX75A297v97EIwxxB0vomUKKc4qiwQ367G9fwmSh3U07n2eE0AFjlQfnqy/dng/qWrhgjuWdTiwAz5bMRntXuG1etAPVSvqLomdhApPSypAXMKsIUrJS32x/c2fjQrTBiBGN1qefq+n505swQWD/dvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087825; c=relaxed/simple;
	bh=qhNaZMqHRNgrvn2itfynRD7HiiYGkt6KoXYBf4VPZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9J+O/nFNss6SZt3wfPXtdz+CwjdPRyErNX0SjDC/lgqKnRPFqvAnN/M79j1l/KiwID8QBissM/IufhVg5srGejmCSVkopLT9ZahzA1MuKpxx8S2mF5ZMn0XjYCtVvXvJLL1AmY4Vnn8po1/kJqeaUvHpdG5f2gif6z1X14DQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnzToYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79BBC4CEDD;
	Thu, 27 Mar 2025 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743087825;
	bh=qhNaZMqHRNgrvn2itfynRD7HiiYGkt6KoXYBf4VPZVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAnzToYvV7cdR79GN/juteoi+4GOjZj0gJx4MyYeq6/r5GQGrSYIgIciTXl4C6vj8
	 QToXCvwcnRSrFUbeRgMBW6Zp4P9sSIxvpdwfbO+8maiAPooUbs9FwyQEbHfC2eU4W3
	 Lss/03kBwumTJtopMQ2MULG4on2Xm7NP5gKCLawyu/ZYWgN3ZwIKgc52mtFenVRQqL
	 FSC4JJca926tf+SnBMo/bVA8yAKNSLIxZ3FnuYAY83EEIJjTqC4YwGz3oGZmEUBwTt
	 weycV6LSbzLgYch6i3f0neFpsotIxVWW0MGmhnJv2vOPtRDrCUMHhKmVwtkEg2C4Yc
	 /jYXbffxCbz7Q==
Date: Thu, 27 Mar 2025 15:03:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <8bf5fb34-a554-4ab3-b774-470c08971447@sirena.org.uk>
References: <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
 <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
 <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
 <6a3a4b10-f51b-43e2-8281-057f6751424b@app.fastmail.com>
 <8ff02f5a-fa66-4403-b193-a18c23879e0d@sirena.org.uk>
 <92817727-d0f2-4d91-8fef-84ee92ab42e7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tf2yxVVdxALET0IF"
Content-Disposition: inline
In-Reply-To: <92817727-d0f2-4d91-8fef-84ee92ab42e7@app.fastmail.com>
X-Cookie: Multics is security spelled sideways.


--tf2yxVVdxALET0IF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2025 at 10:45:57PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 26, 2025, at 17:20, Mark Brown wrote:
> > On Fri, Mar 21, 2025 at 08:42:12PM +0100, Arnd Bergmann wrote:

> >> Using dma_alloc_noncoherent() should make the implementation
> >> much nicer than GFP_DMA in the past, so we could add a bus
> >> specific helper for SPI that checks if the controller actually
> >> wants to do DMA and whether the buffer is problematic at all,
> >> and then decides to either allocate a bounce buffer and
> >> fill the sg table with the correct DMA address, map the
> >> existing buffer, or pass it without mapping depending on
> >> what the device needs.

> > That query feels a lot like spi_optimize_message().  Which should
> > possibly then just do the bouncing if it's needed.

> Would that require attaching the temporary buffer to the message
> or could that be a permanent bounce buffer?

We probably want to be able to do both - have a permanent buffer for
normal operation, and allocate a separate one when
spi_optimize_message() is explicitly called by the client code since the
idea is with the explicit calls is to be able to have the message baked
for a long time and you might have multiple messages ready.

> The advantage of using a permanent buffer is that it
> avoids both the kmalloc and the iommu mapping in the fast
> path and only needs to do the dma_sync_single_()
> for cache management, which should be faster for small
> transfers.

> The downside would be a higher memory usage and the
> need for a mutex.

Yes, the memory consumption is a potential issue.  We only tend to have
small numbers of SPI controllers though so if it's a page or two per
controller it's not too bad.  We could potentially make the buffer
discardable and allocate it on demand and release it under memory
pressure but that feels like a worry about when it's an issue kind of
thing.

For cases where we could use the source buffer directly we also have to
work out when it saves more overhead to use the existing mapping vs
doing a new mapping that skips a copy.

--tf2yxVVdxALET0IF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmflaMwACgkQJNaLcl1U
h9A1pQf+JDEsvjbk+opIKoib4mniCmWAV/h2nR8tAGNT3pnQsgYBRzPL9BLlXO2V
ge0/mawK3854sMFtGweFmcxkj86eDsUJ3IDdf0p7cel10MRu2suvdVxYxDwEQlw/
GLxRS5fm7boCBF+U+AbKQOE0Y6ZyDhvWfc11tB/1QCQslC1enmaN/wBGjQNSw715
dQY+1j48jI4iwOJp7ytWtcaKX+UZDv+PVy2M8sgzhb7A3ZNa1JCLrUlkak3Rk+tH
2eSDoEbM6PyCSHZWeAdpepdgzLZwcCkcvlBrbvbICtiL5y60cTnb94dfCyxqqv+m
M07enFRLku5ZcJv1IdF+jVJjAPqdsg==
=zXrV
-----END PGP SIGNATURE-----

--tf2yxVVdxALET0IF--

