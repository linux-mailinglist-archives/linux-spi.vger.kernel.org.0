Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D657EC8C
	for <lists+linux-spi@lfdr.de>; Fri,  2 Aug 2019 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfHBGUW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Aug 2019 02:20:22 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:59678 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHBGUW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Aug 2019 02:20:22 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5686674A847; Fri,  2 Aug 2019 08:20:21 +0200 (CEST)
Date:   Fri, 2 Aug 2019 08:20:18 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: atmel: add tracing to custom .transfer_one_message
 callback
Message-ID: <20190802062018.GC11858@taurus.defre.kleine-koenig.org>
References: <20190801204710.27309-1-uwe@kleine-koenig.org>
 <20190801234011.GF5488@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20190801234011.GF5488@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mark,

On Fri, Aug 02, 2019 at 12:40:11AM +0100, Mark Brown wrote:
> On Thu, Aug 01, 2019 at 10:47:10PM +0200, Uwe Kleine-K=F6nig wrote:
> > Driver specific implementations for .transfer_one_message need to call
> > the tracing stuff themself. This is necessary to make spi tracing
> > actually useful.
>=20
> Have you tested this for modular builds?  IIRC it breaks unfortunately.

Works for me. Is this just a suspicion or do you have a breaking
=2Econfig? If the latter, the spi-mxs driver probably has the same
problem. When I sent the analogous patch for mxs this was indeed a
problem, but this was fixed in
ca1438dcb34c7fcad63b6ce14ea63a870b92a69b.

Best regards
Uwe

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl1D1h8ACgkQwfwUeK3K
7Am4zQf7Bi8n9xIUrmZxtL5hT3R+I15v345vk7VBPtkvlaZau7tho4UeM9oMLiGs
n/xdyojbfg/XJlKO9qpKtQOaQLReZ3CSzOWa5em0u6vygXn7twPyk3vZdlDrqr9t
OUhjhQcmDAt1DWd2y7N59YRpn7It9PId0nKe/uEkuaLGKSCjGKw/ujO6ffLbneR5
N1rnVbBIJswz2WWj5oPA6xVsl7W8ojgSwku91Um7OSnEGhP/RUiMIb4LLuExW6v6
bLxxn1TUK93yYKTkLjSUflPNvcmrbd0Ble+1NXeq8c61T8FVp0WeOo4crK4mTs2k
V+3k4bkrty6VJbycDTJBz/ikFFs5/w==
=KLHA
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
