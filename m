Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90B579470
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiGSHpK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGSHpJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 03:45:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56D5FA8
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 00:45:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oDhuk-0001FV-Tq; Tue, 19 Jul 2022 09:45:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E348BB3CFB;
        Tue, 19 Jul 2022 07:45:03 +0000 (UTC)
Date:   Tue, 19 Jul 2022 09:45:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lukas Wunner <lukas@wunner.de>, linux-spi@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 05/10] spi: bcm2835: Drop dma_pending flag
Message-ID: <20220719074503.n3csrhq4553zubdu@pengutronix.de>
References: <cover.1568187525.git.lukas@wunner.de>
 <062b03b7f86af77a13ce0ec3b22e0bdbfcfba10d.1568187525.git.lukas@wunner.de>
 <20220719065213.dxplydnkxcst4v7e@pengutronix.de>
 <5e0e595d-dd5d-b1d9-ca25-82b6f6a029e5@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lib5wxgezihod2si"
Content-Disposition: inline
In-Reply-To: <5e0e595d-dd5d-b1d9-ca25-82b6f6a029e5@i2se.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--lib5wxgezihod2si
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2022 09:34:45, Stefan Wahren wrote:
> Am 19.07.22 um 08:52 schrieb Marc Kleine-Budde:
> > The question is: Why runs the IRQ based transfer into a timeout? The
> > kernel that produces the crash has ecfbd3cf3b8b ("spi: bcm2835: Enable
> > shared interrupt support") applied (which was reverted on mainline in a
> > later patch).
>=20
> thank for your report. Unfortunately i don't have an answer to your
> question, but maybe this is related:

Sorry, that question was rhetorical. The kernel that produced this crash
was too old, it has support for the shared SPI interrupts ecfbd3cf3b8b
("spi: bcm2835: Enable shared interrupt support"), but misses the fix
commit 46feb7d7241b ("spi: bcm2835: Fix for shared interrupts").

With the 46feb7d7241b ("spi: bcm2835: Fix for shared interrupts") SPI
transmit timeout doesn't happen any more and thus the NULL pointer
deref is not triggered.

> https://github.com/raspberrypi/linux/commit/c643a3603dcbe6d0feada33915cef=
1ef896b865e
>=20
> > I'll create a patch to fix the NULL pointer deref. As a interrupt based
> > transfer might run into a timeout for other reasons, too. So better
> > avoid a kernel crash in that case.
>=20
> Yes, please

Done:
https://lore.kernel.org/all/20220719072234.2782764-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lib5wxgezihod2si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLWYPwACgkQrX5LkNig
012dagf/f2AhJL6yWYhFPmc6MaIl+/w5+voLP65+xJuLVKlNUryled1UoEPJJM/Q
IgePyL2KcyUWx59GtKve1cEjCSY6945kn65TvwxfxZnAaeqbS9cHZMsohvgePzyK
kyYuysbAHvgWvyPHq1g81JvhYq19s3FOw/ho7MIFG6I3Q9YxDwZpJFEE6i3cKXUq
ktEppPYeV/QJfzujXd0sYCoAPxWV+m+PguDwYNegXEbcXf0CSJFjzQMJRdmcTLFa
S241hhyrcgRfC6Kv0lpso60piO/beKW5R6JhMcR0qi7Ke+FZtCwfl0fAkQluIXxz
/4xd+waS44r8xyT9wbCC+gA/odAOIw==
=/rw9
-----END PGP SIGNATURE-----

--lib5wxgezihod2si--
