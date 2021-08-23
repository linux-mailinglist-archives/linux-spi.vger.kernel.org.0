Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042FB3F42CE
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhHWBIn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhHWBIm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:08:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAFC061760
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:08:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so5058701ejb.11
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5y7wVd3UOjVoEbI5ONgdC3uXVDViTEHAaSeTJ0ja4U=;
        b=h0t9/9UfiLyNfrXy6i0QXamegtgkKo10OoklxRz3R26HLZl3qSFetS66GnthOrWnFf
         8PykNkBM5JtaKkf7uWyRaN89t138vt/k5ZFqskLgc2pFLnrMvajgV8sWsKyLI7CVyw5L
         FOtjL9mWdRKC/LfK7HLFayYeNxmQBONc909smYGw0rf7A1TC/wLwEkixK7SVhue9ER5r
         XVkPy8Bm3BSgyC+Ela1I18JEE0ZGtFWcBI0tKH5q7eqCZ1U9D9pnxZ259b4JW2pwBMPD
         xetYuva9J0p3LJ+wLpd7LmG3bj1jYwgCb7iUpo1GhKG/y4d4XZxJJbI1yAX1LnIn1uT9
         dTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5y7wVd3UOjVoEbI5ONgdC3uXVDViTEHAaSeTJ0ja4U=;
        b=c+wWgAbqDoEPam1bzM47HL5d9EpjupdFyEzzj2Y892mWDtDCabfvFsfZBmNjd5ZhpU
         YPT7lhc7XLksBbIqfXKF150pLd99l/21iH72c3U0yiC0F2jub7ld+n/1XSWxMdh9E5mN
         /iJq7Udrs2m1/MopQWx+wlQUR2BW/Evz/uSmkfa1Rn8FDLBY2lb2mwomwbKqOio6OiSv
         Tl/cb66zLrsaiTanJVGajM02RmuNSyOFFdtuMU0arcbeWx1PhDai/d3rgvOJFMc8Heof
         ig+7PQjknq+y6Zhth7IKQbld1bpq75fZ4oOrLC1XDi5UP29Si1crewBQR02rDr0zKpGZ
         5QnQ==
X-Gm-Message-State: AOAM533sS6fQxhG9ZbdpYPjVLktFx4zxGJPWsHHJb3kxlmFM9qX8rJrc
        p/0UXqWjZqL+r8OnfeXrgZ7+sDkUYuRPjqhXJ4dtnA==
X-Google-Smtp-Source: ABdhPJz0StLU+fjdzYTuDDRKxp8saXqBpf1ETE1pQ01x6B/7KvW0AELfBnJQYQyaNAKcNTY+WEiB0NIW5O91SEGzLTA=
X-Received: by 2002:a17:906:2305:: with SMTP id l5mr33404768eja.72.1629680879402;
 Sun, 22 Aug 2021 18:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <605880ad-6c12-bf1d-45f8-ef70181e4eec@canonical.com>
In-Reply-To: <605880ad-6c12-bf1d-45f8-ef70181e4eec@canonical.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:07:48 -0700
Message-ID: <CAK9rFnxhv88Bc9A_ksFUaKgFp7acxnxM7ujR1GrTCPNLLEwHBw@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Krzysztof,

On Fri, Mar 5, 2021 at 3:25 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 04/03/2021 04:41, Brad Larson wrote:
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
[...]
> > +     ret = devm_gpiochip_add_data(&pdev->dev, &p->chip, p);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "unable to add gpio chip\n");
> > +             return ret;
> > +     }
> > +
> > +     dev_info(&pdev->dev, "elba spics registered\n");
>
> Don't print trivial probe results, unless you print here something
> useful. If you need it for debugging, keep it dev_dbg.

Removed that extraneous logging

Regards,
Brad
