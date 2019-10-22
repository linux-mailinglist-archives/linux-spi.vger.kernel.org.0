Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA139DFF74
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbfJVIck (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 04:32:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbfJVIck (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 04:32:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so10187897pfb.7
        for <linux-spi@vger.kernel.org>; Tue, 22 Oct 2019 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZdKvxj9Z8mPzGBO8PqqxkjEAPdgCzeXSdguPbyi3Og=;
        b=C4WER7itN+32dDA/eOYziidUp/8t8hZ1k9flcdFpUqdKezCFeEjR8iRyegBn5OLVRz
         NSqyVPngBTqzIPx3tnE2/Ucz/RmLWlZ6ha8hYy17Wv9mNxZk9+YsQsFhpbH1V2zo+bPE
         lT/nn1p70NJHjxYDSs1kU/dtoC3WsGWGoQSKyeZ4yR9fPswBLTxiEZIFy7VGo99eJfsR
         Rnb66yIOe34lLUzJRt7aDB/waUtrz4XpUNqhuQoo8FgWhMONGBte3ZGYdjR5Ss/ofBJI
         gmMTZbsROgjQ1ullrB19+08w7rM7TRSlnbOzyH7FMlMUKWNONvsED65puK6JETZiSCCn
         Zkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZdKvxj9Z8mPzGBO8PqqxkjEAPdgCzeXSdguPbyi3Og=;
        b=qAG8fpwy2QZ/QHEyc75EqqnTCjybM0/JfErB7R2z6IMg5TRtTi+kIMCQJtOfzq6zEp
         RPMwBd3cyO0ttCaK7R0e7HZnfEE5y3ag1dFjUpicjgaaaaXfsbVRjS0iS+/oZXod77t1
         Vgp+fciX9LJjOD0JpUDW32mPnj5EEM6+Nes7ihA96uqrj5gizgTClYVMMZYRShrXvjgz
         J6ZvpH8sXI9oKdHtjkk6mo5n7d/6IXt2mYmSdt/Y0In5I23tM+ZPYOaDcgbe7U9RZ7bG
         vnPXihVQYtnyXmznHxap+pa5T0vp7Bj5796B01ZwY5lb07/PPXqYFPXVpKt9COokGpw7
         shgA==
X-Gm-Message-State: APjAAAUh0QzEgbUP3D+iMZHTeZwzNy9Y6yLwzkHbs/Kp9QmX0L3ThbSL
        HQ/ZDhe1oXNOTvfoHYKPjZAR3IQjUFN/T0SUxd6qfCgrFR4=
X-Google-Smtp-Source: APXvYqytu5mRrbjVxvAST0m4zxpLJza9xsDHfDmYv2scNpVkq8ZV+4y2MQ0hJ72PfhvoU6VQb9ZaSHr99e2tSX2rf/o=
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr3252646pjo.20.1571733158042;
 Tue, 22 Oct 2019 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
In-Reply-To: <20191018132131.31608-1-jarkko.nikula@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Oct 2019 11:32:27 +0300
Message-ID: <CAHp75Vci+XKozjUsZHnQsr=ekg2x-zBUjFqMSp0d0rLiKq=E+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: dw: Move runtime PM enable/disable from common
 to platform driver part
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Oct 19, 2019 at 11:26 AM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> After commit 1e6959832510 ("spi: dw: Add basic runtime PM support")
> there is following warning from PCI enumerated DesignWare SPI controller
> during probe:
>
>         dw_spi_pci 0000:00:13.0: Unbalanced pm_runtime_enable!
>
> Runtime PM is already enabled for PCI devices by the PCI core and doing
> it again in common DW SPI code leads to unbalanced enable calls.
>
> Fix this by moving the runtime PM enable/disable calls to the platform
> driver part of the driver.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 5 +++++
>  drivers/spi/spi-dw.c      | 7 -------
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index b5ce8bd58d9e..384a3ab6dc2d 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -9,6 +9,7 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/scatterlist.h>
> @@ -193,6 +194,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>                         goto out;
>         }
>
> +       pm_runtime_enable(&pdev->dev);
> +
>         ret = dw_spi_add_host(&pdev->dev, dws);
>         if (ret)
>                 goto out;
> @@ -201,6 +204,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>         return 0;
>
>  out:
> +       pm_runtime_disable(&pdev->dev);
>         clk_disable_unprepare(dwsmmio->pclk);
>  out_clk:
>         clk_disable_unprepare(dwsmmio->clk);
> @@ -212,6 +216,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
>         struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
>
>         dw_spi_remove_host(&dwsmmio->dws);
> +       pm_runtime_disable(&pdev->dev);
>         clk_disable_unprepare(dwsmmio->pclk);
>         clk_disable_unprepare(dwsmmio->clk);
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 54ed6eb3e252..466f5c67843b 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -10,7 +10,6 @@
>  #include <linux/module.h>
>  #include <linux/highmem.h>
>  #include <linux/delay.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>
> @@ -499,8 +498,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         if (dws->set_cs)
>                 master->set_cs = dws->set_cs;
>
> -       pm_runtime_enable(dev);
> -
>         /* Basic HW init */
>         spi_hw_init(dev, dws);
>
> @@ -529,7 +526,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         spi_enable_chip(dws, 0);
>         free_irq(dws->irq, master);
>  err_free_master:
> -       pm_runtime_disable(dev);
>         spi_controller_put(master);
>         return ret;
>  }
> @@ -544,9 +540,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
>
>         spi_shutdown_chip(dws);
>
> -       if (dws->master)
> -               pm_runtime_disable(&dws->master->dev);
> -
>         free_irq(dws->irq, dws->master);
>  }
>  EXPORT_SYMBOL_GPL(dw_spi_remove_host);
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
