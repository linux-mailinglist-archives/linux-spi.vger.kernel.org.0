Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884AC528A5A
	for <lists+linux-spi@lfdr.de>; Mon, 16 May 2022 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiEPQ3D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 May 2022 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiEPQ3D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 May 2022 12:29:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554193A5FC
        for <linux-spi@vger.kernel.org>; Mon, 16 May 2022 09:28:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nqdaX-0000FC-Mu; Mon, 16 May 2022 18:28:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6E7DB7F950;
        Mon, 16 May 2022 16:28:52 +0000 (UTC)
Date:   Mon, 16 May 2022 18:28:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     David Jander <david@protonic.nl>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
 <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oatepbwdi3leb4oh"
Content-Disposition: inline
In-Reply-To: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--oatepbwdi3leb4oh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.05.2022 20:36:51, Mark Brown wrote:
> > On what respects the user-space application talking to the network inte=
rface,
> > of course it could be multi-threaded, or even multiple applications usi=
ng CAN,
> > but that doesn't change much of what happens in the kernel. The CAN int=
erface
> > is still one physical interface, so at the CAN driver level all transac=
tions
> > are serialized and can be viewed as single threaded from the SPI driver=
 point
> > of view.
>=20
> That's not entirely true - there's some degree of buffering in your CAN
> controller, and obviously more than one device transacting on the bus,
> so you can improve throughput by having a new transaction ready to
> proceed as soon as the bus becomes free.  Eliminating the round trip to
> the host CPU as much as possible is generally going to be beneficial for
> a load like you've got, assuming throughput is the main goal.

The TX path in the mcp251xfd driver uses spi_async() call directly from
the ndo_start_xmit callback. I've a proof of concept patch (not
mainline) that adds xmit_more() support, resulting in sending more than
one TX CAN frame with one SPI transfer.

The mainline mcp251xfd CAN driver already supports software timer based
IRQ coalescing, where the RX and/or TX-complete IRQ stay disabled for a
configurable amount of time after serving the interrupt. That
dramatically reduces the number of SPI transfers as several
RX/TX-complete CAN frames can be transferred in one go.

Both of these measures trade latency for throughput, but David is
looking especially for low latency.

> > Maybe I need to explain some more details about the nature of the CAN b=
us
> > (network): CAN is based on small frames of up to ca 130 bits max, at bi=
t-rates
> > that can go up to 1Mbit/s. It is intended for semi-hard real-time commu=
nication
> > with low or very-low latency. An application should ideally be able to =
receive
> > a single CAN frame and send out a response almost immediately. This is =
not a
> > micro-benchmark in this sense, but a realistic scenario of how CAN bus
> > applications work. The J1939 protocol for example is mostly based of
> > single-frame command-response schemes, which do not allow for in-flight
> > commands. This means that each command needs to be responded to before =
the next
>=20
> My understanding was that CAN is a multi-device bus so even if you're
> doing single threaded RPC to an individual target there may be multiple
> targest being transacted with at once?

There are several use cases for CAN busses. Some prefer low latency
(from RX-IRQ to CAN frame in user space), while others have to deal with
100% CAN bus load. 100% bus load translates to 8k...16k CAN frames per
second, depending on CAN frame size and bit rate. Without coalescing
there's 1 IRQ per CAN frame, with coalescing it's much better (< 1/10 of
IRQ rate).

> > > High level it feels like you are approaching this at the wrong level,=
 as
> > > far as I can tell you are proposing a completely separate API for
> > > drivers which cuts out all the locking which doesn't seem like a very
> > > usable API for them as the performance characteristics are going to e=
nd
> > > up being very system and application specific, it's going to be hard =
for
> > > them to assess which API to use.  I'm not seeing anything here that s=
ays
> > > add a new API, there's certainly room to make the existing API more
> > > performant but I don't see the jump to a new API.
>=20
> > Of course it would be great if we could just make the current sync API =
more
> > performant, but I had given up trying. Maybe if we can somehow implemen=
t the
> > fast-path in the same API that might work, but that seems like a daunti=
ng task
> > to me. This is an RFC, so I am open to suggestions of course.
>=20
> Well, you've identifed a couple of candidates for optimisation here...
> I would start off by trying to address the specific hot points that
> you've identified and see where that takes us, like I said nothing I'm
> hearing sounds like anything other than trying to optimise the hot path
> and it doesn't seem like anything was really tried there yet.

I thinks the statistics are an easy target.

> > > That's not really a good description of what's going on with those AP=
Is
> > > or choosing between them - there's certainly no short/long message
> > > distinction intended, the distinction is more about if the user needs=
 to
> > > get the results of the transfer before proceeding with a side order of
> > > the sync APIs being more convenient to use.  In general if a user has=
 a
> > > lot of work to do and doesn't specifically need to block for it there
> > > will often be a performance advantage in using the async API, even if
> > > the individual messages are short.  Submitting asynchronously means t=
hat
>=20
> > I agree that the async API has perfectly valid use-cases, even for shor=
ter
> > messages, but this is very rarely the case for register-based periphera=
ls like
> > this CAN controller. To prove my point, have a look at the CPU load fig=
ures I
> > showed in my first email: The current sync API uses 2.5 times the CPU t=
ime of
> > the fast API. And this is still without a context switch, but it tells
> > you something about the portion of CPU cycles consumed by the polling l=
oop. I
> > have a hard time believing that doing this same task asynchronously wou=
ldn't
> > use significantly more CPU time even. Maybe we should measure it to set=
tle the
> > case?
>=20
> How much of that time is due to the API being async vs just nobody
> having tried to optimise the slow bits?

You mean slow bits of the mcp251xfd driver?

The TX path of the mcp251xfd driver is fire and forget (see above) and
the spi_async() API fits quite good here....

> Also bear in mind that
> a huge proportion of systems have multiple CPUs available these days so
> CPU time isn't wall clock time - one of the advantages is that we can
> start sending the initial transfers while working out what else to send
> which is useful if there's anything non-trivial going on there.  If the
> driver is doing no work in between messages and the messages are all
> short enough to do using PIO on the system concerned then yes,

If the chip throws an IRQ it's more complicated. The driver has to read
the IRQ status register before it knows which IRQ to handle. For the RX
IRQ it has to read the fill level from the RX FIFO, then it can finally
read the RX'ed CAN frames. The driver does read as many frames as
possible with one transfer.

So the hot path is the RX IRQ, TX-complete IRQ handling is similar but
not as important (as the hardware has a buffer for outgoing TX frames),
the other IRQ sources are various kinds of error handling.

> it's not
> going to get us terribly far unless we can arrange to push the entire
> queue from DMA or something which would be complicated.

One optimization is to not only read the the IRQ status register, but
also the RX FIFO status register, in hope the IRQ is a RX IRQ. If there
are pending TX frames, the TX FIFO status register can be read, too.

The driver uses regmap, which makes this a bit more complicated. I hope
I can hide this behind regmap's caching feature.

The memory layout of this chip is not really great for this. Reading IRQ
status + RX FIFO status (with one transfer) means a transfer length of
72 byes, in other words an overhead of 64 bytes. :/

What's the typical length of a SPI FIFO? On the imx6 it's 64 bytes. If
the SPI host controller needs to refill the TX FIFO you probably have an
additional IRQ per transfer, unless you are in polling mode.

In our measurements of the spi-imx driver we found that IRQ based PIO
mode is faster than DMA mode for these medium sized transfers, while
polled PIO mode is faster for small transfers. I don't have the exact
cutoff numbers. Even for this driver they depends on the used SoC.

You see, it's quite a guessing game, depending on the SPI host driver
(quality) and SoC, if 2 small or 1 lager transfer is better.

> > > we are more likely to be able to start pushing a new message immediat=
ely
> > > after completion of one message which minimises dead time on the bus,
>=20
> > 10us per SPI transfer with the fast API vs 30us per transfer on the cur=
rent
> > sync API, with the possibility of a single context switch taking several
> > microseconds more (at least), make me think that this is not always the=
 case,
> > but maybe I am missing something?
>=20
> It's not 100% guaranteed but it's fairly easy to build up, especially if
> there's anything non-trivial going on between register writes or any
> writes get large enough to be worth DMAing.

It's mostly a register _read_ problem, not a _write_ problem.

Compared to the regmap the mcp251xfd driver does trivial stuff in the RX
path. We need the information of the 1st read to do the 2nd read and the
information of the 2nd read to do the actual read of the CAN frame. The
length of these individual transfers is not worth DMAing - polled PIO is
the fastest approach here.

The writes in the hot path of the interrupt handler are done in a single
call to spi_sync_transfer() (consisting of several transfers). This
might be converted into an async transfer.

> > > and opens up opportunities for preparing one message while the current
> > > one is in flight that don't otherwise exist (opportunities than we
> > > currently make much use of).  Conversely a large message where we need
> > > the result in order to proceed is going to do just fine with the sync
> > > API, it is actually a synchronous operation after all.
> >=20
> > I agree for the case of big sync transfers (under the assumption that
> > interruptible sleep is used of course).
> > The point I am trying to make is that the time required for small, fast
> > transfers (16-64bits on 20+MHz clock, a very common use-case) is often =
far
> > less, or at best in the order of magnitude of the time all the extra co=
de in
> > spi.c takes to execute, and definitely much lower than what a context s=
witch
> > would take. A simple look at the scope signals of such SPI transfers ju=
st
> > tells all the story.
> > What this means, is that you can optimize for concurrency however much =
you
> > want, you will ALWAYS be slower and consume more CPU time than simple f=
ast
> > low-overhead uninterruptible polling approach. Independent of whether y=
ou need
> > the result for the next operation or not.
>=20
> This is the entire reason that spi_sync() runs inline when the bus is
> uncontended rather than punting to the workqueue - but it just does that
> without requiring that client drivers use a completely separate API to
> trigger this behaviour.  If a client needs to wait for the message to
> finish before doing the next one or is only doing a small number of
> transfers before it needs to wait or do something else then spi_sync()
> is absolutely a good interface for it, the more work is being done in a
> single batch either for each message or in number of messages the more
> likely it is that we will be able to get something out of spi_async(),
> either now or in the future.

As David measured the overhead of checking, housekeeping, statistics,
etc... in spi.c for sync transfers is more than twice as big as the
actual transfer itself.

> > > One example of lots of potentially short messages is regmap's cache s=
ync
> > > code, it uses async writes to sync the register map so that it can
> > > overlap working out what to sync and marshalling the data with the
> > > actual writes - that tends to pan out as meaning that the sync comple=
tes
> > > faster since we can often identify and queue several more registers to
> > > write in the time it takes to send the first one which works out fast=
er
> > > even with PIO controllers and bouncing to the worker thread, the cont=
ext
> > > switching ends up being less than the time taken to work out what to
> > > send for even a fairly small number of registers.

All writes in the hot path either async (for TX) already or they are
several writes of the same value to the same register with toggling CS
in between. These are done with a single spi_sync_transfer() (with
work^W opportunity on our side to convert to async, too).

> > Can you point to an example of this? I think it will depend a lot on SP=
I clock
> > and the size and amount of registers in the regmap... and whether multi=
ple
> > registers can be written in one SPI transfer or not.
>=20
> Look at register maps like wm5102 for an example of a larger register
> map where the wins start to add up - I can't remember exactly but I
> suspect that was one of my main targets when I was benchmarking this.
>=20
> IIRC for smaller cases the difference between sync and async ended up
> being mostly a wash, especially with multiple CPUs available but even on
> a single CPU you ended up doing a couple of context switches or
> something (one switching to the SPI pump, then another switching back
> when everything was done) which is non-zero but in this context totally
> fine.
>=20
> > > > Assuming the *sync* API cannot be changed, this leads to the need t=
o introduce
> > > > a new API optimized specifically for this use-case. IMHO it is also=
 reasonable
> > > > to say that when accessing registers on a peripheral device, the wh=
ole
> > > > statistics and accounting machinery in spi.c isn't really so valuab=
le, and
> > > > definitely not worth its overhead in a production system. =20
>=20
> > > That seems like a massive assumption, one could equally say that any
> > > application that is saturating the SPI bus is going to be likely to w=
ant
> > > to be able to monitor the performance and utilisation of the bus in
> > > order to facilitate optimisation and so want the statistics.
>=20
> > I agree. But do you really need to have that code in the hot-path alway=
s,
> > instead of only during development, debugging and testing?
>=20
> As Andrew pointed out the networking code manages to have stats code in
> hot paths that a large number of people care deeply about, I am fairly
> confident that the overhead can be reduced to the point where it is much
> less impactful next to the actual I/O.  The closer we can keep people's
> production and development setups the easier life tends to be for them,
> and even if it's something selected at build time having to use a
> completely separate set of calls in the client driver is going to be
> needlessly painful to use.
>=20
> Not saying there's nothing to improve here, just that a completely
> separate API doesn't seem like the answer.
>=20
> > > >  1. CAN message RX, IRQ line asserted
> > > >  2. Hard IRQ empty, starts IRQ thread
> > > >  3. IRQ thread interrogates MCP2518FD via register access:
> > > >  3.1. SPI transfer 1: CS low, 72bit xfer, CS high
> > > >  3.2. SPI transfer 2: CS low, 200bit xfer, CS high
> > > >  3.3. SPI transfer 3: CS low, 72bit xfer, CS high
> > > >  3.4. SPI transfer 4: CS low, 104bit xfer, CS high
> > > >  4. IRQ thread ended, RX message gets delivered to user-space
> > > >  5. canecho.c recv()
> > > >  6. canecho.c send()
> > > >  7. TX message gets delivered to CAN driver
> > > >  8. CAN driver does spi_async to queue 2 xfers (replace by spi_sync=
 equivalent
> > > >  in kernel C):
> > > >  8.1. SPI message 1: CS low, 168bit xfer, CS high, CS low, 48bit xf=
er, CS high
> > > >  9. CAN message SOF starts appearing on the bus just before last CS=
 high. =20
> > > Note that this is all totally single threaded and sequential which is
> > > going to change the performance characteristics substantially, for
> > > example adding and driving another echo server or even just having the
> > > remote end push another message into flight before it waits for a
> > > response would get more mileage out of the async API.
>=20
> > AFAIK, it doesn't really matter how many echo servers you have in user-=
space.
>=20
> You should be able to get a situation where one end of the link is
> reading a message from it's CAN controller, the other end of the link is
> sending a message to it's CAN controller and one of the CAN controllers
> is sending on the bus.  Ideally (assuming CAN and the controllers cope
> well with this) at least one of the controllers should always have a
> message queued so that as soon as the bus goes idle another message can
> start sending.  It did look like that was viable from the datasheet I
> glanced through but...
>
> > In the end, inside the CAN driver it is just one queue that talks to th=
e SPI
> > driver in exactly the same way. And like I explained above, this is a p=
retty
> > common situation in CAN networks like J1939, where 90% of the time a si=
ngle
> > remote-ECU is talking to a single process on the local machine, and the=
 only
> > thing that matters is single-in-flight response time.
>=20
> ...if that's not really what an application is going to do I guess it
> doesn't matter here.  The test looked like it was going for throughput
> rather than latency.

See above, not all use cases are about throughput, David's about latency.

> > > So for example a sysctl to suppress stats, or making the stats code
> > > fancier with per cpu data or whatever so it doesn't need to lock in t=
he
> > > hot path would help here (obviously the latter is a bit nicer).  Might
> > > be interesting seeing if it's the irqsave bit that's causing trouble
> > > here, I'm not sure that's actually required other than for the error
> > > counters.
>=20
> > Sure. It would be great if that was possible, and if it could at least =
get
> > close to the performance of my proposal. I assumed it wasn't, because I
> > thought the accounting interface being part of the user-space API was s=
et in
> > stone. But if it can be disabled (efficiently), then of course that mig=
ht be a
> > far better solution.
>=20
> Worst case if it's not possible to make it fast enough and people are
> relying on the numbers then we could have a control that defaults it to
> on, then if someone explicitly chooses to turn it off then they can
> presumably cope.
>=20
> > > > spi_set_cs(): Removing all delay code and leaving the bare minimum =
for GPIO
> > > > based CS activation again has a measurable impact. Most (all?) simp=
le SPI
> > > > peripheral chips don't have any special CS->clock->CS timing requir=
ements, so
> > > > it might be a good idea to have a simpler version of this function.=
 =20
>=20
> > > Surely the thing there would just be to set the delays to zero if they
> > > can actually be zero (and add a special case for actually zero delay
> > > which we don't currently have)?  But in any case devices do always ha=
ve
>=20
> ...
>=20
> > > attention needs to be paid.  It should be possible to do something to
> > > assess a delay as being effectively zero and round down which would f=
eed
> > > in here when we're managing the chip select from software but we can't
> > > just ignore the delays.
>=20
> > In practice, when moving a GPIO pin from code and then start an SPI tra=
nsfer
> > immediately, you couldn't get close to 50ns even if you did your best t=
o try.
> > This is of course under the assumption that the GPIO is local (not an I=
2C
> > expander or something like that) and the IO pin slew-rate is in the same
> > range as the SPI signals... which is probably the case in 99% (100%?) o=
f such
> > hardware.
>=20
> That's the "assess the delay as effectively zero" case I mentioned
> above, we should definitely do that.
>=20
> > SPI peripherals very rarely have CS setup and hold time requirements th=
at
> > deviate far from the period time of a SPI clock cycle, let alone are so=
 long
> > that software manipulating a GPIO pin needs to be delayed artificially.
>=20
> There's a bunch of things which have a requirement expressed in terms of
> their master clock rather than the SPI clock (see SPI_DELAY_UNIT_SCK) or
> absolute numbers which can push things up, or special requirements when
> in low power states (not just low power states where the MCLK speed is
> reduced!).  It's not the default case by any mens but this control is
> there for a reason.
>=20
> > > There's a whole pile of assumptions in there about the specific system
> > > you're running on and how it's going to perform.  Like I said above it
> > > really feels like this is the wrong level to approach things at, it's
> > > pushing decisions to the client driver that are really system specifi=
c.
>=20
> > Is that always the case? I mean, client drivers should know best what t=
he
> > requirements are for their SPI transfers, right? Does it need to optimi=
ze
>=20
> The definitions of "short" and "fast" are going to be per system things,
> and the imagination of system integrators can be surprising.  Even with
> something like CAN you're looking at it for what sounds like the
> original ECU application but someone else might decide that it's a good
> fit for some completely different application that uses the bus in a
> different way and so don't build the hardware in a way that's expected.
>=20
> Clients should just do whatever they need to do and let the core figure
> out how that maps on to the particular controller hardware that the
> system has, the core should be able to scale things gracefully even for
> surprising system designs.  We don't want to have clients doing things
> that make the driver totally unusable on some systems, or which cause
> performance to fall off a cliff if the system behaves unexpectedly.
>=20
> > latency for very short fast transfers, or does it need to send fire-and=
-forget
> > bulk transfers?
>=20
> That's already in the API, a client can send whatever transfer length it
> needs and it can send them async.  To put it another way, why would a
> driver ever choose something other than the fast API?
>=20
> >                 Does it need to do transfers from interrupt context? Do=
es it
> > need strictly local-GPIO based CS?
>=20
> We would need something new to have transfers run entirely in hard
> interrupt context (ie, waiting for the transfer to complete rather than
> starting/stopping) and TBH I'd take some convincing that it was a use
> case that makes sense - it's really rude to everything else in the
> system, and we do have tools for configuring the scheduling threaded
> work.
>=20
> Requiring GPIO based chip selects definitely feels suspicious, even
> ignoring system integrators being surprising there's perfectly
> performant and flexible controllers that don't have GPIO based chip
> selects at all.
>=20
> > > Why would a client doing "short" transfers (short itself being a fuzzy
> > > term) not want to use this interface, and what happens when for examp=
le
>=20
> > With "short" I always mean that it takes a time which lies in the order=
 of
> > magnitude or less than that of context-switch overhead.
>=20
> Both the transfer and context switch times being variable of course -
> there's going to be cutoffs somewhere and those cutoffs have much wider
> ranges than a driver author might anticipate.  A small microcontroller
> style SoC and a cutting edge mobile phone SoC are going to have rather
> different characteristics on the CPU side.
>=20
> > > just benefit any client driver using the APIs idiomatically without t=
hem
> > > having to make assumptions about either the performance characteristi=
cs
> > > of the system they're running on or the features it has, especially if
> > > those assumptions would make the driver unusuable on some systems.
>=20
> > I get what you mean. Yet besides this CAN controller I can point to ano=
ther
> > example where this is not so obvious: Oleksij Rempel recently contribut=
ed a
> > IIO-ADC based driver for the TSC2046 touchscreen controller. While this
> > controller works at a very slow SPI clock where these things are much l=
ess of
> > a problem, it is very sensitive to the SPI CS setup time. Right now, in
> > order to get the timing right, the driver will add extra data to the be=
ginning
> > of the SPI transfer [2], which depends on the SPI clock to calculate an=
 exact
> > delay. Any deviation of CS setup time introduces uncertainty to this ti=
ming.
> > Fortunately each board can specify and tune this time in their device-t=
ree.
>=20
> I really don't see the concern or conflict here?  The DT property there
> is the settling time before the samples are usable which is perfectly
> normal for ADCs.
>=20
> > > High chances are not guarantees, and none of this sounds like things
> > > that should require specific coding in the client drivers.
>=20
> > Ok, but if the hardware is designed to require low latency of SPI messa=
ges,
> > based on a certain SPI clock, bus load and maximum CS setup time? In th=
ose
> > cases, an API that introduces so much overhead, that the maximum achiev=
able
> > SPI bus load is less than 10% and CS setup time alone exceeds the compl=
ete
> > transfer time needed, might be just unusable.
>=20
> If the performance is that bad then why only improve the performance for
> some subset of client drivers that happen to use some different API
> rather than for any driver?  I'm not sure there's any devices out there
> that explicitly want poor performance.
>=20
> > > > not involve any context switches. It could be argued that it might =
even be
> > > > beneficial to have an API that can be called from hard IRQ context,=
 but
> > > > experiments in this case showed that the gain of doing the CAN mess=
age read
> > > > out directly in hard-IRQ and removing the IRQ thread is minimal. Bu=
t better
> > > > use-cases could be conceived, so this possibility might need consid=
eration
> > > > also. =20
>=20
> > > That's something that the async API (or the sync API in the contended
> > > case) can enable - if we have another transfer queued then we would if
> > > someone did the work be able to arrange to start pushing it immediate=
ly
> > > the prior transfer completes.
>=20
> > Don't know if I follow you here. You mean that a hard-IRQ schedules the=
 start
> > of an async transfer and later the interrupt thread function just picks=
 up the
> > result? That would be a cool way of reading out some registers indeed.
>=20
> I was thinking more about the case where there's a series of operations
> to perform so that when one completes we can immediately initiate the
> next, for example in a multi transfer message starting the second
> transfer as the first transfer finishes.

In the IRQ case we need the information of the 1st transfer (IRQ status
reg) to start the 2nd (read RX FIFO status reg or TX-complete FIFO
status reg).

> However the case you mention
> where we know the operation we will want to do when the device
> interrupts and have it similarly prepared for immediate start from
> interrupt context is another valid one which makes a lot of sense.

You mean start SPI transfer from hard IRQ? In which context will this
SPI transfer be done?

> > Unfortunately though, again, the context switch from hard-IRQ to interr=
upt
> > thread would be preempted by the SPI worker queue, introducing an unbea=
rable
> > delay due to context-switch overhead alone... at least on my machine (q=
uad
> > core ARM Cortex-A53).
>=20
> To be clear we don't do this yet.  The whole point would be to avoid the
> need to involve any thread in the hot path, in a way that would benefit
> as many client and controller drivers as possible.

It seems I haven't got the whole picture, can you explain a bit more?

> > > If there are other bits of the message setup code which are getting in
> > > the way and don't have obvious paths for optimisation (the validation
> > > potentially?) then if your application is spamming a lot of the same
> > > operation (eg, with the status reading in the interrupt handler) then
> > > quite a while ago Martin Sparl was looking at providing an interface
> > > which would allow client drivers to pre-cook messages so that they co=
uld
> > > be submitted multiple times without going through the validation that=
 we
> > > normally do (and perhaps get some driver preparation done as
> > > well).

Martin's version of the mcp251xfd driver make heavily use of
pre-generated messages, maybe Martin came up with the idea while working
on this.

> > > He
> > > was looking at it for other reasons but it seems like a productive
> > > approach for cutting down on the setup overhead, it would require more
> > > up front work in the client but cut down on the amount of work done p=
er
> > > operation and seems like it should scale well over different systems.
>=20
> > That sounds indeed interesting. I suspect that the message setup is also
> > relatively CPU intensive.
> > Do you have a pointer to Martin's work or discussion?
>=20
> Not off hand sorry, and it was more at the design stage than
> implementation IIRC.  Hopefuly lore can help?  I'll try to dig out some
> references later but it was quite a while ago.  His application was even
> lower latency than what you're proposing, basically getting messages
> prepared so that all the management of the chip select and controller
> as well as the data transfer could be done through a sequence of DMA
> operations with no intervention from the CPU and we just needed to queue
> those DMA operations (on a Pi, which has suitable controller and DMA
> hardware) and was therefore both faster and lower CPU load in the hot
> path.  Extremely cool, but hard to abstract on the controller side.

For register write this is interesting. Basically scatter gather for SPI
based register access? For read this is harder. Just read any
information you might need in the hot path and hope that it's faster
than individual transfers?

> > The idea of being able to setup a message (or transfer) once and then o=
nly
> > modify the TX buffer and re-send it avoiding all the message validation=
 and
> > checking sounds like a worthwhile optimization. That together with a wa=
y to
> > disable all the accounting code efficiently, sounds like it might be ju=
st what
> > is needed here.
>=20
> High level (and certainly for your application I think) that would be
> making an API that calls __spi_validate() and then sets a flag saying
> validation was done.  Then when a message is actually sent if the flag
> was set then don't bother doing the validation, and have an unvalidate
> (or rather unprepare I guess) API to be called when done with the
> message.  So something like
>=20
> 	spi_prepare_message(msg);
>=20
> 	spi_sync(msg);
> 	spi_sync(msg);
>=20
> 	spi_unprepare_message(msg);
>=20
> (we already have a prepare on the controller side so probably best think
> of another name there.)  We'd probably need to require that callers
> check to see if things are DMA mapped and handle mapping/unmapping if
> they access the data in between uses.

This sounds like a good approach to me!

> > > I see the problem, what I don't see is why it requires a new external=
ly
> > > visible API to solve it beyond the suggestion about potentially
> > > preparing messages for repeated use if that's even something that's
> > > really registering.
>=20
> > I doubted it was possible, but you are convincing me that it maybe can =
be done.
> > Like I said above: re-use of messages and skipping all the accounting c=
ode
> > would probably be good enough.
>=20
> OK, great.  You've definitely pointed out some things that could do with
> improvement in the existing code regardless of any API level stuff.
> I'll try to poke at the delay code myself.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oatepbwdi3leb4oh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKCe8AACgkQrX5LkNig
012W4Af/SIZLR0BURtv3+Pc0zpYKR8wJYGr53pE+0zeNicJIgcrd4kh5cloGyQBJ
2yqKTuHXZLeAzNUnlxySU9qDvf7tn2HtxthZYpBTsRrTEDas8omsWy2J8USpPHIe
U5DcnlU0FQp/DLAGSJ42lV5jTyHXK5mYJLnDoUlmYQ/0BHwdbmT+t/YabWOvEfRv
A6ZrfgWhRZ6+f6upGpw1XYlNmHLcbfVe4569yTuhc9YOvv56hnXMGha2QBNFEp1k
c6my36+QsatupBkp14gwMuBnBNToKHaLc8rjrHgACf69OLI9CCHQZTuWwybMRAR0
Odq7xhCpnO3GJwq2WzKhNlva69C6Jg==
=IHXr
-----END PGP SIGNATURE-----

--oatepbwdi3leb4oh--
