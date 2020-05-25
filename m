Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456221E0ED3
	for <lists+linux-spi@lfdr.de>; Mon, 25 May 2020 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbgEYM5q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 May 2020 08:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbgEYM5q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 May 2020 08:57:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C692073B;
        Mon, 25 May 2020 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590411465;
        bh=356HtUA0nB74e5rxu1uui5NilWozq/9SHLuRJhiE1yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1DpFNKmPMfXcEjGAi8BUcn0K3lk+2Al9JL+xpBY/WNauVuZXx0jGFB9kvAYEu0NFo
         bLkpwUvOrUyYUgVIHOOeumTZVeCCTA/1+fWgczhwX0llAe5BD4QG+IsGWjNpempgfG
         Xr3kqAXGqpxbLnoqdv/pSMCKiUpO+ZcrEzLIgNF4=
Date:   Mon, 25 May 2020 13:57:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Message-ID: <20200525125743.GF4544@sirena.org.uk>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
 <20200525113106.GB4544@sirena.org.uk>
 <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <a337c8ea-66e2-13c2-f625-fbe93e367d44@pengutronix.de>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 02:41:31PM +0200, Marc Kleine-Budde wrote:
> On 5/25/20 1:31 PM, Mark Brown wrote:

> > This isn't something that every individual driver should be doing, such
> > rewriting should happen in the core so that everything sees the benefit.

> The core could merge several half duplex transfers (until there's as cs_c=
hange)
> into a single full duplex transfer.

Yes, that is what I am suggesting.

> I think it's not easy to detect and reliable to split a full duplex trans=
fer
> into half duplex ones. How can you tell, if the controller is supposed to=
 tx 0x0
> or actually receive.

I don't understand how that could possibly work or why it would make
sense?

> I think spi_write_then_read() can be extended to generate one full duplex
> transfer instead on two half duplex ones it does a memcpy() anyways.

This has the same problem as doing it in any other driver code - it
causes a needless incompatibility with three wire and single duplex
devices. =20

> To get a feeling for the use cases, this is what I do in the regmap read
> function of a (not yet mainlined) CAN SPI driver.

Like I say it's probably better if code like this gets pushed into the
SPI core where we've got more information about what the controller can
do and there's more win from doing the tuning since more devices and
systems can take advantage of it.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7LwMYACgkQJNaLcl1U
h9C0Ygf/TEq8Q1B3DlwNyeM6Tbrf9vdtDAFqlVRm7tVdnaBiGW/jm2VM+TuMEfDN
gZvtAJd++hQiSGDWh8VoMILzAtwnX+0kewHsVGjBt/RIhmPbmtsA6de7IQG0B8pK
AoOvRBhpXusQ3zaiQThhBgmCAaJRcaG+LRzClVmBn5olZegFZVKD8KYNxRCKN2Af
q4pFAWj5bNIbbPjoQUqrFNDOvW21JRU/2PVMo0oxBuLhAEX+1JBZtMRMCjEI2DXk
zHs8AOYmzMvNtNuFJkdDY1Xlr6dJEXkfgsuxg//aEbz4MfnF6v0ycL/md43Kobt4
4b5Zk3kmL8wuWdQKXrvR94OhpraPuQ==
=yo2+
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
