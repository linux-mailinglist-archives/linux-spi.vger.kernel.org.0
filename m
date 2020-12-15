Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399ED2DA4F8
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgLOAdC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 19:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgLOAc7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 19:32:59 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF1C061285
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 16:31:46 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id q10so10025409vsr.13
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 16:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84N7cJlOJxclhwtANwUaD4YuRjaGmSvqupKHW5C8pj0=;
        b=Ucp5fnDHKfsVnjZV7TOFjrjsgoIYbj2CMPk1Qca4VuimvSCHF5Orz7pxhw8GPNWohf
         IL5I28lX2htwPqr64wPPoWPsFXYFC86Dck5Z5ZJXrn2MEcyWUjKUMlv5ujmNLlicx9/C
         dVA6VEnPc8xBswGXoyizOS5NQDhLtnIy/9ziI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84N7cJlOJxclhwtANwUaD4YuRjaGmSvqupKHW5C8pj0=;
        b=BOyPFBLyXSyMkbmMpSpfQAW5kt2FWJNi4McsnacqEylHijod8Hm7uBAOHEM9ElRbzG
         kY52umM+fkhWLzIfy2/w1nGG4/AiWJcziuJLxNHT2k5ZHEKOij3WzD1W3LO7L1cEYXhR
         0CwPIExyqdtwyTpMZRhn5T2oIv/KpRKPbdc0B+2HT9YAsvPLCKrOubqohyVZq9A6EfM+
         372V7V8G9NXitFJACidVvFWjFvA9BUbw+p9HA5wRUKdxBG0a0B94aBg2mVwaCBmQ2pWJ
         WCFuxR2/DAB7DpWk4GCccBEhaKKeFSYHQkOWTWe+5uj2XCM+J0GSWifa96pzfxp1VvC3
         /URg==
X-Gm-Message-State: AOAM531WsKtORSFbDcqO6V2XuFyDSk8Nw2qf/7PgY62aoH8GpOzhoYQL
        ZQVBY2q//p12jm86k2X20ZnSKVuOrcJDhw==
X-Google-Smtp-Source: ABdhPJz2NmdnQnIbu8MFw9r+ucp3U/Cz4zcHVA3O2+dhd0pBppN8paGs792+CtntfZ8wp/3E6sicMA==
X-Received: by 2002:a67:80d3:: with SMTP id b202mr27149326vsd.2.1607992305040;
        Mon, 14 Dec 2020 16:31:45 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id q11sm2583826vke.35.2020.12.14.16.31.43
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 16:31:44 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id j140so10042299vsd.4
        for <linux-spi@vger.kernel.org>; Mon, 14 Dec 2020 16:31:43 -0800 (PST)
X-Received: by 2002:a67:32c5:: with SMTP id y188mr24736768vsy.4.1607992303231;
 Mon, 14 Dec 2020 16:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com>
 <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
 <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
 <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com>
 <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com>
 <160764967649.1580929.3992720095789306793@swboyd.mtv.corp.google.com>
 <CAD=FV=Xgw+33pCycHyaMPsk64Qs+oh8e-RtJaM1yn0F27qZRVQ@mail.gmail.com>
 <160765077856.1580929.643282739071441296@swboyd.mtv.corp.google.com>
 <CAD=FV=WuyuF-PL2PMnLjWCyWGzOqn8beTVP3ZXWvfLdLhPh8=A@mail.gmail.com> <160773672053.1580929.15441111796129112926@swboyd.mtv.corp.google.com>
In-Reply-To: <160773672053.1580929.15441111796129112926@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 14 Dec 2020 16:31:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UJStfgAUvKc9iv7Y27OAAxWVdEsCf_HVmpc0eN9y4Gfg@mail.gmail.com>
Message-ID: <CAD=FV=UJStfgAUvKc9iv7Y27OAAxWVdEsCf_HVmpc0eN9y4Gfg@mail.gmail.com>
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

On Fri, Dec 11, 2020 at 5:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-10 17:51:53)
> > Hi,
> >
> > On Thu, Dec 10, 2020 at 5:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Doug Anderson (2020-12-10 17:30:17)
> > > > On Thu, Dec 10, 2020 at 5:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Yeah and so if it comes way later because it timed out then what's the
> > > > > point of calling synchronize_irq() again? To make the completion
> > > > > variable set when it won't be tested again until it is reinitialized?
> > > >
> > > > Presumably the idea is to try to recover to a somewhat usable state
> > > > again?  We're not rebooting the machine so, even though this transfer
> > > > failed, we will undoubtedly do another transfer later.  If that
> > > > "abort" interrupt comes way later while we're setting up the next
> > > > transfer we'll really confuse ourselves.
> > >
> > > The interrupt handler just sets a completion variable. What does that
> > > confuse?
> >
> > The interrupt handler sees a "DONE" interrupt.  If we've made it far
> > enough into setting up the next transfer that "cur_xfer" has been set
> > then it might do more, no?
>
> I thought it saw a cancel/abort EN bit?
>
>         if (m_irq & M_CMD_CANCEL_EN)
>                 complete(&mas->cancel_done);
>         if (m_irq & M_CMD_ABORT_EN)
>                 complete(&mas->abort_done)
>
> and only a DONE bit if a transfer happened.

Ah, true.  The crazy thing is that since we do abort / cancel with
commands we get them together with "done".  That "done" could
potentially confuse the next transfer...  In theory we could ignore
DONE if we see ABORT / CANCEL, but I've now spent a bunch of time on
this and I think the best thing is to just make sure we won't start
the next transfer if any IRQs are pending.  I'll post patches...


> > > > I guess you could go the route of adding a synchronize_irq() at the
> > > > start of the next transfer, but I'd rather add the overhead in the
> > > > exceptional case (the timeout) than the normal case.  In the normal
> > > > case we don't need to worry about random IRQs from the past transfer
> > > > suddenly showing up.
> > > >
> > >
> > > How does adding synchronize_irq() at the end guarantee that the abort is
> > > cleared out of the hardware though? It seems to assume that the abort is
> > > pending at the GIC when it could still be running through the hardware
> > > and not executed yet. It seems like a synchronize_irq() for that is
> > > wishful thinking that the irq is merely pending even though it timed
> > > out and possibly never ran. Maybe it's stuck in a write buffer in the
> > > CPU?
> >
> > I guess I'm asserting that if a full second passed (because we timed
> > out) and after that full second no interrupts are pending then the
> > interrupt will never come.  That seems a reasonable assumption to me.
> > It seems hard to believe it'd be stuck in a write buffer for a full
> > second?
> >
>
> Ok, so if we don't expect an irq to come in why are we calling
> synchronize_irq()? I'm lost.

It turns out that synchronize_irq() doesn't do what I thought it did,
actually.  :(  Despite __synchronize_hardirq() talking about waiting
for "pending" interrupts, it actually passes in "IRQCHIP_STATE_ACTIVE"
and not "IRQCHIP_STATE_PENDING".  So much for that.

...but, if it did, I guess my point (which no longer matters) was:

a) If you wait a second but don't wait for pending interrupts to be
done, interrupts might still come later if the CPU servicing
interrupts was blocked.

b) If you don't wait a second but wait for pending interrupts to be
done, interrupts might still come later because maybe the transaction
wasn't finished first.

c) If you wait a second (enough for the transaction to finish) and
then wait for pending interrupts (to handle ISR being blocked) then
you're good.

---

So I got tired of all this conjecture and decided to write some code.
I reproduced the problem with some test code that let me call
local_irq_disable() for a set amount of time based on sysfs.

In terminal 1:
  while true; do ectool version > /dev/null; done

In terminal 2, disable interrupts on cpu0 for 2000 ms:
  taskset -c 0 echo 2000 > /sys/module/spi_geni_qcom/parameters/doug_test

Of course, I got the timeout and the NULL dereference.


Then I could poke at all the corner cases.  Posting patches for what I
think is the best solution...

-Doug
