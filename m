Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11C55A82AD
	for <lists+linux-spi@lfdr.de>; Wed, 31 Aug 2022 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiHaQHt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Aug 2022 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHaQHt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Aug 2022 12:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A97EFEA
        for <linux-spi@vger.kernel.org>; Wed, 31 Aug 2022 09:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4EA61924
        for <linux-spi@vger.kernel.org>; Wed, 31 Aug 2022 16:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C6BC433C1;
        Wed, 31 Aug 2022 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661962067;
        bh=E2+ezHXu46FzZpKRytnsC6T0o4n4yEWTg6wSw0UgvBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVOXOmEJb66v/vKDdD+EWTMJumQeAIlJKp92FcZ5L02qVPbnGbwmk5obCZzqBvyec
         nqmMGhA+6AT8/EU9qAvbd92NNggy0xLYvFRTJSWFwnVM5SuJik6pgLGpSLH9FCLrgu
         xjliXilgFv1X93+8KXrzabi+R1y1sd2xKQ06oCpZADqw3AIApjmHg1gdiHHxlDQcwp
         ejr2wNy7uCer773Gd/TYq1ATgqtaORjOgTlCD69+Y9lMRhEqS1N65GG7UqRDsDJShV
         1047yrDl2QAbSOESMkzbfuNvnxX8Jfj/GUwpGwnCEktAQsGVt2Ob8XHJAfcpegGrIE
         yYdP88zwpmNug==
Date:   Wed, 31 Aug 2022 17:07:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Casper Andersson <casper.casan@gmail.com>,
        linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <Yw+HTj98V1ToLWIL@sirena.org.uk>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ysdh/XKDMXMs0tn8"
Content-Disposition: inline
In-Reply-To: <20220829105613.476622d2@erd992>
X-Cookie: It's later than you think.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ysdh/XKDMXMs0tn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2022 at 10:56:13AM +0200, David Jander wrote:

> spi_mux_transfer_one_message() returns before the message is transferred =
(in
> spi_async()), which is not expected. AFAIK, an ctlr->transfer_one_message=
()
> implementation should not return until the transfer is completed.

That's because what it wants to happen here is that the controller then
runs the message that it's being asked to perform, it'll then get a
callback when the message completes which it'll use to deselect the
device and then complete the original callback.  This is a horrible
hack.

It should be fine for transfer_one_message() to return immediately, it's
called from __spi_pump_transfer_message() which will wait for the
message to be finalized.  However I do note that if we get a message
going in via the sync path skipping the queue we set msg->sync, among
other things, and then the mux will try to reuse the same message and
resubmit it as an async message with the sync flag set which I can't see
is going to go well.

> Not sure if this is a correct fix, but I'd like to know if your situation
> changes this way, if you could try it.
> I don't have access to any hardware with a mux unfortunately, so I can't =
test
> it myself.

I guess claiming to have a noop mux might work for testing, though I'd
be dubious that it was actually doing the mux operations properly?  I
think we need to either change spi_mux to duplicate the incoming message
(that's probably "cleaner") or teach the core that spi-mux exists and
should always use the pump/queue.  The below might do the trick but in
spite of my suggestion above I've not tested either yet:

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index f5d32ec4634e..0709e987bd5a 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
 	ctlr->num_chipselect =3D mux_control_states(priv->mux);
 	ctlr->bus_num =3D -1;
 	ctlr->dev.of_node =3D spi->dev.of_node;
+	ctlr->must_async =3D true;
=20
 	ret =3D devm_spi_register_controller(&spi->dev, ctlr);
 	if (ret)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1cfed874f7ae..88d48a105d3c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct =
spi_message *message)
 	 * guard against reentrancy from a different context. The io_mutex
 	 * will catch those cases.
 	 */
-	if (READ_ONCE(ctlr->queue_empty)) {
+	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
 		message->actual_length =3D 0;
 		message->status =3D -EINPROGRESS;
=20
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e6c73d5ff1a8..f089ee1ead58 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(stru=
ct spi_device *spi, u8 ch
  *	SPI_TRANS_FAIL_NO_START.
  * @queue_empty: signal green light for opportunistically skipping the que=
ue
  *	for spi_sync transfers.
+ * @must_async: disable all fast paths in the core
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -690,6 +691,7 @@ struct spi_controller {
=20
 	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
 	bool			queue_empty;
+	bool			must_async;
 };
=20
 static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)

Assuming that works out there'll be an extra test in the fast path but
no sync operations, and a performance hit for spi-mux users.  Hopefully
that works as well as it did before.

--ysdh/XKDMXMs0tn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMPh00ACgkQJNaLcl1U
h9CqZQf+Nvy7iu/tQytmeFCIZYS91ESrztk8og/9bBbktr0a5KuxTnYtfp+6f2ie
ZCovQqSUsZmRw3Q5YoTwXhhkF80mCIsoP9Y90g2iftsxYFjVTU2ePcvYz28vZmJO
Yf5r3b8IK2OZb8esbmEiA0K7obhagpJAxZFl6XNUucDh7c2V5TQh6PlJXSGEALpl
B/gSIM7CUGm013ZA0F2qb0rWv/EMGxfF64WKB0GncAvsV7LU0M8dAY9X+WUWyrf2
YOCPCmVoMEOGqbaGo2RsTIvGhpNOukV2ecTk1PPdwz58egG3VoQyjQ7l3x1lniLW
nGwjWHqqssIu7BX4Ni4VAm0k4QxN6A==
=Sh7P
-----END PGP SIGNATURE-----

--ysdh/XKDMXMs0tn8--
