Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA72D6D02
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 02:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394461AbgLKBGB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393989AbgLKBFB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 20:05:01 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F4C061794
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:04:21 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id b190so1707590vka.0
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+aiwIBoKANgwGZ9Ev+RnK5mJ+rVZrJ4ukrR2HxoxEM=;
        b=bgXv3fLIp1NUL/oV+/pvj17TNeMUqlU5j7lSuDqg9ENfnlUO6yeaOxDo6ZYS4fRTEW
         GP7V0Pm3BRSsL1gwZEj9uDU/I/z7PNgBabBlS0xi84qSAPtXqg6ZE6YnMDP1y3D6T5A7
         GCp46mZ1vrv7g2Dju/a9ZokPT9xKM7eUEjPnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+aiwIBoKANgwGZ9Ev+RnK5mJ+rVZrJ4ukrR2HxoxEM=;
        b=JDY313tixTyOZEVXg986ksb3u70Xz/75BcDqhjsDa5vxu4FDkCU8GUlm5zvJlqp3wS
         ZJ/iQXMHY4mwPIEMnQUKEdmM2dsdOf3d0AakK70rH4ydfkVSiQFgxinw4PoZHLnl2nmN
         Vx9RU7Xl4DjKr7oZijesakAoubagnh7VnJRajeTIgdO1/gNrAFRtszihIgiz2czB2k/Q
         50+eRszAhTZa56uJxSgW4D7ID9ijNc+kNH7D9NSwoRFXXpoobM3oFWvfDN2hSqL72Y4Y
         ec3ce9m9yrHDaythDX7TgdkgjuU0PGeYEzIUSssIq+c/nehPd0iE4YEChYoGRoL+W5mg
         EOyA==
X-Gm-Message-State: AOAM530PZhhLWyKYxUCFbGPjpuPFc0moM+cChV4F1KaCziXRyvk+e5Cj
        IFi2kSDcQJwsr8Rf1pd7u6++wFATOvgJFQ==
X-Google-Smtp-Source: ABdhPJzP1tRkHEUeDw8x/YxJOF62c+3ixqowQ0Y5BS49f0Id1RwHme8eWjVQ8ZZ8i9T0XRxHS334gg==
X-Received: by 2002:a1f:1c4c:: with SMTP id c73mr11783847vkc.22.1607648659796;
        Thu, 10 Dec 2020 17:04:19 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 127sm783633vse.8.2020.12.10.17.04.18
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 17:04:18 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id j142so1700616vkj.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:04:18 -0800 (PST)
X-Received: by 2002:a1f:3fc9:: with SMTP id m192mr11761317vka.17.1607648658171;
 Thu, 10 Dec 2020 17:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=XKyXnjsM4iS-ydRWBnmYMojPOaYAdYhOkxkPTCQf0RLQ@mail.gmail.com>
 <160757022002.1580929.8656750350166301192@swboyd.mtv.corp.google.com>
 <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
 <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com>
 <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com>
 <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
 <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com> <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com>
In-Reply-To: <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 17:04:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com>
Message-ID: <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 4:51 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-10 15:50:04)
> > Hi,
> >
> > On Thu, Dec 10, 2020 at 3:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Doug Anderson (2020-12-10 15:07:39)
> > > > Hi,
> > > >
> > > > On Thu, Dec 10, 2020 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > right? It will only ensure that other irq handlers have completed, which
> > > > > may be a problem, but not the only one.
> > > > >
> > > > > TL;DR: Peek at the irq status register in the timeout logic and skip it
> > > > > if the irq is pending?
> > > >
> > > > I don't have tons of experience with synchronize_irq(), but the
> > > > function comment seems to indicate that as long as the interrupt is
> > > > pending synchronize_irq() will do what we want even if the CPU that
> > > > should handle the interrupt is in an irqsoff section.  Digging a
> > > > little bit I guess it relies upon the interrupt controller being able
> > > > to read this state, but (hopefully) the GIC can?
> > >
> > > I didn't read synchronize_irq() more than the single line summary. I
> > > thought it would only make sure other irq handlers have finished, which
> > > is beside the point of some long section of code that has disabled irqs
> > > on CPU0 with local_irq_disable(). And further more, presumably the irq
> > > handler could be threaded, and then we could put a sufficiently large
> > > msleep() at the start of geni_spi_isr() and see the same problem?
> >
> > As I understand it synchronize_irq():
> > 1. If the interrupt is not running but is pending at a hardware level,
> > it'll wait.
> > 2. If the interrupt is currently running it waits for it to finish.
> >
> > That should handle all the cases you're talking about including
> > waiting for the threaded IRQ handler.  There's an explicit comment
> > about the threaded IRQ being accounted for in synchronize_irq():
> >
> > https://elixir.bootlin.com/linux/v5.9/source/kernel/irq/manage.c#L134
>
> Ok cool sounds like it would work then. Thanks for reading the code for
> me! :)
>
> >
> >
> > > > If it doesn't work like I think it does, I'd be OK with peeking in the
> > > > IRQ status register, but we shouldn't _skip_ the logic IMO.  As long
> > > > as we believe that an interrupt could happen in the future we
> > > > shouldn't return from handle_fifo_timeout().  It's impossible to
> > > > reason about how future transfers would work if the pending interrupt
> > > > from the previous transfer could fire at any point.
> > >
> > > Right. I just meant skip the timeout handling logic. We'd have to go
> > > back to the timeout and keep waiting until the irq handler can run and
> > > complete the completion variable.
> > >
> > > I forgot that this is half handled in the spi core though. Peeking at
> > > m_irq doesn't look very easy to implement. It certainly seems like this
> > > means the timeout handler is busted and the diagram earlier could
> > > indicate that spi core is driving this logic from
> > > spi_transfer_one_message().
> >
> > My assumption was that it was still OK (even if not perfect) to still
> > process it as a timeout.  I just want to really make sure a future
> > interrupt isn't going to show up.
>
> I'm worried about the buffer disappearing if spi core calls handle_err()
> but the geni_spi_isr() handler runs both an rx and a cancel/abort
> routine. That doesn't seem to be the case though so it looks all fine.

It would be pretty racy if that was the case.  Until it calls
handle_timeout() we're still free to write to that buffer, right?


> > If we want to try to do better, we can do timeout handling ourselves.
> > The SPI core allows for that.
> >
> >
> > > So why don't we check for cur_xfer being NULL in the rx/tx handling
> > > paths too and bail out there? Does the FIFO need to be cleared out in
> > > such a situation that spi core thinks a timeout happened but there's RX
> > > data according to m_irq? Do we need to read it all and throw it away? Or
> > > does the abort/cancel clear out the RX fifo?
> >
> > I don't know for sure, but IMO it's safest to read anything that's in
> > the FIFO.  It's also important to adjust the watermark in the TX case.
> > The suggestions I provided in my original reply (#2 and #3) handle
> > this and are plenty simple.
> >
> > As per my original reply, though, anything we do in the ISR doesn't
> > replace the changes we need to make to handle_fifo_timeout().  It is
> > very important that when handle_fifo_timeout() finishes that no future
> > interrupts for old transfers will fire.
> >
>
> Alright. With a proper diagram in the commit text I think doing all of
> the points, 1 through 3, would be good and required to leave the
> hardware in a sane state for all the scenarios. Why do we need to call
> synchronize_irq() at the start and end of handle_fifo_timeout() though?
> Presumably having it at the start would make sure the long delayed irq
> runs and handles any rx/tx by throwing it away. Sounds great, but having
> it at the end leaves me confused. We want to make sure the cancel really
> went through?  Don't we know that because the completion variable for
> cancel succeeded?

I want it to handle the case where the "abort" command timed out!  :-)
 If the "abort" command timed out then it's still pending and we could
get an interrupt for it at some future point in time.


> I guess I'm not convinced that the hardware is so bad that it cancels
> and aborts the sequencer, raises an irq for that, and then raises an irq
> for the earlier rx/tx that the sequencer canceled out. Is that
> happening? It's called a sequencer because presumably it runs a sequence
> of operations like tx, rx, cs change, cancel, and abort. Hopefully it
> doesn't run them out of order. If they run at the same time it's fine,
> the irq handler will see all of them and throw away reads, etc.

Maybe answered by me explaining that I'm worried about the case where
"abort" times out (and thus the "done" from the abort is still
pending).

NOTE: I will also assert that if we send the "abort" then it seems
like it has a high likelihood of timing out.  Why do I say that?  In
order to even get to sending the "abort", it means:

a) The original transfer timed out

b) The "cancel" timed out.  As you can see, if the "cancel" doesn't
time out we don't even send the "abort"

...so two things timed out, one of which we _just_ sent.  The "abort"
feels like a last ditch effort.  Might as well try it, but things were
in pretty sorry shape to start with by the time we tried it.

-Doug
