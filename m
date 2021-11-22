Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2B458A51
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 09:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhKVIL7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 03:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbhKVIL6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Nov 2021 03:11:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20407C061574
        for <linux-spi@vger.kernel.org>; Mon, 22 Nov 2021 00:08:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mp4Nc-0003FA-Ry; Mon, 22 Nov 2021 09:08:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mp4Nc-000YKa-JV; Mon, 22 Nov 2021 09:08:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mp4Nb-0002m8-IH; Mon, 22 Nov 2021 09:08:47 +0100
Date:   Mon, 22 Nov 2021 09:08:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: docs: improve the SPI userspace API documentation
Message-ID: <20211122080844.ivweo7je2l57btam@pengutronix.de>
References: <20211119121139.2412761-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3y6lhn7agpqntgmo"
Content-Disposition: inline
In-Reply-To: <20211119121139.2412761-1-javierm@redhat.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--3y6lhn7agpqntgmo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 19, 2021 at 01:11:39PM +0100, Javier Martinez Canillas wrote:
> This doc is fairly outdated and only uses legacy device instantiation
> terminology. Let us update it and also mention the OF and ACPI device
> tables, to make easier for users to figure out how should be defined.
>=20
> Also, mention that devices bind could be done in user-space now using
> the "driver_override" sysfs entry.
>=20
> Suggested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for you effort here, that's a nice improvement

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3y6lhn7agpqntgmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGbUAkACgkQwfwUeK3K
7AkViggAm9jSNCNwKa4Wgj9ovX7tpAz/V2wlwnUMMcLtPbCarRZWND9b4fDFAFlx
0h/Sp2OuSlrILVs7CChrUTHGVzEj3isTAWzZFNW/VcBI8P08/zpTafdQ+bzj+TZC
R8ZsRu15Tj2vxxgmouIc1Xm5yfLqX7vUrDhCg4QNmU8OCF+8mbXisF4YIqZiNy5s
gxJjvdy/DHgdsHu1cWuLTX45HiaxRMPeAS8fzUvp/q5/nU26tAVjiARQD1G3L5bE
sl0Cxl2S6H6DKy5TGa5UVaGC6+1c4D09ZwmP4DrPJpq0JWDnZ2j8mv350f3jxsSC
uJX7W9Pjob2FWTFKkW7LEOIyDyDhrQ==
=18nE
-----END PGP SIGNATURE-----

--3y6lhn7agpqntgmo--
