Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835FF53290A
	for <lists+linux-spi@lfdr.de>; Tue, 24 May 2022 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiEXLbJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 May 2022 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiEXLa5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 07:30:57 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C8880C9
        for <linux-spi@vger.kernel.org>; Tue, 24 May 2022 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=ttW2a0tRgz2sy62Juw4TnAgxb3e9oTAz78ghTlVKOwM=;
        b=AKZL66PgFysE2eoZ0jrcT8AM9Js6taqMkEWI8l1WEmJraasNLadyF38xS8003tCNyzmPgplYi3+QM
         uQvhtSIBg7kE/vhEIjEBv5N5LPVNRa4hPl1r/Y+QMC07SSAAeIvKUGP8xXgQ3Dw/SUALNKVREfXOVD
         yD/0/gWThzhlT5D2jywhhrR+2foiaMjBiAQLKCih6bRGd/lSDbHKePYe2F7iFHB2S3tKus2obnK1vC
         E1WTRkW0zIwmufVTWWguTmObbnBdFlFOTLZrru62zOI6E8U3MrY4DqbSoYKYIesKjMm5JED6/R/6X5
         6C6uQm48/gKbWuP9qJgrya79S+TCCQQ==
X-MSG-ID: f6053b99-db54-11ec-a2aa-0050569d11ae
Date:   Tue, 24 May 2022 13:30:48 +0200
From:   David Jander <david@protonic.nl>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220524133048.62053868@erd992>
In-Reply-To: <20220523145935.eve4kzthaquecxnm@pengutronix.de>
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
        <20220523145935.eve4kzthaquecxnm@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 23 May 2022 16:59:35 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 23.05.2022 16:48:32, David Jander wrote:
> > Btw, I just discovered that there was indeed another often unnecessary =
context
> > switch happening in spi_sync(). When spi_finalize_current_message() is =
called,
> > it will always queue work, even if we just managed to do everything in =
the
> > calling context:
> >=20
> > https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/spi/spi.c#L19=
09
> >=20
> > This is needed to have the SPI worker thread unprepare transfer
> > hardware and free the dummy buffers if required. My question is why
> > this needs to be done from the thread. Putting the relevant code after
> > the call to ctlr->transfer_one_message() in __spi_pump_messages(),
> > saves this extra bounce to the worker thread if no more messages are
> > queued, saving ca 10-12us extra time between consecutive spi_sync
> > messages. =20
>=20
> Martin Sperl tried to do a delayed teardown, see:
>=20
> | 412e60373245 spi: core: avoid waking pump thread from spi_sync instead =
run teardown delayed
>=20
> But that turned out be not working properly:
>=20
> | https://lore.kernel.org/all/f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia=
.com/

Ah, thanks for sharing. Added Martin to CC here.

I have been struggling with this too. There are definitely dragons somewher=
e.
I have tried to do tear-down in the same context if possible, similar to th=
is:

@@ -1718,6 +1718,21 @@ static void __spi_pump_messages(struct spi_controlle=
r *ctlr, bool in_kthread)
                goto out;
        }
=20
+       spin_lock_irqsave(&ctlr->queue_lock, flags);
+       /* Check if we can shutdown the controller now */
+       if ((list_empty(&ctlr->queue) || !ctlr->running) && (!in_kthread)) {
+               if (!ctlr->dummy_rx && !ctlr->dummy_tx &&
+                   !ctlr->unprepare_transfer_hardware) {
+                       spi_idle_runtime_pm(ctlr);
+                       ctlr->busy =3D false;
+                       trace_spi_controller_idle(ctlr);
+               } else {
+                       /* Ensure non-atomic teardown is done in the thread=
 */
+                       kthread_queue_work(ctlr->kworker,
+                                          &ctlr->pump_messages);
+               }
+       }
+       spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 out:
        mutex_unlock(&ctlr->io_mutex);
=20
Which is almost a copy/paste from the same piece of code above. The idea was
that in the case the whole transfer was done in the same context anyway, one
could just check after calling ctlr->transfer_one_message() if the controll=
er
can be made idle immediately. This turned out to be racy for some reason, a=
nd
I have not yet discovered exactly why. In the occasions the code didn't hit
the race, it seemed to have a notable performance impact though, so removing
this context switch may be worth the effort.

Unfortunately, besides being racy, this change does introduce a new call to
the queue_lock spinlock, which (as my previous patch shows) negates part of
the performance gain.

This made me think about ways to reduce these spinlocks even further, so I
mapped out the different code-paths that access the queue-spinlock, the
bus-spinlock, the bus-mutex and the io-mutex. It appears the code is optimi=
zed
for concurrency, assuming the overhead of locking is negligible. Unfortunat=
ely
we now know this isn't the case when dealing with small sync transfers at
medium to high clock speeds. Currently there is a ctlr->queue and
ctlr->cur_msg and some other state variables and flags that are accessed fr=
om
three different places: spi_sync, spi_async and the worker thread. The lock=
ing
paths look approximately like this (for one single message):

 1. spi_sync()
    --> bus_lock_mutex
        --> __spi_sync()
            --> bus_lock_spinlock
                --> queue_lock
                    --> list_add_tail()
            --> __spi_pump_messages() (also entered here from WQ)
                --> queue_lock
                    --> list_first_entry()
                --> io_mutex
                    --> transfer_one_message()
                        --> spi_finalize_current_message
                            --> queue_lock
                                --> get cur_msg
                            --> queue_lock
                                --> kthread_queue_work() -> reschedule
                            --> complete() **
    (from thread) __spi_pump_messages()
                    --> queue_lock
                        --> teardown -> done.
    (from main context) wait_for_completion() **
                        --> internal spinlock.

 2. worker thread:
    --> __spi_pump_messages()
        ... same as above from first __spi_pump_messages()

 3. spi_async()
    --> bus_lock_spinlock
        --> __spi_async()
            --> queue_lock
                --> list_add_tail()
                --> kthread_queue_work()

=46rom what I understand of this, bus_lock_mutex is used to serialize spi_sync
calls for this bus, so there cannot be any concurrency from different threa=
ds
doing spi_sync() calls to the same bus. This means, that if spi_sync was the
only path in existence, bus_lock_mutex would suffice, and all the other
spinlocks and mutexes could go. Big win. But the async path is what
complicates everything. So I have been thinking... what if we could make the
sync and the async case two separate paths, with two separate message queue=
s?
In fact the sync path doesn't even need a queue really, since it will just
handle one message beginning to end, and not return until the message is do=
ne.
It doesn't need the worker thread either AFAICS. Or am I missing something?
In the end, both paths would converge at the io_mutex. I am tempted to try
this route. Any thoughts?

Best regards,

--=20
David Jander
