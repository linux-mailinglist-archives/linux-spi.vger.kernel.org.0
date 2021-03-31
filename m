Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1734FFDC
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 14:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhCaMCj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 08:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235026AbhCaMC0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 31 Mar 2021 08:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F948619A7;
        Wed, 31 Mar 2021 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617192146;
        bh=kx89Io23Q8ZxH7C3ANoGwwn1hMUH+9hU4XuiNNbOCtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmzjt+2QN7B8zSJ/azvtMd4XfsajMuFWK1f6KnjWtgVmrdb/IF2nfakhzQeDebFLm
         1euJ+j/rpYeUM/a6aOv7+WeM+WOdllSE0UIwuSi58PsC5kWnulBcTrWjdHgjTK95/W
         SyxG0/wTci64aZ21i5vkVKbc7pTLNJ37lM5vzZnlTUHKKIqPmaz1tngBmzqLDdlccL
         NqX2okZE+joWMRpueABCta0wJC1rp9gOlLNiXrEISaYlUFKi57mlB457gfhnGi64IF
         As4llUrgKxgjdVcKwGvt07G6/JDo0jrDMwEHl63xpiQ8D3eQ/9vmkw0E9U+8a5SCaL
         PzhZBqEtblyUg==
Date:   Wed, 31 Mar 2021 13:02:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        kernel@pengutronix.de, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 6/6] spi: davinci: Simplify using
 devm_clk_get_enabled()
Message-ID: <20210331120212.GB4758@sirena.org.uk>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
 <20210330181755.204339-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20210330181755.204339-7-u.kleine-koenig@pengutronix.de>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 08:17:55PM +0200, Uwe Kleine-K=F6nig wrote:
> devm_clk_get_enabled() returns the clk already (prepared and) enabled
> and the automatically called cleanup cares for disabling (and
> unpreparing). So simplify .probe() and .remove() accordingly.

Acked-by: Mark Brown <broonie@kernel.org>

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkZMQACgkQJNaLcl1U
h9A2MQf1ESv/EUxbKK+nyFc8XUhCYaDUKRl+7/HLRrinK1DuMXLguBIF9AfuCexa
wLkezxpdjngw261Gag9/sZM0lRYgp3tpEnAY06ZQtYcQcYpQQcabkRkesC4jvo7N
KIX1m4sKssU2q//At6vZhNf0YdwzI1rcO8pGBuQM5Yz1nOKCVw9YjRTlafpGDub3
MdDi6IHXe76IB8iOYHS4kgwY8guwHqo0kIPKEAcSLMZyw3r2m8xxc4NX+RKiBC3U
EBOzoZdLf2Xv9Z945Ai6bgyNizlNxBT4PrAH2gNaY6zYErYztX6DSv9FGG9Tiwu6
yOEGoTnA0KVSLnDBIXx4y8Mr7Diy
=zqmZ
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
