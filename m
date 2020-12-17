Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF62DDAF7
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 22:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgLQVqN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 16:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbgLQVqN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 16:46:13 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B42C061794
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:45:32 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id q10so257498vsr.13
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6Qw5qWHGXiBOAFmn045y0oSU+C/RyNs2jifzrZL0yo=;
        b=ZcZ83dyOnkD6dwwKJpvVr6vewC0zVz+2uguxiUfmKIk0n5yHhhSHdF1TdluxPoWHZy
         bjd+Of63HuPQjWdH74tjggwrf1NNVzL6ppVXSWtphIk97Z+Vuivk5/7ew/+FNhOM5hM7
         59YPscDOb6UHVtP2DYBPkINc/2qyZ/pKF9pTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6Qw5qWHGXiBOAFmn045y0oSU+C/RyNs2jifzrZL0yo=;
        b=noH2UiVtkmBGGU1qtWt66y17sQFUVk5LKyJrpwoPVN8zRwn8f2OZ9rtpvBlnVO+QqH
         Wl0o1jSotnK2bnjeS6XNi/6C1M7yx+bbKzfpPKiQW4IgiL+UxNQgqKhdXsiCsbKt6jsH
         fFYad8sMomWJf8MOwgEKVIj2SldWScwy4fYQZfgXSYMALdAFUdfjqGs4qw+M2JVObAix
         pPhoZPOPtg4TzpXSSbWklpI3Ze+i0cZ98I0rJkFAx6zuiZbCJR0TEm3yFcLt7hVpyu6A
         aNfncbvX4amJr10U7LuiOsW1+ERZQioAmqj/4Uz+Dc3sYwtVI8QGf+pLRlMIXKw7annY
         7YoA==
X-Gm-Message-State: AOAM532ChK3Z6kgnbHY+/sFnb5QbtoHbLUZ185XIKLmiIG40/GUHHW1E
        6qbkYh4N/5vNSlkI80ZGUI76rVhXqR9kNQ==
X-Google-Smtp-Source: ABdhPJzeeGHBD4aGjOJvJJhUmiPwu5mBQs6mwfCi4NdXFEtNdEVHCTevwOKz4TGYpFB/5fEoSj0+wA==
X-Received: by 2002:a05:6102:4b6:: with SMTP id r22mr1309033vsa.41.1608241531334;
        Thu, 17 Dec 2020 13:45:31 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id i11sm779742vki.26.2020.12.17.13.45.29
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:45:30 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id x26so294892vsq.1
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:45:29 -0800 (PST)
X-Received: by 2002:a67:32c5:: with SMTP id y188mr1504180vsy.4.1608241529505;
 Thu, 17 Dec 2020 13:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201216144114.v2.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid> <160817888737.1580929.1745000818550256213@swboyd.mtv.corp.google.com>
In-Reply-To: <160817888737.1580929.1745000818550256213@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Dec 2020 13:45:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgGNy2MkYsf5jjL-fcSsqz0vNYsdrpd4hcfG=7tuJcGQ@mail.gmail.com>
Message-ID: <CAD=FV=UgGNy2MkYsf5jjL-fcSsqz0vNYsdrpd4hcfG=7tuJcGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: spi-geni-qcom: Fail new xfers if
 xfer/cancel/abort pending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Dec 16, 2020 at 8:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-12-16 14:41:50)
> > If we got a timeout when trying to send an abort command then it means
> > that we just got 3 timeouts in a row:
> >
> > 1. The original timeout that caused handle_fifo_timeout() to be
> >    called.
> > 2. A one second timeout waiting for the cancel command to finish.
> > 3. A one second timeout waiting for the abort command to finish.
> >
> > SPI is clocked by the controller, so nothing (aside from a hardware
> > fault or a totally broken sequencer) should be causing the actual
> > commands to fail in hardware.  However, even though the hardware
> > itself is not expected to fail (and it'd be hard to predict how we
> > should handle things if it did), it's easy to hit the timeout case by
> > simply blocking our interrupt handler from running for a long period
> > of time.  Obviously the system is in pretty bad shape if a interrupt
> > handler is blocked for > 2 seconds, but there are certainly bugs (even
> > bugs in other unrelated drivers) that can make this happen.
> >
> > Let's make things a bit more robust against this case.  If we fail to
> > abort we'll set a flag and then we'll block all future transfers until
> > we have no more interrupts pending.
>
> Why can't we forcibly roll the ball forward and clear the irq if it's a
> cancel/abort that's pending? Basically tell the hardware that we
> understand it did the job and canceled things out but our sad little CPU
> didn't run that irq handler yet. Here have a cookie and get ready for
> the next transfer.
>
>         if (M_CMD_CANCEL_EN || M_CMD_ABORT_EN) /* but not the other irqs like CMD_DONE or refill fifos */
>                 writel(M_CMD_CANCEL_EN | M_CMD_ABORT_EN, se->base + SE_GENI_M_IRQ_CLEAR);
>
> This would let us limp along and try to send another transfer in the
> case that we timed out but the transfer went through by servicing our
> own interrupt.

A few problems:

1. The cancel and abort are commands and they generate a "done"
interrupt along with their "cancel" and/or "abort".  Clearing the
cancel/abort without the done will leave things in a much more
confused state.

2. If we timed out all the way down then there's probably _also_
interrupts for the previous transfer still pending.  Those would also
need to be cleared.  ...and we'd need to disable watermarks / read
pending data.

3. Even if we tried to solve all that, we're probably still in
terrible shape.  Sure, we could try to start another transfer, but if
the previous one failed because the interrupt handler was blocked then
the next one is just going to fail too so all the extra complexity we
just added to handle this was likely wasted.


The whole fact that you need to send little packets to the sequencer
(and wait for an interrupt to tell you that it got your packet) for
every last thing really doesn't work super well and it's just
especially bad for chip select.


> > +static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
> > +{
> > +       struct geni_se *se = &mas->se;
> > +       u32 m_irq, m_irq_en;
> > +
> > +       if (!mas->abort_failed)
> > +               return false;
> > +
> > +       /*
> > +        * The only known case where a transfer times out and then a cancel
> > +        * times out then an abort times out is if something is blocking our
> > +        * interrupt handler from running.  Avoid starting any new transfers
> > +        * until that sorts itself out.
> > +        */
> > +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
> > +       m_irq_en = readl(se->base + SE_GENI_M_IRQ_EN);
>
> I suppose this could race with the irq handler. Maybe we should grab the
> irq lock around the register reads so we can synchronize with the irq
> handler and save a fail?

I don't _think_ it'll matter a whole lot but it also won't hurt, so sure.

-Doug
