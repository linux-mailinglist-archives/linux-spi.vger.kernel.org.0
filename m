Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD32CF35D
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 18:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgLDRvj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 12:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgLDRvi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 12:51:38 -0500
Date:   Fri, 4 Dec 2020 17:50:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607104258;
        bh=Zelt8CAd5pxJ3bkmos8J2geSRPu13XtbYNa+w6ZJCw4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7tjGJEjV/fMEVT0pTgM440Gq87sqjjzc2jFRuZk/Q298HrUyCMb8i4tlumygKQaY
         mtit0YZoiAW/8RWd+1NFJpi5uKjYyCju+i3e7dSfHM7W8HtcwAgJM0R4eKTo9juTfd
         yzu78hlYuSmk9ggTdBmXQFybHKdRF6uPkFB4+uYnnZvqb2L1seXZTKD3lkjL0OfCob
         MVttTRyqJWDyL5wRvh3fUSg0yufywYYVpe0+8VmGWVqcnts7hu2KIz0NjK37vzvxSN
         zpOAsGy9buQpks3WERYkvDQpQVY3MhvvqnwBL1yGAb8Fdr7pqqVI73y+tdZ51o2gPd
         iZay+J6UXPoHw==
From:   Mark Brown <broonie@kernel.org>
To:     Karen Dombroski <karen.dombroski@marsbioimaging.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-zynq-qspi: fix stack violation bug
Message-ID: <20201204175054.GD4558@sirena.org.uk>
References: <CAArsxNtnCuALXLHLETo5w_EbjrRJdSSte7Xa3nEnVcVw+hV=sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <CAArsxNtnCuALXLHLETo5w_EbjrRJdSSte7Xa3nEnVcVw+hV=sQ@mail.gmail.com>
X-Cookie: Not a flying toy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2020 at 10:13:19PM +1300, Karen Dombroski wrote:
> When the number of bytes for the op is greater than one, the read could
> run off the end of the function stack and cause a crash.

This doesn't apply against current code, please check and resend:

Applying: spi: spi-zynq-qspi: fix stack violation bug
Using index info to reconstruct a base tree...
error: patch failed: drivers/spi/spi-zynq-qspi.c:528
error: drivers/spi/spi-zynq-qspi.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Kdv4ACgkQJNaLcl1U
h9Ah+Qf/dJaiwOJwn3LE7ZU6s1yQFl/dRN845jmJxKArKMyPGsBqTOBs4bQXUKJW
Z9jc7Igq00BLR7ikdS7+mz4MOIwdHiWxvrMkrVhZ/c2tqPwJCV5r0dbl6uU2TTMx
U6yaws/6NBuitggHPK+ew4kpeZVe8ls4Sjmfi3h3jStm3VulzX3I6bQ8II3FGfle
XeRGU+P4qw6/F6R0+rQukJbHYXHHKHatUQpf0hEzHvMisFUl0b1f0lwFXIGIHqf+
p54ir9xrNzL5Vr9++idx6fDZD9LAa7ZxlQ7rh8WboAU2YO2D6WUfDxHGsJ7uUkjG
ldDmLR9xjHBYARs4AMqJjDsCuh1Zxg==
=YIGh
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
