Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196331EF13C
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jun 2020 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFEGNs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Jun 2020 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGNr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Jun 2020 02:13:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E83C08C5C2;
        Thu,  4 Jun 2020 23:13:47 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so9028418iow.7;
        Thu, 04 Jun 2020 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DliN9cWI9tOr6qCWIwnsIRGllVyzqzKKx/V7aOAhqw=;
        b=kLPvCJogKo7qETqtMQGB6/ogTb+8DdxAWtZblbO2zztSbESn5CXEbgj7hJpt3Zfe2U
         6Y5/4wYylXCZl1jWxmzm05PBz1nqCf/Cets7bwLMU+Tj8nC6KRayOVtBptFeSIhM9xlu
         sRTIDF2li6tA46U5BUrM0SVuR8sN/giHFCZU++WDySP20eo8sXNIkyItC3JP36mJc6/Q
         Mgva1x16M1PUv80ZclYg4DDdSXKDl1J9aKl5vpK8dO85EwTZJ1oGzbGfPlW7xNYibIbQ
         +Pn2mipQp1eKs4hGLMR+KjRoQrAsWP01sdX98PwvHBpeWl/vDQuxKMBKMzx44K7+zI3c
         Uz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DliN9cWI9tOr6qCWIwnsIRGllVyzqzKKx/V7aOAhqw=;
        b=LsyH+SxfPWMmJfHZYj4sjRfYwgvzawu7amZYiEjE4vcMDerTXxoPzsd9jCU67mR1Qh
         vgV/EOohxWOU2bvUgjoPZF2D3hR4PUGMsItXEb2NMPAVEBVakZ5eisChDk5Ze3M9+E3y
         xpu7YNRcZKbYrxgXU65Rr/hyZAmcdYdJIN+iCtN5n/h7F4erkAtI+CO2rRK9VMzc6WNq
         3uP3cP0l2oAp4AQ/h0oXtaku8CFZLJoZtbfxb8Gc23oy8Nn3z1QYB7L8QaPqklKlumRI
         sB1HpbBgh9Xmh3jiN+IjF5dAtkn+1+X4vDhrw2AWlng0wxf9Lovc/feEK/OD56ESjTcZ
         oFQA==
X-Gm-Message-State: AOAM530wLQV/wZpZANuL7cVT67HDjQvLo+3XATC9ec5ChFyXUR8DG3HN
        cclfv80ec7P8XYw7StoA9VZrRQhDBJXfd5Qacfk=
X-Google-Smtp-Source: ABdhPJysOq/A5q91X5YKCecp8SjXtRrccofsFE5ct0IbUqhYeBNgFZgynxG2VEcpMLS2aYeifTFcE74V1QhXiNdB3UA=
X-Received: by 2002:a05:6602:2055:: with SMTP id z21mr7237276iod.60.1591337626749;
 Thu, 04 Jun 2020 23:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200602045506.40574-1-navid.emamdoost@gmail.com> <f928fb02-47d7-b6f9-6198-bd549d6ac6b5@nvidia.com>
In-Reply-To: <f928fb02-47d7-b6f9-6198-bd549d6ac6b5@nvidia.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Fri, 5 Jun 2020 01:13:35 -0500
Message-ID: <CAEkB2EREyXRS18Kq+6428MAJKtB3VoZdVqbJOODVJ7Pk9bzLLQ@mail.gmail.com>
Subject: Re: [PATCH] spi: tegra114: missing put on pm_runtime_get_sync failure
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        mccamant@cs.umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jun 5, 2020 at 1:09 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 02/06/2020 05:55, Navid Emamdoost wrote:
> > the call to pm_runtime_get_sync increments the counter even
> > in case of failure leading to incorrect ref count.
> > Call pm_runtime_put if pm_runtime_get_sync fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/spi/spi-tegra114.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> > index 83edabdb41ad..dccd2ac1a975 100644
> > --- a/drivers/spi/spi-tegra114.c
> > +++ b/drivers/spi/spi-tegra114.c
> > @@ -974,6 +974,7 @@ static int tegra_spi_setup(struct spi_device *spi)
> >               dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
> >               if (cdata)
> >                       tegra_spi_cleanup(spi);
> > +             pm_runtime_put(tspi->dev);
> >               return ret;
> >       }
> >
> > @@ -1398,6 +1399,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
> >       ret = pm_runtime_get_sync(&pdev->dev);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
> > +             pm_runtime_put(&pdev->dev);
> >               goto exit_pm_disable;
> >       }
>
> I am wondering if it is better we use put_sync() here to ensure that
> this happens before we exit the probe.

To be honest I am not sure when to use different flavors of
pm_runtime_put (like pm_runtime_put_noidle,
pm_runtime_put_autosuspend, pm_runtime_put_sync, pm_runtime_put,
pm_runtime_put_sync_suspend). I'd appreciate it if you could give me a
pointer on how to decide on this.

>
> Jon
>
> --
> nvpublic



-- 
Navid.
