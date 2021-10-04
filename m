Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E16421164
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhJDOdm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 10:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhJDOdl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 10:33:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB5C061745
        for <linux-spi@vger.kernel.org>; Mon,  4 Oct 2021 07:31:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v18so64570310edc.11
        for <linux-spi@vger.kernel.org>; Mon, 04 Oct 2021 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZuUk2iu5vHcMhoBaZr8flTV9KKhRBTDDf88OfAd1bQ=;
        b=hcseAkgo8Fs/UKNurZ/HjOn337SWuxoZle/5s2FKM//51k9M24jWvZZPDoKpuXJiHT
         DoSp8kDCxl49ACyPlhcukNkilsGYyb60QabmKfGpnQ+NGNx76NSO0pn8BKRJSq/1kNnw
         ZRaGw/gdJtZADTU2vhQT5diiYiSrqPghbGYGBdIXDuuqvsIXb9IhO7OzdT7Dr80frjfS
         euVwrBpLHkcYVIiQSGAYZxj+9FXt7NqRW5An2Cbfda+EIu9nCtJOtjHpOX1ihMJSBoGs
         9b4ZxDnFuimiqx7kXno3u/tRsNN7PXx8tl12CKZ1nmDCO7CZFu1AY4irD+oL7g3/B4m9
         LXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZuUk2iu5vHcMhoBaZr8flTV9KKhRBTDDf88OfAd1bQ=;
        b=BD6l+dMZ9vFKvmhTfBYZOkBUpkWyJYdrhzYdYs3HgaykKV4T1+ZtOkCs9+8dGbQ9K0
         rV/U8pAUJLhmUy/GHSqRP8eXI7+FxhKemXAgNv9qJ9/Oc3H7bwy9/jLMQ1f7/QNKCWYv
         t0qiPYKmiQz71Hx3RPLQqYHc3qE5i0XcQtxWl0OBWxv8DSvl3lZjOeyCBdc+6FOjzqc6
         CXS1EdZR6N0h2bJMNAX+rHyLsDc8sELIlYrve8Zvnq9R/Ibq/kbp0/FzSBfP8GiOfT7w
         xBwWDc3bdisad3t/6+cQAqE9nBeYsA8c4mdLgd3kQXRbj+P/SV0fRe4WzazNARw3sNzw
         79+w==
X-Gm-Message-State: AOAM533MUdt7ZiF5kUjNTVfShDbambPRK4FTiRot9vvd+4RjiDiS9EWV
        VZt+/p3zd10Io1m+EUfGSEqpguq6QIeEffPKWaw=
X-Google-Smtp-Source: ABdhPJzozW2lp8HI17qauDAxWFN5XLE/VahlI/0T8huV8hDx4D44743HHJgPMc8S0aGca96NXIfEgutghG41+/OiKpc=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr17716073ejc.69.1633357824072;
 Mon, 04 Oct 2021 07:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com> <20210930100719.2176-3-mika.westerberg@linux.intel.com>
In-Reply-To: <20210930100719.2176-3-mika.westerberg@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Oct 2021 17:29:47 +0300
Message-ID: <CAHp75VdtOHn4ED-ixdDngBQw10OnKmbtTv=ydLs6dYbkjyqW4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 30, 2021 at 1:08 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The preferred way to implement SPI-NOR controller drivers is through SPI
> subsubsystem utilizing the SPI MEM core functions. This converts the
> Intel SPI flash controller driver over the SPI MEM by moving the driver
> from SPI-NOR subsystem to SPI subsystem and in one go make it use the
> SPI MEM functions. The driver name will be changed from intel-spi to
> spi-intel to match the convention used in the SPI subsystem.

...

> +config SPI_INTEL_PCI
> +       tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> +       depends on PCI && (X86 || COMPILE_TEST)

Perhaps two entries, one of which will be the same as for platform case?

> +       depends on SPI_MEM
> +       select SPI_INTEL
> +       help
> +         This enables PCI support for the Intel PCH/PCU SPI controller in
> +         master mode. This controller is present in modern Intel hardware
> +         and is used to hold BIOS and other persistent settings. Using
> +         this driver it is possible to upgrade BIOS directly from Linux.
> +
> +         Say N here unless you know what you are doing. Overwriting the
> +         SPI flash may render the system unbootable.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called spi-intel-pci.
> +
> +config SPI_INTEL_PLATFORM
> +       tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
> +       depends on X86 || COMPILE_TEST
> +       depends on SPI_MEM
> +       select SPI_INTEL
> +       help
> +         This enables platform support for the Intel PCH/PCU SPI
> +         controller in master mode. This controller is present in modern
> +         Intel hardware and is used to hold BIOS and other persistent
> +         settings. Using this driver it is possible to upgrade BIOS
> +         directly from Linux.
> +
> +         Say N here unless you know what you are doing. Overwriting the
> +         SPI flash may render the system unbootable.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called spi-intel-platform.

...

+ Blank line ?

>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/spi-nor.h>

+ Blank line?

> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>

The rationale is to show that we use two sub(sub)sytems here.

...

> -                       dev_err(ispi->dev, "read error: %llx: %#x\n", from,
> +                       dev_err(ispi->dev, "read error: %x: %#x\n", from,
>                                 status);

Now one line?

...

> -                       dev_err(ispi->dev, "write error: %llx: %#x\n", to,
> +                       dev_err(ispi->dev, "write error: %x: %#x\n", to,
>                                 status);

Ditto.

...

> +               ret = intel_spi_sw_cycle(ispi, opcode, 0,
> +                                        OPTYPE_WRITE_WITH_ADDR);
> +               return ret ? ret : 0;

Why not simply return intel_spi_dw_cycle(...); ?

...

> +       val = readl(ispi->base + HSFSTS_CTL);
> +       val &= ~(HSFSTS_CTL_FDBC_MASK | HSFSTS_CTL_FCYCLE_MASK);
> +       val |= HSFSTS_CTL_AEL | HSFSTS_CTL_FCERR | HSFSTS_CTL_FDONE;

> +       val |= cmd;
> +       val |= HSFSTS_CTL_FGO;

Maybe swap these lines to group constants?

...

> +       status = readl(ispi->base + HSFSTS_CTL);
> +       if (status & HSFSTS_CTL_FCERR)
> +               return -EIO;

> +       else if (status & HSFSTS_CTL_AEL)

Redundant 'else'

> +               return -EACCES;

...

> +static int intel_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +       struct intel_spi *ispi = spi_master_get_devdata(mem->spi->master);
> +       size_t nbytes = op->data.nbytes;
> +       u8 opcode = op->cmd.opcode;
> +
> +       if (op->addr.nbytes) {
> +               if  (op->data.dir == SPI_MEM_DATA_IN)
> +                       return intel_spi_read(ispi, op->addr.val, nbytes,
> +                                             op->data.buf.in);

> +               else if (op->data.dir == SPI_MEM_DATA_OUT)

Redundant 'else' here and nearby.

> +                       return intel_spi_write(ispi, op->addr.val, nbytes,
> +                                              op->data.buf.out);
> +               else if (op->data.dir == SPI_MEM_NO_DATA)
> +                       return intel_spi_erase(ispi, opcode, op->addr.val);
> +       } else {
> +               if  (op->data.dir == SPI_MEM_DATA_IN)
> +                       return intel_spi_read_reg(ispi, opcode, op->data.buf.in,
> +                                                 nbytes);
> +               else if (op->data.dir == SPI_MEM_DATA_OUT)
> +                       return intel_spi_write_reg(ispi, opcode, op->data.buf.out,
> +                                                  nbytes);
> +               else if (op->data.dir == SPI_MEM_NO_DATA)
> +                       return intel_spi_write_reg(ispi, opcode, NULL, 0);
>         }

> +       return -EINVAL;
> +}

-- 
With Best Regards,
Andy Shevchenko
