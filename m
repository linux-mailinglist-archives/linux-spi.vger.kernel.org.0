Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8186B54C9D5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 15:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245265AbiFONbV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONbV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 09:31:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1564633373
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 06:31:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o1T75-0002zf-J2; Wed, 15 Jun 2022 15:31:15 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9322A967F4;
        Wed, 15 Jun 2022 13:31:14 +0000 (UTC)
Date:   Wed, 15 Jun 2022 15:31:13 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] [PATCH v2 00/11] Optimize spi_sync path
Message-ID: <20220615133113.ylwenlzpkv2na25z@pengutronix.de>
References: <20220615124634.3302867-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="meamqf5wauhc5ra7"
Content-Disposition: inline
In-Reply-To: <20220615124634.3302867-1-david@protonic.nl>
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


--meamqf5wauhc5ra7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.06.2022 14:46:23, David Jander wrote:
> These patches optimize the spi_sync call for the common case that the
> worker thread is idle and the queue is empty. It also opens the
> possibility to potentially further optimize the async path also, since
> it doesn't need to take into account the direct sync path anymore.
>=20
> As an example for the performance gain, on an i.MX8MM SoC with a SPI CAN
> controller attached (MCP2518FD), the time the interrupt line stays
> active (which corresponds roughly with the time it takes to send 3
> relatively short consecutive spi_sync messages) is reduced from 98us to
> only 72us by this patch.
>=20
> A note about message ordering:
>=20
> This patch series should not change the behavior of message ordering when
> coming from the same context. This means that if a client driver issues
> one or more spi_async() messages immediately followed by a spi_sync()
> message in the same context, it can still rely on these messages being
> sent out in the order they were fired.

Which git branch to use as the base?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--meamqf5wauhc5ra7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKp3x4ACgkQrX5LkNig
0102RAf+OhB/0W4NGm0cTPBvi+Ug2M6uiyLsqyJ50iGWJ/+2yYf1nszVErE6usH0
b7a8ME1JB7EzQraMeCPWg30a77zOMBPmoDcWIKiToSFRc9QYtjBsicYaNR/5j4pv
BHMZJF4CrqPPlhGcYEkLd9RoQFZEcyycUlTgQqT5FifBzTqHTyu7tcbkO0v7y/yf
cpDg7BIEhUY92dPyPV/VrcW42VTgilMmshZ75golINTdJYZWh+cl6hONLYOckrVo
YKcltmZHx4B3Nqq3FnGumlFgejFdUmitB6cQ9tkAFuzA+1qorv28tdbuIaaDqHDW
4HKwgXvsRuEjB2nB8U55qf2cq7xX2g==
=3PrP
-----END PGP SIGNATURE-----

--meamqf5wauhc5ra7--
