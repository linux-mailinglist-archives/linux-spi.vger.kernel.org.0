Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3209925133
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 15:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfEUNzX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 09:55:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36906 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUNzX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 May 2019 09:55:23 -0400
Received: by mail-io1-f68.google.com with SMTP id u2so13997316ioc.4
        for <linux-spi@vger.kernel.org>; Tue, 21 May 2019 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYYKWYCjLPYmjOdcVu2whaIlQZtmdEbdQ5C4r2D2nTE=;
        b=s1e2i+YzSfr3OfVhPNJMsIUWzRpt4GktTRiVBFD4MCqUVN8zzp8/CgSYaDKIbU7rW7
         y5tJk+tb0o4SxjDLrWf+wLEyJBN6MQrwMW+nHIMrHKfcHUaXLdx7wPSMrzBi+iGH/hRx
         krvkW+NFremFAWvW4fZxex51Fg6BVAzaN4Qy0CSWtDTNI1k3AF6kGHCnXaDJ/E0afcYz
         bcras1Z20f/Y715DiMWGM9UukoT45pZnGzfidGFqMgDecXSkXEctCTZTrB6Jq5ZO1aJA
         MDQkiXCAlvqRhsJ2YVQnBefM2086Uq5p+/AsPcsAS0wtyyrZs3LzMYxL8uZIB+uvA7HA
         HpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYYKWYCjLPYmjOdcVu2whaIlQZtmdEbdQ5C4r2D2nTE=;
        b=BftGeAAckQyjnfBrgjp1s8N8QHU0s1VkdQgh35Iter8npl8C+eJqYZ+4hUBPk85esF
         fsc3OiJypNqpcJcmSYmjqpHx1TcSmWBfPJcPu0v4z1oAzQl+Eh/NsLOMBLQQYfCpP6jk
         c63tqL542DfQSO+mM9dOZkthMuAogpXv0mrfBz50RvrVxQUaVzSztsqXVcIZtFgO83pE
         XXZ6Q6uNvuhaFSpEwqWDwAJVqEkWqoQCnKax47eaUMucUMkbPnQqEXOF1wZMfwtFFoxx
         26BGeVjO1jKOC/FuE5pojD3O79SnM5dsZwBIDD+3HgXrcK4UTj7ZHSyrkAvm8n0RB6vl
         ZUSQ==
X-Gm-Message-State: APjAAAWJXBznQ59lim/WEYjKliQ02/PiHHaaoRb+iosTXhxOl4M+m4t5
        Lmlrt60cb/mNZTqn014OKJLwcpNzGAYMPxeklJ05oA==
X-Google-Smtp-Source: APXvYqxCxt1Xla7icWwnlOQtr/Ll1R3tk54Ka8I+X/kLaEq71k2ynOSVwH2KAvSzTCrwq/1Gjhgj7AHcEoo9EunjCIc=
X-Received: by 2002:a5e:9411:: with SMTP id q17mr11019073ioj.65.1558446921318;
 Tue, 21 May 2019 06:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190521115958.22504-1-masahisa.kojima@linaro.org> <20190521115958.22504-4-masahisa.kojima@linaro.org>
In-Reply-To: <20190521115958.22504-4-masahisa.kojima@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 May 2019 14:55:09 +0100
Message-ID: <CAKv+Gu8zhymKrbuNo+KU58svKyBO2cyLw-wKcKwgON2sDYBK7A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-spi@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 21 May 2019 at 13:00, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This patch adds support for controller found on synquacer platforms.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/spi/Kconfig         |  11 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-synquacer.c | 731 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 743 insertions(+)
>  create mode 100644 drivers/spi/spi-synquacer.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 0fba8f400c59..24a3eac72d12 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -732,6 +732,17 @@ config SPI_SUN6I
>         help
>           This enables using the SPI controller on the Allwinner A31 SoCs.
>
> +config SPI_SYNQUACER
> +       tristate "Socionext's Synquacer HighSpeed SPI controller"
> +       depends on ARCH_SYNQUACER || COMPILE_TEST
> +       select SPI_BITBANG
> +       help
> +         SPI driver for Socionext's High speed SPI controller which provides
> +         various operating modes for interfacing to serial peripheral devices
> +         that use the de-facto standard SPI protocol.
> +
> +         It also supports the new dual-bit and quad-bit SPI protocol.
> +
>  config SPI_MXIC
>          tristate "Macronix MX25F0A SPI controller"
>          depends on SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f2f78d03dc28..63dcab552bcb 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_SPI_STM32_QSPI)                += spi-stm32-qspi.o
>  obj-$(CONFIG_SPI_ST_SSC4)              += spi-st-ssc4.o
>  obj-$(CONFIG_SPI_SUN4I)                        += spi-sun4i.o
>  obj-$(CONFIG_SPI_SUN6I)                        += spi-sun6i.o
> +obj-$(CONFIG_SPI_SYNQUACER)            += spi-synquacer.o
>  obj-$(CONFIG_SPI_TEGRA114)             += spi-tegra114.o
>  obj-$(CONFIG_SPI_TEGRA20_SFLASH)       += spi-tegra20-sflash.o
>  obj-$(CONFIG_SPI_TEGRA20_SLINK)                += spi-tegra20-slink.o
> diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> new file mode 100644
> index 000000000000..04ba76609a12
> --- /dev/null
> +++ b/drivers/spi/spi-synquacer.c
> @@ -0,0 +1,731 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Synquacer HSSPI controller driver
> +//
> +// Copyright (c) 2015-2018 Socionext Inc.
> +// Copyright (c) 2018-2019 Linaro Ltd.
> +//
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spinlock.h>
> +#include <linux/clk.h>
> +
> +/* HSSPI register address definitions */
> +#define SYNQUACER_HSSPI_REG_MCTRL      0x00
> +#define SYNQUACER_HSSPI_REG_PCC0       0x04
> +#define SYNQUACER_HSSPI_REG_PCC(n)     (SYNQUACER_HSSPI_REG_PCC0 + (n) * 4)
> +#define SYNQUACER_HSSPI_REG_TXF                0x14
> +#define SYNQUACER_HSSPI_REG_TXE                0x18
> +#define SYNQUACER_HSSPI_REG_TXC                0x1C
> +#define SYNQUACER_HSSPI_REG_RXF                0x20
> +#define SYNQUACER_HSSPI_REG_RXE                0x24
> +#define SYNQUACER_HSSPI_REG_RXC                0x28
> +#define SYNQUACER_HSSPI_REG_FAULTF     0x2C
> +#define SYNQUACER_HSSPI_REG_FAULTC     0x30
> +#define SYNQUACER_HSSPI_REG_DMCFG      0x34
> +#define SYNQUACER_HSSPI_REG_DMSTART    0x38
> +#define SYNQUACER_HSSPI_REG_DMBCC      0x3C
> +#define SYNQUACER_HSSPI_REG_DMSTATUS   0x40
> +#define SYNQUACER_HSSPI_REG_FIFOCFG    0x4C
> +#define SYNQUACER_HSSPI_REG_TX_FIFO    0x50
> +#define SYNQUACER_HSSPI_REG_RX_FIFO    0x90
> +#define SYNQUACER_HSSPI_REG_MID                0xFC
> +
> +/* HSSPI register bit definitions */
> +#define SYNQUACER_HSSPI_MCTRL_MEN                      BIT(0)
> +#define SYNQUACER_HSSPI_MCTRL_COMMAND_SEQUENCE_EN      BIT(1)
> +#define SYNQUACER_HSSPI_MCTRL_CDSS                     BIT(3)
> +#define SYNQUACER_HSSPI_MCTRL_MES                      BIT(4)
> +#define SYNQUACER_HSSPI_MCTRL_SYNCON                   BIT(5)
> +
> +#define SYNQUACER_HSSPI_PCC_CPHA               BIT(0)
> +#define SYNQUACER_HSSPI_PCC_CPOL               BIT(1)
> +#define SYNQUACER_HSSPI_PCC_ACES               BIT(2)
> +#define SYNQUACER_HSSPI_PCC_RTM                        BIT(3)
> +#define SYNQUACER_HSSPI_PCC_SSPOL              BIT(4)
> +#define SYNQUACER_HSSPI_PCC_SDIR               BIT(7)
> +#define SYNQUACER_HSSPI_PCC_SENDIAN            BIT(8)
> +#define SYNQUACER_HSSPI_PCC_SAFESYNC           BIT(16)
> +#define SYNQUACER_HSSPI_PCC_SS2CD_SHIFT                5
> +#define SYNQUACER_HSSPI_PCC_CDRS_MASK          0x7f
> +#define SYNQUACER_HSSPI_PCC_CDRS_SHIFT         9
> +
> +#define SYNQUACER_HSSPI_TXF_FIFO_FULL          BIT(0)
> +#define SYNQUACER_HSSPI_TXF_FIFO_EMPTY         BIT(1)
> +#define SYNQUACER_HSSPI_TXF_SLAVE_RELEASED     BIT(6)
> +
> +#define SYNQUACER_HSSPI_TXE_FIFO_FULL          BIT(0)
> +#define SYNQUACER_HSSPI_TXE_FIFO_EMPTY         BIT(1)
> +#define SYNQUACER_HSSPI_TXE_SLAVE_RELEASED     BIT(6)
> +
> +#define SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD           BIT(5)
> +#define SYNQUACER_HSSPI_RXF_SLAVE_RELEASED                     BIT(6)
> +
> +#define SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD           BIT(5)
> +#define SYNQUACER_HSSPI_RXE_SLAVE_RELEASED                     BIT(6)
> +
> +#define SYNQUACER_HSSPI_DMCFG_SSDC             BIT(1)
> +#define SYNQUACER_HSSPI_DMCFG_MSTARTEN         BIT(2)
> +
> +#define SYNQUACER_HSSPI_DMSTART_START          BIT(0)
> +#define SYNQUACER_HSSPI_DMSTOP_STOP            BIT(8)
> +#define SYNQUACER_HSSPI_DMPSEL_CS_MASK         0x3
> +#define SYNQUACER_HSSPI_DMPSEL_CS_SHIFT                16
> +#define SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT  24
> +#define SYNQUACER_HSSPI_DMTRP_DATA_MASK                0x3
> +#define SYNQUACER_HSSPI_DMTRP_DATA_SHIFT       26
> +#define SYNQUACER_HSSPI_DMTRP_DATA_TXRX                0
> +#define SYNQUACER_HSSPI_DMTRP_DATA_RX          1
> +#define SYNQUACER_HSSPI_DMTRP_DATA_TX          2
> +
> +#define SYNQUACER_HSSPI_DMSTATUS_RX_DATA_MASK  0x1f
> +#define SYNQUACER_HSSPI_DMSTATUS_RX_DATA_SHIFT 8
> +#define SYNQUACER_HSSPI_DMSTATUS_TX_DATA_MASK  0x1f
> +#define SYNQUACER_HSSPI_DMSTATUS_TX_DATA_SHIFT 16
> +
> +#define SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_MASK      0xf
> +#define SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT     0
> +#define SYNQUACER_HSSPI_FIFOCFG_TX_THRESHOLD_MASK      0xf
> +#define SYNQUACER_HSSPI_FIFOCFG_TX_THRESHOLD_SHIFT     4
> +#define SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_MASK                0x3
> +#define SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT       8
> +#define SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH               BIT(11)
> +#define SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH               BIT(12)
> +
> +#define SYNQUACER_HSSPI_FIFO_DEPTH             16
> +#define SYNQUACER_HSSPI_FIFO_TX_THRESHOLD      4
> +#define SYNQUACER_HSSPI_FIFO_RX_THRESHOLD \
> +       (SYNQUACER_HSSPI_FIFO_DEPTH - SYNQUACER_HSSPI_FIFO_TX_THRESHOLD)
> +
> +#define SYNQUACER_HSSPI_TRANSFER_MODE_TX       BIT(1)
> +#define SYNQUACER_HSSPI_TRANSFER_MODE_RX       BIT(2)
> +#define SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC    2000
> +
> +#define SYNQUACER_HSSPI_CLOCK_SRC_IHCLK                0
> +#define SYNQUACER_HSSPI_CLOCK_SRC_IPCLK                1
> +
> +#define SYNQUACER_HSSPI_NUM_CHIP_SELECT                4
> +
> +struct synquacer_spi {
> +       struct device *dev;
> +       struct completion transfer_done;
> +       unsigned int cs;
> +       unsigned int bpw;
> +       unsigned int mode;
> +       unsigned int speed;
> +       bool aces, rtm;
> +       void *rx_buf;
> +       const void *tx_buf;
> +       struct clk *clk;
> +       int clk_src_type;
> +       void __iomem *regs;
> +       unsigned int tx_words, rx_words;
> +       unsigned int bus_width;
> +       unsigned int transfer_mode;
> +};
> +
> +static void read_fifo(struct synquacer_spi *sspi)
> +{
> +       u32 len = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
> +
> +       len = (len >> SYNQUACER_HSSPI_DMSTATUS_RX_DATA_SHIFT) &
> +              SYNQUACER_HSSPI_DMSTATUS_RX_DATA_MASK;
> +       len = min_t(unsigned int, len, sspi->rx_words);
> +

Please use the same type for len and rx_words instead of relying on
min_t() (and use min() instead)

> +       switch (sspi->bpw) {
> +       case 8:
> +               {
> +               u8 *buf = sspi->rx_buf;
> +
> +               readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> +               sspi->rx_buf = buf + len;
> +               break;
> +               }
> +       case 16:
> +               {
> +               u16 *buf = sspi->rx_buf;
> +
> +               readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> +               sspi->rx_buf = buf + len;
> +               break;
> +               }
> +       default:
> +               {
> +               u32 *buf = sspi->rx_buf;
> +
> +               readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
> +               sspi->rx_buf = buf + len;
> +               break;
> +               }
> +       }
> +
> +       sspi->rx_words -= len;
> +}
> +
> +static void write_fifo(struct synquacer_spi *sspi)
> +{
> +       u32 len = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
> +
> +       len = (len >> SYNQUACER_HSSPI_DMSTATUS_TX_DATA_SHIFT) &
> +              SYNQUACER_HSSPI_DMSTATUS_TX_DATA_MASK;
> +       len = min_t(unsigned int, SYNQUACER_HSSPI_FIFO_DEPTH - len,
> +                   sspi->tx_words);
> +

Same here

> +       switch (sspi->bpw) {
> +       case 8:
> +               {
> +               const u8 *buf = sspi->tx_buf;
> +
> +               writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
> +               sspi->tx_buf = buf + len;
> +               break;
> +               }
> +       case 16:
> +               {
> +               const u16 *buf = sspi->tx_buf;
> +
> +               writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
> +               sspi->tx_buf = buf + len;
> +               break;
> +               }
> +       default:
> +               {
> +               const u32 *buf = sspi->tx_buf;
> +
> +               writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
> +               sspi->tx_buf = buf + len;
> +               break;
> +               }
> +       }
> +       sspi->tx_words -= len;
> +}
> +
> +static int synquacer_spi_config(struct spi_master *master,
> +                               struct spi_device *spi,
> +                               struct spi_transfer *xfer)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       unsigned int speed, mode, bpw, cs, bus_width, transfer_mode;
> +       u32 rate, val, div;
> +
> +       /* Full Duplex only on 1-bit wide bus */
> +       if (xfer->rx_buf && xfer->tx_buf &&
> +           (xfer->rx_nbits != 1 || xfer->tx_nbits != 1)) {
> +               dev_err(sspi->dev,
> +                       "RX and TX bus widths must match for Full-Duplex!\n");
> +               return -EINVAL;
> +       }
> +
> +       if (xfer->tx_buf) {
> +               bus_width = xfer->tx_nbits;
> +               transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_TX;
> +       } else {
> +               bus_width = xfer->rx_nbits;
> +               transfer_mode = SYNQUACER_HSSPI_TRANSFER_MODE_RX;
> +       }
> +
> +       mode = spi->mode;
> +       cs = spi->chip_select;
> +       speed = xfer->speed_hz;
> +       bpw = xfer->bits_per_word;
> +
> +       /* return if nothing to change */
> +       if (speed == sspi->speed &&
> +               bus_width == sspi->bus_width && bpw == sspi->bpw &&
> +               mode == sspi->mode && cs == sspi->cs &&
> +               transfer_mode == sspi->transfer_mode) {
> +               return 0;
> +       }
> +
> +       sspi->transfer_mode = transfer_mode;
> +       rate = master->max_speed_hz;
> +
> +       div = DIV_ROUND_UP(rate, speed);
> +       if (div > 254) {
> +               dev_err(sspi->dev, "Requested rate too low (%u)\n",
> +                       sspi->speed);
> +               return -EINVAL;
> +       }
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_PCC(cs));
> +       val &= ~SYNQUACER_HSSPI_PCC_SAFESYNC;
> +       if (bpw == 8 && (mode & (SPI_TX_DUAL | SPI_RX_DUAL)) && div < 3)
> +               val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
> +       if (bpw == 8 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 6)
> +               val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
> +       if (bpw == 16 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 3)
> +               val |= SYNQUACER_HSSPI_PCC_SAFESYNC;
> +
> +       if (mode & SPI_CPHA)
> +               val |= SYNQUACER_HSSPI_PCC_CPHA;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_CPHA;
> +
> +       if (mode & SPI_CPOL)
> +               val |= SYNQUACER_HSSPI_PCC_CPOL;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_CPOL;
> +
> +       if (mode & SPI_CS_HIGH)
> +               val |= SYNQUACER_HSSPI_PCC_SSPOL;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_SSPOL;
> +
> +       if (mode & SPI_LSB_FIRST)
> +               val |= SYNQUACER_HSSPI_PCC_SDIR;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_SDIR;
> +
> +       if (sspi->aces)
> +               val |= SYNQUACER_HSSPI_PCC_ACES;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_ACES;
> +
> +       if (sspi->rtm)
> +               val |= SYNQUACER_HSSPI_PCC_RTM;
> +       else
> +               val &= ~SYNQUACER_HSSPI_PCC_RTM;
> +
> +       val |= (3 << SYNQUACER_HSSPI_PCC_SS2CD_SHIFT);
> +       val |= SYNQUACER_HSSPI_PCC_SENDIAN;
> +
> +       val &= ~(SYNQUACER_HSSPI_PCC_CDRS_MASK <<
> +                SYNQUACER_HSSPI_PCC_CDRS_SHIFT);
> +       val |= ((div >> 1) << SYNQUACER_HSSPI_PCC_CDRS_SHIFT);
> +
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_PCC(cs));
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +       val &= ~(SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_MASK <<
> +                SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT);
> +       val |= ((bpw / 8 - 1) << SYNQUACER_HSSPI_FIFOCFG_FIFO_WIDTH_SHIFT);
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +       val &= ~(SYNQUACER_HSSPI_DMTRP_DATA_MASK <<
> +                SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
> +
> +       if (xfer->rx_buf)
> +               val |= (SYNQUACER_HSSPI_DMTRP_DATA_RX <<
> +                       SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
> +       else
> +               val |= (SYNQUACER_HSSPI_DMTRP_DATA_TX <<
> +                       SYNQUACER_HSSPI_DMTRP_DATA_SHIFT);
> +
> +       val &= ~(3 << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
> +       val |= ((bus_width >> 1) << SYNQUACER_HSSPI_DMTRP_BUS_WIDTH_SHIFT);
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +

In general, you should use readl and writel everywhere, *unless* there
is a reason you need the _relaxed variants, in which case you need to
provide justification that it is safe to do so (and you still need a
barrier somewhere)

> +       sspi->bpw = bpw;
> +       sspi->mode = mode;
> +       sspi->speed = speed;
> +       sspi->cs = spi->chip_select;
> +       sspi->bus_width = bus_width;
> +
> +       return 0;
> +}
> +
> +static int synquacer_spi_transfer_one(struct spi_master *master,
> +                                     struct spi_device *spi,
> +                                     struct spi_transfer *xfer)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +       int status = 0;
> +       unsigned int words;
> +       u8 bpw;
> +       u32 val;
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +       val |= SYNQUACER_HSSPI_FIFOCFG_RX_FLUSH;
> +       val |= SYNQUACER_HSSPI_FIFOCFG_TX_FLUSH;
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +
> +       /*
> +        * See if we can transfer 4-bytes as 1 word
> +        * to maximize the FIFO buffer effficiency
> +        */
> +       bpw = xfer->bits_per_word;
> +       if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST))
> +               xfer->bits_per_word = 32;
> +
> +       ret = synquacer_spi_config(master, spi, xfer);
> +
> +       /* restore */
> +       xfer->bits_per_word = bpw;
> +
> +       if (ret)
> +               return ret;
> +
> +       reinit_completion(&sspi->transfer_done);
> +
> +       sspi->tx_buf = xfer->tx_buf;
> +       sspi->rx_buf = xfer->rx_buf;
> +
> +       switch (sspi->bpw) {
> +       case 8:
> +               words = xfer->len;
> +               break;
> +       case 16:
> +               words = xfer->len / 2;
> +               break;
> +       default:
> +               words = xfer->len / 4;
> +               break;
> +       }
> +
> +       if (xfer->tx_buf)
> +               sspi->tx_words = words;
> +       else
> +               sspi->tx_words = 0;
> +
> +       if (xfer->rx_buf)
> +               sspi->rx_words = words;
> +       else
> +               sspi->rx_words = 0;
> +
> +       if (xfer->tx_buf)
> +               write_fifo(sspi);
> +
> +       if (xfer->rx_buf) {
> +               val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +               val &= ~(SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_MASK <<
> +                        SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT);
> +               val |= ((sspi->rx_words > SYNQUACER_HSSPI_FIFO_DEPTH ?
> +                       SYNQUACER_HSSPI_FIFO_RX_THRESHOLD : sspi->rx_words) <<
> +                       SYNQUACER_HSSPI_FIFOCFG_RX_THRESHOLD_SHIFT);
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_FIFOCFG);
> +       }
> +
> +       writel_relaxed(~0, sspi->regs + SYNQUACER_HSSPI_REG_TXC);
> +       writel_relaxed(~0, sspi->regs + SYNQUACER_HSSPI_REG_RXC);
> +
> +       /* Trigger */
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +       val |= SYNQUACER_HSSPI_DMSTART_START;
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +
> +       if (sspi->rx_words) {
> +               val = SYNQUACER_HSSPI_RXE_FIFO_MORE_THAN_THRESHOLD |
> +                     SYNQUACER_HSSPI_RXE_SLAVE_RELEASED;
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +               status = wait_for_completion_timeout(&sspi->transfer_done,
> +                       msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> +               writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +       }
> +
> +       if (xfer->tx_buf) {
> +               val = SYNQUACER_HSSPI_TXE_FIFO_EMPTY;
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +               status = wait_for_completion_timeout(&sspi->transfer_done,
> +                       msecs_to_jiffies(SYNQUACER_HSSPI_TRANSFER_TMOUT_MSEC));
> +               writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +       }
> +
> +       if (status < 0) {
> +               dev_err(sspi->dev, "failed to transfer\n");
> +               return status;
> +       }
> +
> +       return 0;
> +}
> +
> +static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
> +       u32 val;
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +       val &= ~(SYNQUACER_HSSPI_DMPSEL_CS_MASK <<
> +                SYNQUACER_HSSPI_DMPSEL_CS_SHIFT);
> +       val |= spi->chip_select << SYNQUACER_HSSPI_DMPSEL_CS_SHIFT;
> +
> +       if (enable) {
> +               val |= SYNQUACER_HSSPI_DMSTOP_STOP;
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +
> +               if (sspi->rx_buf) {
> +                       u32 buf[SYNQUACER_HSSPI_FIFO_DEPTH];
> +
> +                       sspi->rx_buf = buf;
> +                       sspi->rx_words = SYNQUACER_HSSPI_FIFO_DEPTH;
> +                       read_fifo(sspi);
> +               }
> +       } else {
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +
> +               val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +               val &= ~SYNQUACER_HSSPI_DMSTOP_STOP;
> +               writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMSTART);
> +       }
> +}
> +
> +static int synquacer_spi_enable(struct spi_master *master)
> +{
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       u32 val;
> +       unsigned int retries = 0xfffff;
> +
> +       /* Disable module */
> +       writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
> +       while ((readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_MCTRL) &
> +               SYNQUACER_HSSPI_MCTRL_MES) && --retries)
> +               cpu_relax();
> +       if (!retries)
> +               return -EBUSY;
> +
> +       writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +       writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +       writel_relaxed(~0, sspi->regs + SYNQUACER_HSSPI_REG_TXC);
> +       writel_relaxed(~0, sspi->regs + SYNQUACER_HSSPI_REG_RXC);
> +       writel_relaxed(~0, sspi->regs + SYNQUACER_HSSPI_REG_FAULTC);
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_DMCFG);
> +       val &= ~SYNQUACER_HSSPI_DMCFG_SSDC;
> +       val &= ~SYNQUACER_HSSPI_DMCFG_MSTARTEN;
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_DMCFG);
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
> +       if (sspi->clk_src_type == SYNQUACER_HSSPI_CLOCK_SRC_IPCLK)
> +               val |= SYNQUACER_HSSPI_MCTRL_CDSS;
> +       else
> +               val &= ~SYNQUACER_HSSPI_MCTRL_CDSS;
> +
> +       val &= ~SYNQUACER_HSSPI_MCTRL_COMMAND_SEQUENCE_EN;
> +       val |= SYNQUACER_HSSPI_MCTRL_MEN;
> +       val |= SYNQUACER_HSSPI_MCTRL_SYNCON;
> +       writel_relaxed(val, sspi->regs + SYNQUACER_HSSPI_REG_MCTRL);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t sq_spi_rx_handler(int irq, void *priv)
> +{
> +       uint32_t val;
> +       struct synquacer_spi *sspi = priv;
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_RXF);
> +       if ((val & SYNQUACER_HSSPI_RXF_SLAVE_RELEASED) ||
> +           (val & SYNQUACER_HSSPI_RXF_FIFO_MORE_THAN_THRESHOLD))
> +               read_fifo(sspi);
> +
> +       if (sspi->rx_words == 0) {
> +               writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_RXE);
> +               complete(&sspi->transfer_done);
> +       }
> +
> +       return 0;
> +}
> +
> +static irqreturn_t sq_spi_tx_handler(int irq, void *priv)
> +{
> +       uint32_t val;
> +       struct synquacer_spi *sspi = priv;
> +
> +       val = readl_relaxed(sspi->regs + SYNQUACER_HSSPI_REG_TXF);
> +
> +       if (val & SYNQUACER_HSSPI_TXF_FIFO_EMPTY) {
> +               if (sspi->tx_words == 0) {
> +                       writel_relaxed(0, sspi->regs + SYNQUACER_HSSPI_REG_TXE);
> +                       complete(&sspi->transfer_done);
> +                       return 0;
> +               }
> +               write_fifo(sspi);
> +       }
> +
> +       return 0;
> +}
> +
> +static int synquacer_spi_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct spi_master *master;
> +       struct synquacer_spi *sspi;
> +       struct resource *res;
> +       int ret;
> +       int rx_irq, tx_irq;
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, master);
> +
> +       sspi = spi_master_get_devdata(master);
> +       sspi->dev = &pdev->dev;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sspi->regs = devm_ioremap_resource(sspi->dev, res);
> +       if (IS_ERR(sspi->regs)) {
> +               ret = PTR_ERR(sspi->regs);
> +               goto put_spi;
> +       }
> +
> +       if (of_property_match_string(np, "clock-names", "iHCLK") >= 0) {
> +               sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK;
> +               sspi->clk = devm_clk_get(sspi->dev, "iHCLK");
> +       } else if (of_property_match_string(np, "clock-names", "iPCLK") >= 0) {
> +               sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IPCLK;
> +               sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
> +       } else {
> +               dev_err(&pdev->dev, "specified wrong clock source\n");
> +               ret = -EINVAL;
> +               goto put_spi;
> +       }
> +       if (IS_ERR(sspi->clk)) {
> +               dev_err(&pdev->dev, "clock not found\n");
> +               ret = PTR_ERR(sspi->clk);
> +               goto put_spi;
> +       }
> +

Please make the clock handling dependent on ACPI vs DT probing (look
at the netsec or I2C drivers for examples)

> +       sspi->aces = of_property_read_bool(np, "socionext,set-aces");
> +       sspi->rtm = of_property_read_bool(np, "socionext,use-rtm");

Please use the device_property API instead of the of_property API so
that this works in ACPI mode as well

> +
> +       master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
> +
> +       init_completion(&sspi->transfer_done);
> +
> +       rx_irq = platform_get_irq(pdev, 0);
> +       if (rx_irq < 0)
> +               dev_err(&pdev->dev, "get rx_irq failed\n");
> +
> +       tx_irq = platform_get_irq(pdev, 1);
> +       if (tx_irq < 0)
> +               dev_err(&pdev->dev, "get tx_irq failed\n");
> +
> +       ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> +                               0, "synquacer-spi-rx", sspi);
> +       ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> +                               0, "synquacer-spi-tx", sspi);
> +

Can you use the dev_name() for the IRQ names? You may need to
sprintf() it into a buffer to append the rx and tx.

> +       ret = clk_prepare_enable(sspi->clk);
> +       if (ret)
> +               goto put_spi;
> +

Make this depend on DT probing

> +       master->dev.of_node = np;
> +       master->auto_runtime_pm = true;
> +       master->bus_num = pdev->id;
> +
> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> +                           SPI_TX_QUAD | SPI_RX_QUAD;
> +       master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
> +                                    SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
> +
> +       master->max_speed_hz = clk_get_rate(sspi->clk);
> +       master->min_speed_hz = master->max_speed_hz / 254;
> +
> +       master->set_cs = synquacer_spi_set_cs;
> +       master->transfer_one = synquacer_spi_transfer_one;
> +
> +       ret = synquacer_spi_enable(master);
> +       if (ret)
> +               goto fail_enable;
> +
> +       pm_runtime_set_active(sspi->dev);
> +       pm_runtime_enable(sspi->dev);
> +
> +       ret = devm_spi_register_master(sspi->dev, master);
> +       if (ret)
> +               goto disable_pm;
> +
> +       return 0;
> +
> +disable_pm:
> +       pm_runtime_disable(sspi->dev);
> +fail_enable:
> +       clk_disable_unprepare(sspi->clk);
> +put_spi:
> +       spi_master_put(master);
> +
> +       return ret;
> +}
> +
> +static int synquacer_spi_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +
> +       pm_runtime_disable(sspi->dev);
> +       clk_disable_unprepare(sspi->clk);

depend on DT

> +       return 0;
> +}
> +
> +static int __maybe_unused synquacer_spi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = spi_master_suspend(master);
> +       if (ret)
> +               return ret;
> +
> +       if (!pm_runtime_suspended(dev))
> +               clk_disable_unprepare(sspi->clk);

depend on DT

> +
> +       return ret;
> +}
> +
> +static int __maybe_unused synquacer_spi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       if (!pm_runtime_suspended(dev)) {
> +               /* Ensure reconfigure during next xfer */
> +               sspi->speed = 0;
> +
> +               ret = clk_prepare_enable(sspi->clk);
> +               if (ret < 0) {
> +                       dev_err(dev, "failed to enable clk (%d)\n", ret);
> +                       return ret;
> +               }
> +
> +               ret = synquacer_spi_enable(master);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable spi (%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = spi_master_resume(master);
> +       if (ret < 0)
> +               clk_disable_unprepare(sspi->clk);
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
> +                        synquacer_spi_resume);
> +
> +static const struct of_device_id synquacer_spi_of_match[] = {
> +       {.compatible = "socionext,synquacer-spi"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
> +

Add a device table for ACPI (SCX0004)

> +static struct platform_driver synquacer_spi_driver = {
> +       .driver = {
> +               .name = "synquacer-spi",
> +               .pm = &synquacer_spi_pm_ops,
> +               .of_match_table = synquacer_spi_of_match,

Add a .acpi_match_table member

> +       },
> +       .probe = synquacer_spi_probe,
> +       .remove = synquacer_spi_remove,
> +};
> +module_platform_driver(synquacer_spi_driver);
> +
> +MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_AUTHOR("Jassi Brar <jaswinder.singh@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.14.2
>
