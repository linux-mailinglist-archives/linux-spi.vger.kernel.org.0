Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9541614DF48
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2020 17:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgA3Qhj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jan 2020 11:37:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39843 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Qhj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jan 2020 11:37:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1549364plp.6;
        Thu, 30 Jan 2020 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QeUkS8Rj0owL5zLt2/16lPhjl1ZqFJkapQtmAvwsWM=;
        b=PxXsXC4L3jIjwq/6145+BjPtqafsv2IWR4kSEFaSaje5UZ9LvecHyjPjS1VHSFGju7
         ILoNB17+rjTtbJq0anWhsrqwHzjaNw8kxiFdIuzl4FxFXlfaU1PDFQcY8VYGzTusStT0
         paqQLi+SMg7sI+an/CKm/PFBFCVia5YT/qDwdK9CipYuIP0EidOGhn7JI+/ukk6bEPt6
         li0wV0ObL26eps1HWlNJUxKGQaWWFaujuoCSBRZ/zVcnzr6twHCOoU2v4lRXcYJtHP6V
         WVbLMyfzjRwn5K0SxL5W0G2iqYozvgM+KKwda39H3gW78zALBTFYCVmpgLZrRPsLRtU8
         aK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QeUkS8Rj0owL5zLt2/16lPhjl1ZqFJkapQtmAvwsWM=;
        b=rl2lwACNohtEdCUQxQgSaOXKCqWg7E8Tr4UvSWw4/o1PH6nhiWVhiALACWfFNn7bW6
         DIt4DTQyHeVFwG/hZ7swwphzKXW/IfWme2EyxZpiRx9oRlAMFe4DCtX0LUO5CoMeUEXd
         73LKnfi1DquXKNBgS5WRZBLPAtF2AEajSyG6venCbE8QvW5dc4phiGzmsCLVLvuzhdd+
         6v3ibHAUx3NqEV9ow2+JG2AYYWqqS9/86XgbfFxKaXpTPWIR1XjO/ac8RrDkJCuzRYrZ
         4zIUHblNJ6aU8P3ZzzxfTSuf07nm0oxMsiylLDz2VL4/ILmr8ENypWi4gJyTQLqP+Bs4
         372Q==
X-Gm-Message-State: APjAAAWdGDByrbvzG1ySUgX2vjCgTQ/yJTcnkqG1UtQ4r9S1/Q+27b32
        CWR6EPe+oEvWICzfbqZ+uDVWf372i5NV2BnH1KI=
X-Google-Smtp-Source: APXvYqw05Oi6WZ2s8YtE4an6qX1yZwcaXvractqxsGWER+x2zKBdLht0SKoSAYRucLMdYT1sU2mlWTrjrgja7clnFVA=
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr6920931pjb.30.1580402258529;
 Thu, 30 Jan 2020 08:37:38 -0800 (PST)
MIME-Version: 1.0
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jan 2020 18:37:30 +0200
Message-ID: <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> There exists a set of SPI controllers on some POWER processors that may
> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
> engine that can access and drive the SPI controllers. This driver would
> typically be used by a baseboard management controller (BMC).

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

> +#include <linux/of.h>

...

> +struct fsi_spi {
> +       struct device *dev;

Isn't fsl->dev the same?
Perhaps kernel doc to explain the difference?

> +       struct fsi_device *fsi;

> +       u32 base;
> +};

...

> +static int fsi_spi_read_reg(struct fsi_spi *ctx, u32 offset, u64 *value)
> +{
> +       int rc;
> +       __be32 cmd_be;
> +       __be32 data_be;

> +       *value = 0ULL;

Usually the pattern is don't pollute output on error condition. Any
reason why you zeroing output beforehand?

> +       cmd_be = cpu_to_be32(offset + ctx->base);
> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
> +       if (rc)
> +               return rc;

> +       return 0;
> +}

...

> +       data_be = cpu_to_be32((value >> 32) & 0xFFFFFFFF);

Redundant & 0xff... part.

> +       data_be = cpu_to_be32(value & 0xFFFFFFFF);

Ditto.

You may use upper_32_bits() / lower_32_bits() instead.

...

> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> +{
> +       int i;

> +       int num_bytes = len > 8 ? 8 : len;

min(len, 8);

> +       for (i = 0; i < num_bytes; ++i)
> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);

Redundant & 0xffULL part.

Isn't it NIH of get_unalinged_be64 / le64 or something similar?

> +       return num_bytes;
> +}

> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> +{

Ditto as for above function. (put_unaligned ...)

> +}

...

> +       dev_info(ctx->dev, "Resetting SPI controller.\n");

info?! Why?

> +       rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                              SPI_FSI_CLOCK_CFG_RESET2);
> +       return rc;

return fsi_spi_write_reg();

...

> +       return ((64 - seq->bit) / 8) - 2;

Too many parentheses.

...

> +static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
> +                                    struct fsi_spi_sequence *seq,
> +                                    struct spi_transfer *transfer)
> +{

> +       int loops = 1;
> +       int idx = 0;
> +       int rc;
> +       u8 len;
> +       u8 rem = 0;

> +       if (transfer->len > 8) {
> +               loops = transfer->len / 8;
> +               rem = transfer->len - (loops * 8);
> +               len = 8;
> +       } else {
> +               len = transfer->len;
> +       }

len = min(transfer->len, 8);

loops = transfer->len / len;
rem = transfer->len % len;

(I think compiler is clever enough to find out that the division can be avoided)

...and drop assignments in definition block.

I didn't look carefully in the implementation, but I believe there is
still room for improvement / optimization.

> +       if (loops > 1) {

> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG,
> +                                      SPI_FSI_COUNTER_CFG_LOOPS(loops - 1));
> +               if (rc) {

> +                       /* Ensure error returns < 0 in this case. */

I didn't get why this case is special? Why not to be consistent with
return value?

> +                       if (rc > 0)
> +                               rc = -rc;
> +
> +                       return rc;
> +               }

> +               return loops;

If we return here the amount of loops...

> +       }
> +
> +       return 0;

...why here is 0?

I think more consistency is required.

> +}

...

> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
> +                                struct spi_transfer *transfer)
> +{

Can you refactor to tx and rx parts?

> +       return 0;
> +}

...

> +       do {
> +               rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
> +                             SPI_FSI_STATUS_TDR_FULL |
> +                             SPI_FSI_STATUS_RDR_FULL)) {
> +                       rc = fsi_spi_reset(ctx);
> +                       if (rc)
> +                               return rc;
> +

> +                       continue;

I forgot if this to be infinite loop or if it's going to check
previous seq_state value. In any case this code is a bit fishy. Needs
comments / refactoring.

> +               }
> +
> +               seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
> +       } while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));

...

> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> +                         SPI_FSI_CLOCK_CFG_MODE |
> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)

> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                                      wanted_clock_cfg);

Missed {} ?

> +
> +       return rc;
> +}

...

> +       rc = fsi_slave_read(fsi->slave, 0x2860, &root_ctrl_8,

What is this magic for?

> +                           sizeof(root_ctrl_8));
> +       if (rc)
> +               return rc;

...

> +static int fsi_spi_remove(struct device *dev)
> +{
> +       return 0;
> +}

Why do you need this?

...

> +static struct fsi_driver fsi_spi_driver = {
> +       .id_table = fsi_spi_ids,
> +       .drv = {
> +               .name = "spi-fsi",

> +               .bus = &fsi_bus_type,

Why is it not in the module_fsi_driver() macro?

> +               .probe = fsi_spi_probe,
> +               .remove = fsi_spi_remove,
> +       },
> +};
> +
> +module_fsi_driver(fsi_spi_driver);

-- 
With Best Regards,
Andy Shevchenko
