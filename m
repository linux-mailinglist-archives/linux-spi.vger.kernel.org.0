Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CE2DB75C
	for <lists+linux-spi@lfdr.de>; Wed, 16 Dec 2020 01:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLPABc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 19:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgLOXfy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 18:35:54 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE2C061793
        for <linux-spi@vger.kernel.org>; Tue, 15 Dec 2020 15:35:14 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id 4so7296563uap.8
        for <linux-spi@vger.kernel.org>; Tue, 15 Dec 2020 15:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dqey8wd0gkfuRIXMklga824WbL5hWeFSQXkjveLUBac=;
        b=R1aMv9ZEjGvHVhBtz2NqTK/wOEYFBsi2Dd8S46ACnbZMKqTt8lXZUI2g4ejf71iS65
         tVtFT/nPqllwo+3eynwV2gPv6zposBQOqupxj+MQq912gBMtddjfHadcFS3glo96rUjF
         BygtJyefUg3NNrkvCT3jnd+VkPXFC49CTY8EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dqey8wd0gkfuRIXMklga824WbL5hWeFSQXkjveLUBac=;
        b=D4MSCjWvI3NuK/IPFwkcQU+jG6rGNhzm/i/Li0/JfDavvXDlt8tHp8ayArt8eFQtBc
         ZkVIH32/x4KHSdjTwszYuhEnXHXg05Af0UHve2i8gh2RUQkbNXx/hKbJJKTi2CIum4pr
         5AcJQ0VFb3B1B16SXWB9qCrAuxxzE/EJd8XI2O5S/Eb9QOlsTUV1kzICYgwqVWUADlGF
         mrhbkjhHENU+FNaHV37K0WqRFKN4q0VwnZBpQSQGw6W6aQI9Fw5yLlWZlQ9tzZUh1a2+
         80AmSJbn6cYoxRX4j3pjb11ygk9XE1BBhtPKy0GCMTVlzjb9+c54UenWpSi+beAd+iRJ
         m29g==
X-Gm-Message-State: AOAM532CNxXp0VaQNsFmN1wT6mL3BfgwVirwoDiENjhkAU8rU62C7lWX
        U3KoE5iyjcLcKfGa+pngDPp0UlKp9Pl+xw==
X-Google-Smtp-Source: ABdhPJxE5Fb/3ev65zCMUwxyeCl5w8Y9fxBxAbt1LDr/PkFRErwAvjGXGt6ezloWVNBz0pY/nbWdyw==
X-Received: by 2002:ab0:2348:: with SMTP id h8mr29521971uao.4.1608075313396;
        Tue, 15 Dec 2020 15:35:13 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id x186sm33231vke.32.2020.12.15.15.35.12
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 15:35:12 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id p7so11953050vsf.8
        for <linux-spi@vger.kernel.org>; Tue, 15 Dec 2020 15:35:12 -0800 (PST)
X-Received: by 2002:a05:6102:21c4:: with SMTP id r4mr31205638vsg.37.1608075311813;
 Tue, 15 Dec 2020 15:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201214162937.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
 <160800104145.1580929.10562113130948868794@swboyd.mtv.corp.google.com>
 <CAD=FV=UT0+BKrUPbATGCbO1fmwwmrKbSy5c+mW-61wS1y6TtJw@mail.gmail.com> <160807113302.1580929.9178584426202538854@swboyd.mtv.corp.google.com>
In-Reply-To: <160807113302.1580929.9178584426202538854@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Dec 2020 15:34:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XSrqzDFHGpW3b_Sx+bA8u8MMGqdfMJnXkKhkWL6H952A@mail.gmail.com>
Message-ID: <CAD=FV=XSrqzDFHGpW3b_Sx+bA8u8MMGqdfMJnXkKhkWL6H952A@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Really ensure the previous xfer
 is done before new one
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Dec 15, 2020 at 2:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-15 09:25:51)
> > On Mon, Dec 14, 2020 at 6:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Douglas Anderson (2020-12-14 16:30:19)
> > > > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > > > index 6f736e94e9f4..5ef2e9f38ac9 100644
> > > > --- a/drivers/spi/spi-geni-qcom.c
> > > > +++ b/drivers/spi/spi-geni-qcom.c
> >
> > > > +       spin_lock_irq(&mas->lock);
> > > > +       m_irq = readl(se->base + SE_GENI_M_IRQ_STATUS);
> > > > +       m_irq_en = readl(se->base + SE_GENI_M_IRQ_EN);
> > > > +       spin_unlock_irq(&mas->lock);
> > > > +
> > > > +       if (m_irq & m_irq_en) {
> > >
> > > Is this really "busy" though? If we canceled something out then maybe
> > > the irq has fired but what if it's to tell us that we have some
> > > available space in the TX fifo? Does that really matter? It seems like
> > > if we have an RX irq when we're starting a transfer that might be bad
> > > too but we could forcibly clear that by acking it here and then setting
> > > the fifo word count that we're expecting for rx?
> > >
> > > Put another way, why isn't this driver looking at the TX and RX fifo
> > > status registers more than in one place?
> >
> > I'm not sure I understand all your concerns.  Can you clarify?  In
> > case it helps, I'll add a few thoughts here:
> >
> > 1. SPI is a controller clocked protocol and this is the driver for the
> > controller.  There is no way to get a RX IRQ unless we initiate it.
> >
> > 2. The code always takes care to make sure that when we're done with a
> > transfer that we disable the TX watermark.  This means we won't get
> > any more interrupts.
> >
> > The only time an interrupt could still be pending when we start a new
> > transfer is:
> >
> > a) If the interrupt handler is still running on another CPU.  In that
> > case it will have the spinlock and won't release it until it clears
> > the interrupts.
> >
> > b) If we had a timeout on the previous transfer and then got timeouts
> > sending the cancel and abort.
> >
> > In general when we're starting a new transfer we assume that we can
> > program the hardware willy-nilly.  If there's some chance something
> > else is happening (or our interrupt could go off) then it breaks that
> > whole model.
>
> Right. I thought this patch was making sure that the hardware wasn't in
> the process of doing something else when we setup the transfer. I'm
> saying that only checking the irq misses the fact that maybe the
> transfer hasn't completed yet or a pending irq hasn't come in yet, but
> the fifo status would tell us that the fifo is transferring something or
> receiving something. If an RX can't happen, then the code should clearly
> show that an RX irq isn't expected, and mask out that bit so it is
> ignored or explicitly check for it and call WARN_ON() if the bit is set.
>
> I'm wondering why we don't check the FIFO status and the irq bits to
> make sure that some previous cancelled operation isn't still pending
> either in the FIFO or as an irq. While this patch will fix the scenario
> where the irq is delayed but pending in the hardware it won't cover the
> case that the hardware itself is wedged, for example because the
> sequencer just decided to stop working entirely.

It also won't catch the case where the SoC decided that all GPIOs are
inverted and starts reporting highs for lows and lows for highs, nor
does it handle the case where the CPU suddenly switches to Big Endian
mode for no reason.  :-P

...by that, I mean I'm not trying to catch the case where the hardware
itself is behaving in a totally unexpected way.  I have seen no
instances where the hardware wedges nor where the sequencer stops
working and until I see them happen I'm not inclined to add code for
them.  Without seeing them actually happen I'm not really sure what
the right way to recover would be.  We've already tried "cancel" and
"abort" and then waited at least 1 second.  If you know of some sort
of magic "unwedge" then we should add it into handle_fifo_timeout().

However, super delayed interrupts due to software not servicing the
interrupt in time is something that really happens, if rarely.  Adding
code to account for that seems worth it and is easy to test...

Did I convince you?  ;-)

-Doug
