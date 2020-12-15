Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C442DB67E
	for <lists+linux-spi@lfdr.de>; Tue, 15 Dec 2020 23:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbgLOW0a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Dec 2020 17:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbgLOW0Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Dec 2020 17:26:16 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616AC061793
        for <linux-spi@vger.kernel.org>; Tue, 15 Dec 2020 14:25:36 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so411652pjg.1
        for <linux-spi@vger.kernel.org>; Tue, 15 Dec 2020 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=/86Jqc1BgYHQDnZ6vO1e8U/Ca0srAJPo0ZYNhrJXl/w=;
        b=UBUoPhJX5lWdIx3rqXSUL5lFvtLa6+MOIn0Iaywfg+42WHqlFOv0L/EnL8Y4lUzG2S
         3I1xZgVMxo0LpIiyfFH8zfk4c9BYukSerG5LuzV7cWYUcXmucdmoHZiCuNhmwOZkst0M
         N7/deOdxvJaER7ytfHLwZawVSBXvtVo3PTgEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=/86Jqc1BgYHQDnZ6vO1e8U/Ca0srAJPo0ZYNhrJXl/w=;
        b=fFbCs9UVhmFbsxzd+Xn3Zn6XxpQfN9aPRbBZlDXXC9e5PNg0vQZGTYEeK5+vS6XgEy
         42SMu6Sxn4CHMhomVaI4D2xDD4ASJnuwuFrN8eCNF6q+hIabuczbobc3M7dvTkr06vGG
         vMsKqBvATLnMafTnuOKfdxz97Uq6eBwKghO2U4YIxpFYlodsKzRbnO0b1lLmn2THvM+Z
         KPal13tSLZrk7RbQhjucpXMmzL42ZzrnmZZSpCaKxW4XNaxEV3UiSurZDZExyaoG00hz
         8bTGhpVZph8ftNyS+yKT00Gz3lJdThoUl/i6LH+gvWwe0IDa45VrBG1DalZVuMNwwChH
         Gp3g==
X-Gm-Message-State: AOAM532D8d7FQMee8101BRNKlOzk9pYL/XnVYfRMpf+NhFZD4aDwObw5
        lQCDZVjLBvvNAoOEJEcwXjmhXA==
X-Google-Smtp-Source: ABdhPJwq/nFRgmYBUjkEH96kZykB/NSUGea90KA+Tcs8UnXz3iYJ1sucvSVsHG76YI+CxRBpUd3QxA==
X-Received: by 2002:a17:902:8a8a:b029:db:e003:4044 with SMTP id p10-20020a1709028a8ab02900dbe0034044mr25097423plo.19.1608071135407;
        Tue, 15 Dec 2020 14:25:35 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id n5sm139554pgm.29.2020.12.15.14.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 14:25:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=UT0+BKrUPbATGCbO1fmwwmrKbSy5c+mW-61wS1y6TtJw@mail.gmail.com>
References: <20201214162937.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201214162937.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid> <160800104145.1580929.10562113130948868794@swboyd.mtv.corp.google.com> <CAD=FV=UT0+BKrUPbATGCbO1fmwwmrKbSy5c+mW-61wS1y6TtJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: spi-geni-qcom: Really ensure the previous xfer is done before new one
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Dec 2020 14:25:33 -0800
Message-ID: <160807113302.1580929.9178584426202538854@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-15 09:25:51)
> On Mon, Dec 14, 2020 at 6:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2020-12-14 16:30:19)
> > > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > > index 6f736e94e9f4..5ef2e9f38ac9 100644
> > > --- a/drivers/spi/spi-geni-qcom.c
> > > +++ b/drivers/spi/spi-geni-qcom.c
>=20
> > > +       spin_lock_irq(&mas->lock);
> > > +       m_irq =3D readl(se->base + SE_GENI_M_IRQ_STATUS);
> > > +       m_irq_en =3D readl(se->base + SE_GENI_M_IRQ_EN);
> > > +       spin_unlock_irq(&mas->lock);
> > > +
> > > +       if (m_irq & m_irq_en) {
> >
> > Is this really "busy" though? If we canceled something out then maybe
> > the irq has fired but what if it's to tell us that we have some
> > available space in the TX fifo? Does that really matter? It seems like
> > if we have an RX irq when we're starting a transfer that might be bad
> > too but we could forcibly clear that by acking it here and then setting
> > the fifo word count that we're expecting for rx?
> >
> > Put another way, why isn't this driver looking at the TX and RX fifo
> > status registers more than in one place?
>=20
> I'm not sure I understand all your concerns.  Can you clarify?  In
> case it helps, I'll add a few thoughts here:
>=20
> 1. SPI is a controller clocked protocol and this is the driver for the
> controller.  There is no way to get a RX IRQ unless we initiate it.
>=20
> 2. The code always takes care to make sure that when we're done with a
> transfer that we disable the TX watermark.  This means we won't get
> any more interrupts.
>=20
> The only time an interrupt could still be pending when we start a new
> transfer is:
>=20
> a) If the interrupt handler is still running on another CPU.  In that
> case it will have the spinlock and won't release it until it clears
> the interrupts.
>=20
> b) If we had a timeout on the previous transfer and then got timeouts
> sending the cancel and abort.
>=20
> In general when we're starting a new transfer we assume that we can
> program the hardware willy-nilly.  If there's some chance something
> else is happening (or our interrupt could go off) then it breaks that
> whole model.

Right. I thought this patch was making sure that the hardware wasn't in
the process of doing something else when we setup the transfer. I'm
saying that only checking the irq misses the fact that maybe the
transfer hasn't completed yet or a pending irq hasn't come in yet, but
the fifo status would tell us that the fifo is transferring something or
receiving something. If an RX can't happen, then the code should clearly
show that an RX irq isn't expected, and mask out that bit so it is
ignored or explicitly check for it and call WARN_ON() if the bit is set.

I'm wondering why we don't check the FIFO status and the irq bits to
make sure that some previous cancelled operation isn't still pending
either in the FIFO or as an irq. While this patch will fix the scenario
where the irq is delayed but pending in the hardware it won't cover the
case that the hardware itself is wedged, for example because the
sequencer just decided to stop working entirely.
