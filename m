Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443851DB1A6
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETL1D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 07:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETL1C (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 07:27:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6552E207F9;
        Wed, 20 May 2020 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589974022;
        bh=gLzVWqgqOs2IZaQXiCC28rNESIbpbdE/t+v4Lzs82DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iF3n43r12SLt4VMNftZtUN7PQ0CY8utNHmx0ojjKjou3+K+1xgB0z6mNcRwki2McF
         EGgkvb7fs007naatNAJPD2o3LpBAt4RzaCyS7DA6ITOJ7EBujSM9EPB6pS7dPxVgib
         PtM/hhDuSbBYtkkAQgADW6ZtVJpL4WrWGIkupH4A=
Date:   Wed, 20 May 2020 12:26:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-spi@vger.kernel.org,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        nicolas.ferre@microchip.com
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Message-ID: <20200520112659.GB4823@sirena.org.uk>
References: <20200519163353.20c03286@windsurf.home>
 <20200519152449.GM4611@sirena.org.uk>
 <20200520121819.0f816ec0@windsurf.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20200520121819.0f816ec0@windsurf.home>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 12:18:19PM +0200, Thomas Petazzoni wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > The other thing that jumps out looking at the code is that in the
> > interrupts to complete transfers the driver will just complete() and
> > wake the main transfer thread up, for the reads where we always have two
> > transfers per message this will cause an extra context switch.  If the
> > driver were able to initiate the next transfer directly from interrupt
> > context then it should schedule less (and generally reduce latency too).

> Indeed, I see. The spi-atmel driver is however really structured around
> synchronously handling each xfer of the spi_message. I guess what we
> would want to see is atmel_spi_transfer_one_message() start the first
> transfer, and then wait on a completion that indicates the completion
> of *all* xfers. And then, it's the interrupt handler that dequeues the
> next xfer from the spi_message and submits them, so that we don't go
> back to the calling thread for each xfer.

Right.  You'd need to rearrange it to go through the entire message
setting up DMA mappings that will be needed then had everything off to
interrupt context or have extra complexity and optionally go back up to
task context if there's anything complicated to handle.

It might also be possible to rearrange the transfers so that the entire
message is done by the hardware if you can chain things together, though
that only helps with DMA and it'll involve adding dummy TX and RX
segments and might be more trouble than it's worth.

> > I can't really see much obvious in the serial driver - it might want to
> > consider error checking

> I'm not sure what you mean by "it might want to consider error
> checking". Could you explain?

It wasn't checking the return values of SPI API calls.

> >, or if it doesn't care if transfers complete it might want to switch
> >to async SPI calls, but nothing that looks like
> > there's anything obvious for SPI related that you could do here.

> I'm not sure how it can use async transfers. Most of the transfers are
> initiated using regmap_read(), which inherently is synchronous: we need
> the value of the register being read to decide if we received some

Yeah, that's mostly useful on the transmit side I think.

> data, how much data we've received, etc. The only thing that could be
> asynchronous I guess is retrieving the data from the UART RX FIFO: the
> completion callback could push this data up to the TTY layer rather.

That might save you some context thrashing, or allow batching of
switches.

> Mark: in this situation where a threaded interrupt handler in max310x
> is doing SPI transfers, are those SPI transfers then offloaded to the
> SPI workqueue, causing another context switch, or are they done
> directly within the context of the interrupt thread ? I see
> __spi_sync() has some logic to push out the messages from the calling
> context, I guess as opposed to offloading them to the SPI workqueue ?

It should be doing transfers in calling context if the controller is
idle, the SPI thread should only be used when the controller is already
busy or to clean up when the controller goes idle (which will
unfortunately happen rather a lot in your use case).

Actually looking at the code in __spi_pump_messages() again I think that
in the case where we don't have any cleanup to do we should be able to
avoid kicking the thread for that which should help a bit for spi-atmel.
Can you give the patch below a go (compile tested only, not even tried
to boot)?

You can generally get a good idea of what's going on with regard to
context switching at the SPI level from the SPI tracepoints, and about
any latencies in there too.

> Overall, do we consider it "normal" to have a ~30% CPU load for what
> looks like a very light workload ?

It feels a bit high.  It might possibly go down under load if there's
other stuff going on, though I don't think that applies in this use case
- it's mainly cases where we can avoid idling the hardware due to having
a lot of batched up work.


diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c083ee3995e4..9bfc622466c7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1311,6 +1311,14 @@ void spi_finalize_current_transfer(struct spi_contro=
ller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_finalize_current_transfer);
=20
+static void spi_idle_runtime_pm(struct spi_controller *ctlr)
+{
+	if (ctlr->auto_runtime_pm) {
+		pm_runtime_mark_last_busy(ctlr->dev.parent);
+		pm_runtime_put_autosuspend(ctlr->dev.parent);
+	}
+}
+
 /**
  * __spi_pump_messages - function which processes spi message queue
  * @ctlr: controller to process queue for
@@ -1355,10 +1363,17 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
 			return;
 		}
=20
-		/* Only do teardown in the thread */
+		/* Defer any non-atomic teardown to the thread */
 		if (!in_kthread) {
-			kthread_queue_work(&ctlr->kworker,
-					   &ctlr->pump_messages);
+			if (!ctlr->dummy_rx && !ctlr->dummy_tx &&
+			    !ctlr->unprepare_transfer_hardware) {
+				spi_idle_runtime_pm(ctlr);
+				ctlr->busy =3D false;
+				trace_spi_controller_idle(ctlr);
+			} else {
+				kthread_queue_work(&ctlr->kworker,
+						   &ctlr->pump_messages);
+			}
 			spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 			return;
 		}
@@ -1375,10 +1390,7 @@ static void __spi_pump_messages(struct spi_controlle=
r *ctlr, bool in_kthread)
 		    ctlr->unprepare_transfer_hardware(ctlr))
 			dev_err(&ctlr->dev,
 				"failed to unprepare transfer hardware\n");
-		if (ctlr->auto_runtime_pm) {
-			pm_runtime_mark_last_busy(ctlr->dev.parent);
-			pm_runtime_put_autosuspend(ctlr->dev.parent);
-		}
+		spi_idle_runtime_pm(ctlr);
 		trace_spi_controller_idle(ctlr);
=20
 		spin_lock_irqsave(&ctlr->queue_lock, flags);

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7FFAIACgkQJNaLcl1U
h9BC5Qf+Pkv4+x7X0+ElE27f9XiF/IbZYfiym/0uOud+wW6O5L1C2X6qc8pjB7cU
/H0pesryvSYiTZaCqiI5bMVOn4s8MChGwPZuLhKM0F+HdgduXg34ONS0uoVFtjKu
kqmVsr/WeZxtGOSPzTMozVQRozoAXjTyna53jHMwTXqM1iu5Srd+D2ikd93GDr7t
DTxx8ZEPUXyI6+VDv/1lWvOEdpMTve37c8wvEVviO2FiLdO8B6oJj1TnbXnWpJpc
IHjwEY7e9KdV0Z6Op9bs3xFCDLv6kmIsqroj3qisWt+MWE6XVfZt1dKpWnTcI2BD
dhI9+4YYFHU9NwGruXMSPpr0/bakEg==
=e8bQ
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
