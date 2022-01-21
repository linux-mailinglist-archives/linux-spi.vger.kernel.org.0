Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652E4963E6
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jan 2022 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351662AbiAUR0u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jan 2022 12:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiAUR0u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jan 2022 12:26:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B875CC06173B;
        Fri, 21 Jan 2022 09:26:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z22so43824672edd.12;
        Fri, 21 Jan 2022 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkh0FnEnFTf5DbQ41FfAKMkOcMuij67nGb3VgoTKjSk=;
        b=f6bF985qqlGqPAa7FIkrtKNrVjoO/px5P48r3ozibenZ97y414/fH3d3lcqFWNvKdY
         CaNxtraprvPAXJ5Zkrwo5LAOhOAmtKBhtO0S5jIUa0jx9eHrU+t843jt/bLXjl5j6g7u
         gEXMfWkLeC+0q/1Zds0GFBXLqtzuF21txtQIiuP0MGH4KkKctND7dimWsmlOpHOkJIZK
         qI9twLL2yftwQ7icMcYh39glQ22CJMWhyuyrxYRYprdK9zf1N33DacjePmwn6BHeHa4z
         smPEs4PpSTbHFNaLN2m3hv62Lf0Fdg12VA68u1MI+oprIEsqxG6F1BLBihsOWg76kmQA
         k7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkh0FnEnFTf5DbQ41FfAKMkOcMuij67nGb3VgoTKjSk=;
        b=HO2Bm3Vu80oCQrV+4dacl2V03hy4V0AZ52qTYzQqUe863fCyCTxAOb/pI59XrZioCs
         GkmRCXk/ISt7OsJXGBK+RV1Y3TN8sn5+ZQAUDQVZB2O4sq5gdEQQHuQ56Llf7j8GrX7a
         av/5rSIhYglzmcn5GX9ceLiml+6nKvXPIVgvbKunKS26fUvJorycb5zE0bxxtYS6JMZ9
         1dvQsouv2crT5bq7w/+rdYsPQ9NJlEuqjZjH/DaDkzIbL30aZo6WHjcxTb4AXFh27Nwm
         7o0CYt+q7cnsQc2Iwa3D0VUVmUb451GFIJizf8GLsOzyG6Aslm9A1zlZx8eWMIMAvNOg
         Fl+w==
X-Gm-Message-State: AOAM532HtG9Ea6MTbMmCeQIqLeAr7Sgf/h9kAw2OTlDn3xLnb+ybrl/h
        mI4HPfIZuj7Ttfa1r2e0KUwHX8RfX5H8QHSiY2o=
X-Google-Smtp-Source: ABdhPJyX4jzocmZGtPrYSNz0ftAZTSO+DM6khaWgxyfKIAFqpbAY2mpq3e3V7ZQRGb1Lya6bOmTDjJHk08ok/M1wQsA=
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr5015343edc.29.1642786008280;
 Fri, 21 Jan 2022 09:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220118230915.157797-1-linus.walleij@linaro.org>
 <20220118230915.157797-3-linus.walleij@linaro.org> <CAPLW+4=6A=FLKOum48VNUaGBUUXBa=sMYRn4n1_nTtR8a+0YQA@mail.gmail.com>
In-Reply-To: <CAPLW+4=6A=FLKOum48VNUaGBUUXBa=sMYRn4n1_nTtR8a+0YQA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 19:26:11 +0200
Message-ID: <CAHp75VftUNC6xFVRJqJhTqHwLvehtT+2+M9j_TsnhAyOf039rQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v3] spi: s3c64xx: Convert to use GPIO descriptors
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jan 21, 2022 at 1:52 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> On Wed, 19 Jan 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > Convert the S3C64xx SPI host to use GPIO descriptors.
> >
> > Provide GPIO descriptor tables for the one user with CS
> > 0 and 1.

...

> >         /* Configure feedback delay */
> > -       writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
> > +       if (!cs)
> > +               /* No delay if not defined */
> > +               writel(0, sdd->regs + S3C64XX_SPI_FB_CLK);
> > +       else
> > +               writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
>
> Looks good to me. I'd add {} braces and change "if (!cs)" to "if
> (cs)", but that's hair splitting and not worth v4, it's fine as it is.

If you are going to change code, then why not use positive conditions?

  if (cs)
    ...
  else {
    ...
  }

-- 
With Best Regards,
Andy Shevchenko
