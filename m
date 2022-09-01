Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E95A965C
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiIAMIc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 08:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiIAMIb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 08:08:31 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E737EA338
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Mh5ZAwE0H09V5EJX4QR04qeTJwqYdtAQjh8v9LOyyz8=;
        b=bKfyQDSd738gv8xYKBZO2bbShaeJp8W5Rmo8iDR0+wyhKlv8OjEAVN1yezuFTsTbzv9/IVjonOayj
         NqbTNzT02mS0RBkEO9g+gvD70uZaxstoLa3nLZTN5SMb8YKzV6A+ZowwMQF9e/q6PEjmk90PtHoVlQ
         5/X6a0CpyGYbOCQyoihxyM+f9/kO8V+4ktqlE3pZ0H9Osd3U4qN5hz1nMfoalLUHGfCD9a980lEs9j
         tqckcVQueuQVU5JBkD0XaWkm5sB7owVhdAQW/giYdA1RANcquNSPahIkrt5ZKBccZTvgPe7mAq+FYH
         pXlsAmoQaWAkfiNvn0a433zcJtO4tvg==
X-MSG-ID: c80cc119-29ee-11ed-8a45-0050569d11ae
Date:   Thu, 1 Sep 2022 14:08:24 +0200
From:   David Jander <david@protonic.nl>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Casper Andersson <casper.casan@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <20220901140824.64977e82@erd992>
In-Reply-To: <YxCam3BMVyTo+ZON@axis.com>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
        <20220829105613.476622d2@erd992>
        <Yw+HTj98V1ToLWIL@sirena.org.uk>
        <YxBX4bXG02E4lSUW@axis.com>
        <20220901130222.587f4932@erd992>
        <YxCam3BMVyTo+ZON@axis.com>
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

On Thu, 1 Sep 2022 13:42:19 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Thu, Sep 01, 2022 at 01:02:22PM +0200, David Jander wrote:
> > On Thu, 1 Sep 2022 08:57:37 +0200
> > Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:  
> > > You can reproduce the problem with:
> > > 
> > >  git remote add vwax https://github.com/vwax/linux.git
> > >  git fetch vwax
> > >  git archive vwax/roadtest/devel tools/testing/roadtest | tar xf -
> > >  make -C tools/testing/roadtest/ -j24 OPTS="-k adc --rt-timeout 10 -v"
> > > 
> > > The test passes on v5.19 but on current mainline it hangs and times out.  
> > 
> > This is very nice. Thanks.  
> 
> Great to hear that it was useful!
> 
> > I followed your instructions, and if I apply the following, all tests are
> > passed.
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index 83da8862b8f2..32c01e684af3 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
> >         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
> >  
> >         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> > -       if (!ret)
> > -               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> > +       kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> >  
> >         ctlr->cur_msg = NULL;
> >         ctlr->fallback = false;
> > 
> > The problem is that if __spi_pump_transfer_message() fails, the ctlr->busy
> > flag is left true, so __spi_async() is not going to queue new work. The busy
> > transition is handled right above that piece of code, in
> > __spi_pump_transfer_message(), and the mechanism is to queue more work to do
> > it. Apparently work was only queued when the transfer was successful, and I am
> > not sure why it was like that. Queuing work unconditionally solves the issue
> > and should not be a problem.
> > 
> > Curious thing is, that this change alone is sufficient to make all the
> > roadtest tests pass. But I still think that does not fix the bug reported by
> > Casper. For that, Mark's patch is also necessary.  
> 
> Yes, I noticed that too.  If you comment out the two usages of
> "@flaky_bus" in tools/testing/roadtest/roadtest/tests/iio/adc/test_adc084s021.py then
> the bus error injection will be disabled and only the success paths will
> be tested.  If you do that and test ae7d2346dc89ae89a6e0 ("spi: Don't
> use the message queue if possible in spi_sync") with the crash fix and
> iio sysfs fixes cherry-picked in, you'll see the following failure
> without Mark's patch:
> 
>  FAILED roadtest/tests/iio/adc/test_adc084s021.py::test_illuminance - BlockingIOError: [Errno 115] Operation now in progress
> 
> But if you move forward to 69fa95905d40846756d22 ("spi: Ensure the
> io_mutex is held until spi_finalize_current_message()"), then the tests
> start passing again, if they're run without the error injection.
> 
> So 69fa95905d40846756d22 seems to be masking the original problem from
> ae7d2346dc89ae89a6e0 (while at the same time introducing the other
> problem in the error handling).

The following patch set should be viewed as one single change:

dc3029056b02 spi: opportunistically skip ctlr->cur_msg_completion
69fa95905d40 spi: Ensure the io_mutex is held until spi_finalize_current_message()
72c5c59b659d spi: Set ctlr->cur_msg also in the sync transfer case
1a9cafcb57b7 spi: Remove unneeded READ_ONCE for ctlr->busy flag
66a221593cb2 spi: Remove the now unused ctlr->idling flag
049d6ccc4da8 spi: Remove check for idling in __spi_pump_messages()
d5256cce1f50 spi: Remove check for controller idling in spi sync path
8711a2ab51dd spi: __spi_pump_messages: Consolidate spin_unlocks to goto target
c1038165fbbf spi: Lock controller idling transition inside the io_mutex
ae7d2346dc89 spi: Don't use the message queue if possible in spi_sync
1714582a3a08 spi: Move ctlr->cur_msg_prepared to struct spi_message

I left the individual steps, in order to make it easier to view how the code
mutated, but the individual steps have had very little testing in between, and
some have known problems in corner-cases.
Particularly patch 69fa95905d40 does fix support for controllers that do not
call spi_finalize_current_message() in the same context as transfer_one(), for
example from IRQ, or in the case of the mux from a completion. If you replace
spi_async() with spi_sync() in spi-mux.c you will accomplish the same.

Best regards,

-- 
David Jander
