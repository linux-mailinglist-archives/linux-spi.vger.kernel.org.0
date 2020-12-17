Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA12DDAE8
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 22:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQVgC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 16:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgLQVgC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 16:36:02 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB57C061794
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:35:22 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id k9so40634vke.4
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Yy0ldVuuJaGFM+MNqEysR2gur5o+i8usb8h9eXll+c=;
        b=Xei5+0LqNNVPaWZyitvbbu6d+/kK5f1HcGXver02BWJSPGI39mi4xcQeLJFO21Zqgx
         UltUc8We5V1TOFXfrEwvrSBnodJVlpOIyeXD3tLhaHl+waXIJyr0SnOR29e1L02oJA7W
         Gg3eJTtUwZzM9UiRzTHoT04HLzYThuDk6+OH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Yy0ldVuuJaGFM+MNqEysR2gur5o+i8usb8h9eXll+c=;
        b=JNdQWbeSP8PTOba0Fht3ul+2pEzNzKmxjQhhoDMoZcBqSYK0rFXzjcj/GnSYsHS3Jn
         YenvK2Aud+bbwCqQot3e7MB88nNR7zB3HygARNdgMirJbfQ40lkSL+69CrejmLt8NePw
         EOqrVydwxTYGu3K0586Buz9D0vO+3I82GIVqrVpVHSDgiNlsDRBA5pjSJqLXX/0jNNmB
         qOyn2Gi5+pMoimNt8zMkG5dM/kg8PnkczcXYsKgBw6OxK3bLg7be+8QOAGxwWF6RMQVx
         OAvWtynOBAKvdGgY3kMxRy0gaT7qs0KYprI4OVNrSSQmPekUYIyBtPTd6dJ/dWeEP0NH
         XMcA==
X-Gm-Message-State: AOAM530dKswMT7WGqMwWmL49xov6fJ0xORPxyApAvi/jCHv5joeV7yz0
        3nbH4DZOqU2iOWcPUh64gl4jsCgnn76T1Q==
X-Google-Smtp-Source: ABdhPJxqwGZPlwtnTIn+mgNu1Fvs4r2H3ofTbxaYBwm+JnnvBt/nOWbznjRzuZ8vzofIhxUb2hebrQ==
X-Received: by 2002:a1f:f44d:: with SMTP id s74mr1583612vkh.14.1608240921262;
        Thu, 17 Dec 2020 13:35:21 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id j136sm978630vke.52.2020.12.17.13.35.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:35:20 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id n18so126754ual.9
        for <linux-spi@vger.kernel.org>; Thu, 17 Dec 2020 13:35:20 -0800 (PST)
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr1120094uad.121.1608240920144;
 Thu, 17 Dec 2020 13:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20201216144114.v2.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid>
 <20201216144114.v2.3.I07afdedcc49655c5d26880f8df9170aac5792378@changeid> <160817939232.1580929.12113046418592056259@swboyd.mtv.corp.google.com>
In-Reply-To: <160817939232.1580929.12113046418592056259@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Dec 2020 13:35:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XBMYpxLMqEDEwnpVGjtL+iUvCCmXWDrdwngMa-BWGM+w@mail.gmail.com>
Message-ID: <CAD=FV=XBMYpxLMqEDEwnpVGjtL+iUvCCmXWDrdwngMa-BWGM+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] spi: spi-geni-qcom: Don't try to set CS if an xfer
 is pending
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, msavaliy@qti.qualcomm.com,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
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

On Wed, Dec 16, 2020 at 8:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > The SPI core in general assumes that setting chip select is a simple
> > operation that doesn't fail.  Yet another reason to just reconfigure
> > the chip select line as GPIOs.
>
> BTW, we could peek at the irq bit for the CS change and ignore the irq
> handler entirely. That would be one way to make sure the cs change went
> through, and would avoid an irq delay/scheduling problem for this simple
> operation. Maybe using the irq path is worse in general here?

Yes, when I was in my SPI optimization phase I actually coded this up
and thought about it.  It can be made to work and is probably
marginally faster at the expense of more cpu cycles to poll the
interrupt line.  I also don't think it fixes this issue nor does it
simplify things...  :(

1. If there are already commands pending we still have to do something
about them.  Said another way: there's not a separate channel just for
setting the chip select, so if the single command channel is gummed up
then using polling mode to handle the chip select won't really un-gum
it up.

2. In order to use polling mode to set the chip select we have to do
_something_ to temporarily disable our interrupt handler.  If we don't
do that then the interrupt handler will fire for the "DONE" when we
send the chip select command.


If we wanted to truly make this driver super robust against ridiculous
interrupt latencies then, presumably, we could handle the SPI timeout
ourselves but before timing out we could check to see if the
interrupts were pending.  Then we could disable our interrupts,
synchronize our interrupt handler, handle the interrupt directly, and
then re-enable interrupts.  If we did this then transfers could
continue to eek their way through even if interrupts were completely
blocked.  IMO, it's not worth it.  I'm satisfied with not crashing and
not getting the state machine too out-of-whack.

-Doug
