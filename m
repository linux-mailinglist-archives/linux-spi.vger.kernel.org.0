Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDA2531C7
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHZOrv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHZOrt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 10:47:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65968C061574;
        Wed, 26 Aug 2020 07:47:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id b17so3228060ejq.8;
        Wed, 26 Aug 2020 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gA95twJyGCGidmH1niP2vdCAAjYvkpgYs4wEF2NGATY=;
        b=Z2y5K7efMpF7tmK3bUpt6feUulzmgSsFzPAPF0r2WDRoZnCTKMNU7QryO6xuShgnt8
         5sf7kS4gh0U1cBX3/uZeRnFkzc2JEy9afQhkRcs/v6MNT8NcE1KUDcCdZtBMivkpSpZk
         hu7Ggh5B/7KbZwO3wh3lb2pr06DkzAkls+2wZ7GxRSmJT8qCDOUkd1s8XEAH7RPswcRt
         2r2XWBZIhaj3l46sHXE90dOnIaWQjd6ZC1gYIAGjInobEevrork02xAwRJkgFOH2zj6M
         NJ30vYkadJCl6ZC5Zncaxo7ztj9DMqv4Eo6MsQmIl9gZQakrHbGRPDkBjMW4ClZP7TU+
         j2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gA95twJyGCGidmH1niP2vdCAAjYvkpgYs4wEF2NGATY=;
        b=a9fFVszVeijwqigarjyeMjg1KTd9DE0x3uLMkAonM7qJzkRV6ZMs7lLYCWKIb1lODJ
         KVbzNwLX/tTyhvddNxtTSEwBRQ1wdUzl9gW62cBm36GPNudkxgLzKRbRws6n+fL1E7Yk
         LLSR7Wv6cvSNMtNi1DBFUsv0dpi1pQH2egCRcj7vtbSQPF/olzudq5zAPQPJi90/xCCC
         VJpVttaKY3dzNRzFpQm6BoMD8Hkvz3KLNlAatnM/XFhLsXy6MMVlHGByN079LJNuGXUr
         IzHaRQdswGeh7GkjYlu0tk0PHeEKNIyyhMlyFuWaPj496yZvb2sgLI1B5e8vjVyfw5Ao
         X1yw==
X-Gm-Message-State: AOAM530AAjua4JJslql/Ww3YdTQ/zfDC1sUjKAHuKwk7X/rJM9feC272
        qtV9vDY/qr+Rp0YdZco5TVo=
X-Google-Smtp-Source: ABdhPJz2Gge8V/sDgzA3RQ/e2QCMvmbkrTDQhySrf9sn9w9hL/n17mw0A1r2LK8afopoBwla+NmwNQ==
X-Received: by 2002:a17:906:300b:: with SMTP id 11mr15700312ejz.270.1598453267062;
        Wed, 26 Aug 2020 07:47:47 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id u24sm2180389edq.23.2020.08.26.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:47:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:47:44 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
Message-ID: <20200826144744.c4yzgoovk6f4t3id@skbuf>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk>
 <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf>
 <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf>
 <20200826142312.GH4965@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826142312.GH4965@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:
> 
> > - The compatible string plays an integral part in the functionality of
> >   the spi-fsl-dspi driver. I want to see a solution for ACPI where the
> >   driver knows on which SoC it's running on. Otherwise it doesn't know
> >   what are the silicon parameters of the DSPI module (XSPI present or
> >   not, DMA present or not, FIFO depth). I don't see that now. I just see
> >   something hardcoded for:
> >   { "NXP0005", .driver_data = (kernel_ulong_t)&devtype_data[LS2085A], }
> 
> Based on some other stuff I've seen with ACPI on NXP stuff it looks like
> they're following the same scheme but only caring about that one SoC for
> the time being.

So, no argument about caring only about ACPI on one particular SoC for
the time being, but there's a big difference between a solution that
works for N=1 and one that works for N=2...

Showing my ignorance here, but is there something equivalent to
of_machine_is_compatible() for ACPI?

Thanks,
-Vladimir
