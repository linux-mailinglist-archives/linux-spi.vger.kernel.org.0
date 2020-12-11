Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908112D6DC1
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390997AbgLKBxB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Dec 2020 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390970AbgLKBws (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Dec 2020 20:52:48 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D3C0613CF
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:52:07 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id n18so2377128ual.9
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmocuTlFkdrvz3dSgRAckP0PaP8a7z+1zm1gMKMoKF4=;
        b=GcBDxMDo90j9A7h0fSdxICMBTnOcZBbZMW3UYjwASf9i+VeD3cu9Xe7aYOZhu3sa3s
         bZG1aSEw7WRdYQfbPOgVRXZ/h2De7AYllbhGxBEbRfuoObfkPYD+dxwofolcw324jfa0
         8HD2185S9AE4Qme/uWqnEqEbt9sIA39nrHhI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmocuTlFkdrvz3dSgRAckP0PaP8a7z+1zm1gMKMoKF4=;
        b=cg3AcJuUgBhJmWrRsz3EOmuiUcEYWnYQQNwJQ0rmJdN9iYt6ajxxrw3IOixTiDf5ZG
         /6uJr1yU59M1gxG3ahrC1sBTMCkiMENtMmurKd2dB7K5hpHN3XGbWZs7Cn+1H8ODiyd1
         +sVKEsKqCBB13ot91ZzoU2qmu5TM9z7fW9RncIVUmL3GsPSe4alrwwjt03dnIRFigwgD
         1LSnTMmlL+A4enhWA+dTlBnbxtm+kywcIk6hMng9QHsRwyzHytvZo78ZZmGLUETLAhA4
         2+TPuYevTBvBc/Q9RfK5EaUllst/gUWgnJyCf8aQo+mHxPbWS0OKOgsw/wSUqqGoFFW7
         mcPQ==
X-Gm-Message-State: AOAM532zb04oc/mPE+5MP5Nq5+ifUfGvbRzUMnWVlZIi0hvr71+F33VM
        GAyuqmnbUTem16pzs4csnBfjHjli0gRitA==
X-Google-Smtp-Source: ABdhPJz9plPSpkdw+11dPuRIf1nFUFAMOBydOSJSIXdLdSbdnWf4EYONkEFu/Xcgd7Yh+EFGCqlzdA==
X-Received: by 2002:ab0:1c0a:: with SMTP id a10mr11069313uaj.89.1607651526791;
        Thu, 10 Dec 2020 17:52:06 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 2sm752957vso.25.2020.12.10.17.52.06
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 17:52:06 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id j140so3988321vsd.4
        for <linux-spi@vger.kernel.org>; Thu, 10 Dec 2020 17:52:06 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr11018057vsa.34.1607651525656;
 Thu, 10 Dec 2020 17:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20201203074459.13078-1-rojay@codeaurora.org> <CAD=FV=WtU3cnRe6pDKFMA9_0cnQFtSOyohY_bJwZObK+KrbhVQ@mail.gmail.com>
 <160764107797.1580929.14768824290834396298@swboyd.mtv.corp.google.com>
 <CAD=FV=WuQjKC6GHy8d2nuqS-fgsUfxYrJosg3eyC9JU1FPCcjw@mail.gmail.com>
 <160764316821.1580929.18177257779550490986@swboyd.mtv.corp.google.com>
 <CAD=FV=WvG085orLqnvg9WUobL7iyxwgoxh-8RvOaRdi9rLeDUg@mail.gmail.com>
 <160764785500.1580929.4255309510717807485@swboyd.mtv.corp.google.com>
 <CAD=FV=VD78fmSRciFf38AbZG=EFPzDiT_e7QkEC08zA9iL1vTw@mail.gmail.com>
 <160764967649.1580929.3992720095789306793@swboyd.mtv.corp.google.com>
 <CAD=FV=Xgw+33pCycHyaMPsk64Qs+oh8e-RtJaM1yn0F27qZRVQ@mail.gmail.com> <160765077856.1580929.643282739071441296@swboyd.mtv.corp.google.com>
In-Reply-To: <160765077856.1580929.643282739071441296@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 17:51:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WuyuF-PL2PMnLjWCyWGzOqn8beTVP3ZXWvfLdLhPh8=A@mail.gmail.com>
Message-ID: <CAD=FV=WuyuF-PL2PMnLjWCyWGzOqn8beTVP3ZXWvfLdLhPh8=A@mail.gmail.com>
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

On Thu, Dec 10, 2020 at 5:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-12-10 17:30:17)
> > On Thu, Dec 10, 2020 at 5:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Yeah and so if it comes way later because it timed out then what's the
> > > point of calling synchronize_irq() again? To make the completion
> > > variable set when it won't be tested again until it is reinitialized?
> >
> > Presumably the idea is to try to recover to a somewhat usable state
> > again?  We're not rebooting the machine so, even though this transfer
> > failed, we will undoubtedly do another transfer later.  If that
> > "abort" interrupt comes way later while we're setting up the next
> > transfer we'll really confuse ourselves.
>
> The interrupt handler just sets a completion variable. What does that
> confuse?

The interrupt handler sees a "DONE" interrupt.  If we've made it far
enough into setting up the next transfer that "cur_xfer" has been set
then it might do more, no?


> > I guess you could go the route of adding a synchronize_irq() at the
> > start of the next transfer, but I'd rather add the overhead in the
> > exceptional case (the timeout) than the normal case.  In the normal
> > case we don't need to worry about random IRQs from the past transfer
> > suddenly showing up.
> >
>
> How does adding synchronize_irq() at the end guarantee that the abort is
> cleared out of the hardware though? It seems to assume that the abort is
> pending at the GIC when it could still be running through the hardware
> and not executed yet. It seems like a synchronize_irq() for that is
> wishful thinking that the irq is merely pending even though it timed
> out and possibly never ran. Maybe it's stuck in a write buffer in the
> CPU?

I guess I'm asserting that if a full second passed (because we timed
out) and after that full second no interrupts are pending then the
interrupt will never come.  That seems a reasonable assumption to me.
It seems hard to believe it'd be stuck in a write buffer for a full
second?

-Doug
