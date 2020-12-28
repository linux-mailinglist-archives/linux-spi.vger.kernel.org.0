Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469082E3359
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgL1Adk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 19:33:40 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:39126 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgL1Adj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Dec 2020 19:33:39 -0500
Received: by mail-io1-f53.google.com with SMTP id d9so8102229iob.6;
        Sun, 27 Dec 2020 16:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTV2l2x7ugC6vM/oqCVScqutVA7QdYiBogbuEiIVRWU=;
        b=BhDRYdnlUYCCgTGgso7Y5yCf5eMTdquy+uq9u33NKKzH5RTiHERmmUoRxpPEfTB7f5
         nnd/2F5UKhFKLLFLEjEuWf9I22X3f5G769VunO0TpNMCp/JDlM9/66ADK9YwqjyXSVeS
         BEU3W5CTqwl3MnQkg69JvRNIncNOX95O50nM5Qnuk6FIFF2fsnJMfe0MJ9j0MtlgJU9m
         tA1KVs60ZKoqNJVs4EJbbo5xiLBdoRxovJExlfaCKc7FdddM5ibm3gF91X1jBSj9Fbfa
         LdAnYMXCU6nAO13H9A2/pvysgrjqUgE/5aUg0TZV6GDyvoUPTaLavCm8EVWMXvI16PSy
         fAZA==
X-Gm-Message-State: AOAM532zDEHTL7Xo+F9VhJ89p5DHV6vboK96i0z12CjAzCFP7Igni7Yq
        nj+/qici0gEO3Mio5Ckp2PtV5eW86s29TNtCiXI=
X-Google-Smtp-Source: ABdhPJygpeNiGdAlIUvRhUOTpgaqY99nURoCFe4Ik9EQOPunW4MgU6UB1HLPyinshKBqgCp4taMlVUlEIlNMJvV1MPo=
X-Received: by 2002:a5e:9612:: with SMTP id a18mr34761355ioq.13.1609115577726;
 Sun, 27 Dec 2020 16:32:57 -0800 (PST)
MIME-Version: 1.0
References: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn>
In-Reply-To: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 28 Dec 2020 08:32:46 +0800
Message-ID: <CAAhV-H4-7whXqTK59pT4zbkMZJUHSXMkr=jjkPAFrthc938BMQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Qing,

On Sat, Dec 26, 2020 at 5:13 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> The SPI controller has the following characteristics:
>
> - Full-duplex synchronous serial data transmission
> - Support up to 4 variable length byte transmission
> - Main mode support
> - Mode failure generates an error flag and issues an interrupt request
> - Double buffer receiver
> - Serial clock with programmable polarity and phase
> - SPI can be controlled in wait mode
> - Support boot from SPI
>
> Use mtd_debug tool to earse/write/read /dev/mtd0 on development.
>
> eg:
>
> [root@linux mtd-utils-1.0.0]# mtd_debug erase /dev/mtd0 0x20000 0x40000
> Erased 262144 bytes from address 0x00020000 in flash
> [root@linux mtd-utils-1.0.0]# mtd_debug write /dev/mtd0 0x20000 13 1.img
> Copied 13 bytes from 1.img to address 0x00020000 in flash
> [root@linux mtd-utils-1.0.0]# mtd_debug read /dev/mtd0 0x20000 13 2.img
> Copied 13 bytes from address 0x00020000 in flash to 2.img
> [root@linux mtd-utils-1.0.0]# cmp -l 1.img 2.img
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v2:
> - keep Kconfig and Makefile sorted
> - make the entire comment a C++ one so things look more intentional
> - Fix unclear indentation
> - make conditional statements to improve legibility
> - Don't use static inline
> - the core handle message queue
> - Add a new binding document
> - Fix probe part mixed pdev and PCI
>
> v3:
> - expose set_cs to the core and let it handle things
> - replace transfer_one_message to transfer_one
> - replace spi_alloc_master to devm_spi_alloc_master
> - split out into prepare/unprepare_message
> - releases pci regions before unregister master
>
> v4:
> - names used in the manual
> - rename ls7a_spi_do_transfer to ls7a_spi_setup_transfer
> - change read the spcr and sper outside of this function
> - mode configuration moved to prepare instead
> - remove redundancy code about unprepare/prepare_message
> - used 0x4 instead of 0x1,WFEMPTY instead of RFEMPTY
>
> v5:
> - remove unnecessary blank lines
>
> ---
>  drivers/spi/Kconfig    |   7 ++
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/spi-ls7a.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 288 insertions(+)
>  create mode 100644 drivers/spi/spi-ls7a.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index aadaea0..af7c0d4 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -413,6 +413,13 @@ config SPI_LP8841_RTC
>           Say N here unless you plan to run the kernel on an ICP DAS
>           LP-8x4x industrial computer.
>
> +config SPI_LS7A
> +       tristate "Loongson LS7A SPI Controller Support"
> +       depends on CPU_LOONGSON64 || COMPILE_TEST
> +       help
> +         This drivers supports the Loongson LS7A SPI controller in master
> +         SPI mode.
> +
>  config SPI_MPC52xx
>         tristate "Freescale MPC52xx SPI (non-PSC) controller support"
>         depends on PPC_MPC52xx
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 6fea582..d015cf2 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_SPI_LANTIQ_SSC)          += spi-lantiq-ssc.o
>  obj-$(CONFIG_SPI_JCORE)                        += spi-jcore.o
>  obj-$(CONFIG_SPI_LM70_LLP)             += spi-lm70llp.o
>  obj-$(CONFIG_SPI_LP8841_RTC)           += spi-lp8841-rtc.o
> +obj-$(CONFIG_SPI_LS7A)                 += spi-ls7a.o
>  obj-$(CONFIG_SPI_MESON_SPICC)          += spi-meson-spicc.o
>  obj-$(CONFIG_SPI_MESON_SPIFC)          += spi-meson-spifc.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)          += spi-mpc512x-psc.o
> diff --git a/drivers/spi/spi-ls7a.c b/drivers/spi/spi-ls7a.c
> new file mode 100644
> index 0000000..d24b6d91
> --- /dev/null
> +++ b/drivers/spi/spi-ls7a.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Loongson LS7A SPI Controller driver
> +//
> +// Copyright (C) 2020 Loongson Technology Corporation Limited.
> +//
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/spi/spi.h>
> +
> +/* define spi register */
> +#define        SPCR            0x00
> +#define        SPSR            0x01
> +#define        FIFO            0x02
> +#define        SPER            0x03
> +#define        SFC_PARAM       0x04
> +#define        SFC_SOFTCS      0x05
> +#define        SFC_TIMING      0x06
> +
> +struct ls7a_spi {
> +       struct spi_master *master;
> +       void __iomem *base;
> +       unsigned int hz;
> +       unsigned int mode;
> +};
> +
> +static void ls7a_spi_write_reg(struct ls7a_spi *spi,
> +                              unsigned char reg,
> +                              unsigned char data)
> +{
> +       writeb(data, spi->base + reg);
> +}
> +
> +static char ls7a_spi_read_reg(struct ls7a_spi *spi, unsigned char reg)
> +{
> +       return readb(spi->base + reg);
> +}
> +
> +static int ls7a_spi_prepare_message(struct spi_master *master,
> +                                   struct spi_message *msg)
> +{
> +       struct ls7a_spi *ls7a_spi;
> +       struct spi_device *spi = msg->spi;
> +       unsigned char val;
> +
> +       ls7a_spi = spi_master_get_devdata(master);
> +
> +       if (ls7a_spi->mode != spi->mode) {
> +               val = ls7a_spi_read_reg(ls7a_spi, SPCR);
> +               val &= ~0xc;
> +               if (spi->mode & SPI_CPOL)
> +                       val |= 8;
> +               if (spi->mode & SPI_CPHA)
> +                       val |= 4;
> +               ls7a_spi_write_reg(ls7a_spi, SPCR, val);
> +               val = ls7a_spi_read_reg(ls7a_spi, SPER);
> +               ls7a_spi_write_reg(ls7a_spi, SPER, val);
> +               ls7a_spi->mode = spi->mode;
> +       }
> +       return 0;
I'm sorry that I hadn't review very carefully in V4 and you need to
send another new version. In kernel code we usually keep a blank line
before the last "return xxx" in a function, and there are several
other places with the same problem.

Huacai

> +}
> +
> +static void ls7a_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct ls7a_spi *ls7a_spi;
> +       int cs;
> +
> +       ls7a_spi = spi_master_get_devdata(spi->master);
> +
> +       cs = ls7a_spi_read_reg(ls7a_spi, SFC_SOFTCS) & ~(0x11 << spi->chip_select);
> +
> +       if (!!(spi->mode & SPI_CS_HIGH) == enable)
> +               ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x1 << spi->chip_select) | cs);
> +       else
> +               ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x11 << spi->chip_select) | cs);
> +}
> +
> +static int ls7a_spi_setup_transfer(struct spi_device *spi,
> +                                  struct spi_transfer *t)
> +{
> +       unsigned int hz;
> +       unsigned int div, div_tmp;
> +       unsigned int bit;
> +       unsigned long clk;
> +       unsigned char val;
> +       unsigned char spcr, sper;
> +       const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> +       struct ls7a_spi *ls7a_spi;
> +
> +       ls7a_spi = spi_master_get_devdata(spi->master);
> +
> +       if (t) {
> +               hz = t->speed_hz;
> +               if (!hz)
> +                       hz = spi->max_speed_hz;
> +       } else {
> +               hz = spi->max_speed_hz;
> +       }
> +
> +       if (hz & (ls7a_spi->hz != hz)) {
> +               clk = 100000000;
> +
> +               div = DIV_ROUND_UP(clk, hz);
> +               if (div < 2)
> +                       div = 2;
> +               if (div > 4096)
> +                       div = 4096;
> +
> +               bit = fls(div) - 1;
> +               if ((1 << bit) == div)
> +                       bit--;
> +               div_tmp = rdiv[bit];
> +
> +               dev_dbg(&spi->dev, "clk = %ld hz = %d div_tmp = %d bit = %d\n",
> +                       clk, hz, div_tmp, bit);
> +
> +               ls7a_spi->hz = hz;
> +               spcr = div_tmp & 3;
> +               sper = (div_tmp >> 2) & 3;
> +
> +               val = ls7a_spi_read_reg(ls7a_spi, SPCR);
> +               ls7a_spi_write_reg(ls7a_spi, SPCR, (val & ~3) | spcr);
> +               val = ls7a_spi_read_reg(ls7a_spi, SPER);
> +               ls7a_spi_write_reg(ls7a_spi, SPER, (val & ~3) | sper);
> +       }
> +       return 0;
> +}
> +
> +static int ls7a_spi_setup(struct spi_device *spi)
> +{
> +       return  ls7a_spi_setup_transfer(spi, NULL);
> +}
> +
> +static int ls7a_spi_write_read_8bit(struct spi_device *spi,
> +                                   const u8 **tx_buf, u8 **rx_buf,
> +                                   unsigned int num)
> +{
> +       struct ls7a_spi *ls7a_spi;
> +
> +       ls7a_spi = spi_master_get_devdata(spi->master);
> +
> +       if (tx_buf && *tx_buf) {
> +               ls7a_spi_write_reg(ls7a_spi, FIFO, *((*tx_buf)++));
> +
> +               while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x4) == 1)
> +                       ;
> +       } else {
> +               ls7a_spi_write_reg(ls7a_spi, FIFO, 0);
> +
> +               while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) == 1)
> +                       ;
> +       }
> +
> +       if (rx_buf && *rx_buf)
> +               *(*rx_buf)++ = ls7a_spi_read_reg(ls7a_spi, FIFO);
> +       else
> +               ls7a_spi_read_reg(ls7a_spi, FIFO);
> +
> +       return 1;
> +}
> +
> +static unsigned int ls7a_spi_write_read(struct spi_device *spi,
> +                                       struct spi_transfer *xfer)
> +{
> +       unsigned int count;
> +       const u8 *tx = xfer->tx_buf;
> +       u8 *rx = xfer->rx_buf;
> +
> +       count = xfer->len;
> +
> +       do {
> +               if (ls7a_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
> +                       goto out;
> +               count--;
> +       } while (count);
> +
> +out:
> +       return xfer->len - count;
> +}
> +
> +static int  ls7a_spi_transfer_one(struct spi_master *master,
> +                                 struct spi_device *spi,
> +                                 struct spi_transfer *t)
> +{
> +       int status = 0;
> +
> +       status = ls7a_spi_setup_transfer(spi, t);
> +       if (status < 0)
> +               return status;
> +
> +       if (t->len)
> +               ls7a_spi_write_read(spi, t);
> +
> +       return status;
> +}
> +
> +static int ls7a_spi_pci_probe(struct pci_dev *pdev,
> +                             const struct pci_device_id *ent)
> +{
> +       struct spi_master *master;
> +       struct ls7a_spi *spi;
> +       int ret;
> +
> +       master = devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       spi = spi_master_get_devdata(master);
> +       ret = pcim_enable_device(pdev);
> +       if (ret)
> +               goto err_free_master;
> +
> +       ret = pci_request_regions(pdev, "ls7a-spi");
> +       if (ret)
> +               goto err_free_master;
> +
> +       spi->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +       if (!spi->base) {
> +               ret = -EINVAL;
> +               goto err_free_master;
> +       }
> +       ls7a_spi_write_reg(spi, SPCR, 0x51);
> +       ls7a_spi_write_reg(spi, SPER, 0x00);
> +       ls7a_spi_write_reg(spi, SFC_TIMING, 0x01);
> +       ls7a_spi_write_reg(spi, SFC_PARAM, 0x40);
> +       spi->mode = 0;
> +
> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +       master->set_cs = ls7a_spi_set_cs;
> +       master->prepare_message = ls7a_spi_prepare_message;
> +       master->setup = ls7a_spi_setup;
> +       master->transfer_one = ls7a_spi_transfer_one;
> +       master->bits_per_word_mask = SPI_BPW_MASK(8);
> +       master->num_chipselect = 4;
> +       master->dev.of_node = pdev->dev.of_node;
> +
> +       spi->master = master;
> +
> +       pci_set_drvdata(pdev, master);
> +
> +       ret = spi_register_master(master);
> +       if (ret)
> +               goto err_free_master;
> +
> +       return 0;
> +
> +err_free_master:
> +       pci_release_regions(pdev);
> +       return ret;
> +}
> +
> +static void ls7a_spi_pci_remove(struct pci_dev *pdev)
> +{
> +       struct spi_master *master = pci_get_drvdata(pdev);
> +
> +       spi_unregister_master(master);
> +       pci_release_regions(pdev);
> +}
> +
> +static const struct pci_device_id ls7a_spi_pci_id_table[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +       { 0, }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, ls7a_spi_pci_id_table);
> +
> +static struct pci_driver ls7a_spi_pci_driver = {
> +       .name           = "ls7a-spi",
> +       .id_table       = ls7a_spi_pci_id_table,
> +       .probe          = ls7a_spi_pci_probe,
> +       .remove         = ls7a_spi_pci_remove,
> +};
> +
> +module_pci_driver(ls7a_spi_pci_driver);
> +
> +MODULE_AUTHOR("Juxin Gao <gaojuxin@loongson.cn>");
> +MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson LS7A SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.1.0
>
