Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C618A381
	for <lists+linux-spi@lfdr.de>; Wed, 18 Mar 2020 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRUKk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 16:10:40 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38005 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUKh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 16:10:37 -0400
Received: by mail-vs1-f66.google.com with SMTP id x206so43710vsx.5
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2020 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deicxPfTPIgTvqDWUgB6URC9CH6HcGABwiA2ln5QVsQ=;
        b=VhOm5g8vgPzKXgB1wxBrfDRHebq6hpAgVw1slq3jmk/AEcsv6D3PyCqQGBR12NtWJF
         hnYmbthIJ7zUw2d4PM53OlROlAZ/HPO4l51c0lEpcQyKwwE4kUg2Tx4tFM5W48l0JpjT
         BR68pIYwnvW24eISPw74viaADRr5xnB5UlIl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deicxPfTPIgTvqDWUgB6URC9CH6HcGABwiA2ln5QVsQ=;
        b=t7deczTaPBAg+6JMOS8lbqz6Ga/Kz6fqvDnzSjO7fVPR5SV0VCsXQcYPVH0V9Qfx+/
         AG/sHW4ZY/q3PeXvn5ebzxzG+cYFitOC6WqHuU6B2NvFapcI+xt0nxR8X7KmoeZCrh2R
         yoa/1Z2PUk53frY6ATeoFcBoDKs3rIJRa3sXsZSSWt8oGuaIgLtybv/T0nUi9tuIr92t
         BzUBJy4zHTesuvYU2753xzMUSs3eVCy+YosAMK3M8nWEEvavSV1d8zKSpzJxMk2QYJng
         VKl+/qU/WKiXpgdYoBSTXhkI6H+KKTcW51gnxXYXGJ/CmSk4tdcItbK5fbBBNGPp03IB
         EnEA==
X-Gm-Message-State: ANhLgQ0Xcqg6vKD9f3kvO2u7CT7YS6MvUzNurUM7jrrgw8IFwJmb1DfC
        +mJSLSrZW8RKQ6khPg2tmtyoDr1zYJo=
X-Google-Smtp-Source: ADFU+vuDfABnustSORb0H1oeNC88+tbFHmcS4kNE9T0XFvkkZ0JAYxFrcFLpPd0EGiVH+eXeMbEnPw==
X-Received: by 2002:a67:b85:: with SMTP id 127mr5113608vsl.62.1584562234500;
        Wed, 18 Mar 2020 13:10:34 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id k188sm25868vka.15.2020.03.18.13.10.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 13:10:33 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id y6so9993472ual.2
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2020 13:10:32 -0700 (PDT)
X-Received: by 2002:ab0:2881:: with SMTP id s1mr4346871uap.8.1584562232303;
 Wed, 18 Mar 2020 13:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <158448096503.88485.8894151453752608519@swboyd.mtv.corp.google.com>
 <CAD=FV=U+c4GZU1p3xYT3t=0Q2cLFxoiM=vqc8SsxOKehxbZPXw@mail.gmail.com> <158451865253.88485.11351400745937437114@swboyd.mtv.corp.google.com>
In-Reply-To: <158451865253.88485.11351400745937437114@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Mar 2020 13:10:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WzaOk1S+oXPa5JT9HMC_t19xdpSQmiQdEhtxUTcaDVQg@mail.gmail.com>
Message-ID: <CAD=FV=WzaOk1S+oXPa5JT9HMC_t19xdpSQmiQdEhtxUTcaDVQg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Mar 18, 2020 at 1:04 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > * Most of the cases I saw of the "nobody cared" for geni-spi was on a
> > mostly idle system (presumably still doing periodic SPI transactions
> > to the EC, though).  It seems weird that one of these other interrupts
> > would suddenly fire.  It seems more likely that we just happened to
> > win a race of some sort.
>
> Sure, I'm mostly interested in understanding what that race is. I think
> it is something like cur_mcmd being stale when it's tested in the irq
> handler because the IO access triggers the irq before mas->cur_mcmd can
> be updated due to out of order execution. Nothing stops
> spi_geni_set_cs() from being reordered like this, especially because
> there isn't any sort of barrier besides the compiler barrier of asm
> volatile inside geni_set_setup_m_cmd():
>
>   CPU0 (device write overtakes CPU)  CPU1
>   ----                               ----
>   mas->cur_mcmd = CMD_NONE;
>   geni_se_setup_m_cmd(...)
>                                      geni_spi_isr()
>                                       <tests cur_mcmd and it's still NONE>
>   mas->cur_mcmd = CMD_CS;

This is my assumption about what must have happened, yes.  I have no
proof, though.


> > > > +       /* Check for spurious interrupt */
> > > > +       if (!m_irq) {
> > > > +               ret = IRQ_NONE;
> > > > +               goto exit;
> > >
> > > I ask because it could be simplified by reading the status and then
> > > immediately returning IRQ_NONE if no bits are set without having to do
> > > the lock/unlock dance. And does writing 0 to the irq clear register do
> > > anything?
> >
> > Sure.  I'll move it if you want.  It felt nicer to just keep the whole
> > thing under lock so I didn't have to think about whether it mattered.
> > ...and anyone else looking at it didn't need to think about if it
> > mattered, too.  It it is very easy to say that it doesn't _hurt_ to
> > have it under lock other than having one extra memory read under lock.
> > ...and presumably the case where the optimization matters is
> > incredibly rare (a spurious interrupt) and we just spent a whole lot
> > of cycles calling the interrupt handler to begin with for this
> > spurious interrupt.
> >
> > I would have a hard time believing that a write of 0 to a "write 1 to
> > clear" register would have any impact.  It would be a pretty bad
> > hardware design...
>
> This is a writel to a device so it may take some time for the memory
> barrier to drain any other writes with the full memory barrier in there.
> Not sure if we care about getting super high performance here but that's
> a concern.

Right, but I guess the spurious interrupt case wasn't one I'm
optimizing for.  ...and if it's a real problem we should figure out
how to avoid so many spurious interrupts.  Presumably all the overhead
that the Linux kernel did to call our interrupt handler in the first
place is much more serious.


> > So I guess in summary, I'm not planning to spin for any of these
> > things unless you really insist or you say I'm wrong about something
> > above or someone else says my opinions are the wrong opinions.
> >
>
> Why do we need such large locking areas?

We probably don't, but it's unlikely to matter at all and the large
locking areas mean we don't have to spend time thinking about it.
It's super clear that the locking is safe.


In general there shouldn't be tons of downside to have large locking
areas because there shouldn't be contention for this lock.  As you
said, much of this is synchronized at higher levels, so mostly we're
just worried about synchronizing with our interrupt handler and one
would hope the interrupt handler wasn't firing at times we don't
expect.

...but I guess there is the downside that local interrupts are fully
disabled for this whole large locking area and that does feel like
something that might be worth optimizing for...


In theory we _could_ just have a lock around updating 'cur_mcmd' and
kicking off the transfer.  That would make sure that 'cur_mcmd' was
definitely updated by the time the interrupt fired.  It feels at least
a little awkward to me, though, because there is more shared state
between the interrupt handler and the functions kicking off the
transfers and we're really just using the lock as a poor man's memory
barrier, but maybe it's OK.  I can give a shot at this approach if it
feels viable to you.


> Why can't we remove the enum
> software tracking stuff and look at mas->cur_xfer to figure out if a cs
> change is happening or not? I suppose mas->cur_xfer could be stale, so
> we need to make sure that is modified and checked under a lock, and then
> mas->rx_rem_bytes/tx_rem_bytes also need to be under a lock because
> they're modified inside and outside the irq handler, but otherwise I
> don't see any need to hold the lock over the register reads/writes. Most
> other things are synchronized with the completions or in higher layers
> of the SPI core.

In general it's a big-ish change to code that's largely already tested
and that (IMO) it makes readability slightly worse.  It can be worth
it to make big changes for big gain, but I don't see it here.  It
might have a slight performance boost, but seems like premature
optimization since there's no evidence that the existing performance
(even after my big locking patch) is a problem.

If we want to go forward with your suggestion, I'd have to spend more
time thinking about the cancel/abort cases, especially, which I'm not
sure how to test super well.  Specifically does cancel/abort cause the
"done" bit to be set?  If so your new code will finalize the current
transfer, but the old code didn't.  I have no idea if this matters.
You also removed the spinlock from handle_fifo_timeout() and I don't
know if (for instance) it was important to clear the TX watermark
register after firing off the abort command but before the interrupt
handler could run.  It also doesn't necessarily appear that
reinit_completion() has any safety, so is there some chance that the
interrupt could fire and we'd still have the re-init pending on our
side, then clear "done" back to zero after the interrupt handler
completed us?

...one extra thing to think about with all this is that (I think)
handle_fifo_timeout() will be called if someone kicks off a SPI
transfer and then hits "Ctrl-C" partway.  In this case
spi_transfer_wait() will return -EINTR and I think that will change
the chip select and then call "handle_err".  I have no idea if that
works well today, but I have a feeling it will be harder to get right
without an extra state variable.


> I do wonder if we need to hold the lock again when we update the rx/tx
> remaining bytes counter but I can't convince myself that the irq can run
> on another CPU in parallel with the CPU that ran the irq first. That
> seems impossible given that the interrupt would have to come again and
> the irq controller would need to send it to a different CPU at the same
> time. We should only need to grab the lock to make sure that cur_xfer
> and remaining bytes is published by the CPU triggering the rx/tx
> transfers and then assume the irq handler code is synchronous with
> itself.

At least needs a comment?

...but even with a comment, what exactly are you gaining here by
making me and all future readers of the code think about this?  One of
your main goals here is to eliminate the need to have the spin lock
locked for the whole of the IRQ handler, right?  If we're in the
interrupt handler, local interrupts are already off, right?  That
means that the only thing you can gain (in terms of speed) by
decreasing the number of lines "under lock" is that you could allow
someone else trying to get the same lock to run sooner.  As you've
pointed out, there's already a lot of synchronization at higher
layers, and many of the arguments you make are assuming that the other
code isn't running anyway.

So this overall seems like trying to shorten the amount of time that
the lock is held just for the sheer principle of having spin locks
held for the fewest lines of code, but not for any real gain?

To get into micro-optimizations, too, I will also say that having fine
grained locking in the interrupt handler also will lead to more than
one call to spin_lock() per IRQ.  I put traces in and I often saw "rx"
and "cmd_done" fall together and both separately lock in your code.
In general isn't reducing the number of calls to spin_lock() (which I
think has some overhead) more important?


> -       if ((m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN)) {
> -               mas->cur_mcmd = CMD_NONE;
> +       /* Wake up spi_geni_set_cs() or handle_fifo_timeout() */
> +       if (cs_change || (m_irq & M_CMD_CANCEL_EN) || (m_irq & M_CMD_ABORT_EN))
>                 complete(&mas->xfer_done);
> -       }
>
>         writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
> -       spin_unlock_irqrestore(&mas->lock, flags);
> +

It doesn't feel legit to release the spinlock before this writel().
Once you complete(), can't (in theory) another transfer kick off on
another CPU, and then cause an interrupt to fire?  You'd be clearing
someone else's interrupt, perhaps?  Maybe this actually happens in
handle_fifo_timeout() which (after your patch) waits for the
completion and then immediate (with no locking) fires off an abort.

As an aisde and unrelated to your change, I never like it when
interrupt handler clear their IRQ bits at the end anyway because it
always feels like a race.  The only time you clear at the end is if
you have "latched level" interrupts (interrupts that are latched but
will continually re-assert unless the thing that caused them goes
away).  I have no idea of these bits are "latched level", but it feels
unlikely.


NOTE: I didn't do a complete review of your patch because (I think) I
already found a few issues and am still not convinced it's a good use
of time to fully re-architect the control flow of this driver.  If you
still think this is something we need to do, I will try to make time
to work through all the corner cases in my head and try my best to
make sure there are no weird memory-ordering issues, but I can't
promise I won't miss anything.


-Doug
