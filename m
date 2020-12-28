Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E42E3533
	for <lists+linux-spi@lfdr.de>; Mon, 28 Dec 2020 09:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgL1Imu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 03:42:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:55027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgL1Imu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 28 Dec 2020 03:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609144858;
        bh=yueslRjWgXClKba6drIkiEKHVz8XJKFHeh1ocriHqGs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WSKU8QpAnJPGPjkPV4vjCLPGQ9fR825ni5aNe+kanGNn7ybtgxQZrhtvjq122F64E
         rn2Okc+mHVL6xZ/sqhqcO60FBmr5bdhgiia3ptus5zpNcOnoNNfqaJJMmuvI47AKX9
         20Is6TfhcrfYIIJ8sxm37FVWcS53pSwJN5GIuN7A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.44] ([95.91.192.147]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1kDbiF33W5-00p4ld; Mon, 28
 Dec 2020 09:40:58 +0100
Subject: Re: [PATCH v6 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver
 support
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, yangtiezhu@loongson.cn,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
From:   Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <9062b195-b469-42b0-c9f4-412f94df1cbb@rempel-privat.de>
Date:   Mon, 28 Dec 2020 09:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1609124381-9107-1-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5WdbhSiUoWSmQhw4TFQ2sM6GQV+jLCAWwLfIeuO/RfhLWhPXtJD
 sOAly1AlTZ7CP+8D9YIyE3IDJo1OTkVrI6L5oiImkQSKnv5c4XceOlQ/hMSB7DLogIjSeiw
 1mt7oM2NvQE9PD8j+jrQdLS9FwbCqZr7VDRFYqoR+Hw38Z9LkpoNbnH8oid8jmrW2ArX4vk
 lKnEuNPVNrS1rkAz4Q3mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rOjprSdOP48=:Zy83fhwvhBik1ap5paTYOd
 OX4FyijWOK0lf7N60xt3nue94YexWOdiqB0hjQzBPFvPCzdTbO61DAiy8VvaFsur8a0+O1CJ8
 lEkOfaKgS/goPdZ8GAUAG1Csn7nk6aMGmLZUuMAqD9LpCj4JWf1Ki+x9E/EIuooaZo8mnYPP6
 w6xy2CpbCWvZQSaw9L3lXeEwRukRxOg6Av06TdPKnViauVp5VT3UF8tfp1sJInaEpRiwhmdO1
 HDiwAS4lCmB1EVQCH1CO1EQ/u4kTIseGfAkf3dGNskYc/p3tzqUQINNrLunm0WmB7MnZQil0G
 Nqcx0YH1lBSxUfYsY/UZJB3yL562RDu0WIJpNaCFtve/RDrZZBeGZ9wBQ7sZiWg6V0DdKcKv8
 F6iGI/94SrKxhUEa8FzhrZ5Gm4ZAt7iIBwbC7lpDWffDyb8luNRHpKUQ0144ZPosqsvQaKjsW
 4MU4kiFknx1R00hglHOIgQpAzIe+y3cm/lN9LJHQAhmE9CoaKRQNaJmMpSpBi7gmB6llJxSfO
 tv9E/Zfu8KdmNEFXrNuHUw51y+pORGCxZLVW9BS7bFhBpCHncslVZuw83JBbgZaRF3PCRzOln
 xlNQgQD2gwkQkuP8cnhxg6z8bNrdINFCQd+FqP97z82H1vnryAnGZnxmIRObH1u3SSp7M4EPK
 OuK1QkG22yKHvFGGC/h9SkhiR/G/yh3JusTggGTEJaPnHCAnTvRJAhGeTrLJoWKzxsReKUCcq
 fBezIINRoCXB0++Yc29+UahfLgz2KXc6QpGtMd8Ra5wHVzsSyDUhKeYbqHuhiFI7l32+kx4QH
 s6eK6hkXrT0YSoQ99FjRZOLGSf3OlCENc+RtJbDeeKeoZ5mQJA2EanF/wg0bp5FZlF2SGMm3Y
 6BZZ6XwgF9fE6UbN2zcg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 28.12.20 um 03:59 schrieb Qing Zhang:
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
> v6:
> - keep blank line before the last "return xxx"
>
> ---
>  drivers/spi/Kconfig    |   7 ++
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/spi-ls7a.c | 282 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/spi/spi-ls7a.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index aadaea0..af7c0d4 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -413,6 +413,13 @@ config SPI_LP8841_RTC
>  	  Say N here unless you plan to run the kernel on an ICP DAS
>  	  LP-8x4x industrial computer.
>
> +config SPI_LS7A
> +	tristate "Loongson LS7A SPI Controller Support"
> +	depends on CPU_LOONGSON64 || COMPILE_TEST
> +	help
> +	  This drivers supports the Loongson LS7A SPI controller in master
> +	  SPI mode.
> +
>  config SPI_MPC52xx
>  	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
>  	depends on PPC_MPC52xx
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 6fea582..d015cf2 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_SPI_LANTIQ_SSC)		+=3D spi-lantiq-ssc.o
>  obj-$(CONFIG_SPI_JCORE)			+=3D spi-jcore.o
>  obj-$(CONFIG_SPI_LM70_LLP)		+=3D spi-lm70llp.o
>  obj-$(CONFIG_SPI_LP8841_RTC)		+=3D spi-lp8841-rtc.o
> +obj-$(CONFIG_SPI_LS7A)			+=3D spi-ls7a.o
>  obj-$(CONFIG_SPI_MESON_SPICC)		+=3D spi-meson-spicc.o
>  obj-$(CONFIG_SPI_MESON_SPIFC)		+=3D spi-meson-spifc.o
>  obj-$(CONFIG_SPI_MPC512x_PSC)		+=3D spi-mpc512x-psc.o
> diff --git a/drivers/spi/spi-ls7a.c b/drivers/spi/spi-ls7a.c
> new file mode 100644
> index 0000000..8592b85
> --- /dev/null
> +++ b/drivers/spi/spi-ls7a.c
> @@ -0,0 +1,282 @@
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
> +#define	SPCR		0x00
> +#define	SPSR		0x01
> +#define	FIFO		0x02
> +#define	SPER		0x03
> +#define	SFC_PARAM	0x04
> +#define	SFC_SOFTCS	0x05
> +#define	SFC_TIMING	0x06
> +
> +struct ls7a_spi {
> +	struct spi_master *master;
> +	void __iomem *base;
> +	unsigned int hz;
> +	unsigned int mode;
> +};
> +
> +static void ls7a_spi_write_reg(struct ls7a_spi *spi,
> +			       unsigned char reg,
> +			       unsigned char data)
> +{
> +	writeb(data, spi->base + reg);
> +}
> +
> +static char ls7a_spi_read_reg(struct ls7a_spi *spi, unsigned char reg)
> +{
> +	return readb(spi->base + reg);
> +}
> +
> +static int ls7a_spi_prepare_message(struct spi_master *master,
> +				    struct spi_message *msg)
> +{
> +	struct ls7a_spi *ls7a_spi;
> +	struct spi_device *spi =3D msg->spi;
> +	unsigned char val;
> +
> +	ls7a_spi =3D spi_master_get_devdata(master);
> +
> +	if (ls7a_spi->mode !=3D spi->mode) {
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPCR);
> +		val &=3D ~0xc;
> +		if (spi->mode & SPI_CPOL)
> +			val |=3D 8;
> +		if (spi->mode & SPI_CPHA)
> +			val |=3D 4;
> +		ls7a_spi_write_reg(ls7a_spi, SPCR, val);
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPER);
> +		ls7a_spi_write_reg(ls7a_spi, SPER, val);
> +		ls7a_spi->mode =3D spi->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ls7a_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct ls7a_spi *ls7a_spi;
> +	int cs;
> +
> +	ls7a_spi =3D spi_master_get_devdata(spi->master);
> +
> +	cs =3D ls7a_spi_read_reg(ls7a_spi, SFC_SOFTCS) & ~(0x11 << spi->chip_s=
elect);
> +
> +	if (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable)
> +		ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x1 << spi->chip_select) | =
cs);
> +	else
> +		ls7a_spi_write_reg(ls7a_spi, SFC_SOFTCS, (0x11 << spi->chip_select) |=
 cs);
> +}
> +
> +static int ls7a_spi_setup_transfer(struct spi_device *spi,
> +				   struct spi_transfer *t)
> +{
> +	unsigned int hz;
> +	unsigned int div, div_tmp;
> +	unsigned int bit;
> +	unsigned long clk;
> +	unsigned char val;
> +	unsigned char spcr, sper;
> +	const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> +	struct ls7a_spi *ls7a_spi;
> +
> +	ls7a_spi =3D spi_master_get_devdata(spi->master);
> +
> +	if (t) {
> +		hz =3D t->speed_hz;
> +		if (!hz)
> +			hz =3D spi->max_speed_hz;
> +	} else {
> +		hz =3D spi->max_speed_hz;
> +	}
> +
> +	if (hz & (ls7a_spi->hz !=3D hz)) {
> +		clk =3D 100000000;

Default clock frequency should not be here. As i already noted, LS7A has
configurable clock source for SPI core. If you can implement proper clk
framework support now, then assign it at least in the probe, not here.

Did you actually compared the calculated frequency by software and
measured actual frequency on the SPI bus? I still assume, you have 50MHz
input, not 100MHz.

> +
> +		div =3D DIV_ROUND_UP(clk, hz);
> +		if (div < 2)
> +			div =3D 2;
> +		if (div > 4096)
> +			div =3D 4096;
> +
> +		bit =3D fls(div) - 1;
> +		if ((1 << bit) =3D=3D div)
> +			bit--;
> +		div_tmp =3D rdiv[bit];
> +		dev_dbg(&spi->dev, "clk =3D %ld hz =3D %d div_tmp =3D %d bit =3D %d\n=
",
> +			clk, hz, div_tmp, bit);
> +
> +		ls7a_spi->hz =3D hz;
> +		spcr =3D div_tmp & 3;
> +		sper =3D (div_tmp >> 2) & 3;
> +
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPCR);
> +		ls7a_spi_write_reg(ls7a_spi, SPCR, (val & ~3) | spcr);
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPER);
> +		ls7a_spi_write_reg(ls7a_spi, SPER, (val & ~3) | sper);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ls7a_spi_setup(struct spi_device *spi)
> +{
> +	return	ls7a_spi_setup_transfer(spi, NULL);
> +}
> +
> +static int ls7a_spi_write_read_8bit(struct spi_device *spi,
> +				    const u8 **tx_buf, u8 **rx_buf,
> +				    unsigned int num)
> +{
> +	struct ls7a_spi *ls7a_spi;
> +
> +	ls7a_spi =3D spi_master_get_devdata(spi->master);
> +
> +	if (tx_buf && *tx_buf) {
> +		ls7a_spi_write_reg(ls7a_spi, FIFO, *((*tx_buf)++));
> +
> +		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x4) =3D=3D 1)

Please use define instead of magin number. It means, here should be
WFEMPTY instead of 0x4. The same is for all other part in this driver.

Beside, what is the size of this FIFO? Currently you are transferring
8bits at time with busy waiting. So, FIFO is not used. Since the SPI bus
is slow, and the CPU on LS7A system is fast, this driver can probably be
used as coffee heater.
To make use of the FIFO, you need to test if FIFO is full, before
writing to it. And if it is full, use interrupt or at least proper
polling function. For example: readb_poll_timeout()

Timeout is needed to avoid blocked system, just in case SPI failed.

> +			;
> +	} else {
> +		ls7a_spi_write_reg(ls7a_spi, FIFO, 0);
> +
> +		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) =3D=3D 1)
> +			;
> +	}
> +
> +	if (rx_buf && *rx_buf)
> +		*(*rx_buf)++ =3D ls7a_spi_read_reg(ls7a_spi, FIFO);
> +	else
> +		ls7a_spi_read_reg(ls7a_spi, FIFO);
> +
> +	return 1;
> +}
> +
> +static unsigned int ls7a_spi_write_read(struct spi_device *spi,
> +					struct spi_transfer *xfer)
> +{
> +	unsigned int count;
> +	const u8 *tx =3D xfer->tx_buf;
> +	u8 *rx =3D xfer->rx_buf;
> +
> +	count =3D xfer->len;
> +
> +	do {
> +		if (ls7a_spi_write_read_8bit(spi, &tx, &rx, count) < 0)

val < 0 means, you expect here an error, but it is ignored. with
poll_timout you will be able to get a real error, please do not ignore it.

> +			goto out;
> +		count--;
> +	} while (count);
> +
> +out:
> +	return xfer->len - count;
> +}
> +
> +static int  ls7a_spi_transfer_one(struct spi_master *master,
> +				  struct spi_device *spi,
> +				  struct spi_transfer *t)
> +{
> +	int status =3D 0;
> +
> +	status =3D ls7a_spi_setup_transfer(spi, t);
> +	if (status < 0)
> +		return status;
> +
> +	if (t->len)
> +		ls7a_spi_write_read(spi, t);
> +
> +	return status;
> +}
> +
> +static int ls7a_spi_pci_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *ent)
> +{
> +	struct spi_master *master;
> +	struct ls7a_spi *spi;
> +	int ret;
> +
> +	master =3D devm_spi_alloc_master(&pdev->dev, sizeof(*spi));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	spi =3D spi_master_get_devdata(master);
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		goto err_free_master;
> +
> +	ret =3D pci_request_regions(pdev, "ls7a-spi");
> +	if (ret)
> +		goto err_free_master;
> +
> +	spi->base =3D pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
> +	if (!spi->base) {
> +		ret =3D -EINVAL;
> +		goto err_free_master;
> +	}
> +	ls7a_spi_write_reg(spi, SPCR, 0x51);
> +	ls7a_spi_write_reg(spi, SPER, 0x00);
> +	ls7a_spi_write_reg(spi, SFC_TIMING, 0x01);

are there any reason to configure time for the SPI_FLASH mode?

> +	ls7a_spi_write_reg(spi, SFC_PARAM, 0x40);

And then disable SPI_FLASH mode at this step?

The main reason I requested you to avoid magic numbers and add some
comments is: to make you and reviewers understand what is happening here.

> +	spi->mode =3D 0;
> +
> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +	master->set_cs =3D ls7a_spi_set_cs;
> +	master->prepare_message =3D ls7a_spi_prepare_message;
> +	master->setup =3D ls7a_spi_setup;
> +	master->transfer_one =3D ls7a_spi_transfer_one;
> +	master->bits_per_word_mask =3D SPI_BPW_MASK(8);
> +	master->num_chipselect =3D 4;
> +	master->dev.of_node =3D pdev->dev.of_node;
> +
> +	spi->master =3D master;
> +
> +	pci_set_drvdata(pdev, master);
> +
> +	ret =3D spi_register_master(master);
> +	if (ret)
> +		goto err_free_master;
> +
> +	return 0;
> +
> +err_free_master:
> +	pci_release_regions(pdev);
> +	return ret;
> +}
> +
> +static void ls7a_spi_pci_remove(struct pci_dev *pdev)
> +{
> +	struct spi_master *master =3D pci_get_drvdata(pdev);
> +
> +	spi_unregister_master(master);
> +	pci_release_regions(pdev);
> +}
> +
> +static const struct pci_device_id ls7a_spi_pci_id_table[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +	{ 0, }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, ls7a_spi_pci_id_table);
> +
> +static struct pci_driver ls7a_spi_pci_driver =3D {
> +	.name		=3D "ls7a-spi",
> +	.id_table	=3D ls7a_spi_pci_id_table,
> +	.probe		=3D ls7a_spi_pci_probe,
> +	.remove		=3D ls7a_spi_pci_remove,
> +};
> +
> +module_pci_driver(ls7a_spi_pci_driver);
> +
> +MODULE_AUTHOR("Juxin Gao <gaojuxin@loongson.cn>");
> +MODULE_AUTHOR("Qing Zhang <zhangqing@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson LS7A SPI controller driver");
> +MODULE_LICENSE("GPL v2");
>


=2D-
Regards,
Oleksij
