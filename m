Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D35253322
	for <lists+linux-spi@lfdr.de>; Wed, 26 Aug 2020 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHZPNZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Aug 2020 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgHZPNZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Aug 2020 11:13:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84201C061756
        for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2020 08:13:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b2so2060650edw.5
        for <linux-spi@vger.kernel.org>; Wed, 26 Aug 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=oKNHl4Ny4sbuCKjpuRdgyZBkTgWLx5UkA3LoZG6V0lk=;
        b=FB+t+sVO1/ukFnYVyxTChBvyLa9GO6obbOPr9SKpuFup/4ZpcKuf8oUyzovXq85LJn
         PMr7eKU64znflOOOZMHs2rxL+u2r1ECZGrY573Am4BkapgOukgtfFVpIZptIJrI+NAWS
         LqneKqDYE0pj1LYEzHA/rPRFTXnq7pwFEjbz0rsfdDmfJzAHl+jnB6Mwaxgt/DofJG1V
         P7Hq2FrCoCtMvck+9N13aUemZGluAFC1Za44VxUz/z9+EETIFI4CwhFucg+6kfR2ZgE1
         O7E5gwAk8ZEeIZai2ngoCB9yHMfkP7Y4ixQ1VzauUwQIDiwH6MV3WENW37VfyVjIGisx
         6A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=oKNHl4Ny4sbuCKjpuRdgyZBkTgWLx5UkA3LoZG6V0lk=;
        b=uiTklgxIAj6KC7hZpiLrOMzvhpraTYKXVlZe3sFcFFu5IHWaM3GdsBaqEXlTybTKCu
         cZoX/6xnkr00tPPxifPYDhUMg5hAq19btM/kh3wZjwl3yBdqA0pUkykFSZdwqZ+NjtcV
         2nzzQ5T8ASEH4NkOnHZW4bXAGG+KL5xsCMtmQOiwh/MOngyVWM6/flUkIQRmLs2ewYHe
         skHbNfsK7Bo/98Uz5QTge4+5qwsTtp5q0NJ06kp1Y4A31gvnP8gNhArFUeWE1woGt7GX
         YTCw/pVSvkWCfAB6SYCXZZnkLiD2LgkTsU2+o4daXActGF54T+uyM0Gg/jdNIFBb/+WT
         MeKA==
X-Gm-Message-State: AOAM532cBdYH6iry/TinWtqtYI1BEeqZ5ybyKtEDUC84H6p3li4e9xRL
        LxDvsiQl34D4HkIvODYyEQWO/FmppwlU7NkehcaUrA==
X-Google-Smtp-Source: ABdhPJzsRVGSLe4lpmQnlT3HvkKy/20pNcOp7WTKLjOO89AFrfG0IzVA4X1dUrgiUuwohWHrh+PafH6GPl/mKHJR8rI=
X-Received: by 2002:a05:6402:1d17:: with SMTP id dg23mr15482591edb.198.1598454802941;
 Wed, 26 Aug 2020 08:13:22 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200821131029.11440-1-kuldip.dwivedi@puresoftware.com>
 <20200821140718.GH4870@sirena.org.uk> <c810740d75f64e308fd362e6c6a5f437@mail.gmail.com>
 <20200822152118.rlwbcgfk4abjldtg@skbuf> <VE1PR04MB6768699B6D7A507A5BF82F9191540@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <20200826114758.4agph53ag2fin6um@skbuf> <20200826142312.GH4965@sirena.org.uk> <20200826144744.c4yzgoovk6f4t3id@skbuf>
In-Reply-To: <20200826144744.c4yzgoovk6f4t3id@skbuf>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF7/ycK6cTpjLXBKD+ruXNZEs6GEAE4wSq+AcJdu4sBqH1NLAEjPgFbAgU/99oCtsCFlAIqZ5/wqZoKVKA=
Date:   Wed, 26 Aug 2020 20:43:20 +0530
Message-ID: <2e19f8979be4f962045a1597bdbe7886@mail.gmail.com>
Subject: RE: [PATCH] spi: spi-fsl-dspi: Add ACPI support
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Tanveer Alam <tanveer.alam@puresoftware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, August 26, 2020 8:18 PM
> To: Mark Brown <broonie@kernel.org>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>; kuldip dwivedi
> <kuldip.dwivedi@puresoftware.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pankaj Bansal <pankaj.bansal@nxp.com>; Varun
Sethi
> <V.Sethi@nxp.com>; Tanveer Alam <tanveer.alam@puresoftware.com>
> Subject: Re: [PATCH] spi: spi-fsl-dspi: Add ACPI support
>
> On Wed, Aug 26, 2020 at 03:23:12PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2020 at 02:47:58PM +0300, Vladimir Oltean wrote:
> >
> > > - The compatible string plays an integral part in the functionality
of
> > >   the spi-fsl-dspi driver. I want to see a solution for ACPI where
the
> > >   driver knows on which SoC it's running on. Otherwise it doesn't
know
> > >   what are the silicon parameters of the DSPI module (XSPI present
or
> > >   not, DMA present or not, FIFO depth). I don't see that now. I just
see
> > >   something hardcoded for:
> > >   { "NXP0005", .driver_data =
> > > (kernel_ulong_t)&devtype_data[LS2085A], }
> >
> > Based on some other stuff I've seen with ACPI on NXP stuff it looks
> > like they're following the same scheme but only caring about that one
> > SoC for the time being.
>
> So, no argument about caring only about ACPI on one particular SoC for
the time
> being, but there's a big difference between a solution that works for
N=1 and one
> that works for N=2...
>
> Showing my ignorance here, but is there something equivalent to
> of_machine_is_compatible() for ACPI?
Just a query, Can't we use meaningful HID for different SoC just like
compatible strings in DT ?
In this way Silicon parameters can also be added in fsl_dspi_devtype_data
structure , which is
already exist in driver
>
> Thanks,
> -Vladimir
