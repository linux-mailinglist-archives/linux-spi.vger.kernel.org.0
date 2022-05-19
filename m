Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F081E52CE40
	for <lists+linux-spi@lfdr.de>; Thu, 19 May 2022 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiESIYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 May 2022 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiESIYO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 May 2022 04:24:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9E6A035
        for <linux-spi@vger.kernel.org>; Thu, 19 May 2022 01:24:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrbS4-0006ll-QM; Thu, 19 May 2022 10:24:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AD97881DDC;
        Thu, 19 May 2022 08:24:07 +0000 (UTC)
Date:   Thu, 19 May 2022 10:24:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220519082407.ef2ys6pnbb2meyiq@pengutronix.de>
References: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ijhapdtmu5jufvpz"
Content-Disposition: inline
In-Reply-To: <20220519101238.516c5f9e@erd992>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ijhapdtmu5jufvpz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.05.2022 10:12:38, David Jander wrote:
> I just tried this out by re-writing the statistics code using u64_stats_s=
ync
> and per-cpu statistics, which get totaled on sysfs read access as Andrew =
Lunn
> suggested.
> The results are truly amazing!
>=20
> The overhead caused by statistics in my test dropped from 43us to just 1-=
2us.

\o/

> This was tested on a 64-bit machine though, so I don't know how it will a=
ffect
> 32-bit systems. Nor do I have an easy means of testing this. Any ideas?

Test on an imx6 :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ijhapdtmu5jufvpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKF/qQACgkQrX5LkNig
012ktwgAnABOqGnSH78Wn6Ix/ZPYb9LVatXP0Vc+6BVfXGpO0fnnavckY3GZWaHW
mhk2nwnJ3oihwyRfHVMFBVGBeUGQjxBURpkg7TyRAToRuJWu8Z3NU9bI0HTCt2wD
MAo5YYtSrEUd+a1wLNfz3jkjmhEDOt8nl/QRcb6Su5X6iEbCQzsxHoLl5nf6p/rX
azfhbiSrZTdbvSdPQxrocDd5kreJoD27bN7tFbtr0pnCmv3xs/RrDmJ159w19bR3
i4JwkNYaXro7wKd+/S9C+utHxkdfEGzasjarBV9BI6np4kYrywAQffjRWEFV6HPg
PHALie+8B39Dg/DYAmGOyZmqepzyJA==
=Y1YN
-----END PGP SIGNATURE-----

--ijhapdtmu5jufvpz--
