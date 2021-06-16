Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A483AA41A
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jun 2021 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhFPTTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 15:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFPTTD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Jun 2021 15:19:03 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2326C061574;
        Wed, 16 Jun 2021 12:16:56 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id y207so1627508vsy.12;
        Wed, 16 Jun 2021 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNxugS1gOpbkd57DjDo4gtxr8lmWpbvql6CFdMUNkIs=;
        b=c3lEjjMQH+lwfQp6GfLhII7DPTHWW8sHTk6VHLQQVtIe6RY0k/MEeLcu3dhb6IrL5t
         bq4aEjgEAQgnWJ/VajM+/h+yeDxXcdss5lU5mEzmgEwG8m3Ru4vFcPeUdbGr1dmGPUgm
         rnpgTWxuj/eNQ/zgwGRk+MLkJe6K3d243OLte6b0AEQrOC+258aBBwzJBdGfV6bBC1Xx
         2TEtBRMzpB6tfrTdOuLSSfxawJu3lD6dCyf/6OZVeTRpaPhY/+Yx0IXyl8zbD6tWk9ib
         M5FWxaYm7EAG6Bc6H/hI1SCRUgu8vRAnsZFkB7+wtnXUKfwFn+U+PhEbvQn1Q9Z3I1Oj
         ewug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNxugS1gOpbkd57DjDo4gtxr8lmWpbvql6CFdMUNkIs=;
        b=lE9XpJ48BTxxfW8EvlroOGd8JmAWUsJsVei+ICHezCsjocbKZ7G2BhbJqS1gpBgfAc
         UxxcIAaTH799TizvAxw4cg91jYSbB4LSnq220CXP4UoAnYhsQOD5qbH8cmDeDUPV1wNa
         0zbXJDvQw09qIIu25CowPIfPi/vY+iwNZ2j8gQvYh6+JOwP/vsBgcdzq0tJgQIiubvEl
         Bz/kiY2/E/wZs/PRO4/l+noqCQqW+uOThaFx8h0bivFyr9SGmCb5GSafPZayssRWhRKQ
         OzwhZ8M4kngC2M88i/5mpPIk3Us/JHPTMPxZeFFXJaPeKYfpx8fd5OdiI6ApF4i4ZGZC
         nWHA==
X-Gm-Message-State: AOAM531dSA46M+ObhiDR4u2cW0Jpj5zccbnMevFUvN0GbrgXu5zm4k6o
        aAkHoNHBawmv7PlwdUlj2N81/7oYo69cNLp8hFNBYmJfqCw=
X-Google-Smtp-Source: ABdhPJy5hdQvUAWsg6sDdwrc/mbiSu4NFkCaXjivdnsmSgQmdKv7SjwlZC/4lkJBfyFGznDgnGmon3fnOjjB9duwn3Y=
X-Received: by 2002:a67:f48c:: with SMTP id o12mr877406vsn.13.1623871015850;
 Wed, 16 Jun 2021 12:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210527084531.18989-1-christian.gmeiner@gmail.com>
In-Reply-To: <20210527084531.18989-1-christian.gmeiner@gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Wed, 16 Jun 2021 21:16:44 +0200
Message-ID: <CAH9NwWfh9-2+kLoTXJgkVSStb1cHHvC-He5jnfFxMpUngMeAtA@mail.gmail.com>
Subject: Re: [PATCH] spidev: add platform driver support
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ping

Am Do., 27. Mai 2021 um 10:45 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> This makes it possible to use spidev in combination with the
> MFD subsystem. The MFD subsystem add platform_driver devices.
>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/spi/spidev.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index f56e0e975a46..fb7b483ff70d 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -25,6 +25,8 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spidev.h>
>
> +#include <linux/platform_device.h>
> +
>  #include <linux/uaccess.h>
>
>
> @@ -827,6 +829,40 @@ static struct spi_driver spidev_spi_driver = {
>          */
>  };
>
> +static int spidev_platform_probe(struct platform_device *pdev)
> +{
> +       struct device *parent = pdev->dev.parent;
> +       struct spi_device *spi;
> +
> +       if (strcmp(parent->bus->name, "spi"))
> +               return -ENODEV;
> +
> +       spi = to_spi_device(parent);
> +
> +       /* This only works if no drvdata is stored */
> +       if (spi_get_drvdata(spi)) {
> +               dev_err(&pdev->dev, "drvdata is not NULL\n");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return spidev_probe(spi);
> +}
> +
> +static int spidev_platform_remove(struct platform_device *pdev)
> +{
> +       struct spi_device *spi = to_spi_device(pdev->dev.parent);
> +
> +       return spidev_remove(spi);
> +}
> +
> +static struct platform_driver spidev_platfoem_driver = {
> +       .probe = spidev_platform_probe,
> +       .remove = spidev_platform_remove,
> +       .driver = {
> +               .name = "spidev",
> +       },
> +};
> +
>  /*-------------------------------------------------------------------------*/
>
>  static int __init spidev_init(void)
> @@ -853,12 +889,21 @@ static int __init spidev_init(void)
>                 class_destroy(spidev_class);
>                 unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
>         }
> +
> +       status = platform_driver_register(&spidev_platfoem_driver);
> +       if (status < 0) {
> +               spi_unregister_driver(&spidev_spi_driver);
> +               class_destroy(spidev_class);
> +               unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
> +       }
> +
>         return status;
>  }
>  module_init(spidev_init);
>
>  static void __exit spidev_exit(void)
>  {
> +       platform_driver_unregister(&spidev_platfoem_driver);
>         spi_unregister_driver(&spidev_spi_driver);
>         class_destroy(spidev_class);
>         unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
> --
> 2.31.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
