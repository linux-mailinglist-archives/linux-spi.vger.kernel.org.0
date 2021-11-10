Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660544C552
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhKJQuG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhKJQuF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 11:50:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3A6C061764;
        Wed, 10 Nov 2021 08:47:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v11so13057833edc.9;
        Wed, 10 Nov 2021 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vru0Z1VrDog7j7N8movCWVgL2QBStAjcA++1TbbK3Ws=;
        b=hLAWi3NLFdpddsqhJQnfcBxnVXJxfw8j+qp+qYxdxPpJjgBid5lYb/g45aUKsEYBit
         +cxqJdBf7T7a+QtZ43rLTzo5m34o5DzXXWg1ynBAJk0yWuORMhbir5oRTs5A65qM0izC
         UVaU/1PXPHytbI0mkPN15v1bVNzu924OpM0PhC+pcBi7HWFgnrYEyC1cguwm6p+1a3rZ
         Wo1jzLGGaV+jeg2jVOATYWREYVhsrfKz4P2iO9clkYidAICwH1DVCrOYgFwlL25yOwlZ
         YRkiGb+UCl4D0i7LMdGunIq3kYi/wJBu/iaXTqKR5EMvBsqf//px2EozZuPkWTIwfWsy
         QkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vru0Z1VrDog7j7N8movCWVgL2QBStAjcA++1TbbK3Ws=;
        b=ISEey+FAVxJafZxo2I7BZO+zJ0eCihItpONDBRolR799Vigk9/Y/GR3+Zj4WyKPx5N
         jH9DHZLE3HancjTFRJAWS3bvZfRU/U3mHqNeynUFjO1qW4uZQmUIM1NNU5c4gBC8LCrU
         lReFFOJGS2QZ3m4HSjBemjdOj0kUUUUVhUYb6zbWw5ekAPp00DBtk6bmgXJSdPnG8dAf
         WQw47rLlVcQXSLgvPk0dS0bwSPe6jVfI1Csf3AIuss2WbWiWJLh2LI5i07XPjbpFGj7c
         K9vBQW2bue/dhBngKuAHg+4LYHGFVtzPcHq78hbSewyxjiWd433OYfGHbENn0gvhdBeV
         krew==
X-Gm-Message-State: AOAM531AZM9wGGq2DX5+oT6nJlB32e7FbQm4/Lip4JR41d1REP72m/Zh
        Ntrz5XtjX3arLcY6gPcCRhYn5aiSyYWkUBI8iZg0DYJ+ClA=
X-Google-Smtp-Source: ABdhPJxLf5keCKcm+dAd5nvFtmq/fP7/gtO3OhClVpuYrBJE5blq1MssoJQ7RLvM78SIFB1iXzvAjP/WWLNAxH8DHDU=
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr601056ejc.356.1636562836351;
 Wed, 10 Nov 2021 08:47:16 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com> <YYAzrDuLYQt4U06J@sirena.org.uk>
In-Reply-To: <YYAzrDuLYQt4U06J@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Nov 2021 18:46:31 +0200
Message-ID: <CAHp75Vc8DUyHxhTm2RrdoSmcx9EXjDJvm3FDBRD7Lm4WA5sQ+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     Mark Brown <broonie@kernel.org>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 1, 2021 at 8:37 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Nov 01, 2021 at 02:18:44PM +0800, LH.Kuo wrote:
>
> > Add SPI driver for Sunplus SP7021.
>
> In general it looks like this needs quite a bit of a refresh for
> mainline - a lot of it looks to be a combination of minor, easily
> fixable things and stylistic issues which make things hard to follow but
> I think there are some more substantial things going on here as well.

Just looked at their UART driver submission with the similar idea in mind.
Asked them to shrink the size 1.5-2x times. I believe this is possible
(and yes, I already saw a new version which is better, but can be
cleaned up more).

Folks, try again for all your drivers for this SoC.

-- 
With Best Regards,
Andy Shevchenko
