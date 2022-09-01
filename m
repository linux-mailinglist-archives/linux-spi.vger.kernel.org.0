Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF25A954E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 13:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiIALDA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiIALCf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 07:02:35 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF03112EFC
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=II/lt+XVJxuu1MurPBLKDT1XmhjLLDP/CPIRgxbisH0=;
        b=F5rgWXeWNLek1NtrBdceLk2/cMDYnl+gXAvQLNPgZJim4geT5+bLKLLbFBQgj8oCSpJf2SLL8Bx4A
         eOVoT2nvIvjN7Q6xwZBDEAL7n3t7l/XYn90sdYI6mV+vYFq+U0wyK2XsYFLkz4vshSqDs6/qC7/SHl
         jy3N1Ioyc9ON+CREtC/VpOAlUBPm4M41ckpAhKHb3cLqnPBl3TosOysEzKCvHvX9hW6O1SbWP+n2tC
         MzKCxaNSao0Px5BiqzT9/+Frfggn9zKw9QKZ+FOKhjdOUi+mhTYeh2/d5Gwp92ElR9ghqc7Pmpezvd
         HHJgPIAu0CAaOHNOUu+z+uIEa+ze53A==
X-MSG-ID: 8e0e1886-29e5-11ed-8a45-0050569d11ae
Date:   Thu, 1 Sep 2022 13:02:22 +0200
From:   David Jander <david@protonic.nl>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Casper Andersson <casper.casan@gmail.com>,
        <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <20220901130222.587f4932@erd992>
In-Reply-To: <YxBX4bXG02E4lSUW@axis.com>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
        <20220829105613.476622d2@erd992>
        <Yw+HTj98V1ToLWIL@sirena.org.uk>
        <YxBX4bXG02E4lSUW@axis.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Thu, 1 Sep 2022 08:57:37 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Wed, Aug 31, 2022 at 05:07:42PM +0100, Mark Brown wrote:
> > On Mon, Aug 29, 2022 at 10:56:13AM +0200, David Jander wrote:  
> > > Not sure if this is a correct fix, but I'd like to know if your situation
> > > changes this way, if you could try it.
> > > I don't have access to any hardware with a mux unfortunately, so I can't test
> > > it myself.  
> > 
> > I guess claiming to have a noop mux might work for testing, though I'd
> > be dubious that it was actually doing the mux operations properly?  I  
> 
> I'm seeing these problems with the roadtest test framework which uses
> UML and doesn't need any special hardware.  Roadtest puts its emulated
> devices under a spi-mux with gpio-mockup and there are no tests for the
> actual muxing, but other driver tests break since transfers using
> spi-mux don't work properly.
> 
> I pushed the latest version with SPI support to the tree below.  The
> test_adc084s021 tests a SPI device.  Roadtest is placed inside a linux
> tree, but it doesn't need any patches to the kernel:
> 
>  https://github.com/vwax/linux/commits/roadtest/devel
> 
> You can reproduce the problem with:
> 
>  git remote add vwax https://github.com/vwax/linux.git
>  git fetch vwax
>  git archive vwax/roadtest/devel tools/testing/roadtest | tar xf -
>  make -C tools/testing/roadtest/ -j24 OPTS="-k adc --rt-timeout 10 -v"
> 
> The test passes on v5.19 but on current mainline it hangs and times out.

This is very nice. Thanks.
I followed your instructions, and if I apply the following, all tests are
passed.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 83da8862b8f2..32c01e684af3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
        spin_unlock_irqrestore(&ctlr->queue_lock, flags);
 
        ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
-       if (!ret)
-               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
+       kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
 
        ctlr->cur_msg = NULL;
        ctlr->fallback = false;

The problem is that if __spi_pump_transfer_message() fails, the ctlr->busy
flag is left true, so __spi_async() is not going to queue new work. The busy
transition is handled right above that piece of code, in
__spi_pump_transfer_message(), and the mechanism is to queue more work to do
it. Apparently work was only queued when the transfer was successful, and I am
not sure why it was like that. Queuing work unconditionally solves the issue
and should not be a problem.

Curious thing is, that this change alone is sufficient to make all the
roadtest tests pass. But I still think that does not fix the bug reported by
Casper. For that, Mark's patch is also necessary.

@Casper: can you test Mark's patch with above addition?

> > think we need to either change spi_mux to duplicate the incoming message
> > (that's probably "cleaner") or teach the core that spi-mux exists and
> > should always use the pump/queue.  The below might do the trick but in
> > spite of my suggestion above I've not tested either yet:
> > 
> > diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> > index f5d32ec4634e..0709e987bd5a 100644
> > --- a/drivers/spi/spi-mux.c
> > +++ b/drivers/spi/spi-mux.c
> > @@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
> >  	ctlr->num_chipselect = mux_control_states(priv->mux);
> >  	ctlr->bus_num = -1;
> >  	ctlr->dev.of_node = spi->dev.of_node;
> > +	ctlr->must_async = true;
> >  
> >  	ret = devm_spi_register_controller(&spi->dev, ctlr);
> >  	if (ret)
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 1cfed874f7ae..88d48a105d3c 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
> >  	 * guard against reentrancy from a different context. The io_mutex
> >  	 * will catch those cases.
> >  	 */
> > -	if (READ_ONCE(ctlr->queue_empty)) {
> > +	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
> >  		message->actual_length = 0;
> >  		message->status = -EINPROGRESS;
> >  
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index e6c73d5ff1a8..f089ee1ead58 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> >   *	SPI_TRANS_FAIL_NO_START.
> >   * @queue_empty: signal green light for opportunistically skipping the queue
> >   *	for spi_sync transfers.
> > + * @must_async: disable all fast paths in the core
> >   *
> >   * Each SPI controller can communicate with one or more @spi_device
> >   * children.  These make a small bus, sharing MOSI, MISO and SCK signals
> > @@ -690,6 +691,7 @@ struct spi_controller {
> >  
> >  	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
> >  	bool			queue_empty;
> > +	bool			must_async;
> >  };
> >  
> >  static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
> > 
> > Assuming that works out there'll be an extra test in the fast path but
> > no sync operations, and a performance hit for spi-mux users.  Hopefully
> > that works as well as it did before.  
>[...]

Best regards,

-- 
David Jander
Protonic Holland.
