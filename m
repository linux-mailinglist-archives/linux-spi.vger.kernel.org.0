Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5D4039C8
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbhIHMai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 08:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348699AbhIHMai (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 8 Sep 2021 08:30:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E8796113D;
        Wed,  8 Sep 2021 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631104169;
        bh=H2yqdg042QZvfnnf4VNJhOk13tNuvmz5KtZpoSh4nC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHH1MofH+bfPo0ZHlv2NqP4QvbVZ/mhBj0pj4cgvXQV9n06lat9CNq+S3f/yjSQaM
         Hqg83VYW5nmDjQufcYKQY9CcIRCrhWajUKRw6A4yfJBuZNkJVkR8rm5mAEMyMQ59LY
         b3la2LOSJcy2eGrqzZcJWo/CB9BgXCltTon/5FL6trIa+TdvZ01x4Hg6TQOQT0a0ew
         Xaz5gZX1/XjCXdqI453JlAhFJoZuIbBie27BSSpLLGlhLilDstTLVlMRe7WmRJa1eh
         WOzYuBcWauqI0BotuvENmflbOGNEu2SqU65t2x1WpQMGKrZ2/YEANKiH7cgdHTA+u3
         BvD6li6RQaQbA==
Date:   Wed, 8 Sep 2021 13:28:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 00/10] Improve support for AMD SPI controllers
Message-ID: <20210908122853.GE4112@sirena.org.uk>
References: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 08, 2021 at 12:34:41PM +0100, Lucas Tanure wrote:

> Lucas Tanure (9):
>   regmap: spi: Set regmap max raw r/w from max_transfer_size
>   regmap: spi: Check raw_[read|write] against max message size

There's no interaction between these regmap patches and the rest of the
series, they have no API impact, so they should be a separate series to
avoid spurious dependencies.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE4rIQACgkQJNaLcl1U
h9BI/Af9GThj75M3D18NpEwtpTSUJWMvhBRPxiwO+UqXNa810L19otzO2M7R40Mq
8cOoGb5qeqKfwTAlgskjBSzyKJ1zueyt2v4BGf3OCejywW4JPpdu4Hpr+COL649c
8dLFo4x3dA0R6p4LW/LE/8nEJ/P5wLbMiMzj5Li+O0csWSrKQdDt3shSGCCqm8NA
OKgPXZl+lJdyLjClERl5OP0fVHm+rMQB0H5sp2kaYOyyK/8WG8MGFp1vfGdqUtg5
Qgh33uXxzep+gI1XiIyVXYiCCookQVQM4P7bNr8+4hN+VNhG34NC3WRfpwPRdyGv
XgRIJ6MoJh2kvD5ZO84hfOd3PfG63Q==
=eyl4
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
