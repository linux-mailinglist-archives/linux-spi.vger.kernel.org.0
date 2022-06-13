Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C05482B8
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jun 2022 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiFMJF7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jun 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiFMJF6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jun 2022 05:05:58 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE26E0A6
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=JIDlFm5dd8GTbaw4Y2L+iprSIbRszDFQvJ4YZKLDx7E=;
        b=MCS8lsnaTBUwqTfUJJnscM/dmIYyxpk0Yf075MwETMH778A3Az8T9MHRNuWdv/feTsbhg++Fx1Xe+
         cy5Nsl1Pll+8a3AwmLeFqQjPhCE4LKGygqsFXdhgRv5skKWOqb6Y9QuKQXpzFNjf/DIfVPIt4A4Y9h
         kiJ3vdCnHuPm+z09SrRSVnr7nux1CJFpBvatziuLE1jnTfKzDC5jgZ2eEywTxAE+AqfbxMV7TUHJMe
         mfEXne7RWI2alYblrXC5YuwnGsz4CECSekCyDzkhLsna03mC15O5SlXEv5SpvXJoYn5lwH9oVCrc39
         iUdbu655vShxlshbXlGOSrrdU1uJi5w==
X-MSG-ID: 05b1ade8-eaf8-11ec-b450-0050569d3a82
Date:   Mon, 13 Jun 2022 11:05:50 +0200
From:   David Jander <david@protonic.nl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <20220613110550.772c5023@erd992>
In-Reply-To: <YqOKsumo2aXgCvFB@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
        <20220525142928.2335378-4-david@protonic.nl>
        <20220525164603.57c98a0a@erd992>
        <Yp+ZX4XITW7bQtjn@sirena.org.uk>
        <20220608095409.2d8c46fb@erd992>
        <YqCIDNHjFP4p9xxs@sirena.org.uk>
        <20220609173421.437fe1c4@erd992>
        <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
        <20220610092753.6e6c9e59@erd992>
        <YqNKCegdejr522lH@sirena.org.uk>
        <YqOKsumo2aXgCvFB@sirena.org.uk>
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

On Fri, 10 Jun 2022 19:17:22 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jun 10, 2022 at 02:41:34PM +0100, Mark Brown wrote:
> > On Fri, Jun 10, 2022 at 09:27:53AM +0200, David Jander wrote:  
> > > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > Ok, I first thought that this wouldn't be possible without taking the
> > > necessary spinlock, but looking a little closer, I think I understand now.
> > > One question to confirm I understand the code correctly:
> > > An SPI driver that implements its own transfer_one_message() is required to
> > > _always_ call spi_finalize_current_message() _before_ returning, right?  
> 
> > Yes, it should.  
> 
> Sorry, my mistake - I misremembered how that worked.  They might return
> without having completed the message since the message pump is a
> workqueue so it'll just go idle, spi_sync() will work because the caller
> will block on the completion in the message.  It's cur_msg that's
> stopping any new work being scheduled.  I was confusing this with the
> handling of individual transfers, it's been a while since I got deep
> into this.
>
> The bit about allowing us to finalise in any context still applies - the
> goal with that interface is to avoid the need to context switch back to
> the message pump to report that the message completed, and ideally
> immediately start work on the next message if the controller can cope
> with that.

Thinking out loud here, so correct me if I am wrong.
Basically what is happening in that scenario, if we had several async
messages queued up, is this:

 1. __pump_messages() gets first message off queue, stores in cur_msg.
 2. __pump_messages() calls ->transfer_one_message().
 3. transfer_one_message() triggers an IRQ or other context *A*.
 4. transfer_one_message() returns before message is finished.
 5. work queue idles. If someone calls spi_async() now, it will not queue
 work, since ctlr->busy is still true.
 6. *A*: IRQ or other context calls spi_finalize_current_message()
 7. spi_finalize_current_message() schedules new work.
 8. Goto 1.

 Total ctx switches message->message: 2 (at steps 3->6 and 7->8).

Right now, the io_mutex is taken at step 1. and released after step 4. If we
wanted to get an unqueued sync message in between that makes use of cur_msg
safely, then we'd have to change this to take the io_mutex in step 1. and only
release it in step 7. The first obvious problem with that is that the locking
looks unclean. It will be hard to follow, which is probably sub-optimal.
Another potential issue would be in case transfer_one_message() calls
spi_finalize_current_message() before it is actually done accessing the
hardware for some reason, leading to the io_mutex being released too early?
Another solution is what you propose below...

> > > If this is a guarantee and we take the io_mutex at the beginning of
> > > __spi_pump_messages(), then ctlr->cur_msg is only manipulated with the
> > > io_mutex held, and that would make it safe to be used in the sync path, which
> > > is also behind the io_mutex.
> > > Would appreciate if you could confirm this, just to be sure I understand the
> > > code correctly.  
> 
> > I think that should work.  If there's something missed it should be
> > possible to make things work that way.  
> 
> Can we move the cleanup of cur_msg out of spi_finalize_current_message()
> and into the context holding the io_mutex with that blocking on a
> completion?  Don't know what the overhead of that is like, I think it
> should be fine for the case where we don't actually block on the
> completion and it shouldn't be any worse in the case where we're
> completing in the interrupt.  Also the kthread_queue_work() that's in
> there could be moved out to only the queued case since with your new
> approach for spi_sync() we'll idle the hardware in the calling context
> and don't need to schedule the thread at all, that should save some
> overhead.

Ack.
To compare this to my listing above, the difference is that your idea has
cleaner locking:

 1. __pump_messages() gets first message off queue, stores in cur_msg.
 2. __pump_messages() calls ->transfer_one_message().
 3. transfer_one_message() triggers an IRQ or other context *A*.
 4. transfer_one_message() returns before message is finished.
 5. __pump_messages() waits for completion *B*.
 6. If someone calls spi_async() now, it will not queue work, because
 ctlr->busy is still true, and the io_mutex is locked anyway.
 7. *A*: IRQ or other context calls spi_finalize_current_message()
 8. spi_finalize_current_message() completes the completion *B*
 9. *B*: __pump_messages() wakes up on completion, queues next work.
 10. Goto 1.

 Total ctx switches message->message: 2 (at steps 3->7 and 8->9).

So, AFAICS, it looks like the same in terms of overhead. In the presence of an
SMP system, there are only 2 context switches from message to message in both
cases... although each call wait_for_completion() and complete() are
internally spin-locked, so that's that. Won't affect sync path though.

In this scenario, the io_mutex is taken at step 1 and released at step 9,
inside the same function. The io_mutex is released either after
transfer_one_message() returns, or after spi_finalize_current_message() is
called, whatever comes _LAST_. I think I like this. Any potential problems
I am missing?

> Sorry about misremembering this bit.

Never mind ;-)

Best regards,

-- 
David Jander
