Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81F444C534
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhKJQmq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230101AbhKJQmp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Nov 2021 11:42:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A1361058;
        Wed, 10 Nov 2021 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636562398;
        bh=zp2JZUBJUNR07JHTJQqI0CYJegFcSYByxA9sJA2kn8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfL49UZBmKJAN6oAJwZ4YGTJujUpoSoTVk8UpMQp5B427aB6OlbRbK74e0Oz2nHTD
         vTvsddJ2xqYk2qz64pOxCeehRx7jKF2sp3K2pLiirOOb12IZ9Ewq1eCWMvfN6BW6ae
         rRniUu0sfWEJ3vwAtBvvwYVQgOIDdtlpppS6aQQujtP1NYhqb4J9/RZZi5V+581eoc
         Uf5BvTzX6FcZBc4QgMgwObvrgxO22s7spGQh1E/HFD18m4SbvedmGwCpDv+WlEEhAn
         TbYc8ZJe9vcql5o1XH9911LJft/ppXsTYCoUBxpo4Gk+37HKjYehA02uaPpGio8L9L
         dckHQ8YsiIrXw==
Date:   Wed, 10 Nov 2021 16:39:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
Message-ID: <YYv12vhqDVpJ1lS9@sirena.org.uk>
References: <20211110160836.3304104-1-michael@walle.cc>
 <YYvy79HfTvy8hC5/@sirena.org.uk>
 <116159a7cf1e7cb3817aa31931b81d91@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="loCc5CY+lt08QwUQ"
Content-Disposition: inline
In-Reply-To: <116159a7cf1e7cb3817aa31931b81d91@walle.cc>
X-Cookie: You have junk mail.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--loCc5CY+lt08QwUQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 10, 2021 at 05:30:48PM +0100, Michael Walle wrote:
> Am 2021-11-10 17:27, schrieb Mark Brown:

> > > For reference, the kernel oops is:
> > > [   20.242505] Unable to handle kernel paging request at virtual
> > > address 0042a2203dc65260
> > > [   20.250468] Mem abort info:
> > > [   20.253270]   ESR = 0x96000044

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative (it often is
> > for search engines if nothing else) then it's usually better to pull out
> > the relevant sections.

> It was in the comments section of the patch, for exactly this purpose.
> That's how you're doing it, no?

That helps with what ends up in git but it's still including multiple
screenfuls of noise in the email which is where the usability problem
is.

--loCc5CY+lt08QwUQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGL9dkACgkQJNaLcl1U
h9D0tgf8DZPzSAc0fsQNrnqkfX76svhpTUWRk6rbXPzPUesHWfOdsrT9Kdz6V1GP
vIWqHErrwK5UKd5GIhoUy37texlZQMOjvMrdRASzShKU3hYAVPm+k0Uu4pGrfAvu
QH1z95zapp3nTaetuVfrXMHInz2/ecf6z7867Pn66nB4YuaLX1LGy0R6wJ1aPhi0
nZ8fcfHj+FcyIx3+C8bE28Y1lH6/QND0NcqyDfXUBG6AJkNNDNogfR/IJRX/I8eR
MApPCFwM/NHgWaFv9w94d7j0Qy9qEgKqAXs6tsUr5lDhFXT3+hYl1vUowPTJpBIY
M0+m0F7OSaCfpXOdkNwOcdabVgIdHQ==
=/U7j
-----END PGP SIGNATURE-----

--loCc5CY+lt08QwUQ--
