Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D272D766D
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406113AbgLKNTg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 08:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404425AbgLKNS6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 11 Dec 2020 08:18:58 -0500
Date:   Fri, 11 Dec 2020 13:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607692697;
        bh=2E127mU5eJ6ue3tzTmMDUSWHAoCzUtkbINjTlopsJIA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=PA8BFLEUlLmq/basaIXKyyzg6K1lX9Eygrt9+Kdw6TmDi7YEYc92Zl5c+Tag37uQZ
         l97JGYpnkd1BbYjzdB0RTno6/PTh6r+AZKiY0Vg7Ae1pcsKQX09d1aYDGIg8h9HnBw
         RdvCvH+Jp+1Wg8Ee5T9sDAzSN1VLrvsEWkhWyXj/PzBplt2/zOnRoejD1g4tj2/HFo
         Jo/eAUwu+GMTyQ4GEnoiUiBM21pdVD1i/YWZG7EaQK2FbvzI9KDD50ImnKewK4fUQ/
         Z0IoDweyxZZohS4++spkMSy+eEM4mSgQchrSzDxLlpG0ZbTLBJbrKhGW/6t2Bsfa0s
         SBHkOgeAcG7/w==
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high
 and gpio descriptors
Message-ID: <20201211131810.GB4929@sirena.org.uk>
Mail-Followup-To: Sven Van Asbroeck <thesven73@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>, linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
 <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <CAGngYiVKHoXPGxmScCnb-R6xoo9GNw5pG8V8Cpyk3meoJbskiw@mail.gmail.com>
X-Cookie: Nostalgia isn't what it used to be.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2020 at 12:36:40PM -0500, Sven Van Asbroeck wrote:
> On Wed, Dec 9, 2020 at 4:57 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> > +      device node     | cs-gpio       | CS pin state active | Note
> > +      ================+===============+=====================+=====
> > +      spi-cs-high     | -             | H                   |
> > +      -               | -             | L                   |
> > +      spi-cs-high     | ACTIVE_HIGH   | H                   |
> > +      -               | ACTIVE_HIGH   | L                   | 1
> > +      spi-cs-high     | ACTIVE_LOW    | H                   | 2
> > +      -               | ACTIVE_LOW    | L                   |
> > +

> Doesn't this table simply say:
> - specify   'spi-cs-high' for an active-high chip select
> - leave out 'spi-cs-high' for an active-low  chip select
> - the gpio active high/active low consumer flags are ignored
> ?

It seems to, yes.

> If so, then I would simply document it that way.
> Simple is beautiful.

Yeah, it'd definitely be easier to read and clearer what people should
actually do.  As Linus said it'd also be a good idea to explicitly say
that this is not great design or particularly intentional since it could
be pretty confusing for someone trying to understand why the bindings
are the way they are.

I'm going to apply this anyway to make sure we get this documentated but
some incremental improvements along these lines would be good.

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/TcZEACgkQJNaLcl1U
h9AhFggAgIvhGZX6g4DZGo69/v8qSfuNZJ8ZCbQTMs4G0PR/lhIG26joAjbftMvK
zcxjD6svtCScdLgl3ES3AnmZYqUIy10wH6SGPd9XkpYwNRTHaGrLYsK59k//Luaq
Qh3j7FtB42unAmTVI1rVA2KJac2FkvvNuBxNN8g75+95DXbtnvAkxbYTtFE0zit0
q4jh58H0Zh24LpUhoZKZ2w6/Ra1XaqY1vkh0ys7tMTkShhs1LgSY8OzjDiZ36O1c
JIlz5Fwn1uEkJhxwErccG3NYAdxOqiajOWZDM56ky4T1420W+MTwpux/YXfRWQTW
X/ZvM2NIHyPr5ZnEfrYTVqp+uUKAqw==
=bTcQ
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
