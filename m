Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965572E336E
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 02:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgL1B3T (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 27 Dec 2020 20:29:19 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43562 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgL1B3T (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 27 Dec 2020 20:29:19 -0500
Received: from [10.130.0.71] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxPze7NOlfDGgGAA--.38S3;
        Mon, 28 Dec 2020 09:28:27 +0800 (CST)
Subject: Re: [PATCH v5 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver
 support
To:     Huacai Chen <chenhc@lemote.com>
References: <1608973923-8328-1-git-send-email-zhangqing@loongson.cn>
 <CAAhV-H4-7whXqTK59pT4zbkMZJUHSXMkr=jjkPAFrthc938BMQ@mail.gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>,
        linux-spi@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <f74496fe-b393-4960-d58a-74e7831424d1@loongson.cn>
Date:   Mon, 28 Dec 2020 09:28:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4-7whXqTK59pT4zbkMZJUHSXMkr=jjkPAFrthc938BMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxPze7NOlfDGgGAA--.38S3
X-Coremail-Antispam: 1UD129KBjvJXoW3KryxXF1UKw43CF4fZF45Awb_yoWkAw4UpF
        W8Wa1rtF48JF18Ar9Fqr4DWF9Iqr4Sqry7Ww47ta4Ikr90vF4kGF15Wr13CrZ3ZF4xCF1U
        ZF1j9rZIgF15XaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07j0wZ7UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Huacai

On 12/28/2020 08:32 AM, Huacai Chen wrote:
> Hi, Qing,
>
> On Sat, Dec 26, 2020 at 5:13 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>> The SPI controller has the following characteristics:
>>
>> - Full-duplex synchronous serial data transmission
>> - Support up to 4 variable length byte transmission
>> - Main mode support
>> - Mode failure generates an error flag and issues an interrupt request
>> - Double buffer receiver
>> - Serial clock with programmable polarity and phase
>> - SPI can be controlled in wait mode
>> - Support boot from SPI
>>
>> Use mtd_debug tool to earse/write/read /dev/mtd0 on development.
>>
>> eg:
>>
>> [root@linux mtd-utils-1.0.0]# mtd_debug erase /dev/mtd0 0x20000 0x40000
>> Erased 262144 bytes from address 0x00020000 in flash
>> [root@linux mtd-utils-1.0.0]# mtd_debug write /dev/mtd0 0x20000 13 1.img
>> Copied 13 bytes from 1.img to address 0x00020000 in flash
>> [root@linux mtd-utils-1.0.0]# mtd_debug read /dev/mtd0 0x20000 13 2.img
>> Copied 13 bytes from address 0x00020000 in flash to 2.img
>> [root@linux mtd-utils-1.0.0]# cmp -l 1.img 2.img
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>
>> v2:
>> - keep Kconfig and Makefile sorted
>> - make the entire comment a C++ one so things look more intentional
>> - Fix unclear indentation
>> - make conditional statements to improve legibility
>> - Don't use static inline
>> - the core handle message queue
>> - Add a new binding document
>> - Fix probe part mixed pdev and PCI
>>
>> v3:
>> - expose set_cs to the core and let it handle things
>> - replace transfer_one_message to transfer_one
>> - replace spi_alloc_master to devm_spi_alloc_master
>> - split out into prepare/unprepare_message
>> - releases pci regions before unregister master
>>
>> v4:
>> - names used in the manual
>> - rename ls7a_spi_do_transfer to ls7a_spi_setup_transfer
>> - change read the spcr and sper outside of this function
>> - mode configuration moved to prepare instead
>> - remove redundancy code about unprepare/prepare_message
>> - used 0x4 instead of 0x1,WFEMPTY instead of RFEMPTY
>>
>> v5:
>> - remove unnecessary blank lines
>>
>> ---
>>   drivers/spi/Kconfig    |   7 ++
>>   drivers/spi/Makefile   |   1 +
>>   drivers/spi/spi-ls7a.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 288 insertions(+)
>>   create mode 100644 drivers/spi/spi-ls7a.c
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index aadaea0..af7c0d4 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -413,6 +413,13 @@ config SPI_LP8841_RTC
>>            Say N here unless you plan to run the kernel on an ICP DAS
>>            LP-8x4x industrial computer.
>>
>> +config SPI_LS7A
>> +       tristate "Loongson LS7A SPI Controller Support"
>> +       depends on CPU_LOONGSON64 || COMPILE_TEST
>> +       help
>> +         This drivers supports the Loongson LS7A SPI controller in master
>> +         SPI mode.
>> +
>>   config SPI_MPC52xx
>>          tristate "Freescale MPC52xx SPI (non-PSC) controller support"
>>          depends on PPC_MPC52xx
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 6fea582..d015cf2 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -61,6 +61,7 @@ obj-$(CONFIG_SPI_LANTIQ_SSC)          += spi-lantiq-ssc.o
>>   obj-$(CONFIG_SPI_JCORE)                        += spi-jcore.o
>>   obj-$(CONFIG_SPI_LM70_LLP)             += spi-lm70llp.o
>>   obj-$(CONFIG_SPI_LP8841_RTC)           += spi-lp8841-rtc.o
>> +obj-$(CONFIG_SPI_LS7A)                 += spi-ls7a.o
>>   obj-$(CONFIG_SPI_MESON_SPICC)          += spi-meson-spicc.o
>>   obj-$(CONFIG_SPI_MESON_SPIFC)          += spi-meson-spifc.o
>>   obj-$(CONFIG_SPI_MPC512x_PSC)          += spi-mpc512x-psc.o
>> diff --git a/drivers/spi/spi-ls7a.c b/drivers/spi/spi-ls7a.c
>> new file mode 100644
>> index 0000000..d24b6d91
>> --- /dev/null
>> +++ b/drivers/spi/spi-ls7a.c
>> @@ -0,0 +1,280 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Loongson LS7A SPI Controller driver
>> +//
>> +// Copyright (C) 2020 Loongson Technology Corporation Limited.
>> +//
>> +
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/spi/spi.h>
>> +
>> +/* define spi register */
>> +#define        SPCR            0x00
>> +#define        SPSR            0x01
>> +#define        FIFO            0x02
>> +#define        SPER            0x03
>> +#define        SFC_PARAM       0x04
>> +#define        SFC_SOFTCS      0x05
>> +#define        SFC_TIMING      0x06
>> +
>> +struct ls7a_spi {
>> +       struct spi_master *master;
>> +       void __iomem *base;
>> +       unsigned int hz;
>> +       unsigned int mode;
>> +};
>> +
>> +static void ls7a_spi_write_reg(struct ls7a_spi *spi,
>> +                              unsigned char reg,
>> +                              unsigned char data)
>> +{
>> +       writeb(data, spi->base + reg);
>> +}
>> +
>> +static char ls7a_spi_read_reg(struct ls7a_spi *spi, unsigned char reg)
>> +{
>> +       return readb(spi->base + reg);
>> +}
>> +
>> +static int ls7a_spi_prepare_message(struct spi_master *master,
>> +                                   struct spi_message *msg)
>> +{
>> +       struct ls7a_spi *ls7a_spi;
>> +       struct spi_device *spi = msg->spi;
>> +       unsigned char val;
>> +
>> +       ls7a_spi = spi_master_get_devdata(master);
>> +
>> +       if (ls7a_spi->mode != spi->mode) {
>> +               val = ls7a_spi_read_reg(ls7a_spi, SPCR);
>> +               val &= ~0xc;
>> +               if (spi->mode & SPI_CPOL)
>> +                       val |= 8;
>> +               if (spi->mode & SPI_CPHA)
>> +                       val |= 4;
>> +               ls7a_spi_write_reg(ls7a_spi, SPCR, val);
>> +               val = ls7a_spi_read_reg(ls7a_spi, SPER);
>> +               ls7a_spi_write_reg(ls7a_spi, SPER, val);
>> +               ls7a_spi->mode = spi->mode;
>> +       }
>> +       return 0;
> I'm sorry that I hadn't review very carefully in V4 and you need to
> send another new version. In kernel code we usually keep a blank line
> before the last "return xxx" in a function, and there are several
> other places with the same problem.
>
> Huacai
    Thank you again for your reply and suggestions,
    I will send v6 in the soon.

    Thanks,
    -Qing
>
>> +}
>> +
>> +static void ls7a_spi_set_cs(struct spi_device *spi, bool enable)
>> +{
>> +       struct ls7a_spi *ls7a_spi;
>> +       int cs;
>> +
>> +       ls7a_spi = spi_master_get_devdata(spi->master);
>> +
>> +       cs = ls7a_spi_read_reg(ls7a_spi, SFC_SOFTCS) & ~(0x11 << spi->chip_select);
>> +
>> +       if (!!(spi->mode & SPI_CS_HIGH) == enable)
>> +               ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x1 << spi->chip_select) | cs);
>> +       else
>> +               ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x11 << spi->chip_select) | cs);
>> +}
>> +
>> +static int ls7a_spi_setup_transfer(struct spi_device *spi,
>> +                                  struct spi_transfer *t)
>> +{
>> +       unsigned int hz;
>> +       unsigned int div, div_tmp;
>> +       unsigned int bit;
>> +       unsigned long clk;
>> +       unsigned char val;
>> +       unsigned char spcr, sper;
>> +       const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
>> +       struct ls7a_spi *ls7a_spi;
>> +
>> +       ls7a_spi = spi_master_get_devdata(spi->master);
>> +
>> +       if (t) {
>> +               hz = t->speed_hz;
>> +               if (!hz)
>> +                       hz = spi->max_speed_hz;
>> +       } else {
>> +               hz = spi->max_speed_hz;
>> +       }
>> +
>> +       if (hz & (ls7a_spi->hz != hz)) {
>> +               clk = 100000000;
>> +
>> +               div = DIV_ROUND_UP(clk, hz);
>> +               if (div < 2)
>> +                       div = 2;
>> +               if (div > 4096)
>> +                       div = 4096;
>> +
>> +               bit = fls(div) - 1;
>> +               if ((1 << bit) == div)
>> +                       bit--;
>> +               div_tmp = rdiv[bit];
>> +
>> +               dev_dbg(&spi->dev, "clk = %ld hz = %d div_tmp = %d bit = %d\n",
>> +                       clk, hz, div_tmp, bit);
>> +
>> +               ls7a_spi->hz = hz;
>> +               spcr = div_tmp & 3;
>> +               sper = (div_tmp >> 2) & 3;
>> +
>> +               val = ls7a_spi_read_reg(ls7a_spi, SPCR);
>> +               ls7a_spi_write_reg(ls7a_spi, SPCR, (val & ~3) | spcr);
>> +               val = ls7a_spi_read_reg(ls7a_spi, SPER);
>> +               ls7a_spi_write_reg(ls7a_spi, SPER, (val & ~3) | sper);
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int ls7a_spi_setup(struct spi_device *spi)
>> +{
>> +       return  ls7a_spi_setup_transfer(spi, NULL);
>> +}
>> +
>> +static int ls7a_spi_write_read_8bit(struct spi_device *spi,
>> +                                   const u8 **tx_buf, u8 **rx_buf,
>> +                                   unsigned int num)
>> +{
>> +       struct ls7a_spi *ls7a_spi;
>> +
>> +       ls7a_spi = spi_master_get_devdata(spi->master);
>> +
>> +       if (tx_buf && *tx_buf) {
>> +               ls7a_spi_write_reg(ls7a_spi, FIFO, *((*tx_buf)++));
>> +
>> +               while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x4) == 1)
>> +                       ;
>> +       } else {
>> +               ls7a_spi_write_reg(ls7a_spi, FIFO, 0);
>> +
>> +               while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) == 1)
>> +                       ;
>> +       }
>> +
>> +       if (rx_buf && *rx_buf)
>> +               *(*rx_buf)++ = ls7a_spi_read_reg(ls7a_spi, FIFO);
>> +       else
>> +               ls7a_spi_read_reg(ls7a_spi, FIFO);
>> +
>> +       return 1;
>> +}
>> +
>> +static unsigned int ls7a_spi_write_read(struct spi_device *spi,
>> +                                       struct spi_transfer *xfer)
>> +{
>> +       unsigned int count;
>> +       const u8 *tx = xfer->tx_buf;
>> +       u8 *rx = xfer->rx_buf;
>> +
>> +       count = xfer->len;
>> +
>> +       do {
>> +               if (ls7a_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
>> +                       goto out;
>> +               count--;
>> +       } while (count);
>> +
>> +out:
>> +       return xfer->len - count;
>> +}
>> +
>> +static int  ls7a_spi_transfer_one(struct spi_master *master,
>> +                                 struct spi_device *spi,
>> +                                 struct spi_transfer *t)
>> +{
>> +       int status = 0;
>> +
>> +       status = ls7a_spi_setup_transfer(spi, t);
>> +       if (status < 0)
>> +               return status;
>> +
>> +       if (t->len)
>> +               ls7a_spi_write_read(spi, t);
>> +
>> +       return status;
>> +}
>> +
>> +static int ls7a_spi_pci_probe(struct pci_dev *pdev,
>> +                             const struct pci_device_id *ent)
>> +{
>> +       struct spi_master *master;
>> +       struct ls7a_spi *spi;
>> +       int ret;
>> +
>> +       master = devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
>> +       if (!master)
>> +               return -ENOMEM;
>> +
>> +       spi = spi_master_get_devdata(master);
>> +       ret = pcim_enable_device(pdev);
>> +       if (ret)
>> +               goto err_free_master;
>> +
>> +       ret = pci_request_regions(pdev, "ls7a-spi");
>> +       if (ret)
>> +               goto err_free_master;
>> +
>> +       spi->base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
>> +       if (!spi->base) {
>> +               ret = -EINVAL;
>> +               goto err_free_master;
>> +       }
>> +       ls7a_spi_write_reg(spi, SPCR, 0x51);
>> +       ls7a_spi_write_reg(spi, SPER, 0x00);
>> +       ls7a_spi_write_reg(spi, SFC_TIMING, 0x01);
>> +       ls7a_spi_write_reg(spi, SFC_PARAM, 0x40);
>> +       spi->mode = 0;
>> +
>> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>> +       master->set_cs = ls7a_spi_set_cs;
>> +       master->prepare_message = ls7a_spi_prepare_message;
>> +       master->setup = ls7a_spi_setup;
>> +       master->transfer_one = ls7a_spi_transfer_one;
>> +       master->bits_per_word_mask = SPI_BPW_MASK(8);
>> +       master->num_chipselect = 4;
>> +       master->dev.of_node = pdev->dev.of_node;
>> +
>> +       spi->master = master;
>> +
>> +       pci_set_drvdata(pdev, master);
>> +
>> +       ret = spi_register_master(master);
>> +       if (ret)
>> +               goto err_free_master;
>> +
>> +       return 0;
>> +
>> +err_free_master:
>> +       pci_release_regions(pdev);
>> +       return ret;
>> +}
>> +
>> +static void ls7a_spi_pci_remove(struct pci_dev *pdev)
>> +{
>> +       struct spi_master *master = pci_get_drvdata(pdev);
>> +
>> +       spi_unregister_master(master);
>> +       pci_release_regions(pdev);
>> +}
>> +
>> +static const struct pci_device_id ls7a_spi_pci_id_table[] = {
>> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
>> +       { 0, }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(pci, ls7a_spi_pci_id_table);
>> +
>> +static struct pci_driver ls7a_spi_pci_driver = {
>> +       .name           = "ls7a-spi",
>> +       .id_table       = ls7a_spi_pci_id_table,
>> +       .probe          = ls7a_spi_pci_probe,
>> +       .remove         = ls7a_spi_pci_remove,
>> +};
>> +
>> +module_pci_driver(ls7a_spi_pci_driver);
>> +
>> +MODULE_AUTHOR("Juxin Gao <gaojuxin@loongson.cn>");
>> +MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
>> +MODULE_DESCRIPTION("Loongson LS7A SPI controller driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.1.0
>>

