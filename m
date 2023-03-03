Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208F06A9EE0
	for <lists+linux-spi@lfdr.de>; Fri,  3 Mar 2023 19:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjCCSdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 13:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjCCSdn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 13:33:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C583D8
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 10:33:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYADr-0003f5-7F; Fri, 03 Mar 2023 19:33:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYADq-001cPW-9m; Fri, 03 Mar 2023 19:33:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYADp-001udf-FE; Fri, 03 Mar 2023 19:33:37 +0100
Date:   Fri, 3 Mar 2023 19:33:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 67/87] spi: sifive: Convert to platform remove callback
 returning void
Message-ID: <20230303183331.kcb5itikq4cdhqo3@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-68-u.kleine-koenig@pengutronix.de>
 <1f3f97a1-f335-45c0-980b-b0847cd8ad90@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7t5nu352axyhkxy"
Content-Disposition: inline
In-Reply-To: <1f3f97a1-f335-45c0-980b-b0847cd8ad90@spud>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--t7t5nu352axyhkxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Fri, Mar 03, 2023 at 05:46:11PM +0000, Conor Dooley wrote:
> On Fri, Mar 03, 2023 at 06:20:21PM +0100, Uwe Kleine-K=F6nig wrote:
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >=20
> > Trivially convert this driver from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This one landed in my mailbox too, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I have ~2000 of such patches pending in my tree that wait for
submission. If you want a Cc: for each of them, just tell me :-)

Best regards and thanks,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t7t5nu352axyhkxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQCPW8ACgkQwfwUeK3K
7Am1Agf8CfTjWviZwbfrUV0Vn9WyI1ErNhxF9ixhVeOt2bSWfLIy88wzWKHff3l4
P4jAkxYQ0pk7/AvIIDUtOteZY4NMM5qs+c6CHiveNGbdGlumofjHfD91+Y7yYDBg
JveWdR0UTV219gFPUVLPUrp9PVY1S0qMZThEItr+Cc+WiOhH9vcKLVIfqEVTbX81
iU2uVcyUcqNXR5B76bziF+CzLaNiU8O9codnvc7PeIWCxMJ9Tn8TBubE5MNsmFh0
JI+d7U1o3G5HRIIeidi8S5oIg/gvQJRC2yve7hqFooAvwONrHkeATqNJi5xyMzyq
AFHk/329ttyS6ptpnY2JgFvLAKKktA==
=A4Yl
-----END PGP SIGNATURE-----

--t7t5nu352axyhkxy--
