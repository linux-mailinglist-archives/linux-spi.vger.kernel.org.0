Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49A0218B18
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jul 2020 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgGHPWU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jul 2020 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgGHPWU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jul 2020 11:22:20 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06BFC061A0B
        for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2020 08:22:19 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b77so892220vsd.8
        for <linux-spi@vger.kernel.org>; Wed, 08 Jul 2020 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KO628LRg0KELEzDGxGBW/eAFQb7hOqQ53yrytEwvgvY=;
        b=hi5oTWy7PCy7YqHRotH3tuH/k2HpctPr7tYVQrxyXCdwfKApDHb6zk8Hv57vOZr7+T
         uPq3gVmSKLp0lfFLbDvVPJM0L70JoAwZ4cie7WIwJNK8QhE26q9c5evYUjyZgyWdScU1
         mb2a+uTp0kfIJg7L3WdoAHaG/3DhMm2oR+B2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KO628LRg0KELEzDGxGBW/eAFQb7hOqQ53yrytEwvgvY=;
        b=lrPTMkZUiUNYa/1iizxuyw6XCWlkWCNt5Ck4b1gND6p4qR4oTHrfQZLQeGPY0WbBKm
         O2bXJbIdT0fCpjq0CT7AP0O6hhc+Y9g+9cDimLRnJxnC8Xszr+CEq6JhNcD0IQAjd0E3
         QKgIqWOc6FBP3Ra0BMJOjQBFYa8VeX3sVI2brklwA3VrRyK/+wdo01EFZ49hUktZOGyn
         zo0StcoiLN4GHI/c1T34rjFnl0nLDLwfLpFnEcq3NtVSIPXbFNV0pWu+Xftxpfvuo/Zv
         EAiUVqv8joU/zDsX/oQjdJH6GnZq+5npvor3+tfU5mLYqM9T1aelF6Qlumib14wJAlEX
         LspA==
X-Gm-Message-State: AOAM531XpMlpQ41swnkBr9vNT7Ycux8zaCbMGydjjPFj+J3vT+z3y0OO
        LSs8n/EVEm9ntxzEeFgtgiZGKRegq5Q=
X-Google-Smtp-Source: ABdhPJy4nGUfN/UdtU3xQeXr8iWX8DXmScbn841bYSKthEOx5N6jaISdKvuXkbPv7An9iiCb9NnOjA==
X-Received: by 2002:a67:d29d:: with SMTP id z29mr37070729vsi.236.1594221738882;
        Wed, 08 Jul 2020 08:22:18 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id v13sm22044uae.7.2020.07.08.08.22.17
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:22:18 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id f11so3957923uao.9
        for <linux-spi@vger.kernel.org>; Wed, 08 Jul 2020 08:22:17 -0700 (PDT)
X-Received: by 2002:ab0:2408:: with SMTP id f8mr34039056uan.91.1594221736757;
 Wed, 08 Jul 2020 08:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
 <20200707120812.GA22129@sirena.org.uk> <CAD=FV=U5RHh_QuZ1tv9V5JtcsrhRONSa_CerYwUFsHhDOhEqdA@mail.gmail.com>
 <20200708100110.GB4655@sirena.org.uk>
In-Reply-To: <20200708100110.GB4655@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 08:22:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
Message-ID: <CAD=FV=UFFN+FQhvs1Cdh7jWBRMzDvfHNiC43M_ZqiVqnWf+Y+g@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        ctheegal@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Wed, Jul 8, 2020 at 3:01 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 05:53:01AM -0700, Doug Anderson wrote:
> > On Tue, Jul 7, 2020 at 5:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > This doesn't apply against current code, please check and resend.
>
> > As mentioned in the cover letter, I posted this series against the
> > Qualcomm tree.  The commit that it is fixing landed there with your
> > Ack so I was hoping this series could land in the Qualcomm tree with
> > your Ack as well.  Would that be OK?
>
> So I didn't see this until after the patch I applied was queued...  it's
> looking like it would be good to have a cross-tree merge with the
> Qualcomm tree if there's stuff like this - is this on a branch which
> makes that practical?  Otherwise I guess...

It's not too bad.  Of the 5 patches I've sent out (3 for geni SPI, 2
for quad SPI) you've landed just one.  Here's the summary:

a) geni SPI 1/3 (Avoid clock setting): Has your Ack.
b) geni SPI 2/3 (autosuspend delay): Landed in SPI tree
c) geni SPI 3/3 (overhead in prepare_message): Has your Ack.

d) quad SPI 1/2 (Avoid clock setting): Needs your Ack.
e) quad SPI 2/2 (autosuspend delay): Needs your Ack.

Since b) has already landed in your tree, let's just leave it there.
There'll be a bit of a performance hit in the Qualcomm tree, but it'll
still be usable.

Since the rest haven't landed, it would be nice to just land them in
the Qualcomm tree.


I think there's still more work to make the Geni SPI driver more
optimized, but I don't think it'll be as urgent as those patches and I
feel like any more major work could wait a cycle.


-Doug
