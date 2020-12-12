Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACD12D83DE
	for <lists+linux-spi@lfdr.de>; Sat, 12 Dec 2020 02:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406430AbgLLBc5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405261AbgLLBcn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 20:32:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C87C0613D3
        for <linux-spi@vger.kernel.org>; Fri, 11 Dec 2020 17:32:03 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so8135961pfg.0
        for <linux-spi@vger.kernel.org>; Fri, 11 Dec 2020 17:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=89PR1XJOQ3AXJnqqfEc8vjhhdDtUcMjkmWKDCFEBDfA=;
        b=KziBoxlqrygnMqkQZIsOH1IqWRTRks0E0laPSHjpnzDIsngRIIM4b/UeleALrKa3YJ
         4GKyhns8nOMvfT+0LrReca3YXhaHbbqyo2LOdX7LTMywJWPTkNzg2sgUkdhM0M7sved4
         soStHWAioS20Du7cAwmgPNc8A/femXn/+xkGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=89PR1XJOQ3AXJnqqfEc8vjhhdDtUcMjkmWKDCFEBDfA=;
        b=PMzU45eY6L+mpwDUyrbagmCi9LKxoj4HX+PXJxr6jc0HSIlCbMNX76gTJWq1hUBKQr
         xcS6szPfEvIlsMoTicgwK4fqSS1nIwo1J/Q1Os4l1UdXXozqmWRFoJP54juQtjl+/xNT
         /NG9/kxaq4yz4TzdP8qBG14DnKGGkloFiIqpf1SOhoqkSen0pPfS5SybFEsjLCfG1vrC
         GwLpD/R54AFr0ai4Pz1y4QcTcXWn9MgLQB5BA4BvppGngvvAHPd8hgiizWlRut+2cEqC
         Zz+VbcvlNj8IiYkO/YtDeYV0iMDhRGLNmCnt9PcFPnq9dSyOOSUE50LUIrFkhbQJ56QJ
         KEbQ==
X-Gm-Message-State: AOAM530LYimS3PuQR9Zd0YwRvz8ZS4Rt2sg3UNntu+7z5LmoXbYbidT3
        0oXpvNtZo36/x8x9E3Y9evz+oA==
X-Google-Smtp-Source: ABdhPJwMnvGRsZafrjgyMGtbAW3djZ4NDokRc5FKyg0KgrMLwX3pTXAWpcwmCaUsX1DAFXwRttktEg==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr14318396pgl.322.1607736722938;
        Fri, 11 Dec 2020 17:32:02 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id ci2sm10838684pjb.40.2020.12.11.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 17:32:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WuyuF-PL2PMnLjWCyWGzOqn8beTVP3ZXWvfLdLhPh8=A@mail.gmail.com>
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com> <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com> <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com> <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com> <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com> <160764967649.1580929.3992720095789306793@swboyd.mtv.corp.google.com> <CAD=FV=Xgw+33pCycHyaMPsk64Qs+oh8e-RtJaM1yn0F27qZRVQ@mail.gmail.com> <160765077856.1580929.643282739071441296@swboyd.mtv.corp.google.com> <CAD=FV=WuyuF-PL2PMnLjWCyWGzOqn8beTVP3ZXWvfLdLhPh8=A@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Fix NULL pointer access in geni_spi_isr
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Roja Rani Yarubandi <rojay@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Dec 2020 17:32:00 -0800
Message-ID: <160773672053.1580929.15441111796129112926@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Doug Anderson (2020-12-10 17:51:53)
> Hi,
>=20
> On Thu, Dec 10, 2020 at 5:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Doug Anderson (2020-12-10 17:30:17)
> > > On Thu, Dec 10, 2020 at 5:21 PM Stephen Boyd <swboyd@chromium.org> wr=
ote:
> > > >
> > > > Yeah and so if it comes way later because it timed out then what's =
the
> > > > point of calling synchronize_irq() again? To make the completion
> > > > variable set when it won't be tested again until it is reinitialize=
d?
> > >
> > > Presumably the idea is to try to recover to a somewhat usable state
> > > again?  We're not rebooting the machine so, even though this transfer
> > > failed, we will undoubtedly do another transfer later.  If that
> > > "abort" interrupt comes way later while we're setting up the next
> > > transfer we'll really confuse ourselves.
> >
> > The interrupt handler just sets a completion variable. What does that
> > confuse?
>=20
> The interrupt handler sees a "DONE" interrupt.  If we've made it far
> enough into setting up the next transfer that "cur_xfer" has been set
> then it might do more, no?

I thought it saw a cancel/abort EN bit?

        if (m_irq & M_CMD_CANCEL_EN)
                complete(&mas->cancel_done);
        if (m_irq & M_CMD_ABORT_EN)
                complete(&mas->abort_done)

and only a DONE bit if a transfer happened.

>=20
>=20
> > > I guess you could go the route of adding a synchronize_irq() at the
> > > start of the next transfer, but I'd rather add the overhead in the
> > > exceptional case (the timeout) than the normal case.  In the normal
> > > case we don't need to worry about random IRQs from the past transfer
> > > suddenly showing up.
> > >
> >
> > How does adding synchronize_irq() at the end guarantee that the abort is
> > cleared out of the hardware though? It seems to assume that the abort is
> > pending at the GIC when it could still be running through the hardware
> > and not executed yet. It seems like a synchronize_irq() for that is
> > wishful thinking that the irq is merely pending even though it timed
> > out and possibly never ran. Maybe it's stuck in a write buffer in the
> > CPU?
>=20
> I guess I'm asserting that if a full second passed (because we timed
> out) and after that full second no interrupts are pending then the
> interrupt will never come.  That seems a reasonable assumption to me.
> It seems hard to believe it'd be stuck in a write buffer for a full
> second?
>=20

Ok, so if we don't expect an irq to come in why are we calling
synchronize_irq()? I'm lost.
