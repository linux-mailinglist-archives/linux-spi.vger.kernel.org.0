Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBF51DCA8C
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 11:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgEUJ5f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgEUJ5f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 05:57:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B15C061A0E;
        Thu, 21 May 2020 02:57:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w19so2629291ply.11;
        Thu, 21 May 2020 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltjPOCU9A538igJqlQC+KDjFjSNLYyghW5XAjlV0EQI=;
        b=pu4rceYVK6Lihnp83v+yc225cXHJm6lSy6vbEjEHturjUCei0W1hvCJmTDioKSPvJI
         OSBAM7jlX9gl5xaYxJ5HvCF1SQ6mrm9cN3btWB6BgifgTY4sJZt1TBzgThmwMTl47Zdh
         AMcraqWfMI02Jt/vFZjYUIaeaeRd5y/OraiOQVFe5NCH3dYK+8+5M1vTL0GUkbWl9muY
         Elp78zjWwXYcNWzaKdgodX+Zjxf+cnpajpvtR1Uv+eTp8p+73hAqhT0z+8YCeA0MTljf
         wxROOPCKgug260TPkmD7emTonRwFOBSPqNw2PA9kDuOylV+T4qifM+7zCN83rMt8YPpT
         fUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltjPOCU9A538igJqlQC+KDjFjSNLYyghW5XAjlV0EQI=;
        b=cXMcZbGUSxO4/G6sz8D94W9kJBILZP2Mzl7Aptrfdi78/N0F3dFaU0bfvE/uz60EEM
         KA79CIiPtNX1mAb0knZfSjtrwmvo7JbDlWAwGhy2pIweUfKKDNlWgzB0nw45IQFDyq4g
         28EeEh8hixUuHuSbfVA3tNqH7W3VxD3a9mrCCt1kpOUN7n+G34xr2HDnLWN3NFiZmA29
         HYWHETlT+6r1RrIPTjkHL9O2XN1ypRgBAGaxcVqRHffoPouU2e/yPd/pB1MqvOnq79HT
         03eoob7J8PibJjn11I5bzHQCO6q5RAfJVsL4sj0SQTn9u3EQoasF1UQSTwqJH9Vs3R7G
         reQA==
X-Gm-Message-State: AOAM533UJH/5N5DQC1KiGGk8lUCOnt4PZZ5uFV9uE2TiA4QsRBG0FHZn
        kHC6tzskRUF4p0L4vWfdOXuqHmKh3k9O7Ax0a2U=
X-Google-Smtp-Source: ABdhPJx4ebqcn9Ni6XbCgdV990I5/qzjx21xek5LX0qUfdKIo169E5pSe+gPowt99bXNUOjhLG135va1VeEt5wtiZTc=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr10186753pjd.181.1590055053473;
 Thu, 21 May 2020 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200521012206.14472-1-Sergey.Semin@baikalelectronics.ru> <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200521012206.14472-4-Sergey.Semin@baikalelectronics.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 May 2020 12:57:17 +0300
Message-ID: <CAHp75VcOX-hZSxHqro_W2X=KzSShg1V=jAsxdz8L5TZpW0kBYA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] spi: dw: Discard static DW DMA slave structures
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Clement Leger <cleger@kalray.eu>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, May 21, 2020 at 4:23 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Having them declared is redundant since each struct dw_dma_chan has
> the same structure embedded and the structure from the passed dma_chan
> private pointer will be copied there as a result of the next calls
> chain:
> dma_request_channel() -> find_candidate() -> dma_chan_get() ->
> device_alloc_chan_resources() = dwc_alloc_chan_resources() ->
> dw_dma_filter().
> So just remove the static dw_dma_chan structures and use a locally
> declared data instance with dst_id/src_id set to the same values as
> the static copies used to have.

...

> - Explicitly initialize the dw_dma_slave members on stack.

Thanks for an update, but that's not what I asked for...

> -static struct dw_dma_slave mid_dma_tx = { .dst_id = 1 };
> -static struct dw_dma_slave mid_dma_rx = { .src_id = 0 };

>  static int mid_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
>  {
> +       struct dw_dma_slave slave = {
> +               .src_id = 0,
> +               .dst_id = 0
> +       };

(It's member, and not memberS)

> -       struct dw_dma_slave *tx = dws->dma_tx;
> -       struct dw_dma_slave *rx = dws->dma_rx;

May we simple do

struct dw_dma_slave tx = { .dst_id = 1 };
struct dw_dma_slave rx = { .src_id = 0 };

please?

-- 
With Best Regards,
Andy Shevchenko
