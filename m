Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4953145A
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiEWO7r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 10:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEWO7q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 10:59:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C9A5B8AF
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 07:59:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nt9Wz-0001Vf-Lk; Mon, 23 May 2022 16:59:37 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93955846BB;
        Mon, 23 May 2022 14:59:36 +0000 (UTC)
Date:   Mon, 23 May 2022 16:59:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220523145935.eve4kzthaquecxnm@pengutronix.de>
References: <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
 <YoeyIG+RGpRBm9Cc@sirena.org.uk>
 <20220523164832.4d9a0bb8@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kcxserx2nnleitmd"
Content-Disposition: inline
In-Reply-To: <20220523164832.4d9a0bb8@erd992>
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


--kcxserx2nnleitmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.05.2022 16:48:32, David Jander wrote:
> Btw, I just discovered that there was indeed another often unnecessary co=
ntext
> switch happening in spi_sync(). When spi_finalize_current_message() is ca=
lled,
> it will always queue work, even if we just managed to do everything in the
> calling context:
>=20
> https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/spi/spi.c#L1909
>=20
> This is needed to have the SPI worker thread unprepare transfer
> hardware and free the dummy buffers if required. My question is why
> this needs to be done from the thread. Putting the relevant code after
> the call to ctlr->transfer_one_message() in __spi_pump_messages(),
> saves this extra bounce to the worker thread if no more messages are
> queued, saving ca 10-12us extra time between consecutive spi_sync
> messages.

Martin Sperl tried to do a delayed teardown, see:

| 412e60373245 spi: core: avoid waking pump thread from spi_sync instead ru=
n teardown delayed

But that turned out be not working properly:

| https://lore.kernel.org/all/f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.c=
om/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kcxserx2nnleitmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKLoVUACgkQrX5LkNig
0126dwf+Pve9pEa0YxIJO1xymaWwMfNDAvic+apQdD8GMF7W27YEvDMxi1RQfFku
9RI5ue4PtuSSJtKjaFRMmn9eFyu81O+xANvnMSILK4GDO19i9E3pX34W/8LNUOkl
oLFw12tQaYPQJt5DTOnwQMLQDs4/jR9yOEBa2hF3twiLu5gd/tFIlo8FtzOfKRIn
cZtHiBkLRxxzH6lsDnRNCqSMZf3t28Mbi4aOsDf8kkIl/mgOMls4O1Oqlgk7nur1
33b1+A+6mHTae6J/3lsmFviyW92FS4PXU0IX/IV8E1MVkwbfVBcL5gWmZ3KgXY4R
d6MjDyXkXAPdXYtvRTfIIupjOs7vbQ==
=5Otb
-----END PGP SIGNATURE-----

--kcxserx2nnleitmd--
