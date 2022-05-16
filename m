Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69196528C40
	for <lists+linux-spi@lfdr.de>; Mon, 16 May 2022 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiEPRqq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 May 2022 13:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiEPRqp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 May 2022 13:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3911C2C
        for <linux-spi@vger.kernel.org>; Mon, 16 May 2022 10:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED88612D6
        for <linux-spi@vger.kernel.org>; Mon, 16 May 2022 17:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F08C385AA;
        Mon, 16 May 2022 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652723202;
        bh=znA+lV7AqkEB5tCQt7H4YcibFSzfYL2gBcFzTG+6fdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEP5JdZk6Z2SUqtcUn270WrWQB7FjnZrmHId00UliCfP6QiS2uPlt4VQINxoaK+i2
         T8wnlBpJuKXii0AK+k+46/neS+cXe7uWXxaP+/3Q31SAvmUmuPrIDl67xzP/KAqqn8
         y92ZO6i/lF+Uevj50JUaUpaUIVY/ga3IlVBwsykGx8FGAqhQ0zZKWGc9jYinwEfgJm
         NkEs6uFPmKMCoaJl4Nls3dne/q2H+wIk8uNL0leaPwHfqw1e07DmzyC1Ke/mg3mlyS
         FWTuxfIzBm6OZLI6CqMBE6ueM+eko2FhNPi+Dh5Z17dESKVvRxpU/Fu1RNF9BZ2ELq
         lSJtUL3e7V2+Q==
Date:   Mon, 16 May 2022 18:46:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     David Jander <david@protonic.nl>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoKN/lqrgKJbVBVq@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
 <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttiGBkzg2SPsZFri"
Content-Disposition: inline
In-Reply-To: <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ttiGBkzg2SPsZFri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2022 at 06:28:51PM +0200, Marc Kleine-Budde wrote:
> On 13.05.2022 20:36:51, Mark Brown wrote:

> > Well, you've identifed a couple of candidates for optimisation here...
> > I would start off by trying to address the specific hot points that
> > you've identified and see where that takes us, like I said nothing I'm
> > hearing sounds like anything other than trying to optimise the hot path
> > and it doesn't seem like anything was really tried there yet.

> I thinks the statistics are an easy target.

Yes, that seems fairly clear.  I hadn't realised how much of an impact
that was having, this is certainly the first time anyone mentioned it on
the list.

> > How much of that time is due to the API being async vs just nobody
> > having tried to optimise the slow bits?

> You mean slow bits of the mcp251xfd driver?

No, of the SPI core.

> > Also bear in mind that
> > a huge proportion of systems have multiple CPUs available these days so
> > CPU time isn't wall clock time - one of the advantages is that we can
> > start sending the initial transfers while working out what else to send
> > which is useful if there's anything non-trivial going on there.  If the
> > driver is doing no work in between messages and the messages are all
> > short enough to do using PIO on the system concerned then yes,

> If the chip throws an IRQ it's more complicated. The driver has to read
> the IRQ status register before it knows which IRQ to handle. For the RX
> IRQ it has to read the fill level from the RX FIFO, then it can finally
> read the RX'ed CAN frames. The driver does read as many frames as
> possible with one transfer.

> So the hot path is the RX IRQ, TX-complete IRQ handling is similar but
> not as important (as the hardware has a buffer for outgoing TX frames),
> the other IRQ sources are various kinds of error handling.

Yes, indeed - like I was saying elsewhere in the message the async stuff
is mainly a win when generating a stream of data the device, as soon as
you have to wait for information from the device before you proceed
you're into the sync case.

> > it's not
> > going to get us terribly far unless we can arrange to push the entire
> > queue from DMA or something which would be complicated.

> One optimization is to not only read the the IRQ status register, but
> also the RX FIFO status register, in hope the IRQ is a RX IRQ. If there
> are pending TX frames, the TX FIFO status register can be read, too.

Yes, that'd fit in with the preprepared list of transactions idea.

> The driver uses regmap, which makes this a bit more complicated. I hope
> I can hide this behind regmap's caching feature.

We could probably do something that looks like the interface we use for
patching which allows the user to submit a batch of reads at once.

> The memory layout of this chip is not really great for this. Reading IRQ
> status + RX FIFO status (with one transfer) means a transfer length of
> 72 byes, in other words an overhead of 64 bytes. :/

At that point I'd guess you're probably better off doing several reads.

> What's the typical length of a SPI FIFO? On the imx6 it's 64 bytes. If
> the SPI host controller needs to refill the TX FIFO you probably have an
> additional IRQ per transfer, unless you are in polling mode.

It's kind of all over the place to be honest, 64 bytes is possibly on
the larger side.

> In our measurements of the spi-imx driver we found that IRQ based PIO
> mode is faster than DMA mode for these medium sized transfers, while
> polled PIO mode is faster for small transfers. I don't have the exact
> cutoff numbers. Even for this driver they depends on the used SoC.

> You see, it's quite a guessing game, depending on the SPI host driver
> (quality) and SoC, if 2 small or 1 lager transfer is better.

Yes, there's room for a lot of tuning of the threasholds for switching
to DMA - I've not seen much work in that area but it does feel like we
could get some useful wins.  I suspect that there is some room for
tuning depending on if we've got more work queued up as well, if we are
already running and can start the next transfer as DMA from hard IRQ
context that's probably going to be better at a lower threashold than if
the controller is idle and we can run the entire message with PIO in the
context of the requesting thread.

> > > 10us per SPI transfer with the fast API vs 30us per transfer on the current
> > > sync API, with the possibility of a single context switch taking several
> > > microseconds more (at least), make me think that this is not always the case,
> > > but maybe I am missing something?

> > It's not 100% guaranteed but it's fairly easy to build up, especially if
> > there's anything non-trivial going on between register writes or any
> > writes get large enough to be worth DMAing.

> It's mostly a register _read_ problem, not a _write_ problem.

Well, serialisation problem as much as anything - the issue with reads
is more needing one read to complete before we can work out what the
next one we need to do is than anything specific to reads.  That is
going to be much more likely to be an issue for reads though.

> The writes in the hot path of the interrupt handler are done in a single
> call to spi_sync_transfer() (consisting of several transfers). This
> might be converted into an async transfer.

That would certainly improve the interoperability with controllers -
there's a whole bunch where we just can't control the chip select so
anything that needs non-standard chip select handling in the middle of a
message just won't work.  Or possibly it's as well to just do a series
of spi_sync() operations.

> > This is the entire reason that spi_sync() runs inline when the bus is
> > uncontended rather than punting to the workqueue - but it just does that
> > without requiring that client drivers use a completely separate API to
> > trigger this behaviour.  If a client needs to wait for the message to
> > finish before doing the next one or is only doing a small number of
> > transfers before it needs to wait or do something else then spi_sync()
> > is absolutely a good interface for it, the more work is being done in a
> > single batch either for each message or in number of messages the more
> > likely it is that we will be able to get something out of spi_async(),
> > either now or in the future.

> As David measured the overhead of checking, housekeeping, statistics,
> etc... in spi.c for sync transfers is more than twice as big as the
> actual transfer itself.

Sure, the point here is that we don't need a new API but rather to
optimise the implementation of the current one - running spi_sync()
inline in the uncontended case is an example of doing that.

> > However the case you mention
> > where we know the operation we will want to do when the device
> > interrupts and have it similarly prepared for immediate start from
> > interrupt context is another valid one which makes a lot of sense.

> You mean start SPI transfer from hard IRQ? In which context will this
> SPI transfer be done?

Hardware ideally.

> > > > If there are other bits of the message setup code which are getting in
> > > > the way and don't have obvious paths for optimisation (the validation
> > > > potentially?) then if your application is spamming a lot of the same
> > > > operation (eg, with the status reading in the interrupt handler) then
> > > > quite a while ago Martin Sparl was looking at providing an interface
> > > > which would allow client drivers to pre-cook messages so that they could
> > > > be submitted multiple times without going through the validation that we
> > > > normally do (and perhaps get some driver preparation done as
> > > > well).

> Martin's version of the mcp251xfd driver make heavily use of
> pre-generated messages, maybe Martin came up with the idea while working
> on this.

Yes, IIRC it was a CAN bus optimising for throughput.

> > Not off hand sorry, and it was more at the design stage than
> > implementation IIRC.  Hopefuly lore can help?  I'll try to dig out some
> > references later but it was quite a while ago.  His application was even
> > lower latency than what you're proposing, basically getting messages
> > prepared so that all the management of the chip select and controller
> > as well as the data transfer could be done through a sequence of DMA
> > operations with no intervention from the CPU and we just needed to queue
> > those DMA operations (on a Pi, which has suitable controller and DMA
> > hardware) and was therefore both faster and lower CPU load in the hot
> > path.  Extremely cool, but hard to abstract on the controller side.

> For register write this is interesting. Basically scatter gather for SPI
> based register access? For read this is harder. Just read any
> information you might need in the hot path and hope that it's faster
> than individual transfers?

Yes, it's a bit more interesting for things like checking interrupt
status.

One thing that might be useful would be if we could start the initial
status read message from within the hard interrupt handler of the client
driver with the goal that by the time it's threaded interrupt handler
runs we might have the data available.  That could go wrong on a lightly
loaded system where we might end up running the threaded handler while
the transfer is still running, OTOH if it's lightly loaded that might
not matter.  Or perhaps just use a completion from the SPI operation and
not bother with the threaded handler at all.

--ttiGBkzg2SPsZFri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCjf0ACgkQJNaLcl1U
h9BjGwf+PRH6MO/Zne+RIVs00O4Ec22Fq3V2rj1F6FYQxl6Jc+2Ad7anGptzCnwH
NrnbhrLuTt/ttxsEuYbJEOSyIodLUvL4jGJ0IzO5w595nkN6HkYRcUXnQ5nhGyXH
fWwPIc0JFO7+J3F0U4yY44OVM2p5HVh/u1shYZfeEDn+LIGgB9oFaZi6g6+tcfhV
MQdwDKzD7Br1ZXKpc8KEGQ2FWegj/eeG+3a7uVUm6S7NiTX+7udqRufYsR5VlI7W
ylPHv8SVWF0uL5+rfBDO7Qp4MBrRODwCpI0H1etS+M/iC6gDUZxgdc+fjh6o5iD+
UjvQdr1qOQmtYxcDNxw9VOVkUtZ4DQ==
=QDJG
-----END PGP SIGNATURE-----

--ttiGBkzg2SPsZFri--
