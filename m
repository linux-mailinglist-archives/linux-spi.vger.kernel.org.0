Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3083F4301
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhHWBZ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhHWBZ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:25:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFDC06175F
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:24:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x11so33592154ejv.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUskZ43oS2QasNZgCvZtCMR+w3j0gMdgXq4nBNaHbXg=;
        b=UUsf62eVXzoiROSSjLuMCMQNtaVhreUl7DABKyh4VUS/aWovhfBoWGgQAqzdQBxofm
         ELJux0MO9HzMHl6LF7MiVrd79R74XgmFR8FyImHLbAFXLJbWcSpR+ICnmOdsXj3aZTHJ
         E7UVymNGheg7YIVq3uYEKuzwC+5+DKo7p4DF4wZBsGVkbzcPGY6hHDPjGKxFcVejoUQu
         1DiDc9WCUxC+m6IpSfNcluj6hW+aSN7UNGBvAT005hGDUodiK7zNe6MX1/fTFvpqh//b
         5jItnCCfTlsUTE6042M4NeCwvbYuH6jhxoI4RIOYEHeOoGm708JuWJAbVnB/NJ3aZ0gM
         rpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUskZ43oS2QasNZgCvZtCMR+w3j0gMdgXq4nBNaHbXg=;
        b=MlSolSmw0HMjjy7pSJGO+dcd2fVVsWagsJ6cqg6LQdsFrWcfERRP6pOdSbXLr+TGwR
         x8yJXXPXseBFxPuqaSABAAuSx3bx9+hvAMUWdNc0HWMkXHidAszy84dRKgbi59ZI0JAi
         ncIG6SkxOkPm4OPAIOkHip3iNKylbtBOJz3542MbZvDfkdcGcQCWZ1VmS9l6h+5cJ4Eo
         2jW00WUiagzQlEw9YZld2bRbKPovHKz20igp75AMw1y+Ul7Q+FuaNGu3NOfrnhNLeuhP
         C+ObfWunnOL8J6PC1mUqD8/pjsRKcA7OUnxNghU+XJoCqK46FHfWJTL3jrgsJnk8gQI6
         H4GQ==
X-Gm-Message-State: AOAM532M1u55VsFYYgjHSLA4RTpR/dN2CA6dUKRLOktwKQXtPCICT6rR
        Cuq/UFmvf+06haoksBJ1lOyqpITbjDHev8TDxvQj9w==
X-Google-Smtp-Source: ABdhPJyU1yusS44yV0uBsgNQcUHPB5hFFpnrxMyR6e3lo39dJykapAfpaBmCpICTcWi0y75UdplkGoZRIYgXAD2FB3Y=
X-Received: by 2002:a17:906:2f15:: with SMTP id v21mr21142743eji.444.1629681885876;
 Sun, 22 Aug 2021 18:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-2-brad@pensando.io>
 <20210331181041.me5mqqagtml355vk@mobilestation>
In-Reply-To: <20210331181041.me5mqqagtml355vk@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:24:35 -0700
Message-ID: <CAK9rFnxKHmzoZhbc-FK_BML-2rCY64x4REhkdZE+TWYm+VWHFg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpio: Add Elba SoC gpio driver for spi cs control
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
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

Hi Sergey,

On Wed, Mar 31, 2021 at 11:10 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:26PM -0700, Brad Larson wrote:
> > This GPIO driver is for the Pensando Elba SoC which
> > provides control of four chip selects on two SPI busses.
[...]
> > +static int elba_spics_probe(struct platform_device *pdev)
> > +{
> > +     struct elba_spics_priv *p;
> > +     struct resource *res;
> > +     int ret = 0;
> > +
> > +     p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> > +     if (!p)
> > +             return -ENOMEM;
> > +
>
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     p->base = devm_ioremap_resource(&pdev->dev, res);
>
> In accordance with the DTS-node this is just a single register
> 0x307c2468-0x307c24C picked from some bigger block, which most likely
> belongs to something like a system controller. PCIe node has got
> another register from there "0x307c2480-0x307c2484/* MS CFG_WDT */",
> and some BSM device too "0x307c2080-0x307c2084". Please consider using
> syscon instead of directly requesting the resource here.
>
> -Sergey

I've looked into a few syscon based implementations which resulted in
a regressions to include Elba spi probe failure and host machine check
trying to perform PCIe access to Elba SoC.  I like the idea of
refactoring to use syscon but I don't have a functional solution to do
so.

Regards,
Brad
