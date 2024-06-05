Return-Path: <linux-spi+bounces-3271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F228FD859
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5A61C21F0F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DB715F3FF;
	Wed,  5 Jun 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5eTOdPO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63CB15F321;
	Wed,  5 Jun 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622569; cv=none; b=dq8RkDaGaNaeY57wImMSJRE6oVCiqjdpRg1cabnHTO8c+exiSVxLWaPRDfMKKjERz0/ekhIgUPoRhZ2U6Wi19s871Vd+YmXnHZ0jirhYXo2SvHYUCQKA0UuOY+4NViJNoKECKdXCpDp+wW+63/jx7iNF816X/CX3TBa7Z5R6Ss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622569; c=relaxed/simple;
	bh=9ELB2XwksNK1kao5A30aeiFYFmaXRPLHmU2DJV4DaqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF7dahkpVtWSM5LCurLgGYquI9tFMNOZqkNYtt6lupEUBNBz30L2EcCjJU93MhBYTY/1lpztPy8SJMaYlSde0a1hAiuqk4SLJ7hYSVhO7VFNwYLX3QldSyy3x52fBZbT5m28Z9fCdBK+Jf4gwWhjN8UJylYigA7yqNGUPef0/7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5eTOdPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1E0C2BD11;
	Wed,  5 Jun 2024 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717622568;
	bh=9ELB2XwksNK1kao5A30aeiFYFmaXRPLHmU2DJV4DaqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5eTOdPOXuhVSSvFZ0phbOxUcn4jf5NFQdlrmwrWhuJCd5KgGjBaP0mEgAdsllc+z
	 r3yeGPPS4Cg8GXM267to+0sy8XSf+wTpbUQ5XUV1s7gHtXzUaFueV0GyEOCCv5DAnh
	 E1xpTUe3Lh4pWFUpkRlLCcGfguW05lfX6FvCdoxpnQK2CSYCa4a4SM9mxh2RdOsJdq
	 fND3yQ7l9IHHq5EbmKTVxD8pXWSnv2MHFM1gqtOy/Tkev2Yv4GWBMvznw/qbNPCu5l
	 GfPwE3NgtZEKKpH86eWEzfKOpUnXCKPN79bmj3dIHqWX5LshnJBYKrK1vtVx4jCMyc
	 5rxMGrRPMQL1A==
Date: Wed, 5 Jun 2024 22:22:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] spi: gpio: Make num_chipselect 8-bit in the
 struct spi_gpio_platform_data
Message-ID: <c7ba4e75-0577-487c-9e79-e8693bd66de9@sirena.org.uk>
References: <20240517194246.747427-1-andriy.shevchenko@linux.intel.com>
 <20240517194246.747427-4-andriy.shevchenko@linux.intel.com>
 <ce75b03e-e061-43ac-94fa-1539c8fe6203@sirena.org.uk>
 <ZksXrM-W_69e5q2m@smile.fi.intel.com>
 <ZmDUBHUyy1uozcn2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kIGtS6zyCrkHUyx5"
Content-Disposition: inline
In-Reply-To: <ZmDUBHUyy1uozcn2@smile.fi.intel.com>
X-Cookie: Simulated picture.


--kIGtS6zyCrkHUyx5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 12:09:24AM +0300, Andy Shevchenko wrote:

> Should I do something about the first two patches or is it fine to get th=
em in?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--kIGtS6zyCrkHUyx5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZg1yQACgkQJNaLcl1U
h9AN7Af8CEZYtjw+hfXN5Z9zpRSvcnt7ICD9AB3oWsv4UM/9hERrcnLE+IxvNgNR
hGVd8vDG/VPcgZx2yDtdIj4CWi65Gwyups/N/ON4ZcgvYxFZDtYfI198RZyIyMAL
MsNTldJjvMju/4saXVShmApuEt/hgAci77IAVdxaspMqKywJEnsE17DWkp5GNjAl
F+L6F84h15DO0UApym4obk9rVGqGlvcuGot8OAuhA1xiVborcD8beOAq2uCN3grt
wLuVGxLe7FUyyerM4DMTurL54HIRU91Fi4HxH5oOpxhkED4KCDdVwXZwjU7tx/of
Y5uSnOC6zLu28BPpjPT3kUxxIy2Esg==
=4pcS
-----END PGP SIGNATURE-----

--kIGtS6zyCrkHUyx5--

