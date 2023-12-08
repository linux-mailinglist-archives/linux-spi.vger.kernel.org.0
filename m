Return-Path: <linux-spi+bounces-178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47B80A894
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 17:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553621F2108E
	for <lists+linux-spi@lfdr.de>; Fri,  8 Dec 2023 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7983528F;
	Fri,  8 Dec 2023 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DamV/uBP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA51DA51
	for <linux-spi@vger.kernel.org>; Fri,  8 Dec 2023 16:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21356C433C8;
	Fri,  8 Dec 2023 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702052178;
	bh=HNMdAMXJERUF53Kjs3E4YL0gn1F8mGeITFeWYHqhCY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DamV/uBPQc58DmxPnUsISkF315n9vxPM3sL0n8Yr8uCCL+/01CCaF3yQmBBMH4RGO
	 mLJgBCX1+o8xVVan342PGxbBpaPu78kdasv/k6JEMMZNbS2MpDWwDBdMDB3DPahRNS
	 fgT2GGqOPzVBB7fs6jODEh0V0jlGXp0mxPsNnrl50zt1YSQ/RULU5SvLOSZS/wGEs9
	 cUhfEGPWWU3JlgAn8sWUmy82kYkqguJxqYbQ1Hre4V1K7REonWSV0N5nGR4vYWL4iq
	 vJPI4bEV3CF8tJdvtunLCtzGce4zuQvreZtqgA9meoSPUJJjSAd1FlESjYulOo+GPy
	 1mu3I/McX2bdA==
Date: Fri, 8 Dec 2023 16:16:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Update DMA mapping and using logic
 in the documentation
Message-ID: <ZXNBT9/sDSuTrvxh@finisterre.sirena.org.uk>
References: <20231207221426.3259806-1-andriy.shevchenko@linux.intel.com>
 <20231207221426.3259806-3-andriy.shevchenko@linux.intel.com>
 <ZXNAVXRG9aXWlwsu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7R8vsKA7asubWBkm"
Content-Disposition: inline
In-Reply-To: <ZXNAVXRG9aXWlwsu@smile.fi.intel.com>
X-Cookie: Slow day.  Practice crawling.


--7R8vsKA7asubWBkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 06:12:05PM +0200, Andy Shevchenko wrote:

> Here seems inconsistent indentation. I'll fix it in the next version.
> Mark, should I resend patch 1 as well?

Yes, please.

--7R8vsKA7asubWBkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVzQUsACgkQJNaLcl1U
h9DGoAf7BJ32xvvFG1tg3bveQjPCnizwGDyXGr/VZTS5TBu4gy/MGCnnJtoKMyDM
g5hrhRhHaQ1pgkhrogRB+h1eYSJmatyoFG/6O90rXKplKDCmMiJDLjgh0XBEoRhA
GLY8QuXkMPxcabXKbS0FH8JiYNc1SSYlvb2oPSbdZvc5q1lCx8wPrH9PK9zpcR3q
0psdxqq6DD5HVgvVPj7V10e4fXBziBs5EK31sZ4MlR+7ujuFVFFVkZhpeFdZQBn8
qW5JRXvInozVGweNGqixP+SY1KpYd3A8miZlXgwX0YOLQz04aHFjtqP2rhK+qWR1
454pv9eUprrY2CoIWwvnnCU5InHSXg==
=obtJ
-----END PGP SIGNATURE-----

--7R8vsKA7asubWBkm--

