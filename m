Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C6492A47
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jan 2022 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiARQIp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 11:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbiARQIW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 11:08:22 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43512C06176D
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 08:08:15 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id y11-20020a0568302a0b00b0059a54d66106so7620695otu.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEXlFWe/RRxSBawapRn9SDXx9+/QLY02dhjgwIQqPyM=;
        b=iQFGf5IOoRW7z7O5Gn10aLK3jkjcFhIBlN2bJPhOgZ+rXrcW3DQWw39VBj12wBQy+r
         bzrKzMosk7DN9UDljbad1JW7aC+LW0uO39Td7dydEVEm9OYafnvWtFVtmF/U73yNfaOI
         DTYD2meRHvyT3fyz/Yx91ByNwWmuiev8ETpwagQKKVXAOi/O3H/YabzjSUxLaX6xD/VQ
         hmSWz/pnPvTJJiiSwDA4iUkvdf8XsYl2DG/Dxj+ha6Ip9a+9F6LwTTSTHxtnPxS6ACwc
         1MVX/8Q9OYQpj/AKwumngKdrGrCgYf0fuTcJLo1HTllAQKDAJ4iPYDhhXowZuiaM9FWF
         gJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEXlFWe/RRxSBawapRn9SDXx9+/QLY02dhjgwIQqPyM=;
        b=zNFFVKiveQpjh9AWu+CTmyg4Xo3pwiOhfHR4aJoUHkcK7BUINLICtxMILCLYYwBr5S
         zkQPeqcndi+C5RXM85ZvadjNIfBaxIwwafPE/dxLLlzUSkMHjUnXXtAR4MYJfMkitFSf
         ISuOgEM3oQt+ub//t6bmfAG9A7plncepqVDthaQBcuEjscBOpRnj+T1er2yynqNifend
         pe5JwMz7CiJhaPR1VelIe/ysA5CrH4j1APiH+wOSB5P9hd4UdP1wAoB32d7DAZldrUXn
         Mg/PRUQvgXoatIxQ/r0QFdtB+YN5m4p+Fd+ghhN6+mYD4+oc7wt8B0r6MT87odkZyhsL
         QgSw==
X-Gm-Message-State: AOAM533Ho9Eu78SBOO7RwVDVctgxpnhGaOYKTD4ZU91l3SB6WBS6jk7Q
        avrCUibpkh82NEC6l4PJ1Ewb69S4KAKZjPluFkQdyw==
X-Google-Smtp-Source: ABdhPJw8GHcOEwEgXiJD4Ev84MPeeZxU0LFHDrAesZxnYaGJYwkd9eLiPxv9sEzfXEOPQwgLnB+/PWrQeUdHaHQYwEc=
X-Received: by 2002:a9d:465:: with SMTP id 92mr20889618otc.35.1642522094495;
 Tue, 18 Jan 2022 08:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20220118110928.120640-1-linus.walleij@linaro.org>
 <20220118110928.120640-3-linus.walleij@linaro.org> <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
In-Reply-To: <CAPLW+4kNbC2BNcC54evJL_9tYoY_S3hcski81KHUPughs3f0ag@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jan 2022 17:08:02 +0100
Message-ID: <CACRpkdaL3RFU-cJNW2e40RiHGP06BfunnmU73FK_6U=Syvx_Wg@mail.gmail.com>
Subject: Re: [PATCH 3/3 v2] spi: s3c64xx: Convert to use GPIO descriptors
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jan 18, 2022 at 4:27 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:

> > +       if (!cs)
> > +               return 0;
>
> Shouldn't some error code be returned in that case? Or is it normal case?

No, because it just means the platform didn't define any fb_delay.

> >         /* Configure feedback delay */
> >         writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);

But maybe I should always write 0 into this then.

> > - * This is per SPI-Slave Chipselect information.
> > + * This is per SPI-Slave FB delay information.
>
> Not sure if this change is needed: this comments will be incorrect if
> some new fields are added in future. For example, downstream trees
> like [1] have more fields there, not only feedback delay one.

OK I fix

> Other than minor comments above:
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> Btw, this SPI driver is used in Exynos850 SoC, which I'm working on
> right now. It's the shame I didn't enable it yet on my board, so I
> can't test the code. But I'm happy to see it's being modernized, kudos
> for doing that!

Yeah I saw it being used in the Tesla SoC and also Exynos850 so as
I now know this is not going away any time soon we might as well just
fix it up.

Yours,
Linus Walleij
