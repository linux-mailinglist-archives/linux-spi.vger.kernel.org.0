Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A233595F0
	for <lists+linux-spi@lfdr.de>; Fri,  9 Apr 2021 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhDIG7w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Apr 2021 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbhDIG7w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Apr 2021 02:59:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1DC061761;
        Thu,  8 Apr 2021 23:59:39 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 7so4892544qka.7;
        Thu, 08 Apr 2021 23:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/tejr2/uh+1Wal7zJlIcpvUZ6IPZqdEqxDQqb4GHzw=;
        b=jXmLVhTRBrg62WD2F55bliSUil4x0gPuiPNtILwoHQ6vYAEbN9tSmM23dhPceENmvI
         BjLVbpES734MDk9s1iCOXZtbw61PTd6f9vMqgR//zgSxNhgL7bjKodpo6KoKyWnGv4XD
         vkmd9rxBeDh9Xwd9ckvBBF+PrLc8vN4NzOAAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/tejr2/uh+1Wal7zJlIcpvUZ6IPZqdEqxDQqb4GHzw=;
        b=oj6GZTEt0pQqbZ8I1a3YATEsX2FIsCDZjnVd+YcXKH8uj+hojm1GYfU926f6zKSGAP
         6me4IXDm9KtS8MyZUz/IFoM4nnbbR3PivCz8jjDXC1Ura6zGdU8IWQxo8nbV12aoFaSX
         IyvbRZuKTtSFJQSOkJdWYrZ9PeHWIMa+1GS7cjL6m6tLIT4uACmDviUegp8+0shFNF9z
         bW8bDfeg9NYKqAJv0uIlKSgIpKaS5ERjVxrj7ztHoFRJt5eklpIGQgBrW4a30uL5Do78
         r46xYbhvDTD9W0hfsiZ53fGUCuHxaAmudvw0iWxHcXrj9Ipv/8dh9stehVIzfrZ2cDTu
         OxRA==
X-Gm-Message-State: AOAM531BkdHWcBLdAXjxbDrS+uJZmnr0JkKjkYFsHwW+nbkVB/m8XXIY
        Bqc+soWAdd+o95qZU7kkHEIrAWMRvyLJFPLiJIWQJ7/uWcA=
X-Google-Smtp-Source: ABdhPJyKcADophW6MaZY/tX7xb0gci6Gx5eaJSC83xHh2wYAcw5xJt46Q2kU7TLL6HRIolVQhJheknr0u0VEqQTfO7s=
X-Received: by 2002:a37:d202:: with SMTP id f2mr12568606qkj.273.1617951578539;
 Thu, 08 Apr 2021 23:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210407095527.2771582-1-wak@google.com>
In-Reply-To: <20210407095527.2771582-1-wak@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 9 Apr 2021 06:59:26 +0000
Message-ID: <CACPK8Xd8e3xmx=itKm8bg3oQsfWh0VhMpgyMbnOdB_4u0Z65aQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix use-after-free with devm_spi_alloc_*
To:     "William A. Kennington III" <wak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 7 Apr 2021 at 09:55, William A. Kennington III <wak@google.com> wrote:
>
> We can't rely on the contents of the devres list during
> spi_unregister_controller(), as the list is already torn down at the
> time we perform devres_find() for devm_spi_release_controller. This
> causes devices registered with devm_spi_alloc_{master,slave}() to be
> mistakenly identified as legacy, non-devm managed devices and have their
> reference counters decremented below 0.

Thanks for spending the time to track down the bug and sending a fix
for it. I appreciate it!

Reviewed-by: Joel Stnaley <joel@jms.id.au>

Cheers,

Joel

>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 660 at lib/refcount.c:28 refcount_warn_saturate+0x108/0x174
> [<b0396f04>] (refcount_warn_saturate) from [<b03c56a4>] (kobject_put+0x90/0x98)
> [<b03c5614>] (kobject_put) from [<b0447b4c>] (put_device+0x20/0x24)
>  r4:b6700140
> [<b0447b2c>] (put_device) from [<b07515e8>] (devm_spi_release_controller+0x3c/0x40)
> [<b07515ac>] (devm_spi_release_controller) from [<b045343c>] (release_nodes+0x84/0xc4)
>  r5:b6700180 r4:b6700100
> [<b04533b8>] (release_nodes) from [<b0454160>] (devres_release_all+0x5c/0x60)
>  r8:b1638c54 r7:b117ad94 r6:b1638c10 r5:b117ad94 r4:b163dc10
> [<b0454104>] (devres_release_all) from [<b044e41c>] (__device_release_driver+0x144/0x1ec)
>  r5:b117ad94 r4:b163dc10
> [<b044e2d8>] (__device_release_driver) from [<b044f70c>] (device_driver_detach+0x84/0xa0)
>  r9:00000000 r8:00000000 r7:b117ad94 r6:b163dc54 r5:b1638c10 r4:b163dc10
> [<b044f688>] (device_driver_detach) from [<b044d274>] (unbind_store+0xe4/0xf8)
>
> Instead, determine the devm allocation state as a flag on the
> controller which is guaranteed to be stable during cleanup.
>
> Fixes: 5e844cc37a5c ("spi: Introduce device-managed SPI controller allocation")
> Signed-off-by: William A. Kennington III <wak@google.com>
> ---
>  drivers/spi/spi.c       | 9 ++-------
>  include/linux/spi/spi.h | 3 +++
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b08efe88ccd6..904a353798b6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2496,6 +2496,7 @@ struct spi_controller *__devm_spi_alloc_controller(struct device *dev,
>
>         ctlr = __spi_alloc_controller(dev, size, slave);
>         if (ctlr) {
> +               ctlr->devm_allocated = true;
>                 *ptr = ctlr;
>                 devres_add(dev, ptr);
>         } else {
> @@ -2842,11 +2843,6 @@ int devm_spi_register_controller(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_spi_register_controller);
>
> -static int devm_spi_match_controller(struct device *dev, void *res, void *ctlr)
> -{
> -       return *(struct spi_controller **)res == ctlr;
> -}
> -
>  static int __unregister(struct device *dev, void *null)
>  {
>         spi_unregister_device(to_spi_device(dev));
> @@ -2893,8 +2889,7 @@ void spi_unregister_controller(struct spi_controller *ctlr)
>         /* Release the last reference on the controller if its driver
>          * has not yet been converted to devm_spi_alloc_master/slave().
>          */
> -       if (!devres_find(ctlr->dev.parent, devm_spi_release_controller,
> -                        devm_spi_match_controller, ctlr))
> +       if (!ctlr->devm_allocated)
>                 put_device(&ctlr->dev);
>
>         /* free bus id */
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 592897fa4f03..643139b1eafe 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -510,6 +510,9 @@ struct spi_controller {
>
>  #define SPI_MASTER_GPIO_SS             BIT(5)  /* GPIO CS must select slave */
>
> +       /* flag indicating this is a non-devres managed controller */
> +       bool                    devm_allocated;
> +
>         /* flag indicating this is an SPI slave controller */
>         bool                    slave;
>
> --
> 2.31.0.208.g409f899ff0-goog
>
