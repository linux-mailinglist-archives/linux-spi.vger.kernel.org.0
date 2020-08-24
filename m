Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67824FEBD
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHXNVv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXNVs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 09:21:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8939CC061573
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2020 06:21:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d26so1768198ejr.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2020 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=90su1owIcZp1qZ8W+tbpS5QP1K7qOdgVEZYDn1cZZPI=;
        b=HmZ0L+ZO9rkNEJk5r0Ka6FMGlXEuCReREwZJyU/MzsB9S8jVOUjFNQYMNFTr4abObP
         fVq1khF3ehL0JqKu8fdJVYpL2pp6XNDHNuG3uUUBs0Lfm+yk9/suss49FVzUcBjw/aoI
         gkqBI6IH42fGKgFpGz3vy69QOSjGS+S1H/25Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=90su1owIcZp1qZ8W+tbpS5QP1K7qOdgVEZYDn1cZZPI=;
        b=fW7LNYCPT/UhOkDiEQ9Xlo4fgjcYqp4PmHfOXKm44pTSH/txgZ1nApKV4xFhJPySNp
         rKRwGw93opbXe67O26EqkW6aeYdGD/S6hxd+TW2dIDNaMV20BiCvx5I1FUQ33ZopSxlE
         YGw6hYf4P4LwZoGquPO2HCyDR+krqXmwVe7N85a/2kwHoGHslnXODxxeq9S4J84VE3h5
         XRVJS5RK0+69pe4we24IY64UPIhEQ2d/2t6VlvTd+Wt5XJGUFNOH46A/qmXyT1Uwp5y7
         HScPsnMtXlMbavE9LWpvYu2TpXmQm+6755XAgIVEt8oiwrOqlaDPIMxJ/CjoksbGVlq+
         256Q==
X-Gm-Message-State: AOAM531DKVgmXAManRE2dlNCLkJYXJDtBL7it40kXdM7cEMY3vjZst3A
        YL5gj6dqmBl4W5ntSlSNuKz6hZbWXAVw5g==
X-Google-Smtp-Source: ABdhPJw3cqTNQqESGdVU63bOJ/axrS+gfLCGbMRKHMwBfRRYihh+4RBvDNuLDJN9J7sVFx4WavQcCQ==
X-Received: by 2002:a17:906:5452:: with SMTP id d18mr5726740ejp.163.1598275306853;
        Mon, 24 Aug 2020 06:21:46 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id fx15sm10026200ejb.1.2020.08.24.06.21.45
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 06:21:46 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id b66so5860805wmb.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2020 06:21:45 -0700 (PDT)
X-Received: by 2002:a1c:5581:: with SMTP id j123mr5764243wmb.11.1598275305542;
 Mon, 24 Aug 2020 06:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200824131716eucas1p16a3fde52aa765e7cd6584d4733762047@eucas1p1.samsung.com>
 <20200822124325.GF20423@kozik-lap> <dleftj5z98xjxs.fsf%l.stelmach@samsung.com>
In-Reply-To: <dleftj5z98xjxs.fsf%l.stelmach@samsung.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 24 Aug 2020 15:21:34 +0200
X-Gmail-Original-Message-ID: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
Message-ID: <CAAFQd5ADym6YapCoJ8+fJbPjSestcD_2R8L5T8jAfO4c=GFQkA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] spi: spi-s3c64xx: Ensure cur_speed holds actual
 clock value
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Aug 24, 2020 at 3:17 PM Lukasz Stelmach <l.stelmach@samsung.com> wr=
ote:
>
> It was <2020-08-22 sob 14:43>, when Krzysztof Kozlowski wrote:
> > On Fri, Aug 21, 2020 at 06:13:59PM +0200, =C5=81ukasz Stelmach wrote:
> >> cur_speed is used to calculate transfer timeout and needs to be
> >> set to the actual value of (half) the clock speed for precise
> >> calculations.
> >
> > If you need this only for timeout calculation just divide it in
> > s3c64xx_wait_for_dma().
>
> I divide it here to keep the relationship between the value the variable
> holds and the one that is inside clk_* (See? It's multiplied 3 lines
> above). If you look around every single clk_get_rate() call in the file i=
s
> divided by two.
>
> > Otherwise why only if (cmu) case is updated?
>
> You are righ I will update that too.
>
> However, I wonder if it is even possible that the value read from
> S3C64XX_SPI_CLK_CFG would be different than the one written to it?
>

It is not possible for the register itself, but please see my other
reply, where I explained the integer rounding error which can happen
when calculating the value to write to the register.

> > You are also affecting here not only timeout but
> > s3c64xx_enable_datapath() which is not mentioned in commit log. In othe=
r
> > words, this looks wrong.
>
> Indeed, there is a reference too. I've corrected the message.
>

Thanks!

Best regards,
Tomasz

> >>
> >> Cc: Tomasz Figa <tfiga@chromium.org>
> >> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 02de734b8ab1..89c162efe355 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -626,6 +626,7 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_d=
river_data *sdd)
> >>              ret =3D clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> >>              if (ret)
> >>                      return ret;
> >> +            sdd->cur_speed =3D clk_get_rate(sdd->src_clk) / 2;
> >>      } else {
> >>              /* Configure Clock */
> >>              val =3D readl(regs + S3C64XX_SPI_CLK_CFG);
> >> --
> >> 2.26.2
> >>
> >
> >
>
> --
> =C5=81ukasz Stelmach
> Samsung R&D Institute Poland
> Samsung Electronics
