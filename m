Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363AA2538A0
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 21:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZT4y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZT4y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 15:56:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70822C061574;
        Wed, 26 Aug 2020 12:56:53 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k25so2812887edj.13;
        Wed, 26 Aug 2020 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tk0FdBRl4yrZP8KpNGRoyatrwcoEEVz5bzGl7M6mn84=;
        b=saLNRmhED3dlhcNReWUFAiieOMjkTrBEzsAb/2uRF4gwjrDeJqB9Xg6FPBr2zQdaug
         TryKkusVjcz+tJ2o46njmZMb4efeTX4A6fqd40/ST8lQU5xVj+CzHOOLEf8TqQj+zFrI
         FUAcSKjdBGoLp/kD/7W8MO6PkM0M1Kwe3FutAYpg5HuC1tVEN+XA63/Ta42bIpwUwpFY
         6KISPdQgBHBKUdx5B7x4KuG+ZANYYBaywAbXKdqawrwKorn6waSYOKmyIvMUy/FBaTu3
         OPW/oqlmnWrYxIZBD8Sb6vE7WgG/oltlFnRGmwhFkXLFgkgP2r8eAJ164CX9Gj/Z7xBI
         8rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tk0FdBRl4yrZP8KpNGRoyatrwcoEEVz5bzGl7M6mn84=;
        b=UoKAkv2sq3hWmzYGOMpdX3GZXcEeuvHWIR3KbHGnYHGu/0Hn6zmI4VWlRcXDypt1j4
         S9qmocQHT3xxnyrNclrQNtE7r1Dw63quaVrXkw8jCfpOnQfKowxJ1na87s/cjbKFEn8U
         AK23rlN1EQGHaCd4R8Lqk1sF23KEnsfTk74hmS08M0secfIcEC5swvzsntpNvChOo1Bu
         54hY6EUgYX5yfvP27b8/fweEZ8E6t4MYkr09zosKGB//qz6Fj1nq810OHExOVQmvbLMJ
         Iv3AeMwdGLB2RXhPOYKP+7Lqcr6/qjed0nU73Jq7JrL9beJKxbAXKxO5zz5fR1W5nbq8
         mcTg==
X-Gm-Message-State: AOAM5330WXo/MDLmdOmzfkNmmAZuhqamPYVreWcgXuf0MQUgIxl2Jv5A
        fhoWrjnGG7SShsH+TY9+EhY=
X-Google-Smtp-Source: ABdhPJzjoMwMKQyvECLPjHomEXVw4I0MeN1eDxKP02jaERKv3xOiex2NsMXPzcHWtpjHpqmv7twIfw==
X-Received: by 2002:aa7:cb0a:: with SMTP id s10mr16788025edt.134.1598471811840;
        Wed, 26 Aug 2020 12:56:51 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id f6sm1725454edy.2.2020.08.26.12.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:56:51 -0700 (PDT)
Date:   Wed, 26 Aug 2020 22:56:49 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        tanveer <tanveer.alam@puresoftware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826195649.g6k574y6ofzbagnm@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200822183342.6sdhp6yq6i7yvdia@skbuf>
 <CAHp75VeNXy1jWNWMuZc0bfXruKc3=0H4ezwpE8jbj6GLYk5QBA@mail.gmail.com>
 <CAHp75VetYbnOHv3LQhq4Gvs1CFe8LnZPzFAVoNmBi5DyAmZ9Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VetYbnOHv3LQhq4Gvs1CFe8LnZPzFAVoNmBi5DyAmZ9Jg@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 10:36:15PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 10:34 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 22, 2020 at 9:37 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > > On Fri, Aug 21, 2020 at 06:40:29PM +0530, kuldip dwivedi wrote:
> >
> > > Just noticed this now.
> > > So for device tree, spi-fsl-dspi supports the following compatibles:
> > >
> > > fsl,vf610-dspi
> > > fsl,ls1021a-v1.0-dspi
> > > fsl,ls1012a-dspi
> > > fsl,ls1028a-dspi
> > > fsl,ls1043a-dspi
> > > fsl,ls1046a-dspi
> > > fsl,ls2080a-dspi
> > > fsl,ls2085a-dspi
> > > fsl,lx2160a-dspi
> > >
> > > Depending on the compatible string, the driver knows whether to use DMA
> > > or XSPI mode, and what the FIFO size is.
>
> FIFO size can be read from the property

My personal preference is for the driver to hold the expert information
about the hardware parameters, and not the device tree. Today you need
to know only about this set of parameters, tomorrow you need something
new, but you also need to work with old DT blobs... It's a mess.

> (or better if you can derive it directly from HW, like DesignWare
> does).

Nope, can't do that. This IP block doesn't even have an ID or revision
register.

> DMA is just defined by FixedDMA resources (your platform with DMA
> provides them, otherwise no such resources).
>

This is a case of knowing that tomatoes are fruit, but being wise enough
to not put them in a fruit salad.

I would not be happy to see this driver make the decision to use DMA
based just on the presence of DMA channels in the firmware blob. On some
platforms, there are DMA channels but due to an erratum they don't work.
While on other platforms, using the DMA channels would simply cause a
performance downgrade.
Same thing about interrupts, in fact. The firmware blob tells the driver
what the interrupt line is, but it doesn't mean that the driver has to
use it.

Thanks,
-Vladimir
