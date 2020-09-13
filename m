Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA5267D09
	for <lists+linux-spi@lfdr.de>; Sun, 13 Sep 2020 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIMBMK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 12 Sep 2020 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgIMBMJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Sep 2020 21:12:09 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A11C061757
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 18:12:08 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 7so2671421vsp.6
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaUKvG17QDFsiEMAiiN5tAG3XK9xts1CDUuIgPPVkFs=;
        b=YuUNpl3Ev5lNK/FHlTWko3kIUdAS2yo9gZ2RSb0HXuGs7XMbKulrv9r3668dnQWlso
         9hsec0djgWmeAdb/9vAOVRAbzm8xMGNwXd53E9szIg4t9nb/mWSASnIyXyGMXEVVDMlD
         3PAs2Mz1rmK6JGmbaHefYZG1IGQF3uYf4ht0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaUKvG17QDFsiEMAiiN5tAG3XK9xts1CDUuIgPPVkFs=;
        b=Y/u9j0GxLYHU7xHMuoHcGkXLtF2gIx38k/jOblSIQwA/K2VX8k/9uKD1+Zbk3n4Pq0
         p+0ahQ8P45NwC7GYCxZqdS2ty5NQ7aMLMJBsMP7JBg1AoJwGByg8yBP7F+9tkLEHO+7j
         oSzgQUyh9vsNvdO5FF63ge7H9r1vpRjLT9B5ojgv4mZnW8k0ZginmiQbIJGmLvTOFa50
         EVU2VEG4th1SC9CTMvFFBj5drHaK/fce8VUE/53sw2Ix3fo/ghuj4HpZzioqN58Tg9nb
         u16/wBKpQD+Be+nhnHZWcrot4NT0WbWiCC0Y6zfXDC442EpG0VJwdw4HVpn1R4SLjQ3X
         L9Mw==
X-Gm-Message-State: AOAM530fvTqYLpzgFPoRvsh3sTsgk5bpM/832oDauqzkA1UUKV6mDuCv
        lvlu9SG0tVt371N5XBX8gbL85pZtWe9ZSw==
X-Google-Smtp-Source: ABdhPJz9SNVD2iHlhp1JSfgWrpbPRqpwXbVq9YfJ3keRiC3LcR8SaDTh/l5BC6f6e1DSLaY+Cye6GA==
X-Received: by 2002:a67:7dcb:: with SMTP id y194mr4727000vsc.26.1599959527910;
        Sat, 12 Sep 2020 18:12:07 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 188sm1045926vsr.24.2020.09.12.18.12.07
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 18:12:07 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id a16so7525078vsp.12
        for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2020 18:12:07 -0700 (PDT)
X-Received: by 2002:a67:ff97:: with SMTP id v23mr4715341vsq.11.1599959526518;
 Sat, 12 Sep 2020 18:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200912140730.1.Ie67fa32009b94702d56232c064f1d89065ee8836@changeid>
 <20200912225302.GA3715@yoga>
In-Reply-To: <20200912225302.GA3715@yoga>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 12 Sep 2020 18:11:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VT+7RX=vdy0Ba_AB3dyMKVGu9uwP5bS2eew2W49BdcWA@mail.gmail.com>
Message-ID: <CAD=FV=VT+7RX=vdy0Ba_AB3dyMKVGu9uwP5bS2eew2W49BdcWA@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Use the FIFO even more
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sat, Sep 12, 2020 at 3:53 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 12 Sep 16:07 CDT 2020, Douglas Anderson wrote:
>
> > In commit 902481a78ee4 ("spi: spi-geni-qcom: Actually use our FIFO") I
> > explained that the maximum size we could program the FIFO was
> > "mas->tx_fifo_depth - 3" but that I chose "mas->tx_fifo_depth()"
> > because I was worried about decreased bandwidth.
> >
> > Since that time:
> > * All the interconnect patches have landed, making things run at the
> >   proper speed.
> > * I've done more measurements.
> >
> > This lets me confirm that there's really no downside of using the FIFO
> > more.  Specifically I did "flashrom -p ec -r /tmp/foo.bin" on a
> > Chromebook and averaged over several runs.
>
> Wouldn't there be a downside in the form of setting the watermark that
> close to the full FIFO we have less room for being late handling the
> interrupt? Or is there some mechanism involved that will prevent
> the FIFO from being overrun?

Yeah, I had that worry too, but, as described in 902481a78ee4 ("spi:
spi-geni-qcom: Actually use our FIFO"), it doesn't seem to be a
problem.  From that commit: "We are the SPI master, so it makes sense
that there would be no problems with overruns, the master should just
stop clocking."

-Doug
