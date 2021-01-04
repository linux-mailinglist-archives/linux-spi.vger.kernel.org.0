Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03FC2E977E
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhADOmA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbhADOl7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 09:41:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35544C061794;
        Mon,  4 Jan 2021 06:41:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j13so10987585pjz.3;
        Mon, 04 Jan 2021 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXaJNX2Jskx5OEocIASLdr6b8/tqPfbVLLfBn2sa/P0=;
        b=KdaqA3gz6Ai0xge8iuPiFSIphNs5pe5lz+PJp8K3TRcc+LrsabVL6IMVfULH/htJZ3
         vYEriW2+VcS5qMMc1+MIt0idp7LoNpHFX9TZfJAtGTX0geg3btsljnGIfhmkPqpOJLAu
         YP61V1kA/4/0zXtethM1kl4af1vHImO4EbHllMsTNXsELYXfZQuy1O4eEMZAi6ha7AVq
         8qLEm4OjeXtrYSk1c/bl21roFhFnxaTegRj/oTTBgQUIyyzvmAv4LXz4t9H8e+Ia2qxb
         qKJVkoQ0KtSMst0q9sVlTtU3+9B+zmuygPSZ0McWvOdcvD4SNWz4C07X3KPYl62/wiRW
         IOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXaJNX2Jskx5OEocIASLdr6b8/tqPfbVLLfBn2sa/P0=;
        b=ZwFYD5tm3v3WEzf3fcS0Aw/CyaErE2xAGLznWlHF1dDTW04E3FQSrg9O/hKxxm494r
         vpUXyoFySOH1nm8NE392Ikhc8ko6df+vw6x/T12pgcGBN5gZDzQZ4e9tw4pI9yE91JGO
         BAC26f0gsUgjf5s4hthZ+sBdD2Zpib1EKRONiPRl4+GlZx0ido8nBfvAUkFTc1M5fDeV
         4uPmtFi6PcHjRNdZ16+Axk414+jyiFm6AQqWQKt4jLrBFXytOQV42mfvlMLPk6lUtbnl
         jlnL0oP9+Hq0luzEtbNChUnHvllT2GUfv1dJt3yuyM22SKRKeu/fBiFvd9rnUo4LyaOO
         mksw==
X-Gm-Message-State: AOAM532RiYSI08sARZqVCZGnf4ou5kmZ93zMYjDzojqmIbcxlKSKnA+x
        EJ0SgupvcHKODweKuSrjRjl+Ip31kKv5rLxtw3A=
X-Google-Smtp-Source: ABdhPJxpQJLinOmgjXNcmG/F9gQPqs7wkOS5EYRvUHZac1b5y3nEzUaH+KeKKquCejYrUsH2AshYgJHRP4Zcqyjc9WE=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr30577197pjb.129.1609771278761;
 Mon, 04 Jan 2021 06:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20210104085923.53705-1-alexandru.ardelean@analog.com> <20210104143103.56510-1-alexandru.ardelean@analog.com>
In-Reply-To: <20210104143103.56510-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jan 2021 16:42:07 +0200
Message-ID: <CAHp75VfjCK9=a1Hy1kJK85VFEPc0GhT=tGC3wOzsiR-e+6LVkQ@mail.gmail.com>
Subject: Re: [PATCH v2] spi: stm32: update dev_dbg() print format for SPI params
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jan 4, 2021 at 4:27 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
> type of the macros are enforced to 'unsigned long int' via the _BITUL()
> macro.
>
> This causes some -Wformat warnings in the spi-stm32 driver.
> This patch adds a double-negation operator to the bit-masks. Essentially,
> the important values for debugging are 0 or 1, while masking them directly
> would show 0 or BIT(x) values.
> This way, the type of the arguments are automatically re-cast.

Thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: f7005142dace ("spi: uapi: unify SPI modes into a single spi.h header")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Changelog v1 -> v2:
> * revert to using '%d' specifiers
> * add !! operatior to bit-masking; this way the types are automatically
>   re-cast
> * add 'Reported-by: kernel test robot <lkp@intel.com>'
>
>  drivers/spi/spi-stm32.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
> index 6017209c6d2f..be0fb169d7a7 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1028,10 +1028,10 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
>                 clrb |= spi->cfg->regs->lsb_first.mask;
>
>         dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
> -               spi_dev->mode & SPI_CPOL,
> -               spi_dev->mode & SPI_CPHA,
> -               spi_dev->mode & SPI_LSB_FIRST,
> -               spi_dev->mode & SPI_CS_HIGH);
> +               !!(spi_dev->mode & SPI_CPOL),
> +               !!(spi_dev->mode & SPI_CPHA),
> +               !!(spi_dev->mode & SPI_LSB_FIRST),
> +               !!(spi_dev->mode & SPI_CS_HIGH));
>
>         spin_lock_irqsave(&spi->lock, flags);
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
