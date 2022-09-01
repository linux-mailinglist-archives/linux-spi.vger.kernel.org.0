Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF15A95DC
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiIALmY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiIALmX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 07:42:23 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E651314E2
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662032542;
  x=1693568542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qd/EZS8grf3Pa+l+ymh97GGhnjn+F/mqY/QsA5ER9pc=;
  b=iTPyBxlqCDrkT5iAvi4uSDewXpenR/rhy9+urvV83/reZEuokTD8ZmyI
   sPWCjrwSiRcLObmyW/wfIpeuRhdLZ9jN2R/bBZEuFZOm5PYIp1j80DpVA
   uBbimWWKsozIgb+dEcH00DSMU1X3PlvIFM+fonnbf4YRGm0YDWVxErQcC
   1w9y+MPaccuaw1uQzcmA/cwh+HIagLecnD1J+skM1YY+WcBW8LgLV0P36
   BVsf4Baol285EQBAIzmiuRahtLs1fG8QWXMkf2S8tnXrwX+tu3ugR/mHK
   nQKTLvmvqiyCvEqdIQ3H+95MklEc3rBgvMHe7xqLoqieiefg4EWjohGil
   w==;
Date:   Thu, 1 Sep 2022 13:42:19 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     David Jander <david@protonic.nl>
CC:     Mark Brown <broonie@kernel.org>,
        Casper Andersson <casper.casan@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <YxCam3BMVyTo+ZON@axis.com>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
 <Yw+HTj98V1ToLWIL@sirena.org.uk>
 <YxBX4bXG02E4lSUW@axis.com>
 <20220901130222.587f4932@erd992>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220901130222.587f4932@erd992>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 01, 2022 at 01:02:22PM +0200, David Jander wrote:
> On Thu, 1 Sep 2022 08:57:37 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > You can reproduce the problem with:
> > 
> >  git remote add vwax https://github.com/vwax/linux.git
> >  git fetch vwax
> >  git archive vwax/roadtest/devel tools/testing/roadtest | tar xf -
> >  make -C tools/testing/roadtest/ -j24 OPTS="-k adc --rt-timeout 10 -v"
> > 
> > The test passes on v5.19 but on current mainline it hangs and times out.
> 
> This is very nice. Thanks.

Great to hear that it was useful!

> I followed your instructions, and if I apply the following, all tests are
> passed.
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 83da8862b8f2..32c01e684af3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
>         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
>  
>         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> -       if (!ret)
> -               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> +       kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
>  
>         ctlr->cur_msg = NULL;
>         ctlr->fallback = false;
> 
> The problem is that if __spi_pump_transfer_message() fails, the ctlr->busy
> flag is left true, so __spi_async() is not going to queue new work. The busy
> transition is handled right above that piece of code, in
> __spi_pump_transfer_message(), and the mechanism is to queue more work to do
> it. Apparently work was only queued when the transfer was successful, and I am
> not sure why it was like that. Queuing work unconditionally solves the issue
> and should not be a problem.
> 
> Curious thing is, that this change alone is sufficient to make all the
> roadtest tests pass. But I still think that does not fix the bug reported by
> Casper. For that, Mark's patch is also necessary.

Yes, I noticed that too.  If you comment out the two usages of
"@flaky_bus" in tools/testing/roadtest/roadtest/tests/iio/adc/test_adc084s021.py then
the bus error injection will be disabled and only the success paths will
be tested.  If you do that and test ae7d2346dc89ae89a6e0 ("spi: Don't
use the message queue if possible in spi_sync") with the crash fix and
iio sysfs fixes cherry-picked in, you'll see the following failure
without Mark's patch:

 FAILED roadtest/tests/iio/adc/test_adc084s021.py::test_illuminance - BlockingIOError: [Errno 115] Operation now in progress

But if you move forward to 69fa95905d40846756d22 ("spi: Ensure the
io_mutex is held until spi_finalize_current_message()"), then the tests
start passing again, if they're run without the error injection.

So 69fa95905d40846756d22 seems to be masking the original problem from
ae7d2346dc89ae89a6e0 (while at the same time introducing the other
problem in the error handling).
