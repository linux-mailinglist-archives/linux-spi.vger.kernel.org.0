Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C034985C80
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfHHIJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 04:09:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36346 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbfHHIJX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 04:09:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id r6so115155113oti.3;
        Thu, 08 Aug 2019 01:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBFSdcaTcFoDPEtsfprZTWviaehhzIBA9CqQY+IL5/Y=;
        b=QWLrJVSTN+oAbY8u6+JjSBfg0cXKMI3XZQ+gDdGFWHhrkwsl9UMHLw+kjxum9wPNqj
         po2aXEKcWt+duY4vHH8tGpwKqF+8JveQabU8DwSDeo+MWwCXygSzgVATvRFx4qQntc2a
         iScU8C3/TVj6s8+ne8ZRW1yE6W13qIiKh2OQjgy6/DM0t7OARwezeV8rIcqscI9NOM2B
         z7B3Y11JYQINiifdtHm0vGhqqlAe8aJSAUMEJ69KkuR25/DsBxqQefrK9sPZtD37zzQW
         mPRGtUyQ8pnvyVC96CT6zdfjUyAUqgjuMkyol2ybfin/SH2OkJn95/VzhG3Q8Gnj+jbF
         /wJw==
X-Gm-Message-State: APjAAAV+vhawgbnciT+KqBPPZgmWGfXfzWZyxQS/h9RCLJPbgH3Bd0qe
        SqISaw6SF3H8g/KZBoxgKNPpCsYQoU7WrveP5FM=
X-Google-Smtp-Source: APXvYqydNbKoEj5yccYRAI19XY287hgtCeiyoefADzGyalRGi0KNiysoeatvbVR35E7SB8lrJ1JjxbckO9DPGCuWlA0=
X-Received: by 2002:a9d:529:: with SMTP id 38mr12094425otw.145.1565251762153;
 Thu, 08 Aug 2019 01:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-42-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-42-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 10:09:10 +0200
Message-ID: <CAMuHMdWBFzNGhzAdEyFEbRE6nOWBKpCQ-5VXZfh3Bg+FMB7NXg@mail.gmail.com>
Subject: Re: [PATCH v6 41/57] spi: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Stephen,

On Tue, Jul 30, 2019 at 8:19 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/spi/atmel-quadspi.c     |  1 -
>  drivers/spi/spi-armada-3700.c   |  1 -
>  drivers/spi/spi-bcm2835.c       |  1 -
>  drivers/spi/spi-bcm2835aux.c    |  1 -
>  drivers/spi/spi-bcm63xx-hsspi.c |  4 +---
>  drivers/spi/spi-bcm63xx.c       |  4 +---
>  drivers/spi/spi-cadence.c       |  1 -
>  drivers/spi/spi-dw-mmio.c       |  4 +---
>  drivers/spi/spi-efm32.c         |  4 +---
>  drivers/spi/spi-ep93xx.c        |  4 +---
>  drivers/spi/spi-fsl-dspi.c      |  1 -
>  drivers/spi/spi-fsl-qspi.c      |  4 +---
>  drivers/spi/spi-geni-qcom.c     |  4 +---
>  drivers/spi/spi-lantiq-ssc.c    | 12 +++---------
>  drivers/spi/spi-mt65xx.c        |  1 -
>  drivers/spi/spi-npcm-pspi.c     |  1 -
>  drivers/spi/spi-nuc900.c        |  1 -
>  drivers/spi/spi-nxp-fspi.c      |  4 +---
>  drivers/spi/spi-pic32-sqi.c     |  1 -
>  drivers/spi/spi-pic32.c         | 12 +++---------
>  drivers/spi/spi-qcom-qspi.c     |  4 +---
>  drivers/spi/spi-s3c24xx.c       |  1 -
>  drivers/spi/spi-sh-msiof.c      |  1 -
>  drivers/spi/spi-sh.c            |  4 +---
>  drivers/spi/spi-sifive.c        |  1 -
>  drivers/spi/spi-slave-mt27xx.c  |  1 -
>  drivers/spi/spi-sprd.c          |  4 +---
>  drivers/spi/spi-stm32-qspi.c    |  5 +----
>  drivers/spi/spi-sun4i.c         |  1 -
>  drivers/spi/spi-sun6i.c         |  1 -
>  drivers/spi/spi-synquacer.c     |  2 --
>  drivers/spi/spi-ti-qspi.c       |  1 -
>  drivers/spi/spi-uniphier.c      |  1 -
>  drivers/spi/spi-xlp.c           |  4 +---
>  drivers/spi/spi-zynq-qspi.c     |  1 -
>  drivers/spi/spi-zynqmp-gqspi.c  |  1 -
>  36 files changed, 19 insertions(+), 80 deletions(-)

Failed to catch
drivers/spi/spi-rspi.c: ret = platform_get_irq_byname(pdev, "rx");
drivers/spi/spi-rspi.c- if (ret < 0) {
drivers/spi/spi-rspi.c:         ret = platform_get_irq_byname(pdev, "mux");
drivers/spi/spi-rspi.c-         if (ret < 0)
drivers/spi/spi-rspi.c:                 ret = platform_get_irq(pdev, 0);
drivers/spi/spi-rspi.c-         if (ret >= 0)
drivers/spi/spi-rspi.c-                 rspi->rx_irq = rspi->tx_irq = ret;
drivers/spi/spi-rspi.c- } else {
drivers/spi/spi-rspi.c-         rspi->rx_irq = ret;
drivers/spi/spi-rspi.c:         ret = platform_get_irq_byname(pdev, "tx");
drivers/spi/spi-rspi.c-         if (ret >= 0)
drivers/spi/spi-rspi.c-                 rspi->tx_irq = ret;
drivers/spi/spi-rspi.c- }
drivers/spi/spi-rspi.c- if (ret < 0) {
drivers/spi/spi-rspi.c:         dev_err(&pdev->dev, "platform_get_irq error\n");
drivers/spi/spi-rspi.c-         goto error2;
drivers/spi/spi-rspi.c- }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
