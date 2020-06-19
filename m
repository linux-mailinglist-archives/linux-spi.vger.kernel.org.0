Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294E11FFF52
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgFSAfL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 20:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgFSAfK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jun 2020 20:35:10 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C76C0613EF
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:35:09 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r5so2100037vso.11
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sL5gZ4vOAKEirPKLzW02auBChHPmDUb8IY2xuO5IvUk=;
        b=YoGoPScH89CrVSf52d0551jmRTDhQPIuxmkDlYUfpuRR+FPM9Wu5+I79mM1TZNt6FB
         ok7O1Yy3TQ+J/i5f4mpkwV43SFeJZQ0adURF9ebgA7sIPuDXBRVdzT1Sf4TRXVgujQDj
         UrmCB+tHNuAI8lySYE/ZXe1IOjrSe7SOEU+Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sL5gZ4vOAKEirPKLzW02auBChHPmDUb8IY2xuO5IvUk=;
        b=U4LSfhaYIXyUK/wN9L0+40GXlvU2FIIRHheGqvo5OE1TzXgJIlxnG7afQwIKSNRZnl
         EFtkOR/pwsyKEudyC5IshDN+sMsJO8e+44fctAe8zRhmZG50vQzRCT3ahA2/CVfPR2DB
         gEu6UDLUwaGVxaxVb9+TCmjyh3ysZlhNVbYcLkWHiXWx0xm1hlWzSl049BXrg2xL/KoM
         1yvjlhSQjX1ALt5rrK02ci8y2ScQANroNed7n1RK3VxAD+XPduSprScxD0rr9qL0iXaE
         Q1oRPDCytcEkCD4v7srxVWXltS7hh69/smkIdJswI7JmWh+LVEupbFC7LzMaQOU3mc5p
         hZsg==
X-Gm-Message-State: AOAM532E2xLDjGphquglm5EcSt8OZAbg2C7/nJ4kAXbI27FHNnuP7xPA
        8PXV70Cex++iuIJI2yB5h9f5GkKqm14=
X-Google-Smtp-Source: ABdhPJwW3C8sEuFEafkC/XudYMbSnE5qxgWdwbrJ1WHGGYRqxp9eO/SKQcrmV1DV6MdE0heb8LTtnQ==
X-Received: by 2002:a67:c381:: with SMTP id s1mr5544270vsj.183.1592526908572;
        Thu, 18 Jun 2020 17:35:08 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id z14sm539297vkd.31.2020.06.18.17.35.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:35:07 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id b10so2625874uaf.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2020 17:35:07 -0700 (PDT)
X-Received: by 2002:a9f:3b1c:: with SMTP id i28mr773392uah.22.1592526906708;
 Thu, 18 Jun 2020 17:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
 <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com>
 <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
 <159251712230.62212.10744179843753723398@swboyd.mtv.corp.google.com>
 <CAD=FV=W1y4Z4T13i410zkb27mUxqn+rQE889=ckEEBhbPuci2w@mail.gmail.com> <159252347502.62212.15886549130634139267@swboyd.mtv.corp.google.com>
In-Reply-To: <159252347502.62212.15886549130634139267@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 17:34:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WC_EaktmUgev_13roVYyTsmHukYO0oJODhjVVryVPpzQ@mail.gmail.com>
Message-ID: <CAD=FV=WC_EaktmUgev_13roVYyTsmHukYO0oJODhjVVryVPpzQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 4:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-06-18 15:00:10)
> > On Thu, Jun 18, 2020 at 2:52 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > -----8<----
> > > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > > index d8f03ffb8594..670f83793aa4 100644
> > > --- a/drivers/spi/spi-geni-qcom.c
> > > +++ b/drivers/spi/spi-geni-qcom.c
> > > @@ -121,6 +121,10 @@ static void handle_fifo_timeout(struct spi_master *spi,
> > >         spin_lock_irq(&mas->lock);
> > >         reinit_completion(&mas->cancel_done);
> > >         writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> > > +       /*
> > > +        * Make sure we don't finalize a spi transfer that timed out but
> > > +        * came in while cancelling.
> > > +        */
> > >         mas->cur_xfer = NULL;
> > >         mas->tx_rem_bytes = mas->rx_rem_bytes = 0;
> > >         geni_se_cancel_m_cmd(se);
> >
> > Sure.  It gets the point across, though
> > spi_finalize_current_transfer() is actually pretty harmless if you
> > call it while cancelling.  It just calls a completion.  I'd rather say
> > something like "If we're here because the SPI controller was calling
> > handle_err() then the transfer is done and we shouldn't hold onto it
> > anymore".
> >
>
> Agreed it's mostly harmless. I thought the concern was that 'cur_xfer'
> may reference a freed piece of memory so it's best to remove ownership
> of the pointer from here so that the irq handler doesn't try to finalize
> a transfer that may no longer exist. "Shouldn't hold onto it anymore"
> doesn't tell us why it shouldn't be held onto, leaving it to the reader
> to figure out why, which isn't good.

Right.  The point is that 'cur_xfer' isn't valid anymore after
handle_err() finishes so we shouldn't hold the pointer.  I'm OK with
your wording and am happy if Mark squashes it when he applies or I can
send out a new version soon.

-Doug
