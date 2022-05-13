Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8041C526240
	for <lists+linux-spi@lfdr.de>; Fri, 13 May 2022 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiEMMqz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 May 2022 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiEMMqy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 May 2022 08:46:54 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86993369CB
        for <linux-spi@vger.kernel.org>; Fri, 13 May 2022 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=CIqLKEzYneMqZI6Krn4eyF+rXP8CrzOpa+m8olp1Dm4=;
        b=ompdtJNbQ50EQLV7BKcN5AmVWfYAHbzhkHL+lEz99J/Tdc54KkO/eDp4Gxn+JARE3BqzQW4pEzWYr
         JiNMLLcFNZo7XInubs2rqjXi6MeJlfd9TZ0dBsIgGo7NSF9/r4iLClO5o0+XPmhTGEEdnn+v2Q7J6d
         3vlFM8Suf3BtOWGw1bfLVLUxZ7D0FCbFiQSnAh/UWhblThjXpclGIAx6Cj/bI/bFmecGcj4DVO1e84
         DOab+b8wesKUCFIZxXCPYNLqsw733Zw6pLrfoC3QEZICySYZa2GdPH12WZ8QBF7jUQq1AlKF8ANDrk
         7F4JY8UwZyjqDjBTAp1vnDy4olvWEOw==
X-MSG-ID: bf985bbd-d2ba-11ec-b450-0050569d3a82
Date:   Fri, 13 May 2022 14:46:45 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <20220513144645.2d16475c@erd992>
In-Reply-To: <Yn1wE4TLyXCIm9GF@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
        <Yn1wE4TLyXCIm9GF@sirena.org.uk>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Mark,

Thanks a lot for your reply!

On Thu, 12 May 2022 21:37:39 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Thu, May 12, 2022 at 04:34:45PM +0200, David Jander wrote:
> 
> > Sorry for sending an RFC without actual patches. What I am about to propose
> > would require a lot of work, and I am sure I will not get it right without
> > first asking for comments. I also assume that I might not be the only one
> > asking/proposing this, and may ignore the existence of discussions that may
> > have happened in the past. If I am committing a crime, please accept my
> > apologies and let me know.  
> 
> > TL;DR: drivers/spi/spi.c API has too much overhead for some use cases.  
> 
> It would be really helpful if you could describe in concrete terms your
> actual use case here.  According to your mail you are testing with a
> single threaded echo server which is obviously not a realistic
> application and will be a bit of a limiting factor, it would be good to
> understand what's going on in a way that's less microbenchmarky.

I agree that from the SPI bus standpoint I did not take multiple SPI users
into account, but that is kind of a special scenario on purpose. I am also a
hardware designer, and as such I would never hook up an MCP2518FD to an SPI
bus that I know will also be used for other peripherals at the same time. It
would kill CAN bus performance. In essence, it would be a broken design. I
know this is short sighted, because others might still want to do this, so you
have a good point there.
On what respects the user-space application talking to the network interface,
of course it could be multi-threaded, or even multiple applications using CAN,
but that doesn't change much of what happens in the kernel. The CAN interface
is still one physical interface, so at the CAN driver level all transactions
are serialized and can be viewed as single threaded from the SPI driver point
of view.
Maybe I need to explain some more details about the nature of the CAN bus
(network): CAN is based on small frames of up to ca 130 bits max, at bit-rates
that can go up to 1Mbit/s. It is intended for semi-hard real-time communication
with low or very-low latency. An application should ideally be able to receive
a single CAN frame and send out a response almost immediately. This is not a
micro-benchmark in this sense, but a realistic scenario of how CAN bus
applications work. The J1939 protocol for example is mostly based of
single-frame command-response schemes, which do not allow for in-flight
commands. This means that each command needs to be responded to before the next
command can be sent by the other party. This makes it essential, that reaction
to incoming messages and processing of them be as fast as possible, specially
for single messages. The CAN networking layer in the kernel even has a special
CAN receive off-loading ring-buffer mechanism that can be called in hard-IRQ
context [1]. Regular (ideal) CAN controllers are connected to a fast local bus,
so that the driver can access interrupt-flag and receive data registers in
real-time from hard-IRQ context, and that works very well.
Obviously, an SPI connected CAN controller is far from ideal, but in practice
it is possible to get quite close to local-bus CAN controller performance...
just not with current spi.c code.

> High level it feels like you are approaching this at the wrong level, as
> far as I can tell you are proposing a completely separate API for
> drivers which cuts out all the locking which doesn't seem like a very
> usable API for them as the performance characteristics are going to end
> up being very system and application specific, it's going to be hard for
> them to assess which API to use.  I'm not seeing anything here that says
> add a new API, there's certainly room to make the existing API more
> performant but I don't see the jump to a new API.

Of course it would be great if we could just make the current sync API more
performant, but I had given up trying. Maybe if we can somehow implement the
fast-path in the same API that might work, but that seems like a daunting task
to me. This is an RFC, so I am open to suggestions of course.

> > There are many use-cases for SPI in the Linux kernel, and they all have
> > special requirements and trade-offs: On one side one wants to transfer large
> > amount of data to the peripheral efficiently (FLASH memory) and without
> > blocking. On the opposite side there is the need to modify registers in a
> > SPI-mapped peripheral, ideally using regmap.  
> 
> > There are two APIs already: sync and async, that should cover these use-cases.
> > Unfortunately both share a large portion of the code path, which causes the
> > sync use-case for small, fast register manipulation to be bogged down by all
> > the accounting and statistics code. There's also sometimes memcpy()'s involved
> > to put buffers into DMA space (driver dependent), even though DMA isn't used.  
> 
> That's not really a good description of what's going on with those APIs
> or choosing between them - there's certainly no short/long message
> distinction intended, the distinction is more about if the user needs to
> get the results of the transfer before proceeding with a side order of
> the sync APIs being more convenient to use.  In general if a user has a
> lot of work to do and doesn't specifically need to block for it there
> will often be a performance advantage in using the async API, even if
> the individual messages are short.  Submitting asynchronously means that

I agree that the async API has perfectly valid use-cases, even for shorter
messages, but this is very rarely the case for register-based peripherals like
this CAN controller. To prove my point, have a look at the CPU load figures I
showed in my first email: The current sync API uses 2.5 times the CPU time of
the fast API. And this is still without a context switch, but it tells
you something about the portion of CPU cycles consumed by the polling loop. I
have a hard time believing that doing this same task asynchronously wouldn't
use significantly more CPU time even. Maybe we should measure it to settle the
case?
In any case, it would obliterate latency.
Just for illustration: In kernel 5.16, the spi-imx.c driver still didn't have
a polling mode and relied on a workqueue. With this SPI driver the CAN driver
was so slow, it couldn't keep up with CAN traffic at anything higher than 10%
bus load.... not due to CPU load but due to latency, which makes CPU load
impossible to asses or to compare in that case unfortunately.

> we are more likely to be able to start pushing a new message immediately
> after completion of one message which minimises dead time on the bus,

10us per SPI transfer with the fast API vs 30us per transfer on the current
sync API, with the possibility of a single context switch taking several
microseconds more (at least), make me think that this is not always the case,
but maybe I am missing something?

> and opens up opportunities for preparing one message while the current
> one is in flight that don't otherwise exist (opportunities than we
> currently make much use of).  Conversely a large message where we need
> the result in order to proceed is going to do just fine with the sync
> API, it is actually a synchronous operation after all.

I agree for the case of big sync transfers (under the assumption that
interruptible sleep is used of course).
The point I am trying to make is that the time required for small, fast
transfers (16-64bits on 20+MHz clock, a very common use-case) is often far
less, or at best in the order of magnitude of the time all the extra code in
spi.c takes to execute, and definitely much lower than what a context switch
would take. A simple look at the scope signals of such SPI transfers just
tells all the story.
What this means, is that you can optimize for concurrency however much you
want, you will ALWAYS be slower and consume more CPU time than simple fast
low-overhead uninterruptible polling approach. Independent of whether you need
the result for the next operation or not.

> One example of lots of potentially short messages is regmap's cache sync
> code, it uses async writes to sync the register map so that it can
> overlap working out what to sync and marshalling the data with the
> actual writes - that tends to pan out as meaning that the sync completes
> faster since we can often identify and queue several more registers to
> write in the time it takes to send the first one which works out faster
> even with PIO controllers and bouncing to the worker thread, the context
> switching ends up being less than the time taken to work out what to
> send for even a fairly small number of registers.

Can you point to an example of this? I think it will depend a lot on SPI clock
and the size and amount of registers in the regmap... and whether multiple
registers can be written in one SPI transfer or not.

> > Assuming the *sync* API cannot be changed, this leads to the need to introduce
> > a new API optimized specifically for this use-case. IMHO it is also reasonable
> > to say that when accessing registers on a peripheral device, the whole
> > statistics and accounting machinery in spi.c isn't really so valuable, and
> > definitely not worth its overhead in a production system.  
> 
> That seems like a massive assumption, one could equally say that any
> application that is saturating the SPI bus is going to be likely to want
> to be able to monitor the performance and utilisation of the bus in
> order to facilitate optimisation and so want the statistics.

I agree. But do you really need to have that code in the hot-path always,
instead of only during development, debugging and testing?

> > 5. Details of the SPI transfers involved
> > ----------------------------------------
> > 
> > The MCP2518FD CAN driver does a series of small SPI transfers when running a
> > single CAN message from cangen to canecho and back:
> > 
> >  1. CAN message RX, IRQ line asserted
> >  2. Hard IRQ empty, starts IRQ thread
> >  3. IRQ thread interrogates MCP2518FD via register access:
> >  3.1. SPI transfer 1: CS low, 72bit xfer, CS high
> >  3.2. SPI transfer 2: CS low, 200bit xfer, CS high
> >  3.3. SPI transfer 3: CS low, 72bit xfer, CS high
> >  3.4. SPI transfer 4: CS low, 104bit xfer, CS high
> >  4. IRQ thread ended, RX message gets delivered to user-space
> >  5. canecho.c recv()
> >  6. canecho.c send()
> >  7. TX message gets delivered to CAN driver
> >  8. CAN driver does spi_async to queue 2 xfers (replace by spi_sync equivalent
> >  in kernel C):
> >  8.1. SPI message 1: CS low, 168bit xfer, CS high, CS low, 48bit xfer, CS high
> >  9. CAN message SOF starts appearing on the bus just before last CS high.  
> 
> Note that this is all totally single threaded and sequential which is
> going to change the performance characteristics substantially, for
> example adding and driving another echo server or even just having the
> remote end push another message into flight before it waits for a
> response would get more mileage out of the async API.

AFAIK, it doesn't really matter how many echo servers you have in user-space.
In the end, inside the CAN driver it is just one queue that talks to the SPI
driver in exactly the same way. And like I explained above, this is a pretty
common situation in CAN networks like J1939, where 90% of the time a single
remote-ECU is talking to a single process on the local machine, and the only
thing that matters is single-in-flight response time.

> > 6.1. Accounting spinlocks:  
> 
> > Spinlocks are supposed to be fast, especially for the case that they are not
> > contested, but in such critical paths their impact shouldn't be neglected.  
> 
> > SPI_STATISTICS_ADD_TO_FIELD: This macro defined in spi.h has a spinlock, and
> > it is used 4 times directly in __spi_sync(). It is also used in
> > spi_transfer_one_message() which is called from there. Removing the spinlocks
> > (thus introducing races) makes the code measurably faster (several us).  
> 
> > spi_statistics_add_transfer_stats(): Called twice from
> > spi_transfer_one_message(), and also contains a spinlock. Removing these again
> > has a measurable impact of several us.  
> 
> So for example a sysctl to suppress stats, or making the stats code
> fancier with per cpu data or whatever so it doesn't need to lock in the
> hot path would help here (obviously the latter is a bit nicer).  Might
> be interesting seeing if it's the irqsave bit that's causing trouble
> here, I'm not sure that's actually required other than for the error
> counters.

Sure. It would be great if that was possible, and if it could at least get
close to the performance of my proposal. I assumed it wasn't, because I
thought the accounting interface being part of the user-space API was set in
stone. But if it can be disabled (efficiently), then of course that might be a
far better solution.

> > spi_set_cs(): Removing all delay code and leaving the bare minimum for GPIO
> > based CS activation again has a measurable impact. Most (all?) simple SPI
> > peripheral chips don't have any special CS->clock->CS timing requirements, so
> > it might be a good idea to have a simpler version of this function.  
> 
> Surely the thing there would just be to set the delays to zero if they
> can actually be zero (and add a special case for actually zero delay
> which we don't currently have)?  But in any case devices do always have
> some minimum requirements for delays at various points around asserting
> chip select, plus there's considerations around providing enough ramp
> time for signals to reach appropriate levels which are more system level
> than chip level.  The required delays are normally very small so
> effectively pan out as zero in a lot of systems but the faster things
> run (both on the bus and for the SoC) the more visible they get and more
> attention needs to be paid.  It should be possible to do something to
> assess a delay as being effectively zero and round down which would feed
> in here when we're managing the chip select from software but we can't
> just ignore the delays.
> 
> I note that for example that the MPC2515 quotes minimum chip select
> setup, hold and disable times of 50ns - those are very small, but they
> are non-zero.

In practice, when moving a GPIO pin from code and then start an SPI transfer
immediately, you couldn't get close to 50ns even if you did your best to try.
This is of course under the assumption that the GPIO is local (not an I2C
expander or something like that) and the IO pin slew-rate is in the same
range as the SPI signals... which is probably the case in 99% (100%?) of such
hardware.
SPI peripherals very rarely have CS setup and hold time requirements that
deviate far from the period time of a SPI clock cycle, let alone are so long
that software manipulating a GPIO pin needs to be delayed artificially.
Keep in mind that the _theoretical_ granularity of the current software
implementation is 10us... that is 200 time the CS setup/hold time of the chip
you mention! So if you introduce even the minimal non-zero delay, you'd kill
SPI bandwidth by a factor of 2 for 50 bit transfers.

> > Since this hypothetical new API would be used only for very short, very fast
> > transfers where latency and overhead should be minimized, the best way to do
> > it is obviate all scheduling work and do it strictly synchronous and based on
> > polling. The context switch of even a hard-IRQ can quickly cost a lot more CPU
> > cycles than busy waiting for 48 bits to be shifted through the transmitter at
> > 20+MHz clock. This requires that SPI drivers offer low-level functions that do
> > such simple transfers on polling basis. The patches [1] from Marc Kleine-Budde
> > already do this, but it is the SPI driver that choses whether to use polling or
> > IRQ based transfers based on heuristics calculating the theoretical transfer
> > time given the clock frequency and its size. While it improves the performance
> > in a lot of cases already, peripheral drivers have no choice but to still go
> > through all the heavy code in spi.c.  
> 
> There's a whole pile of assumptions in there about the specific system
> you're running on and how it's going to perform.  Like I said above it
> really feels like this is the wrong level to approach things at, it's
> pushing decisions to the client driver that are really system specific.

Is that always the case? I mean, client drivers should know best what the
requirements are for their SPI transfers, right? Does it need to optimize
latency for very short fast transfers, or does it need to send fire-and-forget
bulk transfers? Does it need to do transfers from interrupt context? Does it
need strictly local-GPIO based CS?
I agree that this will make some combinations of client drivers with some SPI
controllers or GPIO controllers incompatible, but that's just the way it is.
An MCP2518FD is simply unworkable without local-GPIO CS or polling mode SPI.

> Why would a client doing "short" transfers (short itself being a fuzzy
> term) not want to use this interface, and what happens when for example

With "short" I always mean that it takes a time which lies in the order of
magnitude or less than that of context-switch overhead.

> someone puts one of these CAN controllers on a USB dongle which simply
> can't implement a non-blocking mode?  We should aim to do things which

It would need a local microcontroller that does buffering, so the problem
would be translated to the USB domain and the latencies achievable there.
If you are thinking of some sort of SPI over USB interface, that would just
not work for this chip.

> just benefit any client driver using the APIs idiomatically without them
> having to make assumptions about either the performance characteristics
> of the system they're running on or the features it has, especially if
> those assumptions would make the driver unusuable on some systems.

I get what you mean. Yet besides this CAN controller I can point to another
example where this is not so obvious: Oleksij Rempel recently contributed a
IIO-ADC based driver for the TSC2046 touchscreen controller. While this
controller works at a very slow SPI clock where these things are much less of
a problem, it is very sensitive to the SPI CS setup time. Right now, in
order to get the timing right, the driver will add extra data to the beginning
of the SPI transfer [2], which depends on the SPI clock to calculate an exact
delay. Any deviation of CS setup time introduces uncertainty to this timing.
Fortunately each board can specify and tune this time in their device-tree.

> > Since these are low-latency applications, chances are very high that the
> > hardware is also designed for low-latency access, which implies that CS
> > control via GPIO most probably uses local GPIO controllers instead of I2C GPIO
> > expanders for example, so CS access can be assumed to be fast and direct and  
> 
> High chances are not guarantees, and none of this sounds like things
> that should require specific coding in the client drivers.

Ok, but if the hardware is designed to require low latency of SPI messages,
based on a certain SPI clock, bus load and maximum CS setup time? In those
cases, an API that introduces so much overhead, that the maximum achievable
SPI bus load is less than 10% and CS setup time alone exceeds the complete
transfer time needed, might be just unusable.
What I am saying is that IMHO one cannot assume that any combination of SPI
peripheral with any SPI controller is a workable combination. That's just not
the case. A hardware developer that didn't take that into consideration didn't
do his job. But if it is the software that kills the use-case... then it is
not the hardware developers fault anymore... although I'd argue it is at least
in part, because IMHO one should only use hardware components (and
combinations) that are supported in mainline Linux, or account fot the needed
software development ;-)

> > not involve any context switches. It could be argued that it might even be
> > beneficial to have an API that can be called from hard IRQ context, but
> > experiments in this case showed that the gain of doing the CAN message read
> > out directly in hard-IRQ and removing the IRQ thread is minimal. But better
> > use-cases could be conceived, so this possibility might need consideration
> > also.  
> 
> That's something that the async API (or the sync API in the contended
> case) can enable - if we have another transfer queued then we would if
> someone did the work be able to arrange to start pushing it immediately
> the prior transfer completes.

Don't know if I follow you here. You mean that a hard-IRQ schedules the start
of an async transfer and later the interrupt thread function just picks up the
result? That would be a cool way of reading out some registers indeed.
Unfortunately though, again, the context switch from hard-IRQ to interrupt
thread would be preempted by the SPI worker queue, introducing an unbearable
delay due to context-switch overhead alone... at least on my machine (quad
core ARM Cortex-A53).

> > Care should be taken to solve locking in such a way, that it doesn't impact
> > performance for the fast API, while still allowing safe concurrency with
> > spi_sync and spi_async. I did not go as far as to solve this issue. I just
> > used a simple spinlock and carefully avoided using any call to the old API for
> > doing these proof-of-concept measurements.  
> 
> Apart from the hard bits...  :P

Yeah... I am not an expert in locking mechanisms in the kernel. I figured
someone more versed in this could come up with an efficient solution.

> The only bits of the existing code that you've specifically identified
> as taking substantial time here are the delays and the statistics, both
> of these seem like areas which could just be improved in place without
> requiring changes outside of the SPI subsystem that benefit all users.
> It sounds like the bits you've profiled as causing trouble are delays
> and stats synchronisation which does sound plausible but those do also
> seem like they can be specifically targetted - being smarter about when
> we actually do a delay, and either improving the locking or providing
> more optimisation for the stats code.

I tried... but in the end I got the impression that nothing really takes that
much time. It's the whole bunch of code together that is just slow.
To be fair, "slow" is a relative term. We are talking microseconds here.
And I think that's the whole point: The use-case here is comparing direct
local-bus access to peripheral registers (in the order of 100ns) with SPI
transactions that in theory don't take more than 5-10us. It is very easy to
get into single microsecond territory with a few ifs, even if they are not
taken, and even on a decently fast machine.
With the advent of quad-spi in peripheral chips (as opposed to FLASH memory),
this will be even more critical I suppose.

> If there are other bits of the message setup code which are getting in
> the way and don't have obvious paths for optimisation (the validation
> potentially?) then if your application is spamming a lot of the same
> operation (eg, with the status reading in the interrupt handler) then
> quite a while ago Martin Sparl was looking at providing an interface
> which would allow client drivers to pre-cook messages so that they could
> be submitted multiple times without going through the validation that we
> normally do (and perhaps get some driver preparation done as well).  He
> was looking at it for other reasons but it seems like a productive
> approach for cutting down on the setup overhead, it would require more
> up front work in the client but cut down on the amount of work done per
> operation and seems like it should scale well over different systems.

That sounds indeed interesting. I suspect that the message setup is also
relatively CPU intensive.
Do you have a pointer to Martin's work or discussion?
The idea of being able to setup a message (or transfer) once and then only
modify the TX buffer and re-send it avoiding all the message validation and
checking sounds like a worthwhile optimization. That together with a way to
disable all the accounting code efficiently, sounds like it might be just what
is needed here.

> > Performance of spi.c API for the specified use-cases is not ideal.
> > Unfortunately there is no single smoking gun to be pointed at, but instead
> > many different bits which are not needed for the given use-case that add to
> > the bloat and ultimately have a big combined performance impact.
> > The stated usage scenario is fairly common in the Linux kernel. A simple
> > investigation counted 60+ IIO drivers and 9 input drivers alone that use
> > spi_sync*() for example, up to a total of 171 .c files. In contrast only 11 .c
> > files use the spi_async*() calls. This does not account for all users of
> > regmap_spi.
> > Due to this, IMHO one can ask for a better, simpler, more efficient API for
> > these use-cases, am I want to propose to create it.  
> 
> I see the problem, what I don't see is why it requires a new externally
> visible API to solve it beyond the suggestion about potentially
> preparing messages for repeated use if that's even something that's
> really registering.

I doubted it was possible, but you are convincing me that it maybe can be done.
Like I said above: re-use of messages and skipping all the accounting code
would probably be good enough.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/dev/rx-offload.c?h=v5.18-rc6#n204

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/adc/ti-tsc2046.c?h=v5.18-rc6#n356

Best regards,

-- 
David Jander
Protonic Holland.
