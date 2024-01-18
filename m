Return-Path: <linux-spi+bounces-500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D4831952
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 13:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877C42858D7
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F06125A7;
	Thu, 18 Jan 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7G0JwaH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAD241F6
	for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581731; cv=none; b=sRaQdIx0GSam6gd9qfr/x8Njsw9Lhry623rEwXmrrZsuSKfZk13oYrJaJ0hyAKVbbzXzTEuvwP5BANJ4FP6JlWegvRPE4ol180KOP7eB5RYru3M/JBE/Qa8+umr8FfdDTO+BGoqTRYWlmdnAbrk1kHyNzx2yooSF+J5CmcUZOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581731; c=relaxed/simple;
	bh=W7OSW5dFdo/XvtJWe9lEGiRrdv4cFaT96XCmhrn/kVk=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=CJm9Bx90MSf/i4IYlOOoNiyjYm2BCmqsH/uscTjzoXTIHl7vPYtikEexEHg7TZp1IsAAhft1Ncad9rDIgnD6PrjF52ONt63QrLjCH4GZ780IyaiS7I9kvGLTW3TSnuqpZL09pnXfHhaZaTcLMQoXfh/Muc3SS3nvIWbBjrgzohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7G0JwaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAACC43390;
	Thu, 18 Jan 2024 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705581730;
	bh=W7OSW5dFdo/XvtJWe9lEGiRrdv4cFaT96XCmhrn/kVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7G0JwaHTniE+I0iI8qTDW/uSJvAu7lrGGQnnYGyxVwyFZErO1EvArFeq/re86Wxd
	 e2et3HvflvRkkyK3fbIjFuDLF1ZJ2PvWqH3RYP3jFUomBmAUj6LQwpxv5dqiXGI9+b
	 7VIWP6bOuUD7Q4NHig18IpasM9/wApYci6/bFDSXpksgBNxa5MsYz+dkbamXy9osUo
	 ObPaz2MrHaZrJNDPma9rSZ4H6jQzlWc2tN/IVtgkBFM4DQuloOXfaqHPAczIYDbB00
	 MgGWE2ieX5rd+CM6Es3F0p2ETTlwKE0IhhHA20pe0al4g4+haz3PUrI8WYEOlh+ZTc
	 hCR64ltBoM2Mw==
Date: Thu, 18 Jan 2024 12:42:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: akinobu.mita@gmail.com,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	kernel@martin.sperl.org
Subject: Re: [PATCH 5/6] spi: loopback-test: add elapsed time check
Message-ID: <a176ecb0-08ed-4e1a-bd0a-aaf70186f5bd@sirena.org.uk>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
 <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
 <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
 <e3db65ab-be7e-45dc-9104-fe2a3b046b7d@sirena.org.uk>
 <f0a9f2af-f737-496e-a1bf-7758826089b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1cuev2445iwSYFPn"
Content-Disposition: inline
In-Reply-To: <f0a9f2af-f737-496e-a1bf-7758826089b9@linaro.org>
X-Cookie: FEELINGS are cascading over me!!!


--1cuev2445iwSYFPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 18, 2024 at 08:30:39AM +0000, Tudor Ambarus wrote:
> On 1/12/24 18:37, Mark Brown wrote:

> >> [ 6748.913400] spi-loopback-test spi13.0: elapsed time 532837 ns is
> >> shorter than minimum estimated time 82240000 ns

> > That's a *very* substantial error, it makes me suspect that the hardware
> > might be doing loopback at a stage before it actually clocks the bus and
> > doing something like just connecting the TX and RX FIFOs.

> Thanks, Mark! It was a problem on how the clocks were handled, I ended
> up with a higher frequency than I requested.

Ouch, hopefully that's only affecting loopback mode and not normal
operation for everyone.

--1cuev2445iwSYFPn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpHJ4ACgkQJNaLcl1U
h9Brzgf/dT19ztiVrdJN0n7ECZZxNtJAz/zHh/4KkCp64IobMuJEGxhue4z8G5F+
Y/344yfIU6EOa4tjhSDrqA6nBM9hhmeAeTypXF+pGD6FJJl7yni7lIGsrx+lJulX
P8TX1U0VPND7vGgS3MnMTzsmQD5aynjQboEgW/LORwFDP+lZKQ60NW0ZGZEVjlgj
o1SR8GNvU7QIgABOpKq2p2XIacOwR+I4lOlhNuehvRamMp6TYYIIbMOkdRdjuuHm
t1joOAB1+WQiwBO7JwBsp7xv0fiMWP4jUE084yfL9lWYlJq9Pq9Lu8ukdryZTS/y
GFbhnHloiUn9fCsT0YSwJnTHyujeFQ==
=3/IC
-----END PGP SIGNATURE-----

--1cuev2445iwSYFPn--

