Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B462D9F43
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440916AbgLNSeZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 13:34:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:36035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440902AbgLNSeX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Dec 2020 13:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607970747;
        bh=a/vukGu8AzXqd21toKVuSDutKwf+6bo7H9J/lsrzujA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hj/j844JKduc6JEborqskl6YuFWpkW7p2JJOsTqKEb6WpG8Lrtf6UnsPDeHGoLmm2
         JtGHMk/Zo2j80WPBenAsKvM2QcVoIIjvJT1gXJg6U3KSeA8HmWaE74d3U0aVDxkJKq
         jEN5mGi0rxDNGdwlhRN9YS+ZJqWbSJhMe4QS3ut8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.44] ([95.91.192.147]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1kJvX11nGK-00mXmp; Mon, 14
 Dec 2020 19:32:27 +0100
Subject: Re: [PATCH v3 1/4] spi: LS7A: Add Loongson LS7A SPI controller driver
 support
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juxin Gao <gaojuxin@loongson.cn>,
        ", Du Huanpeng" <u74147@gmail.com>
References: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
From:   Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <a6d39f0c-67b1-e518-d493-7b17128c2b06@rempel-privat.de>
Date:   Mon, 14 Dec 2020 19:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T1HgYA5I1LtP8QnADaLGEucsnwJNYzY8j3Kyv7MhoO9lp38DKxp
 /XAoYPXm4l+KGhST4BtMBGNn/NiuXKmXtVFtVVUGVoI8K5aAyCcyZF5zMghvr6q9PUupk5v
 BsfOIajuAGFegPmn+W++CJ9iG01TCMeNvHIYbvxtCaQjh/BjroMJ1hcg0fpAAQapLr6cKhF
 4nHzLtLCZhqyeqIxiOQvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mnut7DALhk8=:3yKgbCEJp68Lil5F3VS9+p
 U4/MSakC0gM9L/JS4DDDmpepQZvjU7KExmj1AY3WLz255lO6ahO3yZsvEC/ncSl/eeIM5ZPjr
 hZMxceZ+BXtbFoBikpmgztLIb05XG2IIhux4Oj+JLMWsrF/txK+5DX7+u7JR7AlB0FDUeJWp1
 1X3tCH13cp6U+Q+67pSPLtSexjLIkxx1KAM6q2JTSjzYi6J0w2ddPqKuZiU3252iXqpxqAgFs
 spKAgkcv2/WeLJsPaiTKTI3u1iKHPgSPb2VThezbqIpdz1hxVXdyxR60X2jebjbBNdJJV4MJV
 Qp/3GuJRtom6vdP5mYLGLt6ELku5wRefNNN++lN3hmdlDu8fGNbx0a1qlo9Hxc/0++GFFnG2n
 c9hMpYJpkjU/JuSFJb2UzjUdxsbbqdedvVhXZubI6hKBkAUFRdtjQX6vJh1N4UV2qEmHWDAOh
 iCgxJ+ug0TCHOi2GWeO4mhFBdWTINhQxo1UQaz9+RTCzyh28G8X1RAaDBWGjpc1WFrMqM2TpT
 RnyWphTBDPJNrEG2212Hxvl4nCRufksXNY0uLK9NkzAfYJOA8kwSdUhxWSBxj0aME5nnGR9n4
 KWwUlbGEUEPkYINYg5dNlPZXa599LNmoDmIf9m9wtpOqnv68dT8ZmxvszakTuJ/J9XUQW8it9
 ARVwjXj37gS+h0uJ3tTydbKXEMF+AUK3eHnhPjfpD+U581a3a7GWYfyjBSeTp/rjwkDeiARFO
 y4WWQN2nENHjbP3bYXAD8+qDLj6qOzATqznyeXs0FA31m8M247PsZeWNEcgKxrkwuUUo1V1i5
 dd4L/Ezufl7RCa9BengKFnD3kVf1JdWc9UUbjYnJPfS1B2tPhieLhStgY0bUE7VIRwJQ+OZal
 e1XVdizjPuk336+fE1yg==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

After quick search I found (nearly?) identical SPI controller on many
other Loongson products. For example: ls1b, ls2k, 3A4000, etc...
Probably it will help you to make right decisions now, if you compare
this docs:
http://www.loongson.cn/product/

Am 14.12.20 um 06:58 schrieb Qing Zhang:
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
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
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
> ---
>  drivers/spi/Kconfig    |   7 ++
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/spi-ls7a.c | 293 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  3 files changed, 301 insertions(+)
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

LS1B is 32bit

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
> index 0000000..d3b7e86
> --- /dev/null
> +++ b/drivers/spi/spi-ls7a.c
> @@ -0,0 +1,293 @@
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
> +#define	SPCR	0x00
> +#define	SPSR	0x01
> +#define	FIFO	0x02
> +#define	SPER	0x03
> +#define	PARA	0x04

Please use names used in the manual. In this case instead of PARA was
used SFC_PARAM

> +#define	SFCS	0x05
> +#define	TIMI	0x06

Please, use driver specific names. Not too generic. For example:
LSXX_SPI_SPCR

Please, define bits and bit masks from this regs and replace all magic
numbers. It will help to read this code. It will be good if you can
provide some comments to this bits in english. If I see it correctly,
there are no translated documentations.

> +
> +struct ls7a_spi {
> +	spinlock_t lock;
> +	struct spi_master *master;
> +	void __iomem *base;
> +	unsigned int hz;
> +	unsigned char spcr, sper;
> +	unsigned int mode;
> +};
> +
> +static void ls7a_spi_write_reg(struct ls7a_spi *spi,
> +			       unsigned char reg,
> +			       unsigned char data)
> +{
> +	writeb(data, spi->base + reg);

In this driver "spi" is used in different caseses:
- struct ls7a_spi *spi
- struct spi_device *spi

this is confusing. I personally prefer to call driver privat stucture as
"priv"

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
> +	int param;
> +
> +	ls7a_spi =3D spi_master_get_devdata(master);
> +
> +	spin_lock(&ls7a_spi->lock);
> +	param =3D ls7a_spi_read_reg(ls7a_spi, PARA
> +	ls7a_spi_write_reg(ls7a_spi, PARA, param &=3D ~1);

You are switching the SPI controller from SPI Flash mode, to plain SPI.
This was already done on the probe. Are there any reason for doing this
again?

> +	spin_unlock(&ls7a_spi->lock);
> +
> +	return 0;
> +}
> +
> +static int  ls7a_spi_unprepare_message(struct spi_master *master,
> +				       struct spi_message *msg)
> +{
> +	struct ls7a_spi *ls7a_spi;
> +	int param =3D 0;
> +
> +	ls7a_spi =3D spi_master_get_devdata(master);
> +
> +	spin_lock(&ls7a_spi->lock);
> +	ls7a_spi_write_reg(ls7a_spi, PARA, param);

here we set all bit to 0, why? there is not enable bit, if i see it
correctly

> +	spin_unlock(&ls7a_spi->lock);
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
> +	cs =3D ls7a_spi_read_reg(ls7a_spi, SFCS) & ~(0x11 << spi->chip_select)=
;
> +
> +	if (!!(spi->mode & SPI_CS_HIGH) =3D=3D enable)
> +		ls7a_spi_write_reg(ls7a_spi, SFCS, (0x1 << spi->chip_select) | cs);
> +	else
> +		ls7a_spi_write_reg(ls7a_spi, SFCS, (0x11 << spi->chip_select) | cs);
> +}
> +
> +static int ls7a_spi_do_transfer(struct ls7a_spi *ls7a_spi,
> +				struct spi_device *spi,
> +				struct spi_transfer *t)

The functiono name is confusing. What ever is done in this function is
not realated to this name.

> +{
> +	unsigned int hz;
> +	unsigned int div, div_tmp;
> +	unsigned int bit;
> +	unsigned long clk;
> +	unsigned char val;
> +	const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};

Please use dividers instead of positions, it is easier to read.

> +
> +	if (t) {
> +		hz =3D t->speed_hz;
> +		if (!hz)
> +			hz =3D spi->max_speed_hz;
> +	} else {
> +		hz =3D spi->max_speed_hz;
> +	}




> +	if (((spi->mode ^ ls7a_spi->mode) & (SPI_CPOL | SPI_CPHA))
> +		|| (hz && ls7a_spi->hz !=3D hz)) {

Please, do not put complete function in to the if statement. If the
statment is not true, just return.

> +		clk =3D 100000000;

This code is made with assumption, there is fixed 100MHz clock provider.
According to the manual, the LS7A clock structure looks like this:
100MHz-->DIV2--->MISC Block
              \-->SPI

If some one will change the DIV2, nasty things will happen. Other
Loongson products have divers and configurable PLLs as well, it will be
better if you start to use clk framework instead of hard coding clock spee=
d.

> +		div =3D DIV_ROUND_UP(clk, hz);
> +		if (div < 2)
> +			div =3D 2;
> +		if (div > 4096)
> +			div =3D 4096;
> +
> +		bit =3D fls(div) - 1;
> +		if ((1<<bit) =3D=3D div)
> +			bit--;
> +		div_tmp =3D rdiv[bit];

This divider calculation assums that you have liniar divider. According
to the manual, your dividers are:
2, 4, 16, 32, 8, 64,...

This order looks identical in all loongsoon manuals, so I assume there
is a bug in the hardware.

> +
> +		dev_dbg(&spi->dev, "clk =3D %ld hz =3D %d div_tmp =3D %d bit =3D %d\n=
",
> +			clk, hz, div_tmp, bit);
> +
> +		ls7a_spi->hz =3D hz;

After taking best possible divider, the outgoung clk is not equal to the
requested clock. Please store actual used speed by the controller to the
transfer->effective_speed_hz

See:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
drivers/spi/spi-imx.c?h=3Dv5.10&id=3Dbf253e6bf6b876a4ce74db7dcf8a13b80d84a=
a5f

> +		ls7a_spi->spcr =3D div_tmp & 3;
> +		ls7a_spi->sper =3D (div_tmp >> 2) & 3;
> +
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPCR);
> +		val &=3D ~0xc;
> +		if (spi->mode & SPI_CPOL)
> +			val |=3D 8;
> +		if (spi->mode & SPI_CPHA)
> +			val |=3D 4;

Please, no magi numbers. Use defines.

> +		ls7a_spi_write_reg(ls7a_spi, SPCR, (val & ~3) | ls7a_spi->spcr);
> +		val =3D ls7a_spi_read_reg(ls7a_spi, SPER);
> +		ls7a_spi_write_reg(ls7a_spi, SPER, (val & ~3) | ls7a_spi->sper);
> +		ls7a_spi->mode =3D spi->mode;
> +	}
> +	return 0;
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

Is it OK to write to FIFO without checking if it is actually empty?

> +		ls7a_spi_write_reg(ls7a_spi, FIFO, *((*tx_buf)++));
> +
> +		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) =3D=3D 1)
> +			;

Should be here used 0x4 instead of 0x1? WFEMPTY instead of RFEMPTY?
If SPI controller will fail for some reason, this while loop will block
complete system. Please, abort on time out.

> +	} else {
> +		ls7a_spi_write_reg(ls7a_spi, FIFO, 0);
> +
> +		while ((ls7a_spi_read_reg(ls7a_spi, SPSR) & 0x1) =3D=3D 1)
> +			;
> +	}

Should we checl if RxFIFO is not empty before reading it?

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
> +
> +	u8 *rx =3D xfer->rx_buf;
> +
> +	count =3D xfer->len;
> +
> +	do {
> +		if (ls7a_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
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
> +	struct ls7a_spi *ls7a_spi;
> +	int status;
> +
> +	ls7a_spi =3D spi_master_get_devdata(master);
> +
> +	status =3D ls7a_spi_do_transfer(ls7a_spi, spi, t);
> +	if (status < 0)
> +		return status;
> +
> +	ls7a_spi_write_read(spi, t);

return value is ignored

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
> +	ls7a_spi_write_reg(spi, TIMI, 0x01);
> +	ls7a_spi_write_reg(spi, PARA, 0x40);

Please do not use magic number, add comments what you are doing here.

> +	spi->mode =3D 0;
> +
> +	spin_lock_init(&spi->lock);
> +
> +	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +	master->prepare_message =3D ls7a_spi_prepare_message;
> +	master->set_cs =3D ls7a_spi_set_cs;
> +	master->transfer_one =3D ls7a_spi_transfer_one;
> +	master->unprepare_message =3D ls7a_spi_unprepare_message;
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

On ls1b and ls2k this SPI controoler is a simple MEMIO.

You will need to add here probe as platform device as well.

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


=2D-
Regards,
Oleksij
