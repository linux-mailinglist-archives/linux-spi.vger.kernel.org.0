Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128C652A3BD
	for <lists+linux-spi@lfdr.de>; Tue, 17 May 2022 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348057AbiEQNoN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 May 2022 09:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348088AbiEQNoL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 May 2022 09:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1A4CD68
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 06:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CFF9B81870
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 13:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90587C385B8;
        Tue, 17 May 2022 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652795043;
        bh=WfMM/hE56N+CuLESXpJo0esdNV1oVYoiTDKP20WMdAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4fAm04oPx3p53kDeXojgvsn+QJODlTAD/2dVENTPHuptEweSa82dUNX1L77YrNlp
         At4yzxXmh1WUkJKcJXW66+0HYMpNLAC5ThBeYpTiJLkvDuAc5CzY0Vgtx5MUpWKU0B
         rKwkzVsbXH6gzV87A/1Y5S2YDmqw2WObSzOR6/nWu2xR3IyWjK0iM+tde+TvbW1Fxi
         pXcomhvqJ8bYHSU6cqdHJV9wkqE0F00hp0Ne9KvwVkvo/tP/UWLAxNdogtEM8qKLrL
         91dFXj16ou4Ek+ur+It5RZrM6aoM7hFBvAZYtq7MslMmT9vnGFOkyUZkzSsk5y7Ynw
         JxCr/j6l71HLA==
Date:   Tue, 17 May 2022 14:43:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoOmn1k6yEtJofe5@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
 <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R6aljjPloSPnfSZZ"
Content-Disposition: inline
In-Reply-To: <20220517150906.09a16a47@erd992>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--R6aljjPloSPnfSZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 03:09:06PM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 17, 2022 at 12:24:39PM +0200, David Jander wrote:

> > > on, so I wonder whether there is something to gain if one could just =
call
> > > spi_bus_lock() at the start of several such small sync transfers and =
use
> > > non-locking calls (skip the queue lock and io_mutex)? Not sure that w=
ould have

> > I do worry about how this might perform under different loads where
> > there are things coming in from more than one thread.

> I understand your concern. The biggest issue is probably the fact that cl=
ient
> drivers can claim exclusive access to the bus this way, and who knows if =
they
> take care to not claim it for too long?

Yes, claiming the bus for a long time.

> In the end, if multiple latency-sensitive client drivers share the same S=
PI
> bus, besides this being a questionable HW design, this will be asking for
> trouble. But I agree that usage of spi_bus_lock() by client drivers is
> probably not a good idea.

I think the worst case would be mixing latency sensitive and throughput
sensitive devices, or possibly tasks on a device.  As you say there's an
element of system design here.

> > >  1. hard-IRQ, queue msg --ctx--> SPI worker, call msg->complete() whi=
ch does
> > >  thread IRQ work (but can only do additional sync xfers from this con=
text). =20
> >=20
> > > vs. =20
> >=20
> > >  2. hard-IRQ, queue msg --ctx--> SPI worker, call completion --ctx-->=
 IRQ
> > >  thread wait for completion and does more xfers... =20
> >=20
> > > vs (and this was my idea). =20
> >=20
> > >  3. hard-IRQ, pump FIFO (if available) --ctx--> IRQ thread, poll FIFO=
, do more
> > >  sync xfers... =20
> >=20
> > Roughly 1, but with a lot of overlap with option 3.  I'm unclear what
> > you mean by "queue message" here.
>=20
> In the above, I meant:

>  "queue message":=20
> 	list_add_tail(&msg->queue, &ctlr->queue);
> 	kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);

OK, no - I'm proposing actually putting the message onto the hardware
=66rom interrupt context.

> > Yes, that's the whole point.  This also flows nicely when you've got a
> > queue since you can restart the hardware from the interrupt context
> > without waiting to complete the transfer that just finished.

> Ack. Only caveat I see is the requirement for CS to be settable in a
> non-sleepable context. Not all GPIO pins have gpiod_set_value(). Some mig=
ht
> only have gpiod_set_value_cansleep(). Although the latter case is not a g=
ood
> choice for a CS signal, so I doubt it can be found in the wild.
> Example: I2C GPIO expanders. In such a (very unlikely) case, the spi subs=
ystem
> would need to fall back to the worker-queue, so probably not a big deal.

Yes, there's a bunch of things where we have to fall back on a queue.
There's fully bitbanged controllers, excessively large messages or delay
requirements, clock reprogramming and other things.

--R6aljjPloSPnfSZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKDpp4ACgkQJNaLcl1U
h9BQ6wf/TKSPg8J3JGIJPtLlZkkxF03xICRcAGoSoZ1fDc6uagj/mVepOVz5ZLre
hMF+ImsscATG4UROkx9nwnHATII9HiWpUE/PP5GL4700mNF+FQsbmjamtuNIo6eq
/KxqM4x947QghjujCiVKrecPjB7dwutpPfhz4CtgdQgtk2t2CIDhFcnX0xPdI9F/
wakFBsKDQppI0kLcGv00kRxY1Ul8NslDI34X2xqjfMFm4Gw2D8ZSLH/88yVjkW6Z
Fnx/0PnNAwpHFHwGyhD/Iihuth7fuDOwCwumo1rG0eqBMOOK5Td18AqofUZwJEnM
c6Pl+EGJmKcC1EGqDBEi26Hl7ZkZ9Q==
=6Y7+
-----END PGP SIGNATURE-----

--R6aljjPloSPnfSZZ--
