Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504271621B
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjE3Ngl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjE3Ngk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 09:36:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCADA1
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 06:36:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3zWV-0007td-W5; Tue, 30 May 2023 15:36:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3zWV-003t9S-0a; Tue, 30 May 2023 15:36:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3zWU-009W3q-Cp; Tue, 30 May 2023 15:36:26 +0200
Date:   Tue, 30 May 2023 15:36:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: mt65xx: Properly handle failures in .remove()
Message-ID: <20230530133623.w5icilpjef22d4ks@pengutronix.de>
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
 <20230530081648.2199419-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bwoxo3tg2d22j34r"
Content-Disposition: inline
In-Reply-To: <20230530081648.2199419-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bwoxo3tg2d22j34r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 30, 2023 at 10:16:46AM +0200, Uwe Kleine-K=F6nig wrote:
> Returning an error code in a platform driver's remove function is wrong
> most of the time and there is an effort to make the callback return
> void. To prepare this rework the function not to exit early.
>=20
> There wasn't a real problem because if pm runtime resume failed the only
> step missing was pm_runtime_disable() which isn't an issue.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I just noticed there is a patch in next that conflicts with that one. My
merge resolution looks as follows:


diff --cc drivers/spi/spi-mt65xx.c
index 17162c8661b4,9333a0e8204d..000000000000
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@@ -1276,18 -1275,21 +1276,24 @@@ static int mtk_spi_remove(struct platfo
  	struct mtk_spi *mdata =3D spi_master_get_devdata(master);
  	int ret;
 =20
 +	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
 +		complete(&mdata->spimem_done);
 +
- 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
- 	if (ret < 0)
- 		return ret;
+ 	ret =3D pm_runtime_get_sync(&pdev->dev);
+ 	if (ret < 0) {
+ 		dev_warn(&pdev->dev, "Failed to resume hardware (%pe)\n", ERR_PTR(ret));
+ 	} else {
+ 		/*
+ 		 * If pm runtime resume failed, clks are disabled and
+ 		 * unprepared. So don't access the hardware and skip clk
+ 		 * unpreparing.
+ 		 */
+ 		mtk_spi_reset(mdata);
 =20
- 	mtk_spi_reset(mdata);
-=20
- 	if (mdata->dev_comp->no_need_unprepare) {
- 		clk_unprepare(mdata->spi_clk);
- 		clk_unprepare(mdata->spi_hclk);
+ 		if (mdata->dev_comp->no_need_unprepare) {
+ 			clk_unprepare(mdata->spi_clk);
+ 			clk_unprepare(mdata->spi_hclk);
+ 		}
  	}
 =20
  	pm_runtime_put_noidle(&pdev->dev);

If it's too complicated to apply, I can resend a rebased version.
After that the other two patches apply just fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bwoxo3tg2d22j34r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR1+9YACgkQj4D7WH0S
/k4xswgAqR9LBvO5+sHk8YAxf68ZmSMUmt0HsbjXSpNc75gb9KXMn9Rw6NEobbAH
ZOQJT0KxdchxeApsGJCHs4RCL7GsNemNmcmovVyUhXEUjn+UB9+AX9W4twqLTL8v
qAypJ5WOHUhJT00kF0TDYSuYUeU/US7niuIYdE7B+PD/b8wWp0AI/8x5ZqlrayPn
HBTPuB8310FaLtD5D4AfWZ4KuqX6Swl6UBC98hsGEU6oMgNKME5y3SR6FN0SB7/T
P9eyIAP85vd6R7IzQhcquiLhZ/MlnQCjNLviA1jHfEtBxhAs5hP+Qd6FNmmsL4O4
/a1uq+ITwM9y9dXbps7YQ05jAZWCrQ==
=L/Gt
-----END PGP SIGNATURE-----

--bwoxo3tg2d22j34r--
