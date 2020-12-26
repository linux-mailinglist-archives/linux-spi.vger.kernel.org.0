Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD22E2D17
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 05:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgLZEbJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Dec 2020 23:31:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgLZEbJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Dec 2020 23:31:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBB8A221EA;
        Sat, 26 Dec 2020 04:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608957028;
        bh=yEZrPp0aGF7ez5ZHTSqcT1jHjcDWmc9LHJFl2QhW/m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ED8PDvWWZEycbDI3Q7/EelAvO/phAI1BD6oZUxkkscm94zKSVuMjEMv+fH5JCrODo
         S1xFn00fuq6ow68M/swaW0g8N/7GEMLaiI9vxsTqfPmYbWTnRxgvxp+nnLTxVs7kNY
         6sU8Pg+31B1qT4i469BaeEjtG6h0f1MLSQ3ST7zJ4f+JElrs7N+1U7aruNl+n/B9hV
         TdaORLmWWjPneD0mIOhmg4RJGr3f8YF74AKLzMX3tyKZo360vEIVo5eDsc6h/dH72U
         vdqwRIrTl1du4tStZWY6Tnr50ogLmocTS/ID34gOGnIxtLgbtEmn/EikkSj9TUgMz7
         e/9fzCMKqGxww==
Received: by mail-il1-f176.google.com with SMTP id w12so5094716ilm.12;
        Fri, 25 Dec 2020 20:30:28 -0800 (PST)
X-Gm-Message-State: AOAM533jvuwq9nXg+9x+UFDr85WuDBsdGvMXA8hKr4EXwwdc7Ag9m28A
        uhcZE+nr+ZKCg6Wvgl/1JoesHT8QhRCDIh1z1hs=
X-Google-Smtp-Source: ABdhPJyNf6wufayG+upQJkdTWlICkKGuuRFsUZwE2X/sGjkLqzlXZA0gVP2O1CBm2GwizIJKQytxaRIc8oLnhJiMAuM=
X-Received: by 2002:a92:c990:: with SMTP id y16mr35835943iln.35.1608957028288;
 Fri, 25 Dec 2020 20:30:28 -0800 (PST)
MIME-Version: 1.0
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn> <1608892552-15457-4-git-send-email-zhangqing@loongson.cn>
In-Reply-To: <1608892552-15457-4-git-send-email-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 26 Dec 2020 12:30:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4VQNU9SczY5R1RJYaqCqDRx5P1bFJK-G0SkSUmuMgdeQ@mail.gmail.com>
Message-ID: <CAAhV-H4VQNU9SczY5R1RJYaqCqDRx5P1bFJK-G0SkSUmuMgdeQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] MIPS: Loongson: Enable Loongson LS7A SPI in loongson3_defconfig
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Fri, Dec 25, 2020 at 6:41 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> This is now supported, enable for Loongson systems.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v2:
>  - Modify CONFIG_SPI_LOONGSON to CONFIG_SPI_LS7A
>
> v3:
>  - No changes
>
> v4:
>  - No changes
>
> ---
>  arch/mips/configs/loongson3_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
> index 38a817e..28784cb 100644
> --- a/arch/mips/configs/loongson3_defconfig
> +++ b/arch/mips/configs/loongson3_defconfig
> @@ -271,6 +271,9 @@ CONFIG_HW_RANDOM=y
>  CONFIG_RAW_DRIVER=m
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_PIIX4=y
> +CONFIG_SPI=y
> +CONFIG_SPI_MASTER=y
> +CONFIG_SPI_LS7A=y
>  CONFIG_GPIO_LOONGSON=y
>  CONFIG_SENSORS_LM75=m
>  CONFIG_SENSORS_LM93=m
> --
> 2.1.0
>
