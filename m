Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB654459728
	for <lists+linux-spi@lfdr.de>; Mon, 22 Nov 2021 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbhKVWNm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 22 Nov 2021 17:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhKVWNl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Nov 2021 17:13:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3EC061746;
        Mon, 22 Nov 2021 14:10:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so83111273edd.13;
        Mon, 22 Nov 2021 14:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iIP8X/GQ/zXH+OqmQkkmK8AOlGNQWXCC8HDQ4K4jkSc=;
        b=YrdMKv9p5UXwMFZRJgNjVFQgdHCA4lCcRpWUVgvpPCc0Y7105mYSSC4OYL/OeUqLtv
         d/NhGu0bMnZFFZJG1pz8j8ls7JB/Ob8RqjxcXfv1+viht5hTynDvi7G9yD82vkfcPYy0
         YoFo4XlN/pdSjoroAajopm2vG/TAJx2veUcWYSQ7EbWKn6uPxYBbekF8Nq0TrLY2PCrI
         Gx5B/7CtMcfEKae7Y3qgGj5CLhq+XM65y4I4FUIfUoUprvSw4okrnj17LN4mxwtvQ87m
         EgkwkQikj3kd69kPMnH/H0huwGP6z4xuyKlzcxcYcrJ3QVZ4swzwsNmAUc9kVsy0GhHA
         HFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iIP8X/GQ/zXH+OqmQkkmK8AOlGNQWXCC8HDQ4K4jkSc=;
        b=V+r2mC+b2l2GcCV1RS8MmcnJA8V0HwRR6ChvKb5zCymw2trcnB4oCCVkyFfVrTNmJj
         5HZ4VmoPe8fRMi/vfHelYiF+keHLktURHTvh70Brw0DOYexlwDccAUQdaiH2W3c8rBrT
         /OlSpoGprvz1Z54oezxkDJimXGqBUFlK7Ln4AclDbV9hknR4jgvp1JEnBwdjj3Hb7ot1
         QTAkwurgxi0hJRIULggCfUGpk+TOZUw3pKdM1+9Un3+TFL7lJoNY7JIOP9eSL/mHG8rz
         bYJcL+2GpF6kyc6R7C/JusnnUSCeKVgTZMG7jIDXykLGsAt5GGjY3M1T8t/HB6OEUyYC
         Omhw==
X-Gm-Message-State: AOAM530KY3HuS+h5+PJnDCRzOXh2ju+upsg/H3YYv07aCLKpb8fbFM05
        pMPN3J9DBFDXbkwGmnjvcrGPuafI5OYWtFI5tmw=
X-Google-Smtp-Source: ABdhPJzx2poYmInv/5piC/WYqWeeSXH48WP68AWfNwuNmFkMOqoGlujRYSbGEw69PIfgSgsi4uf/7c+P2PcDKrUzzJY=
X-Received: by 2002:aa7:df9a:: with SMTP id b26mr708866edy.107.1637619032745;
 Mon, 22 Nov 2021 14:10:32 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com> <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
In-Reply-To: <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 00:09:54 +0200
Message-ID: <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 22, 2021 at 4:34 AM LH.Kuo <lhjeff911@gmail.com> wrote:
>
> Add SPI driver for Sunplus SP7021.

Much better, but needs more work to be good enough, see my comments below.

...

> +config SPI_SUNPLUS_SP7021
> +       tristate "Sunplus SP7021 SPI controller"
> +       depends on SOC_SP7021
> +       help
> +         This enable Sunplus SP7021 spi controller driver on the SP7021 =
SoCs.

enables
SPI

> +         This driver can also be built as a module. If so, the module wi=
ll be
> +         called as spi-sunplus-sp7021.
> +
> +         If you have a  Sunplus SP7021 platform say Y here.
> +         If unsure, say N.

...

> +// SPDX-License-Identifier: GPL-2.0-only

> +//

Do you need this line?

> +// Copyright (c) 2021 Sunplus Inc.
> +// Author: LH Kuo <lh.kuo@sunplus.com>

...

> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/delay.h>

Sort them, please.

...

> +#define SLAVE_INT_IN

What's this?

...

> +#define SP7021_MAS_REG_NAME "spi_master"
> +#define SP7021_SLA_REG_NAME "spi_slave"
> +
> +#define SP7021_MAS_IRQ_NAME "mas_risc_intr"
> +#define SP7021_SLA_IRQ_NAME "slave_risc_intr"

Why do you need these?

...

> +#define SP7021_CLR_MAS_INT (1<<6)

Make use of BIT() and GENMASK() here and below.

> +#define SP7021_SLA_DMA_READ (0xd)
> +#define SP7021_SLA_SW_RST (1<<1)
> +#define SP7021_SLA_DMA_WRITE (0x4d)
> +#define SP7021_SLA_DMA_W_INT (1<<8)
> +#define SP7021_SLA_CLR_INT (1<<8)
> +#define SP7021_SLA_DATA_RDY (1<<0)

This is a mess. Make sure they are sorted by the value.
Also it's visible that bit 6 defines READ vs. WRITE (at least for DMA).

> +#define SP7021_CLR_MAS_W_INT (1<<7)
> +
> +#define SP7021_TOTAL_LENGTH(x) (x<<24)
> +#define SP7021_TX_LENGTH(x) (x<<16)
> +#define SP7021_GET_LEN(x)     ((x>>24)&0xFF)
> +#define SP7021_GET_TX_LEN(x)  ((x>>16)&0xFF)
> +#define SP7021_GET_RX_CNT(x)  ((x>>12)&0x0F)
> +#define SP7021_GET_TX_CNT(x)  ((x>>8)&0x0F)
> +
> +#define SP7021_FINISH_FLAG (1<<6)
> +#define SP7021_FINISH_FLAG_MASK (1<<15)
> +#define SP7021_RX_FULL_FLAG (1<<5)
> +#define SP7021_RX_FULL_FLAG_MASK (1<<14)
> +#define SP7021_RX_EMP_FLAG (1<<4)
> +#define SP7021_TX_EMP_FLAG (1<<2)
> +#define SP7021_TX_EMP_FLAG_MASK (1<<11)
> +#define SP7021_SPI_START_FD (1<<0)
> +#define SP7021_FD_SEL (1<<6)
> +#define SP7021_LSB_SEL (1<<4)
> +#define SP7021_WRITE_BYTE(x) (x<<9)
> +#define SP7021_READ_BYTE(x) (x<<7)
> +#define SP7021_CLEAN_RW_BYTE (~0x780)
> +#define SP7021_CLEAN_FLUG_MASK (~0xF800)
> +
> +#define SP7021_CPOL_FD (1<<0)
> +#define SP7021_CPHA_R (1<<1)
> +#define SP7021_CPHA_W (1<<2)
> +#define SP7021_CS_POR (1<<5)
> +
> +#define SP7021_FD_SW_RST (1<<1)
> +#define SP7021_FIFO_DATA_BITS (16*8)    // 16 BYTES
> +#define SP7021_INT_BYPASS (1<<3)
> +
> +#define SP7021_FIFO_REG 0x0034
> +#define SP7021_SPI_STATUS_REG 0x0038
> +#define SP7021_SPI_CONFIG_REG 0x003c
> +#define SP7021_INT_BUSY_REG 0x004c
> +#define SP7021_DMA_CTRL_REG 0x0050
> +
> +#define SP7021_DATA_RDY_REG 0x0044
> +#define SP7021_SLV_DMA_CTRL_REG 0x0048
> +#define SP7021_SLV_DMA_LENGTH_REG 0x004c
> +#define SP7021_SLV_DMA_ADDR_REG 0x004c

...

> +enum SPI_MODE {

Besides unneeded names, which may collide with generic definitions...

> +       SP7021_SLA_READ =3D 0,
> +       SP7021_SLA_WRITE =3D 1,
> +       SP7021_SPI_IDLE =3D 2

...add a comma here, since it doesn't look like a terminator.

> +};

...

> +enum {
> +       SP7021_MASTER_MODE,
> +       SP7021_SLAVE_MODE,
> +};

Is it related to hardware? Then assign proper values explicitly.

...

> +struct sp7021_spi_ctlr {

> +

Redundant blank line.

> +       struct device *dev;
> +       int mode;
> +       struct spi_controller *ctlr;

> +       void __iomem *mas_base;
> +       void __iomem *sla_base;

Why do you need this to be separated?

> +       u32 xfer_conf;

> +       int mas_irq;
> +       int sla_irq;

Ditto.

> +       struct clk *spi_clk;
> +       struct reset_control *rstc;
> +
> +       spinlock_t lock;
> +       struct mutex buf_lock;
> +
> +       struct completion isr_done;
> +       struct completion sla_isr;

Ditto.

> +       unsigned int  rx_cur_len;
> +       unsigned int  tx_cur_len;
> +
> +       const u8 *tx_buf;
> +       u8 *rx_buf;
> +
> +       unsigned int  data_unit;
> +};

...

> +// spi slave irq handler

Useless comments.

...

> +// slave only. usually called on driver remove

Why is it so?
Also find use of proper English grammar (capitalization, periods, etc.
Ditto for all your comments.

...

> +// slave R/W, called from S_transfer_one() only

Ditto here and for all similar comments. If you point out that
something is called from something either explain why or drop useless
comments since anybody can see what function called from which
function (even indirectly).

...

> +int sp7021_spi_sla_tx(struct spi_device *spi, struct spi_transfer *xfer)
> +{
> +       struct sp7021_spi_ctlr *pspim =3D spi_controller_get_devdata(spi-=
>controller);

> +       struct device *devp =3D &(spi->dev);

Here and everywhere else, first of all we are using dev for struct
device pointers, second there are too many parentheses.

> +       int err =3D 0;

What's the use? See below...

> +       mutex_lock(&pspim->buf_lock);
> +
> +       reinit_completion(&pspim->sla_isr);
> +
> +       writel_relaxed(SP7021_SLA_DMA_WRITE, pspim->sla_base + SP7021_SLV=
_DMA_CTRL_REG);
> +       writel_relaxed(xfer->len, pspim->sla_base + SP7021_SLV_DMA_LENGTH=
_REG);
> +       writel_relaxed(xfer->tx_dma, pspim->sla_base + SP7021_SLV_DMA_ADD=
R_REG);
> +       writel(readl(pspim->sla_base + SP7021_DATA_RDY_REG) | SP7021_SLA_=
DATA_RDY,
> +                       pspim->sla_base + SP7021_DATA_RDY_REG);

> +       if (wait_for_completion_interruptible(&pspim->sla_isr))
> +               dev_err(devp, "%s() wait_for_completion timeout\n", __fun=
c__);

...seems you missed to assign proper error code.

> +       mutex_unlock(&pspim->buf_lock);
> +       return err;
> +}

...

> +exit_spi_slave_rw:

Make names of goto labels meaningful, what does above mean? What it
should mean is what will be done when goto to it, i.e. out_unlock: in
this case.

> +       mutex_unlock(&pspim->buf_lock);
> +       return err;

> +

You need to clean up your code before submission.
So, let's see -50 LOCs next time, I see it's achievable.

> +}

...

> +void sp7021_spi_mas_rb(struct sp7021_spi_ctlr *pspim, u8 len)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < len; i++) {
> +               pspim->rx_buf[pspim->rx_cur_len] =3D
> +                       readl(pspim->mas_base + SP7021_FIFO_REG);
> +               pspim->rx_cur_len++;
> +       }
> +}
> +
> +void sp7021_spi_mas_wb(struct sp7021_spi_ctlr *pspim, u8 len)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < len; i++) {
> +               writel(pspim->tx_buf[pspim->tx_cur_len],
> +                       pspim->mas_base + SP7021_FIFO_REG);
> +               pspim->tx_cur_len++;
> +       }
> +}

Are these NIH of readsl() / writesl()?

...

> +       unsigned long flags;
> +       struct sp7021_spi_ctlr *pspim =3D dev;
> +       u32 fd_status =3D 0;
> +       unsigned int tx_len, rx_cnt, tx_cnt, total_len;
> +       bool isrdone =3D false;

Reversed xmas tree order here and everywhere else.

...

> +               writel(readl(pspim->mas_base + SP7021_INT_BUSY_REG)
> +                       | SP7021_CLR_MAS_INT, pspim->mas_base + SP7021_IN=
T_BUSY_REG);

Use a temporary variable instead of this mess.

...

> +static void sp7021_prep_transfer(struct spi_controller *ctlr,
> +                       struct spi_device *spi)

One line?

...

> +       // set clock
> +       clk_rate =3D clk_get_rate(pspim->spi_clk);
> +       div =3D clk_rate / xfer->speed_hz;
> +
> +       clk_sel =3D (div / 2) - 1;

When div =3D=3D 0 is it okay to have this value for clk_sel?

...

> +       // set full duplex (bit 6) and fd freq (bits 31:16)

Useless, and use GENMASK()

> +       rc =3D SP7021_FD_SEL | (0xffff << 16);
> +       rs =3D SP7021_FD_SEL | ((clk_sel & 0xffff) << 16);

What' the point of having SP7021_FD_SEL in rc and rs simultaneously?

> +       writel((pspim->xfer_conf & ~rc) | rs, pspim->mas_base + SP7021_SP=
I_CONFIG_REG);

...

> +       writel(readl(pspim->mas_base + SP7021_SPI_STATUS_REG) | SP7021_FD=
_SW_RST,
> +                                       pspim->mas_base + SP7021_SPI_STAT=
US_REG);

Introduce proper IO accessors as other drivers do.

> +       //set up full duplex frequency and enable  full duplex
> +       rs =3D SP7021_FD_SEL | ((0xffff) << 16);

Seems like d=C3=A9j=C3=A0-vu to me. Perhaps it makes sense to have a dedica=
ted definition.

...

> +       unsigned long timeout =3D msecs_to_jiffies(1000);
> +       unsigned int i;
> +       int ret;
> +       unsigned int xfer_cnt, xfer_len, last_len;

...

> +       for (i =3D 0; i <=3D xfer_cnt; i++) {

> +

Redundant. As I said you have a lot of this kind of blank lines sparse
over the code.

> +               mutex_lock(&pspim->buf_lock);
> +
> +               sp7021_prep_transfer(ctlr, spi);
> +               sp7021_spi_setup_transfer(spi, ctlr, xfer);
> +
> +               reinit_completion(&pspim->isr_done);
> +
> +               if (i =3D=3D xfer_cnt)
> +                       xfer_len =3D last_len;
> +               else
> +                       xfer_len =3D SP7021_SPI_DATA_SIZE;

If xfer_len =3D=3D 0 does it make any sense to go via the entire loop?

...

> +               if (!wait_for_completion_interruptible_timeout(&pspim->is=
r_done,
> +                                                              timeout)){

One line? Also check wrong spacing.

...

> +free_maste_xfer:
> +       return ret;

Useless label. You may return directly. Actually the entire function
needs a bit of care.

...

> +                       dma_unmap_single(dev, xfer->tx_dma,
> +                               xfer->len, DMA_TO_DEVICE);

One line

...

> +                       dma_unmap_single(dev, xfer->rx_dma,
> +                               xfer->len, DMA_FROM_DEVICE);

Ditto.

...

> +       pdev->id =3D 0;

Why?

...

> +       if (pdev->dev.of_node) {
> +               pdev->id =3D of_alias_get_id(pdev->dev.of_node, "sp_spi")=
;

Ditto.

...

> +               if (of_property_read_bool(pdev->dev.of_node, "spi-slave")=
)
> +                       mode =3D SP7021_SLAVE_MODE;

There is no need to check of_node for this call.

...

> +       dev_dbg(&pdev->dev, "pdev->id =3D %d\n", pdev->id);

Useless.

...

> +       ctlr->dev.of_node =3D pdev->dev.of_node;

Use device_set_node().

...

> +       pspim->mas_base =3D devm_platform_ioremap_resource_byname
> +               (pdev, SP7021_MAS_REG_NAME);
> +       pspim->sla_base =3D devm_platform_ioremap_resource_byname
> +               (pdev, SP7021_SLA_REG_NAME);

Something is wrong with the indentation.

...

> +       dev_dbg(&pdev->dev, "mas_base 0x%x\n", (unsigned int)pspim->mas_b=
ase);

Redundant.

...

> +       pspim->mas_irq =3D platform_get_irq_byname(pdev, SP7021_MAS_IRQ_N=
AME);
> +       if (pspim->mas_irq < 0) {

> +               dev_err(&pdev->dev, "failed to get %s\n", SP7021_MAS_IRQ_=
NAME);

Duplicate message printing.

> +               return pspim->mas_irq;
> +       }
> +
> +       pspim->sla_irq =3D platform_get_irq_byname(pdev, SP7021_SLA_IRQ_N=
AME);
> +       if (pspim->sla_irq < 0) {

> +               dev_err(&pdev->dev, "failed to get %s\n", SP7021_SLA_IRQ_=
NAME);

Ditto.

> +               return pspim->sla_irq;
> +       }

...

> +       // clk

Meaningless.

...

> +       dev_dbg(&pdev->dev, "pspim->rstc : 0x%x\n", (unsigned int)pspim->=
rstc);

Get rid of the debugging like this, it's not for production use at all.

...

> +               return dev_err_probe(&pdev->dev, PTR_ERR(pspim->rstc),
> +                                    "devm_rst_get fail\n");

One line.

...

> +               return dev_err_probe(&pdev->dev, ret,
> +                       "failed to enable clk\n");

Ditto. And so on...
To make lines shorter, utilize a temporary variable for struct device *dev.

...

> +       dev_dbg(&pdev->dev, "pm init done\n");

Redundant.

> +       dev_dbg(&pdev->dev, "spi_master_probe done\n");

Redundant.

...

> +       dev_dbg(dev, "devid:%d\n", dev->id);

Redundant.

...

> +       dev_dbg(dev, "devid:%d\n", dev->id);

Ditto.

--=20
With Best Regards,
Andy Shevchenko
