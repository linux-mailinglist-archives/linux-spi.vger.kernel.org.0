Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998B036F8E1
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhD3LAb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 07:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhD3LAb (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Apr 2021 07:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8AE61418;
        Fri, 30 Apr 2021 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619780382;
        bh=tBELwnH1I1kwn2Zj7bFGqXscPmPp5QXvntbnnDhS2kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAjGvjkP7U5JZxnCcAnzTz6gYNVoauPkUYtlO6jCLPmvB/XCTb5HM5Csvs7xqAbZ9
         DI2l37T0/wDXaciIpsojFGMaotMQHwmRpB2x14wjjV499SDoaF/G2fDkO6vjTDRjZP
         MBkK3drVMkZrNnhrgB42LNO4vAmuN8QPk3M5iWNPLiII3fXFuXC8UdEN2FILIU/0qN
         x+fLL/fjPdlpMLlBAxA5JvfVUTHEJVO8cETnaauLuXOKxAL125iL0nuG86OTtUD8Mz
         YsKZraR9C/IO0WFKmlwqpOHQaOncBwcy3cnaKbSkTpEY+W9bptSFdKu+RiF1wc46pS
         wDjWJYecn922Q==
Date:   Fri, 30 Apr 2021 11:59:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, nick@khadas.com,
        Gouwa Wang <gouwa@khadas.com>
Subject: Re: [PATCH] SPI: meson-spifc add missed calls to remove function
Message-ID: <20210430105910.GA5981@sirena.org.uk>
References: <20210423034247.992052-1-art@khadas.com>
 <20210423114735.GA5507@sirena.org.uk>
 <CAKaHn9+d5crmmG-aKyLuvyxk+A7aC9qqfX_3wuMXm50pg+pZ4w@mail.gmail.com>
 <20210426115645.GB4590@sirena.org.uk>
 <CAKaHn9JM-KEiz3_Btsz8_fr7hcZ2Sm8B64VyLvgpvKK-NKco3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <CAKaHn9JM-KEiz3_Btsz8_fr7hcZ2Sm8B64VyLvgpvKK-NKco3w@mail.gmail.com>
X-Cookie: QOTD:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 04:49:35PM +0800, Art Nikpal wrote:

> Yep! but

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> if i try call spi_master_put(master) or spi_unregister_controller(master);
> it's made Segmentation fault for me
>=20
> what's wrong - may be somebody can help me

Probably something is referencing the controller afer it was freed, I do
notice that the current version of the driver uses devm_ to register the
controller so you'd end up with a double free unless you either use devm_
when freeing or change to a normal registration.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCL4v0ACgkQJNaLcl1U
h9C+ygf/aSVidn4I4EOCKFzVvuP8YtVO/LlZ673fdMyXlahIvobO2X+Q+kJBMo2J
s7Lj6lM7SL6CA4AKXi5oiGD/nDKxNzlPzm4YsCiqmmtXov0lJlvIPI9WP5eCI4vh
4tFrzc86tskjj1elOlGLTDgYDoEoxF11+Qmo34pOBNlPiDQcGzoN2u0IHPgmEZIr
8PaJ0kFyD0svdptByZp5auKmNWSaOfUYSCqTD6NLqXgO/7kiS9gt40a3X2zlcSNB
fhU5us6mx5hC0snp0O1rzjQDaHZBfi5WYk431gzG3ZG81uyJdKQ7iFjuz71Vo+nJ
cG5VuDJ8NoOV25w4rCnh/b2IscFWPA==
=YmgC
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
