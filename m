Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1846369DA4
	for <lists+linux-spi@lfdr.de>; Sat, 24 Apr 2021 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhDXAJq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 20:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhDXAJp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Apr 2021 20:09:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436EC061574;
        Fri, 23 Apr 2021 17:09:08 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b9so3010278iod.13;
        Fri, 23 Apr 2021 17:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUIgi8gr2tgzWKj4+8JDnT/+2+iJBvHpF1dlGi1xl7U=;
        b=eIVk3kWDGLkxI6e7AjS74LPf7mENaT1FX8HKi8JueWU4UuoHBig3oizGT1ntPq+hbt
         tFqvOi88/997OlaQMY6hKHbHb0cP7bLW4A31KySs7OgfFqPrP7xXw3Tf7xOvwuYRO7tN
         U8wMXMyT/rmbqquvTLIWV2Pge5r3gtI6p3XlGqMcqM2ZOvKqFNIWyPTRNYFA3jw9elb/
         gf/6N2VDaCiDyEDSBJooEq657o73WG9pD3kV8rb3dmsK5x3luSueweF7aDA6t2mKfM4Y
         c79p1OBa/DJdJCA0N+cTn4qi7jZkVZhOoj/bdrMrHAxn6wt7+lo8xhY/GJiJ6EsvOGfp
         TK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUIgi8gr2tgzWKj4+8JDnT/+2+iJBvHpF1dlGi1xl7U=;
        b=sQau/zN0QlC8C2BdF/JuOZGpEEIvZ0x9mS4Nay3jhG+A4JB2OH11Ku85LaUL4FgHIE
         qbJt8vjChaBJjrayxVh3NMiukAL28Y+vm9LvulHVLecju5VyJ/gppd/objVhc/KyKiAO
         +ixyUNhl7THjFy1dhxKZSw1U78iI3PNOEn7cX6ODDXkJKTuYXwa9agI2Wb4+9KAeXSa0
         WhyucSimwYYB/xGQxtJGzkL64Mz8NEvv3T3yMivUvI7/4pndvrYMscd2U6SLoqWLBM8T
         Z1eS7u4REDgYAmInl4Dy1B5N+GwsXpCltQEPCQ0qQTiuJCyFjCRMUWyjTt/bOmMtyH4C
         kLPw==
X-Gm-Message-State: AOAM531R/StOsxOLPF9yj50J5wbDqTh4PPGxxkYRyxc3PkEdy9B7pwNy
        o9QyJWC54jIc3AvzD0UQJYlRNYZvkcRXOfecens=
X-Google-Smtp-Source: ABdhPJzpqEKzOQAznBrk9weKRq/P/QY2iIQeqtxS3bPY6W15AZaVS8+fIA29w7CgKa8lN9Gg4oFBEDPlkNfMCTJh7/8=
X-Received: by 2002:a05:6602:22c9:: with SMTP id e9mr5125249ioe.73.1619222948139;
 Fri, 23 Apr 2021 17:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210423034247.992052-1-art@khadas.com> <20210423114735.GA5507@sirena.org.uk>
In-Reply-To: <20210423114735.GA5507@sirena.org.uk>
From:   Art Nikpal <email2tema@gmail.com>
Date:   Sat, 24 Apr 2021 08:08:57 +0800
Message-ID: <CAKaHn9LC19cduyrwxkDRAdM5pjgSPBCdZUjsEMgGqS7yVQS1-g@mail.gmail.com>
Subject: Re: [PATCH] SPI: meson-spifc add missed calls to remove function
To:     Mark Brown <broonie@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>, nick@khadas.com,
        Gouwa Wang <gouwa@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> I would expect the driver to unregister the controller at the start of
> the remove function, suspend doesn't really make sense here

It's strange - But without spi_master_suspend i have randomly stucks
when i try unload this module - as was written before
i was test it (load/unload module in loop) and for me suspend make sense here

If anybody has another solution - or real problem not here - please
help to find the right way!

PS: i have another way for solve this problem (may be it can help us
fix problem in kernel)

# before unload module need
echo -n spi0.0 > /sys/bus/spi/drivers/spi-nor/unbind
# after unbind driver we can unload module without problem
rmmod spi_meson_spifc # can stuck without unbind driver before ...


On Fri, Apr 23, 2021 at 7:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Apr 23, 2021 at 11:42:47AM +0800, Artem Lapkin wrote:
> > Problem: rmmod meson_gx_mmc - not stable without spi_master_suspend call
> > and we can get stuck when try unload this module
>
> > +++ b/drivers/spi/spi-meson-spifc.c
> > @@ -359,6 +359,7 @@ static int meson_spifc_remove(struct platform_device *pdev)
> >       struct spi_master *master = platform_get_drvdata(pdev);
> >       struct meson_spifc *spifc = spi_master_get_devdata(master);
> >
> > +     spi_master_suspend(master);
> >       pm_runtime_get_sync(&pdev->dev);
> >       clk_disable_unprepare(spifc->clk);
> >       pm_runtime_disable(&pdev->dev);
>
> I would expect the driver to unregister the controller at the start of
> the remove function, suspend doesn't really make sense here.
