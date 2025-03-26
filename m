Return-Path: <linux-spi+bounces-7323-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A271A71BA4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC77A652C
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF01F4288;
	Wed, 26 Mar 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhU7SCX1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A01B3950;
	Wed, 26 Mar 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006027; cv=none; b=G8YRKZbZ67P0oFiZ8BW4oOs9eDCAWsAXnXYmOPtYEnQfaPcWnnsdW+V0i1DFbFFebE9mK8RQVd45Z7ln3z7iB3DAuHSVB7fAb4lF2WNzBOBsKHK8gROwbYMWbfdLBnqQ7XGpFDjC3XVGD5ZSYjrOObV+13iOooveqdX6ZRQtVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006027; c=relaxed/simple;
	bh=NlyzFBEeZY6V7OLkIjQjuzyo0eIa9iyxmf4xj+EVJ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nToS9J2bfzUvnJuCMu3TB4Yz077SuwQtT1fzXH/8XKHa1NTb8FZGIA0mwTPVKG9FOwILAV6KpsUk/O4kpXlw1Kk4bzhH0D8uYOQjHazrkuq5GnNylY9sN82KqXbqmRVUlovZrnEgSMQsXF+ozQaRwVTbAI69yln9rvexVEX+9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhU7SCX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8312BC4CEE2;
	Wed, 26 Mar 2025 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743006027;
	bh=NlyzFBEeZY6V7OLkIjQjuzyo0eIa9iyxmf4xj+EVJ5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhU7SCX1EZkfMdCUrAoOdmzMsYCvS9EBOn96zC+5i4ZUMK71ZfjOtCLBGFv/GtzwH
	 tYawjy9n4mSiaGGwQ3RQUPiNYB5KKkMobVUrWtZXbW2tzKGAnM5C2euC+OlSffvtKy
	 IC1yxRP5NXTBkJArG40KVjLQ4aKZK539+8hzbi1ssT19QPC9q8cAkKHDu5DVxsAD2w
	 ULGYiOBVZGZENJAWg9rXLcVPT1fd0br1Qauu1yQLRd0olVKEtmHS8R9kSGxxYRxtaO
	 soOdvXEd/Ig5sM8jmhXY7Q64o1WHKrD3ruC+QIXdOePbcvwVmFmjJawjIUqs0bTHOW
	 5JBMRXLlpw9VQ==
Date: Wed, 26 Mar 2025 16:20:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Tesarik <ptesarik@suse.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <8ff02f5a-fa66-4403-b193-a18c23879e0d@sirena.org.uk>
References: <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <db36bbf0-0ad5-4c37-bfcc-917508805eba@sirena.org.uk>
 <efe910db-77d0-4ddf-8fc2-df4955e7b9f3@app.fastmail.com>
 <06435855-531b-4a3b-9f2e-1a5caea0d65b@sirena.org.uk>
 <38fe54d2-bd8a-4655-863d-cd1c482ac9a8@app.fastmail.com>
 <Z917hRQM2ZhSwvFx@finisterre.sirena.org.uk>
 <6a3a4b10-f51b-43e2-8281-057f6751424b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XACVXunMOL7SbzcG"
Content-Disposition: inline
In-Reply-To: <6a3a4b10-f51b-43e2-8281-057f6751424b@app.fastmail.com>
X-Cookie: To err is humor.


--XACVXunMOL7SbzcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2025 at 08:42:12PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 21, 2025, at 15:45, Mark Brown wrote:

> > Hrm, right.  I think that usage is reasonable so we probably should
> > allow it rather than forcing things to do an allocation for a transfer
> > that ends up being PIOed anyway almost all the time, OTOH the same API
> > is also used for large transfers like firmware downloads where we don't
> > want to trigger a spurious copy.  Having different requirements at
> > different times would be miserable though so I think we need to just
> > accept any buffer and then figure it out inside the API, but I've not
> > fully thought that through yet.

> My feeling so far is that we want the default regmap interface
> to just take any buffer (stack, misaligned, vmalloc, kmap) and
> leave it up to the underlying bus to make sure this works in
> a sensible way.

Definitely for regmap, I was thinking about the implementation of that -
it feels like something other places will want to do.

> Using dma_alloc_noncoherent() should make the implementation
> much nicer than GFP_DMA in the past, so we could add a bus
> specific helper for SPI that checks if the controller actually
> wants to do DMA and whether the buffer is problematic at all,
> and then decides to either allocate a bounce buffer and
> fill the sg table with the correct DMA address, map the
> existing buffer, or pass it without mapping depending on
> what the device needs.

That query feels a lot like spi_optimize_message().  Which should
possibly then just do the bouncing if it's needed.

--XACVXunMOL7SbzcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfkKUYACgkQJNaLcl1U
h9B4UAf9GaUDUOeQdHmkgV5BxLQkyrxGtsAfFN7ZmUrJUK86sTReHhC4HlaIYj1h
xin3gvNNNzvxSUEkNgEaYKmKlMw7ctR+z5+EPkCc5C6nzAEbi4lOkwLhOh9ZAFh0
6pYikgGsc2DsiBs9xvT6qsb62/Tzoh79OEKD7SIrh4diID4QSdCbwT7O6/8r55qP
VNL/5tWUFGAQ/1fXTv1Hc8dM4kWnFtVR6DcLIq6D32QZxapHGTdKxHzauu2Na70W
XkjgBK8Jp1pQWwgFEXn2kLpOrmMnqlIV4xNMvXVRtHOU9XQn9TnGMIgphxAMChav
Heoaq1jZqd6/nSnRnunRyaOcpVYG2w==
=6pQl
-----END PGP SIGNATURE-----

--XACVXunMOL7SbzcG--

