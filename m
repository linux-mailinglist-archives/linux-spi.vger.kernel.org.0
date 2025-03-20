Return-Path: <linux-spi+bounces-7262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B296DA6AE0F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF4A189EFA8
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73362288EA;
	Thu, 20 Mar 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3lHK5vH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4A1C69D;
	Thu, 20 Mar 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496954; cv=none; b=g02BRJ5Qi+JE1HkaTTjcJJR7oaWYkluCnfeD9Rp1cHrDdBJo7srDYx/z1qTs/aiaPorPqhc62fRUdKyazU1UzpET06N54dEVdeK+hyVP4xvHmdBRp9NXbmcDtpDlLTTunXAkixQQ2UOInghpxhdqID1EcAK9UdHXMgfhVPkodOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496954; c=relaxed/simple;
	bh=bpN/85K3GQ3AlOPx5AI0LjvEzJfDvNGW47DH3s5PiEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ7aLiIaaVZYSaYw4lnAdlBRYz5jUIx3PfKQ+j5oNfX7z4W598vvgppoQPR+AELNStySN8xueI0PucXjFu94/Omz+eKjGXECAI7Rvzs/gEmR4kZA1MVVpPxdVf45vW9/APEObfzUyoF4PvaULfEdG6tDgb0C+SPkmQP31YHRork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3lHK5vH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B057EC4CEDD;
	Thu, 20 Mar 2025 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496954;
	bh=bpN/85K3GQ3AlOPx5AI0LjvEzJfDvNGW47DH3s5PiEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3lHK5vHOqpFKN1p3oJ3mUrEoqQ81FB0P7fbPDe1YezSmZV6wSL52DcI+X4wO8oTu
	 y8sPDVBbPi7g5gRrk4g2PCEtvi5oWabcgJGE3EkQvU1+LcpS28Prpuv/rVjT39iptx
	 Bw7aJ1dU6fHji1x7v+0LykFg5SrJu2VLPo1QvXf4s4rErZgG3YKnwUySAij60V7RA5
	 iNBVL3ANuGxWyCHYPpoYL5Bt/vz+iQtubTo9f+6+sd0Td6eJj7LZZkS5hfy+UAlhvA
	 wzEJUZo+AxUGx5bSABIwep3bniIGzEHLZMVDfjzd9LxzlqLoIM9qR22vZhpP8siwYk
	 m5QV5kkAEww2A==
Date: Thu, 20 Mar 2025 18:55:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] spi: Ensure memory used for spi_write_then_read() is DMA
 safe
Message-ID: <c46aa694-d804-47d6-a2d0-990ca6fbebb2@sirena.org.uk>
References: <1359268504-24937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130205142128.2E28D3E1265@localhost>
 <20250320124330.480d652d@mordecai.tesarici.cz>
 <ca70e24d-57b6-4250-bd0d-7f5c72e1d282@sirena.org.uk>
 <b37480a4-5344-4cf4-8fd1-400e2588fc28@app.fastmail.com>
 <20250320153536.44774a74@mordecai.tesarici.cz>
 <9ac953ec-fba3-41a7-8e5d-b867abc1566f@sirena.org.uk>
 <20250320170846.64db4a4d@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gFCt+t73yFgTihPX"
Content-Disposition: inline
In-Reply-To: <20250320170846.64db4a4d@mordecai.tesarici.cz>
X-Cookie: Do not fold, spindle or mutilate.


--gFCt+t73yFgTihPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 05:08:46PM +0100, Petr Tesarik wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 20, 2025 at 03:35:36PM +0100, Petr Tesarik wrote:

> > > CC'ing Robin Murphy, because there seem to be some doubts about DMA A=
PI
> > > efficiency. =20

> > Or possibly just documentation, the number of memory types we have to
> > deal with and disjoint interfaces makes all this stuff pretty miserable.

> I have to agree here. Plus the existing documentation is confusing, as
> it introduces some opaque terms: streaming, consistent, coherent ...
> what next?

> I volunteer to clean it up a bit. Or at least to give it a try.

That would be amazing.

> If we want to make life easier for authors who don't need to squeeze
> the last bit of performance from their driver, the core DMA API could be
> extended with a wrapper function that checks DMA-ability of a buffer
> address and takes the appropriate action. I kind of like the idea, but
> I'm not a subsystem maintainer, so my opinion doesn't mean much. ;-)

That sounds sensible.  There's the dance that spi_{map,unmap}_buf() is
doing which feels like it should be more generic, a general "I have this
buffer, make it DMAable" which sounds like the same sort of ballpark and
I always thought could be usefully factored out but never got round to
finding a home for.

> > > I still believe the SPI subsystem should not try to be clever. The
> > > DMA API already avoids unnecessary copying as much as possible. =20

> > It's not particularly trying to be clever here?

> Well, it tries to guess whether the lower layer will have to make a
> copy, but it does not always get it right (e.g. memory encryption).

> Besides, txbuf and rxbuf might be used without any copying at all, e.g.
> if they point to direct-mapped virtual addresses (e.g. returned by
> kmalloc).

> At the end of the day, it's no big deal, because SPI transfers are
> usually small and not performance-critical. I wouldn't be bothered
> myself if it wasn't part of a larger project (getting rid of DMA zones).

Some of the IIO users might beg to differ about performance criticality
and transfer sizes there, and there's things like firmware download and
SPI flashes too.  A lot of the performance work on the subsystem came
=66rom people with CAN controllers they're trying to saturate, some of
which was large messages.  It's not the same situation as block devices
or networking but it's an area where anything we can do to eliminate
dead time on the bus can be really noticable to applications.  It gets
used a lot with mixed signal applications where implementing digital
logic is expensive but you might want to get a lot of data in or out.

--gFCt+t73yFgTihPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfcZLUACgkQJNaLcl1U
h9DOIwgAgPEw0mfje+6KbfDLvx2eO3UqUQ8cGQZ1eq97+oAVr5FhPdfZbvtEylBu
jRGSiB6i2jFxAFcEUHFNDmBEXIHO97CDjoe8bcqui5OaEisPaQpugFbpFKPAiwSa
6rXpZmIXPeHxJ5gBFE1c2zsGPSnoZVPSowlX1d77aR/eqHP3VcxDMfLmJkufu+4O
L+e2LFCXnf+88o79K3ZVrartGpNQ5zRVL2/jLFzsWYzlZJaxla/NLm2WoyBkbaVk
8mbnpdGXs2D03zXIUAYAEgFbFiiz7AQ5997bWAUidbzThMtq0bKmh5odjwI5hq4g
+PY0lhtuYrNr8wmyqmTPzm4OEbgehg==
=cWMq
-----END PGP SIGNATURE-----

--gFCt+t73yFgTihPX--

