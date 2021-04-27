Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7D36C45A
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhD0KuG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 06:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhD0KuG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 06:50:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 800A3611BE;
        Tue, 27 Apr 2021 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619520563;
        bh=IynpH/1tZ1nW6uCOBCWBcA5G5XhdF8ILsL5RRo+T+rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCZkWgNR7EUi6Vrj/X8aDl3mt046jiqPhrVvAxguXOa9QB+z/JAo/Y24oKGLaxKVB
         SIiRW3cvOOHeoOIDledUTYnby6pd/0mw/fnp8cripxbX/yczVYeJMabawfS3+gNXc9
         lpfxnCErRzhhe2DHMGbZ0qE6RHgTyInBmU0HVqg7zuAmuKtQOIZ8maul8RMgLfFk0G
         1Z+fKR/k7z1WSA/yWx4NWbwM+CybubU4LUTHr2S+yqeuWZLKA3+wH7M3CB5bkqv9MZ
         l9hdBQvMU2K/UfWzZ+n+H0Qo/UfigG3tmS5rFWsBHk+i87HnbNdkhjUpmD3A/yt1pO
         SwQzKqop4hmVA==
Date:   Tue, 27 Apr 2021 11:48:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
Message-ID: <20210427104851.GC4605@sirena.org.uk>
References: <20210426235638.1285530-1-saravanak@google.com>
 <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 09:52:48AM +0300, Andy Shevchenko wrote:
> +Cc Lukas

The cleanup callback has been in release() since the framework was
merged AFAICT.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCH7BMACgkQJNaLcl1U
h9CF8wf7BURoXLMYVywhkygz0iKZ9Xze/7xlPD0oYbX4+PrmOs4si7yFfJ2qhhvk
Z8D6ueLlYp3+YvoNglU5Y5laqgr8qCkzU2XlhomcMRVwy6iTjq63SF5CXgMH+xYE
l6h49/4g3gPb6kXVPAPPJJ51yKmtYhpCZUXQ75CoxQs1mumadPlXfgNhU/bmNRsI
CAMq4KkqiB9wF23QyrUngcscq2k5bcizXLDqw8j6b5ctjCMaHwJydqTpxyIIZ//9
kAayA7U/MmSKYwsoMmAyqFwpy2ikNlRkIDUH5Dhq1+dCBh67sgjCqSUC/8jIOr7q
LIN+kgWRo6dmPhk2WoDF7dwW+n2Zfg==
=LOiQ
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
