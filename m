Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B707A5C4C
	for <lists+linux-spi@lfdr.de>; Tue, 19 Sep 2023 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjISISb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Sep 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISISZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Sep 2023 04:18:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C991102
        for <linux-spi@vger.kernel.org>; Tue, 19 Sep 2023 01:18:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiVw0-0003FB-AE; Tue, 19 Sep 2023 10:18:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiVvz-007PZQ-Ka; Tue, 19 Sep 2023 10:18:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiVvz-002voE-BE; Tue, 19 Sep 2023 10:18:15 +0200
Date:   Tue, 19 Sep 2023 10:18:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Drop warning from spi_stop_queue()
Message-ID: <20230919081813.acguclkhll7mzap7@pengutronix.de>
References: <20230916161235.1050176-1-u.kleine-koenig@pengutronix.de>
 <CAMuHMdVi2TeWv0NXtxx=7NnGfJfWHoHCKty7Se0K-QusVi1xAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocmngo7qawgpbf4x"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVi2TeWv0NXtxx=7NnGfJfWHoHCKty7Se0K-QusVi1xAQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ocmngo7qawgpbf4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 09:26:42AM +0200, Geert Uytterhoeven wrote:
> Hi Uwe,
>=20
> On Sat, Sep 16, 2023 at 6:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Both callers of spi_stop_queue() (i.e. spi_destroy_queue() and
> > spi_controller_suspend()) already emit an error message if
> > spi_stop_queue() fails. Another warning in this case isn't helpful, so
> > drop it.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Thanks for your patch, which is now commit 9386c958beb77aee ("spi:
> Drop warning from spi_stop_queue()") in spi/for-next.
>=20
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -2093,10 +2093,6 @@ static int spi_stop_queue(struct spi_controller =
*ctlr)
> >
> >         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
> >
> > -       if (ret) {
> > -               dev_warn(&ctlr->dev, "could not stop message queue\n");
> > -               return ret;
> > -       }
> >         return ret;
> >  }
>=20
> Why did you decide to remove the printed warning from the callee,
> instead of the multiple printed warnings from the callers?
> The alternative would have reduced kernel size a bit more.

The callers used dev_err, the removed message is a dev_warn. So I kept
the messages with the higher prio.

Also the two error messages are more specific:

	spi_destroy_queue()
	-> dev_err(&ctlr->dev, "problem destroying queue\n");
	spi_controller_suspend()
	-> dev_err(&ctlr->dev, "queue stop failed\n");

But I didn't think about size reduction, if you want to improve further,
you're welcome.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ocmngo7qawgpbf4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUJWUQACgkQj4D7WH0S
/k6Rtwf/dBbNNrRBxeNgFA6+C+hMPVsRSID5WzD99vWfE6rajlrTMd3Mp/8IifR+
1NyL4LHs2IipS5FNfPOdQhCe6GvI9siSWEzFRisABAfVGe/r4Ayzcl7QX7opNY/0
jGCq3sUAWCnSoTy+OakKuwydD4hqIDp51qiyv0ga7XakOY2aTDhrBebnVF3dMncM
JvkzKbZiNxAhPB24SCG/ByvKV5e/IVg2rWnzuWtHh5GpUvYX+Lvv2R9fsmiAUKfO
V/nGIQdqBl20guK8nDVv/FGDG0eP5bW2/bcQekLz/VPBZYyGRrna5pu7RYxqkSQH
lDJSzSnQjEnqfOzaQF7ATzGsuA4uIA==
=NK0N
-----END PGP SIGNATURE-----

--ocmngo7qawgpbf4x--
