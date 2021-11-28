Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989FA4607D3
	for <lists+linux-spi@lfdr.de>; Sun, 28 Nov 2021 18:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358488AbhK1RJZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Nov 2021 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358489AbhK1RHY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Nov 2021 12:07:24 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED66C0613F9
        for <linux-spi@vger.kernel.org>; Sun, 28 Nov 2021 09:03:17 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 70so9360029vkx.7
        for <linux-spi@vger.kernel.org>; Sun, 28 Nov 2021 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BY3oht+y8HrGDIiA0mto2rflEOHEoMX+CLpzHXZf2nA=;
        b=isEtZ0KqXs7KwQiyrUe6920AusXIYyZ3lAycqrX8wlYMxZzrktdUryhup02VI1Fc9m
         6RbwZfK5VEwmxi4UjWRmZWbt303aROEHrxkJJaNuODRMse9Ohe1/XfcUA2kKvpqE/UhR
         RbvvxfS7z6qb3X5YjlkfRE/T60Xju+cO7p9YyQj6EXdMEqvWjpSSGjY7+8CraHpfL2aA
         ffanPd/1CCgvM5Qlb7yHtQ4jsRvgFbvogD1YtoQrtwx8TwfczmVqEphgtQg/Mw4op13n
         xhf2K4LG1zddQ8cTqaUD7GGqrYRoeY6Irx5UZc4QfFAbdWaoCrgQ8/GT2dQ3C6PBrKqL
         g4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BY3oht+y8HrGDIiA0mto2rflEOHEoMX+CLpzHXZf2nA=;
        b=keH8u4AWLBAqeYcYhutRCN+HTIFfByTUppMmRt2n9nEgTp4uqTO5K4+i1CrLDVeiVl
         +Q+ns4rZb9cc2DUPWqyCPx3ijaprAx+5HGXFRyyKNpr7UkqrF1nhdF+SodWuvkmcQqq1
         5iM/UlTPnoJTt1MCDfhI2hsY+n05HgSBc4IfHCAZ9oeTPwQzvzKbftPWaJ+Zg6Y5Cebv
         WaKzBM8qBuDasLo2i40SbOR9OtSgCMGaFWwuHi4SNnX6qNvxZ2ODfC2jfe3jzth4fBq0
         vvVYaNgg+jEuYilRtn/OyQJD3NrdvhEEQS6AB6XnVpkEyXHx8eAYfCZbxj16XcwEJNjR
         1oxA==
X-Gm-Message-State: AOAM532g3KIKy75OI7nVHwmntpqokAa41/hv7ARZupvURDYFun3SDESa
        Du6bOXoOQveYneXGy8nDX4PafLcZGh7OmMRz4e0duA==
X-Google-Smtp-Source: ABdhPJzWijuBwUQuP+Vndk1T+sepX2T8/WmWaWQfnWsOR0CMc9FuYs9zuujxjQxRb2Guzz9nNOvUpGArHq0GRwbXUxw=
X-Received: by 2002:a1f:2849:: with SMTP id o70mr25716022vko.35.1638118996213;
 Sun, 28 Nov 2021 09:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20211127223253.19098-1-semen.protsenko@linaro.org>
 <20211127223253.19098-5-semen.protsenko@linaro.org> <YaOR+TbcR1V4ovf/@kroah.com>
 <CAPLW+4mG8AMPCXGWYwURVJhCw0Cv=mYYzNAZf0i7akVcqc384w@mail.gmail.com>
In-Reply-To: <CAPLW+4mG8AMPCXGWYwURVJhCw0Cv=mYYzNAZf0i7akVcqc384w@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 28 Nov 2021 19:03:05 +0200
Message-ID: <CAPLW+4k9OAdcg8XcTbazV_470mFw3x61_UakoR-qNHo5C8et_g@mail.gmail.com>
Subject: Re: [PATCH 4/8] tty: serial: samsung: Remove USI initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Youngmin Nam <youngmin.nam@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, 28 Nov 2021 at 18:26, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Sun, 28 Nov 2021 at 16:28, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Nov 28, 2021 at 12:32:49AM +0200, Sam Protsenko wrote:
> > > USI control is now extracted to dedicated USIv2 driver. Remove USI
> > > related code from serial driver to avoid conflicts and code duplication.
> >
> > What conflicts?
> >
>
> There might be possible conflicts when accessing the same USI register
> from both serial driver and USIv2 driver. Also there will be conflicts
> when trying to access the same I/O address space in those both
> drivers.
>
> > What duplication?  All you did here was delete code.
> >
>
> It's all explained in [PATCH 0/8], but long story short, I've added
> USIv2 driver (in this series) which handles the code that's removed
> from serial driver in this patch.
>

In other words, this code is now present here: [1]. But of course
USIv2 driver must be applied first, and then this patch (removing the
same code from serial driver). That's why it's in the same series and
it's placed after USIv2 driver ([PATCH 3/8]).

[1] https://patchwork.kernel.org/project/linux-samsung-soc/patch/20211127223253.19098-4-semen.protsenko@linaro.org/

> > confused,
> >
> > greg k-h
