Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C4526A76
	for <lists+linux-spi@lfdr.de>; Fri, 13 May 2022 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383692AbiEMThA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 May 2022 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379948AbiEMTg7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 May 2022 15:36:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA653A6A
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 12:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F16F616AB
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 19:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81319C34100;
        Fri, 13 May 2022 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652470615;
        bh=JCFRPO8lVLiUP+JDmA0iicHeuX8v1cjwnieGT/wkD94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixfinDp8znjcpgJbdfujYgmEvFOYDMSWMUoKG5g0lM3yJthrcMMNLkt5/NzmZMd9z
         UoEdRzcK4gvLH/GHkUVBlBLPAUlqCbUhknJyzz+SkyH1i4zd5pbb8Gbarv3G4oXiwt
         UIZJcfDY4WZE+L0HVY4WdG9T4WDj5VuplzYmktbdHofZUwSPAzRlMuLBhADLf/Frfg
         OVHF4vSLvXmIwLvJdNpv8EW53hGXDgPrkSKvBouHcuEbyjZUL9v+mU0VHuFjLizdPY
         tIRzf2dFDQM3s2ZDIDtYfjfu/en9IzuWrEzoWGGygOzLHFN3mk2yxeT9L7R7nb3e+4
         znVJm68JzdFEg==
Date:   Fri, 13 May 2022 20:36:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AbV2zwONtgQTp00R"
Content-Disposition: inline
In-Reply-To: <20220513144645.2d16475c@erd992>
X-Cookie: You have taken yourself too seriously.
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AbV2zwONtgQTp00R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2022 at 02:46:45PM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Thu, May 12, 2022 at 04:34:45PM +0200, David Jander wrote:

> I agree that from the SPI bus standpoint I did not take multiple SPI users
> into account, but that is kind of a special scenario on purpose. I am als=
o a
> hardware designer, and as such I would never hook up an MCP2518FD to an S=
PI
> bus that I know will also be used for other peripherals at the same time.=
 It
> would kill CAN bus performance. In essence, it would be a broken design. I
> know this is short sighted, because others might still want to do this, s=
o you
> have a good point there.

Right, and of course other system integrators may not be bothered about
CAN bus performance (eg, just needing to send an occasional command vs a
constant data stream).

> On what respects the user-space application talking to the network interf=
ace,
> of course it could be multi-threaded, or even multiple applications using=
 CAN,
> but that doesn't change much of what happens in the kernel. The CAN inter=
face
> is still one physical interface, so at the CAN driver level all transacti=
ons
> are serialized and can be viewed as single threaded from the SPI driver p=
oint
> of view.

That's not entirely true - there's some degree of buffering in your CAN
controller, and obviously more than one device transacting on the bus,
so you can improve throughput by having a new transaction ready to
proceed as soon as the bus becomes free.  Eliminating the round trip to
the host CPU as much as possible is generally going to be beneficial for
a load like you've got, assuming throughput is the main goal.

> Maybe I need to explain some more details about the nature of the CAN bus
> (network): CAN is based on small frames of up to ca 130 bits max, at bit-=
rates
> that can go up to 1Mbit/s. It is intended for semi-hard real-time communi=
cation
> with low or very-low latency. An application should ideally be able to re=
ceive
> a single CAN frame and send out a response almost immediately. This is no=
t a
> micro-benchmark in this sense, but a realistic scenario of how CAN bus
> applications work. The J1939 protocol for example is mostly based of
> single-frame command-response schemes, which do not allow for in-flight
> commands. This means that each command needs to be responded to before th=
e next

My understanding was that CAN is a multi-device bus so even if you're
doing single threaded RPC to an individual target there may be multiple
targest being transacted with at once?

> > High level it feels like you are approaching this at the wrong level, as
> > far as I can tell you are proposing a completely separate API for
> > drivers which cuts out all the locking which doesn't seem like a very
> > usable API for them as the performance characteristics are going to end
> > up being very system and application specific, it's going to be hard for
> > them to assess which API to use.  I'm not seeing anything here that says
> > add a new API, there's certainly room to make the existing API more
> > performant but I don't see the jump to a new API.

> Of course it would be great if we could just make the current sync API mo=
re
> performant, but I had given up trying. Maybe if we can somehow implement =
the
> fast-path in the same API that might work, but that seems like a daunting=
 task
> to me. This is an RFC, so I am open to suggestions of course.

Well, you've identifed a couple of candidates for optimisation here...
I would start off by trying to address the specific hot points that
you've identified and see where that takes us, like I said nothing I'm
hearing sounds like anything other than trying to optimise the hot path
and it doesn't seem like anything was really tried there yet.

> > That's not really a good description of what's going on with those APIs
> > or choosing between them - there's certainly no short/long message
> > distinction intended, the distinction is more about if the user needs to
> > get the results of the transfer before proceeding with a side order of
> > the sync APIs being more convenient to use.  In general if a user has a
> > lot of work to do and doesn't specifically need to block for it there
> > will often be a performance advantage in using the async API, even if
> > the individual messages are short.  Submitting asynchronously means that

> I agree that the async API has perfectly valid use-cases, even for shorter
> messages, but this is very rarely the case for register-based peripherals=
 like
> this CAN controller. To prove my point, have a look at the CPU load figur=
es I
> showed in my first email: The current sync API uses 2.5 times the CPU tim=
e of
> the fast API. And this is still without a context switch, but it tells
> you something about the portion of CPU cycles consumed by the polling loo=
p. I
> have a hard time believing that doing this same task asynchronously would=
n't
> use significantly more CPU time even. Maybe we should measure it to settl=
e the
> case?

How much of that time is due to the API being async vs just nobody
having tried to optimise the slow bits?  Also bear in mind that
a huge proportion of systems have multiple CPUs available these days so
CPU time isn't wall clock time - one of the advantages is that we can
start sending the initial transfers while working out what else to send
which is useful if there's anything non-trivial going on there.  If the
driver is doing no work in between messages and the messages are all
short enough to do using PIO on the system concerned then yes, it's not
going to get us terribly far unless we can arrange to push the entire
queue from DMA or something which would be complicated.

> > we are more likely to be able to start pushing a new message immediately
> > after completion of one message which minimises dead time on the bus,

> 10us per SPI transfer with the fast API vs 30us per transfer on the curre=
nt
> sync API, with the possibility of a single context switch taking several
> microseconds more (at least), make me think that this is not always the c=
ase,
> but maybe I am missing something?

It's not 100% guaranteed but it's fairly easy to build up, especially if
there's anything non-trivial going on between register writes or any
writes get large enough to be worth DMAing.

> > and opens up opportunities for preparing one message while the current
> > one is in flight that don't otherwise exist (opportunities than we
> > currently make much use of).  Conversely a large message where we need
> > the result in order to proceed is going to do just fine with the sync
> > API, it is actually a synchronous operation after all.
>=20
> I agree for the case of big sync transfers (under the assumption that
> interruptible sleep is used of course).
> The point I am trying to make is that the time required for small, fast
> transfers (16-64bits on 20+MHz clock, a very common use-case) is often far
> less, or at best in the order of magnitude of the time all the extra code=
 in
> spi.c takes to execute, and definitely much lower than what a context swi=
tch
> would take. A simple look at the scope signals of such SPI transfers just
> tells all the story.
> What this means, is that you can optimize for concurrency however much you
> want, you will ALWAYS be slower and consume more CPU time than simple fast
> low-overhead uninterruptible polling approach. Independent of whether you=
 need
> the result for the next operation or not.

This is the entire reason that spi_sync() runs inline when the bus is
uncontended rather than punting to the workqueue - but it just does that
without requiring that client drivers use a completely separate API to
trigger this behaviour.  If a client needs to wait for the message to
finish before doing the next one or is only doing a small number of
transfers before it needs to wait or do something else then spi_sync()
is absolutely a good interface for it, the more work is being done in a
single batch either for each message or in number of messages the more
likely it is that we will be able to get something out of spi_async(),
either now or in the future.

> > One example of lots of potentially short messages is regmap's cache sync
> > code, it uses async writes to sync the register map so that it can
> > overlap working out what to sync and marshalling the data with the
> > actual writes - that tends to pan out as meaning that the sync completes
> > faster since we can often identify and queue several more registers to
> > write in the time it takes to send the first one which works out faster
> > even with PIO controllers and bouncing to the worker thread, the context
> > switching ends up being less than the time taken to work out what to
> > send for even a fairly small number of registers.

> Can you point to an example of this? I think it will depend a lot on SPI =
clock
> and the size and amount of registers in the regmap... and whether multiple
> registers can be written in one SPI transfer or not.

Look at register maps like wm5102 for an example of a larger register
map where the wins start to add up - I can't remember exactly but I
suspect that was one of my main targets when I was benchmarking this.

IIRC for smaller cases the difference between sync and async ended up
being mostly a wash, especially with multiple CPUs available but even on
a single CPU you ended up doing a couple of context switches or
something (one switching to the SPI pump, then another switching back
when everything was done) which is non-zero but in this context totally
fine.

> > > Assuming the *sync* API cannot be changed, this leads to the need to =
introduce
> > > a new API optimized specifically for this use-case. IMHO it is also r=
easonable
> > > to say that when accessing registers on a peripheral device, the whole
> > > statistics and accounting machinery in spi.c isn't really so valuable=
, and
> > > definitely not worth its overhead in a production system. =20

> > That seems like a massive assumption, one could equally say that any
> > application that is saturating the SPI bus is going to be likely to want
> > to be able to monitor the performance and utilisation of the bus in
> > order to facilitate optimisation and so want the statistics.

> I agree. But do you really need to have that code in the hot-path always,
> instead of only during development, debugging and testing?

As Andrew pointed out the networking code manages to have stats code in
hot paths that a large number of people care deeply about, I am fairly
confident that the overhead can be reduced to the point where it is much
less impactful next to the actual I/O.  The closer we can keep people's
production and development setups the easier life tends to be for them,
and even if it's something selected at build time having to use a
completely separate set of calls in the client driver is going to be
needlessly painful to use.

Not saying there's nothing to improve here, just that a completely
separate API doesn't seem like the answer.

> > >  1. CAN message RX, IRQ line asserted
> > >  2. Hard IRQ empty, starts IRQ thread
> > >  3. IRQ thread interrogates MCP2518FD via register access:
> > >  3.1. SPI transfer 1: CS low, 72bit xfer, CS high
> > >  3.2. SPI transfer 2: CS low, 200bit xfer, CS high
> > >  3.3. SPI transfer 3: CS low, 72bit xfer, CS high
> > >  3.4. SPI transfer 4: CS low, 104bit xfer, CS high
> > >  4. IRQ thread ended, RX message gets delivered to user-space
> > >  5. canecho.c recv()
> > >  6. canecho.c send()
> > >  7. TX message gets delivered to CAN driver
> > >  8. CAN driver does spi_async to queue 2 xfers (replace by spi_sync e=
quivalent
> > >  in kernel C):
> > >  8.1. SPI message 1: CS low, 168bit xfer, CS high, CS low, 48bit xfer=
, CS high
> > >  9. CAN message SOF starts appearing on the bus just before last CS h=
igh. =20
> > Note that this is all totally single threaded and sequential which is
> > going to change the performance characteristics substantially, for
> > example adding and driving another echo server or even just having the
> > remote end push another message into flight before it waits for a
> > response would get more mileage out of the async API.

> AFAIK, it doesn't really matter how many echo servers you have in user-sp=
ace.

You should be able to get a situation where one end of the link is
reading a message from it's CAN controller, the other end of the link is
sending a message to it's CAN controller and one of the CAN controllers
is sending on the bus.  Ideally (assuming CAN and the controllers cope
well with this) at least one of the controllers should always have a
message queued so that as soon as the bus goes idle another message can
start sending.  It did look like that was viable from the datasheet I
glanced through but...

> In the end, inside the CAN driver it is just one queue that talks to the =
SPI
> driver in exactly the same way. And like I explained above, this is a pre=
tty
> common situation in CAN networks like J1939, where 90% of the time a sing=
le
> remote-ECU is talking to a single process on the local machine, and the o=
nly
> thing that matters is single-in-flight response time.

=2E..if that's not really what an application is going to do I guess it
doesn't matter here.  The test looked like it was going for throughput
rather than latency.

> > So for example a sysctl to suppress stats, or making the stats code
> > fancier with per cpu data or whatever so it doesn't need to lock in the
> > hot path would help here (obviously the latter is a bit nicer).  Might
> > be interesting seeing if it's the irqsave bit that's causing trouble
> > here, I'm not sure that's actually required other than for the error
> > counters.

> Sure. It would be great if that was possible, and if it could at least get
> close to the performance of my proposal. I assumed it wasn't, because I
> thought the accounting interface being part of the user-space API was set=
 in
> stone. But if it can be disabled (efficiently), then of course that might=
 be a
> far better solution.

Worst case if it's not possible to make it fast enough and people are
relying on the numbers then we could have a control that defaults it to
on, then if someone explicitly chooses to turn it off then they can
presumably cope.

> > > spi_set_cs(): Removing all delay code and leaving the bare minimum fo=
r GPIO
> > > based CS activation again has a measurable impact. Most (all?) simple=
 SPI
> > > peripheral chips don't have any special CS->clock->CS timing requirem=
ents, so
> > > it might be a good idea to have a simpler version of this function. =
=20

> > Surely the thing there would just be to set the delays to zero if they
> > can actually be zero (and add a special case for actually zero delay
> > which we don't currently have)?  But in any case devices do always have

=2E..

> > attention needs to be paid.  It should be possible to do something to
> > assess a delay as being effectively zero and round down which would feed
> > in here when we're managing the chip select from software but we can't
> > just ignore the delays.

> In practice, when moving a GPIO pin from code and then start an SPI trans=
fer
> immediately, you couldn't get close to 50ns even if you did your best to =
try.
> This is of course under the assumption that the GPIO is local (not an I2C
> expander or something like that) and the IO pin slew-rate is in the same
> range as the SPI signals... which is probably the case in 99% (100%?) of =
such
> hardware.

That's the "assess the delay as effectively zero" case I mentioned
above, we should definitely do that.

> SPI peripherals very rarely have CS setup and hold time requirements that
> deviate far from the period time of a SPI clock cycle, let alone are so l=
ong
> that software manipulating a GPIO pin needs to be delayed artificially.

There's a bunch of things which have a requirement expressed in terms of
their master clock rather than the SPI clock (see SPI_DELAY_UNIT_SCK) or
absolute numbers which can push things up, or special requirements when
in low power states (not just low power states where the MCLK speed is
reduced!).  It's not the default case by any mens but this control is
there for a reason.

> > There's a whole pile of assumptions in there about the specific system
> > you're running on and how it's going to perform.  Like I said above it
> > really feels like this is the wrong level to approach things at, it's
> > pushing decisions to the client driver that are really system specific.

> Is that always the case? I mean, client drivers should know best what the
> requirements are for their SPI transfers, right? Does it need to optimize

The definitions of "short" and "fast" are going to be per system things,
and the imagination of system integrators can be surprising.  Even with
something like CAN you're looking at it for what sounds like the
original ECU application but someone else might decide that it's a good
fit for some completely different application that uses the bus in a
different way and so don't build the hardware in a way that's expected.

Clients should just do whatever they need to do and let the core figure
out how that maps on to the particular controller hardware that the
system has, the core should be able to scale things gracefully even for
surprising system designs.  We don't want to have clients doing things
that make the driver totally unusable on some systems, or which cause
performance to fall off a cliff if the system behaves unexpectedly.

> latency for very short fast transfers, or does it need to send fire-and-f=
orget
> bulk transfers?

That's already in the API, a client can send whatever transfer length it
needs and it can send them async.  To put it another way, why would a
driver ever choose something other than the fast API?

>                 Does it need to do transfers from interrupt context? Does=
 it
> need strictly local-GPIO based CS?

We would need something new to have transfers run entirely in hard
interrupt context (ie, waiting for the transfer to complete rather than
starting/stopping) and TBH I'd take some convincing that it was a use
case that makes sense - it's really rude to everything else in the
system, and we do have tools for configuring the scheduling threaded
work.

Requiring GPIO based chip selects definitely feels suspicious, even
ignoring system integrators being surprising there's perfectly
performant and flexible controllers that don't have GPIO based chip
selects at all.

> > Why would a client doing "short" transfers (short itself being a fuzzy
> > term) not want to use this interface, and what happens when for example

> With "short" I always mean that it takes a time which lies in the order of
> magnitude or less than that of context-switch overhead.

Both the transfer and context switch times being variable of course -
there's going to be cutoffs somewhere and those cutoffs have much wider
ranges than a driver author might anticipate.  A small microcontroller
style SoC and a cutting edge mobile phone SoC are going to have rather
different characteristics on the CPU side.

> > just benefit any client driver using the APIs idiomatically without them
> > having to make assumptions about either the performance characteristics
> > of the system they're running on or the features it has, especially if
> > those assumptions would make the driver unusuable on some systems.

> I get what you mean. Yet besides this CAN controller I can point to anoth=
er
> example where this is not so obvious: Oleksij Rempel recently contributed=
 a
> IIO-ADC based driver for the TSC2046 touchscreen controller. While this
> controller works at a very slow SPI clock where these things are much les=
s of
> a problem, it is very sensitive to the SPI CS setup time. Right now, in
> order to get the timing right, the driver will add extra data to the begi=
nning
> of the SPI transfer [2], which depends on the SPI clock to calculate an e=
xact
> delay. Any deviation of CS setup time introduces uncertainty to this timi=
ng.
> Fortunately each board can specify and tune this time in their device-tre=
e.

I really don't see the concern or conflict here?  The DT property there
is the settling time before the samples are usable which is perfectly
normal for ADCs.

> > High chances are not guarantees, and none of this sounds like things
> > that should require specific coding in the client drivers.

> Ok, but if the hardware is designed to require low latency of SPI message=
s,
> based on a certain SPI clock, bus load and maximum CS setup time? In those
> cases, an API that introduces so much overhead, that the maximum achievab=
le
> SPI bus load is less than 10% and CS setup time alone exceeds the complete
> transfer time needed, might be just unusable.

If the performance is that bad then why only improve the performance for
some subset of client drivers that happen to use some different API
rather than for any driver?  I'm not sure there's any devices out there
that explicitly want poor performance.

> > > not involve any context switches. It could be argued that it might ev=
en be
> > > beneficial to have an API that can be called from hard IRQ context, b=
ut
> > > experiments in this case showed that the gain of doing the CAN messag=
e read
> > > out directly in hard-IRQ and removing the IRQ thread is minimal. But =
better
> > > use-cases could be conceived, so this possibility might need consider=
ation
> > > also. =20

> > That's something that the async API (or the sync API in the contended
> > case) can enable - if we have another transfer queued then we would if
> > someone did the work be able to arrange to start pushing it immediately
> > the prior transfer completes.

> Don't know if I follow you here. You mean that a hard-IRQ schedules the s=
tart
> of an async transfer and later the interrupt thread function just picks u=
p the
> result? That would be a cool way of reading out some registers indeed.

I was thinking more about the case where there's a series of operations
to perform so that when one completes we can immediately initiate the
next, for example in a multi transfer message starting the second
transfer as the first transfer finishes.  However the case you mention
where we know the operation we will want to do when the device
interrupts and have it similarly prepared for immediate start from
interrupt context is another valid one which makes a lot of sense.

> Unfortunately though, again, the context switch from hard-IRQ to interrupt
> thread would be preempted by the SPI worker queue, introducing an unbeara=
ble
> delay due to context-switch overhead alone... at least on my machine (quad
> core ARM Cortex-A53).

To be clear we don't do this yet.  The whole point would be to avoid the
need to involve any thread in the hot path, in a way that would benefit
as many client and controller drivers as possible.

> > If there are other bits of the message setup code which are getting in
> > the way and don't have obvious paths for optimisation (the validation
> > potentially?) then if your application is spamming a lot of the same
> > operation (eg, with the status reading in the interrupt handler) then
> > quite a while ago Martin Sparl was looking at providing an interface
> > which would allow client drivers to pre-cook messages so that they could
> > be submitted multiple times without going through the validation that we
> > normally do (and perhaps get some driver preparation done as well).  He
> > was looking at it for other reasons but it seems like a productive
> > approach for cutting down on the setup overhead, it would require more
> > up front work in the client but cut down on the amount of work done per
> > operation and seems like it should scale well over different systems.

> That sounds indeed interesting. I suspect that the message setup is also
> relatively CPU intensive.
> Do you have a pointer to Martin's work or discussion?

Not off hand sorry, and it was more at the design stage than
implementation IIRC.  Hopefuly lore can help?  I'll try to dig out some
references later but it was quite a while ago.  His application was even
lower latency than what you're proposing, basically getting messages
prepared so that all the management of the chip select and controller
as well as the data transfer could be done through a sequence of DMA
operations with no intervention from the CPU and we just needed to queue
those DMA operations (on a Pi, which has suitable controller and DMA
hardware) and was therefore both faster and lower CPU load in the hot
path.  Extremely cool, but hard to abstract on the controller side.

> The idea of being able to setup a message (or transfer) once and then only
> modify the TX buffer and re-send it avoiding all the message validation a=
nd
> checking sounds like a worthwhile optimization. That together with a way =
to
> disable all the accounting code efficiently, sounds like it might be just=
 what
> is needed here.

High level (and certainly for your application I think) that would be
making an API that calls __spi_validate() and then sets a flag saying
validation was done.  Then when a message is actually sent if the flag
was set then don't bother doing the validation, and have an unvalidate
(or rather unprepare I guess) API to be called when done with the
message.  So something like

	spi_prepare_message(msg);

	spi_sync(msg);
	spi_sync(msg);

	spi_unprepare_message(msg);

(we already have a prepare on the controller side so probably best think
of another name there.)  We'd probably need to require that callers
check to see if things are DMA mapped and handle mapping/unmapping if
they access the data in between uses.

> > I see the problem, what I don't see is why it requires a new externally
> > visible API to solve it beyond the suggestion about potentially
> > preparing messages for repeated use if that's even something that's
> > really registering.

> I doubted it was possible, but you are convincing me that it maybe can be=
 done.
> Like I said above: re-use of messages and skipping all the accounting code
> would probably be good enough.

OK, great.  You've definitely pointed out some things that could do with
improvement in the existing code regardless of any API level stuff.
I'll try to poke at the delay code myself.

--AbV2zwONtgQTp00R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ+s1IACgkQJNaLcl1U
h9AOtwf/UODEUT0lEZv3D23rU7ef+cf/CJCbBZTea6u1yGYCJ886GX/FT+U+j9+a
0feSqWeZBr1BQgycyQSEVPRgXRXyZPY5P+MTfPiZoSfioCQYKbdkM85GxboBb0Eu
BgkW0sPa/8HhU3Km3N5Xx8epf3SSLtrOkVZU2EUC0RUCA2gj+kI5WAziNkENxmre
trSYHaLP8eqOq11B154BQTQbtA9BaNs23Ck28RVjaDz3gg9DiEdPi9a+XT+xlbhG
BmvFX8+oYNeUJchWqPwUiYeMo0l5lw1MOl/6/lMMskO++y303lY14EgdBJQKnuTX
5jRcvtFx12K1oawUwLcIBTGHHr07/w==
=SvV0
-----END PGP SIGNATURE-----

--AbV2zwONtgQTp00R--
