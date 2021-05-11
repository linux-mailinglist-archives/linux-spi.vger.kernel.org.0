Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D998B37AB36
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 17:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhEKP7O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 11:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEKP7N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 11:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B52D6162B;
        Tue, 11 May 2021 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620748686;
        bh=t9qvcLeZ3fw4S7vHEVM6gHzerTr2Sd8DRnLU7SVUrKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RePWecYEsd6EY+cTouQHYmlunwvTatqxz3LICPjymnJWqjFhgbH2t3hxbxyavvTgz
         c1YDqUZtUy6sROBTprO2SjKdNNubUWenoLNw7P4g+WyT3Ws4gC5d/OGSDZNV3C6bFf
         9QuYJWKSSq3BWSnZwRc9mJynw2YXbNqeF48ToKvSiEGG+JeU93/XF8KQGJgGFR3Vf6
         w7NXM8sPOhnTMPMn6Jfgq6ejtaKucBDsMzybIBLEesO0y8py8V4+ZRXg8xIIGoI4DT
         dMUVgWXBa0iYOr2TR3QuZk34LUMPsEDi+Nk2+BDjMEZ/DkXrIeVQ7x+G8+U9yd85oB
         X25eVj40e4FDw==
Date:   Tue, 11 May 2021 16:57:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: Don't have controller clean up spi device before
 driver unbind
Message-ID: <20210511155726.GN4496@sirena.org.uk>
References: <20210505164734.175546-1-saravanak@google.com>
 <CAHp75VeDzOZ_j30v=rgec2d9f6pPXHXE8BqJN1ARoYkfGL=d6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Content-Disposition: inline
In-Reply-To: <CAHp75VeDzOZ_j30v=rgec2d9f6pPXHXE8BqJN1ARoYkfGL=d6g@mail.gmail.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 05, 2021 at 08:53:14PM +0300, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 8:26 PM Saravana Kannan <saravanak@google.com> wrote:

> > Can you test this one your end to make sure you don't have issues
> > anymore?

> Do you need a test on my setup?

It wouldn't hurt.

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCaqWYACgkQJNaLcl1U
h9CzVwf+PNx4ueYszcj43zEUk1g7rlDCZ0j6Ry8JhOzI9QL0OAAk/YYQGYEheVya
qCpm0TTh9BRUKd7dC57Wd7jaYrgt6jM02zwvd+1BFxyzrlM4U3HlTtEhvgXCjLAB
udVbDB2nm87IoCaQIVIi1T4jrazw84ZZ2+sP2K+ZuygzHKlzn4Doqg+cuf59WNGH
NkwAwEW7eKL9gcUkWsN7zw596R7xqaO1jMhet0mG4pTPi3FxNSZQSH1MRe2Hyx1t
CTYS0YDOCAP1TBTzaTIwKpmu4XUU6eg/H2Eck3olo9p0f6mPIHRgt+A3FB2hfWmn
e0fhxl5g3kVXuEGf3Iw8z31XlDJ+Yw==
=yw8W
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
