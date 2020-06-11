Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B612C1F6338
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFKIDL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 11 Jun 2020 04:03:11 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44665 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFKIDK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Jun 2020 04:03:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id x202so4631425oix.11;
        Thu, 11 Jun 2020 01:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YzlTP+1rh4pdZnlbxkCTui5HSd7UbfOODY7F+gh8TyU=;
        b=sTsvgP/QSFCjhmBJh5seO74EmzZw8DBZBbIk0kH5AJl0YP4UG04n5iZkNnOLQ1tQfn
         KEPp99oAouxRqfGfLwRkiHq4b8r6/+AT8jG+NpOH0UkXJ1HOcaaOeNqdIWyTtU6wJBvs
         BDujEslg6V1gFnA27tu6vBljxZeEYy+gbxh2CVm66GjvAeCXAhzk1fSQoHVtQ4Vi33d+
         UpIIQLS3okhZQ9wUt/Z06LZ3ZnoRKaGkC4zR28QnuHSR+LblgheB3oq5dUSjHm6LYyDw
         bVgdWkB5jkliVD8vCvlUNqCFmzKktCODCxbmPOSPVi80CCepLHGq5dzjaa9JCAzr6xsB
         xRJA==
X-Gm-Message-State: AOAM531SvAPE8SsjFK6NDhthRd6LpdUx1J2Dxvj3dfWmHlDgorKCtNuj
        Opu+UorSrYwJmIayjj3EIWWD4a75G+Nb5t9VpAOv7XPs
X-Google-Smtp-Source: ABdhPJyjAqbfbqEJ7psjr4uCLMpEdxBepeCDGPUf/OFAsYBjP0TSlk6QeRu25IhSV+a9ZrOuDjV9REGAxVjFXE8xTsA=
X-Received: by 2002:aca:1a19:: with SMTP id a25mr5441574oia.54.1591862589818;
 Thu, 11 Jun 2020 01:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <1591846947-14252-1-git-send-email-zhangqing@loongson.cn> <1591846947-14252-2-git-send-email-zhangqing@loongson.cn>
In-Reply-To: <1591846947-14252-2-git-send-email-zhangqing@loongson.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Jun 2020 10:02:58 +0200
Message-ID: <CAMuHMdW9RDbBV+MVG52229xhpaWyO_hxXJv_to=SqbDHjxz3VA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: tools: Fix build errors
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Qing,

Thanks for your patch!

On Thu, Jun 11, 2020 at 5:43 AM Qing Zhang <zhangqing@loongson.cn> wrote:
> Fix the following build errors:
>
> include/linux/spi 2>&1 || true
> ln -sf /home/zhangqing/spi.git2/tools/spi/../../include/uapi/linux/spi/spidev.h include/linux/spi/spidev.h
> make -f /home/zhangqing/spi.git2/tools/build/Makefile.build dir=. obj=spidev_test
> make[1]: Entering directory '/home/zhangqing/spi.git2/tools/spi'
>   CC       spidev_test.o
> spidev_test.c: In function ‘transfer’:
> spidev_test.c:131:13: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
>   if (mode & SPI_TX_OCTAL)
>              ^
> spidev_test.c:131:13: note: each undeclared identifier is reported only once for each function it appears in
> spidev_test.c:137:13: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
>   if (mode & SPI_RX_OCTAL)
>              ^
> spidev_test.c: In function ‘parse_opts’:
> spidev_test.c:290:12: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function)
>     mode |= SPI_TX_OCTAL;
>             ^
> spidev_test.c:308:12: error: ‘SPI_RX_OCTAL’ undeclared (first use in this function)
>     mode |= SPI_RX_OCTAL;
>             ^
>   LD       spidev_test-in.o
> ld: cannot find spidev_test.o: No such file or directory
> /home/zhangqing/spi.git2/tools/build/Makefile.build:144: recipe for target 'spidev_test-in.o' failed
> make[1]: *** [spidev_test-in.o] Error 1
> make[1]: Leaving directory '/home/zhangqing/spi.git2/tools/spi'
> Makefile:39: recipe for target 'spidev_test-in.o' failed
> make: *** [spidev_test-in.o] Error 2
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>

Oops, somehow I forgot I had made a similar change on the target
when adding Octal mode support to spidev_test.c.
Sorry for that.

Fixes: 896fa735084e4a91 ("spi: spidev_test: Add support for Octal mode
data transfers")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/uapi/linux/spi/spidev.h
> +++ b/include/uapi/linux/spi/spidev.h
> @@ -48,6 +48,8 @@
>  #define SPI_TX_QUAD            0x200
>  #define SPI_RX_DUAL            0x400
>  #define SPI_RX_QUAD            0x800
> +#define        SPI_TX_OCTAL            0x2000
> +#define        SPI_RX_OCTAL            0x4000

Probably we should add SPI_CS_WORD and SPI_3WIRE_HIZ, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
