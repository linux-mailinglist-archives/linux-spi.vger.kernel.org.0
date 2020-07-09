Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457C321A234
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jul 2020 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGIOfu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jul 2020 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgGIOfu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 10:35:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FEC08C5CE
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 07:35:50 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id c11so482725vkn.11
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2020 07:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWCCqzwkXNQwDDVnRS5QJrwRcFWWrsGrXxrBs0AKBWA=;
        b=j/lq7oiV1czXOm0Xrjg7hTWHdeePe+OVN/IIAHVSKiamx2KDcqCkRHYjp6E0mM/gKU
         suaKSwpDx7MTtFVPDMEYpPQVr4wnjIkYW0k8taTSLmplQVkI+4EnVMTc4Rr1n3YsoZSQ
         JeyQkzbK1Gdlt9tb5cmaMJzwg0Uf5gXVTMrZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWCCqzwkXNQwDDVnRS5QJrwRcFWWrsGrXxrBs0AKBWA=;
        b=hJZwGldEvYhlP/rfj5nQuqJ+Fm2tz8y6r+grh2sGWEj4LRbbvsVa7pxihIwLC5dTvO
         T5ssxzPPe9s7AX1IwgZbIZTGEVkMYyAxnD3Ix2QhNa4hAZiSJqu8w898IazycyCw/tSI
         0GIFEjByAROQIZD/7mg06mVTgfaRlDaEWE60h9M9DIzP1UFdfL/gwzuhvSbSHP66KHod
         1NNNzuTAYdK7eYxAj4To2c2y/07P/mHe1jV50x268hgMG/PjBDZuQJ7AoKylAvAgSUkC
         HyH+8wHwwXQp8EQryLtvQzMNgmGAC35z2yMhQTyc4SPkrT4KaXOsvLU5BxHLC6gOcR9v
         GAYg==
X-Gm-Message-State: AOAM532vHC/1EwQmS/6Vi74lbqHwx6DOAZMOUEDWWPTT4ha879yPMFzZ
        DCrYt8UchBcBOR0crCKfJCfd0brBgdY=
X-Google-Smtp-Source: ABdhPJwwHgFoyGr9NCqZY6bwBE99v8GGnY96dPaXYFgTUx4gB1nLtbGMoO9/86pDydWMD7UeLb8/TA==
X-Received: by 2002:a1f:ab0f:: with SMTP id u15mr44817161vke.99.1594305348950;
        Thu, 09 Jul 2020 07:35:48 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id n13sm326544vsm.19.2020.07.09.07.35.48
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 07:35:48 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id h18so787937uao.6
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2020 07:35:48 -0700 (PDT)
X-Received: by 2002:ab0:186d:: with SMTP id j45mr47636182uag.104.1594305347655;
 Thu, 09 Jul 2020 07:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200708163922.1.I0b701fc23eca911a5bde4ae4fa7f97543d7f960e@changeid>
 <c7956e65-d21b-8844-45d7-de06b8d3d4f0@codeaurora.org>
In-Reply-To: <c7956e65-d21b-8844-45d7-de06b8d3d4f0@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 07:35:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vpw0VeSucRBDdkT5g6N5DrJeecBuDT3fMhhzF8adVpGQ@mail.gmail.com>
Message-ID: <CAD=FV=Vpw0VeSucRBDdkT5g6N5DrJeecBuDT3fMhhzF8adVpGQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Set the clock properly at runtime resume
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>, ctheegal@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 12:30 AM Akash Asthana <akashast@codeaurora.org> wrote:
>
> Hi Doug,
>
> >
> > @@ -670,7 +674,13 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
> >       if (ret)
> >               return ret;
> >
> > -     return geni_se_resources_on(&mas->se);
> > +     ret = geni_se_resources_on(&mas->se);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
> > +
> > +     return 0;
> >   }
>
> Should we fail to resume if error is returned from 'opp_set_rate'?
>
> 'spi_geni_prepare_message' use to fail for any error from
> 'opp_set_rate'  before patch series "Avoid clock setting if not needed".
>
> But now it's possible that 'prepare_message' can return success even
> when opp are not at desired state(from previous resume call).

I can.  I was following the spi_geni_runtime_suspend() example and
just calling it, but I suppose it makes sense that setting the clock
to 0 failing isn't as important as setting it to something non-zero.

I'll post a v2 real quick and keep Acks / Reviews.

-Doug
