Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA455442023
	for <lists+linux-spi@lfdr.de>; Mon,  1 Nov 2021 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKASjt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Nov 2021 14:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhKASjG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Nov 2021 14:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68CFB60F24;
        Mon,  1 Nov 2021 18:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635791793;
        bh=+W2knp6YasMzA1kZhyzd8UpFjgwDdyLPxKycazYB2zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFX0oedvhRobxT/8CZHcAs5mvuHYSPYtZ3GeqweTZRaOdLwpQ+qo5RRuW4P5Y8p2a
         XFoOiEFZLi+2qrLtsQsqZpEqagiCxtJMSCNWMh5pelr1YDjEOcNyLnv2fJF3aIWnKx
         mulWEfjE5hHKficMNXOJLoliBQHeqre9USnzTkB6NGUFzMjTpDSry2E3sgya8PBC0P
         dJJdyiLEj1Xlg1jp6naCCT5CUnE5BqL2SXSemYoE/4S17rGdZEKkO40+1T41NdX4fA
         V9cKoQJza8AGx2pZDV5h+LGC0sy6lj4JunsXnFmwkrXfyaIocxXTj4mkmBpYLYzn4E
         XmUfupk2GRCgA==
Date:   Mon, 1 Nov 2021 18:36:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YYAzrDuLYQt4U06J@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Un4W9GzqfBqDWZE"
Content-Disposition: inline
In-Reply-To: <1635747525-31243-2-git-send-email-lh.kuo@sunplus.com>
X-Cookie: Don't Worry, Be Happy.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--5Un4W9GzqfBqDWZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 01, 2021 at 02:18:44PM +0800, LH.Kuo wrote:

> Add SPI driver for Sunplus SP7021.

In general it looks like this needs quite a bit of a refresh for
mainline - a lot of it looks to be a combination of minor, easily
fixable things and stylistic issues which make things hard to follow but
I think there are some more substantial things going on here as well.

One big thing is that the driver appears to copy everything through
bounce buffers ore or less unconditionally.  It's not clear why it's
doing this - if it's for DMA usage in general the buffers supplied to
SPI devices should be suitable for this.

Stylistically the code just doesn't really look like Linux code, there's
a few frequent issues I've highlighted in the review but there's
probably more that are masked, it'd be worth visually comparing the
driver to others and making sure it looks similar.

> +++ b/drivers/spi/spi-sunplus-sp7021.c
> @@ -0,0 +1,1356 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Sunplus SPI controller driver
> + *
> + * Author: Sunplus Technology Co., Ltd.

Please make the entire comment a C++ one so things look more
intentional.

> +//#define DEBUG

Please drop commented out lines like this, there's *lots* of this in the
driver.

> +/* ---------------------------------------------------------------------=
------------------------- */
> +
> +//#define SPI_FUNC_DEBUG
> +//#define SPI_DBG_INFO
> +#define SPI_DBG_ERR

All this stuff is just duplicating the standard facilities we have in
the kernel for controlling output, please remove it and convert things
over to using normal logging infrastructure rather than a custom setup
for your device driver.

> +#define SPI_FULL_DUPLEX
> +
> +#define MAS_REG_NAME "spi_master"
> +#define SLA_REG_NAME "spi_slave"
> +
> +#define DMA_IRQ_NAME "dma_w_intr"
> +#define MAS_IRQ_NAME "mas_risc_intr"
> +
> +#define SLA_IRQ_NAME "slave_risc_intr"
> +
> +#define SPI_TRANS_DATA_CNT (4)
> +#define SPI_TRANS_DATA_SIZE (255)
> +#define SPI_MSG_DATA_SIZE (SPI_TRANS_DATA_SIZE * SPI_TRANS_DATA_CNT)
> +
> +
> +#define CLEAR_MASTER_INT (1<<6)
> +#define MASTER_INT (1<<7)
> +
> +#define DMA_READ (0xd)
> +#define SLA_SW_RST (1<<1)

Many of these names seem very generic and likely to have collisions in
future, please use prefixes to avoid potential future collisions.

> +struct SPI_MAS {
> +	// Group 091 : SPI_MASTER
> +	unsigned int MST_TX_DATA_ADDR                      ; // 00  (ADDR : 0x9=
C00_2D80)

Please try to follow the kernel coding style, we don't use upper case
for struct or variable names.

> +	unsigned int MST_TX_DATA_3_2_1_0                   ; // 01  (ADDR : 0x9=
C00_2D84)

I don't know what these numbers at the end of variable names are
intended to represent but they don't feel like they're helping.

> +	u8 tx_data_buf[SPI_TRANS_DATA_SIZE];
> +	u8 rx_data_buf[SPI_TRANS_DATA_SIZE];

These look like they'd be better as dynamically allocated buffers, aside
=66rom anything else this will ensure that they are well aligned for DMA.

> +static unsigned int bufsiz =3D 4096;

This should be per device.

> +static void pentagram_set_cs(struct spi_device *_s, bool _on)
> +{
> +	if (_s->mode & SPI_NO_CS)
> +		return;
> +	if (!(_s->cs_gpiod))
> +		return;
> +	dev_dbg(&(_s->dev), "%d gpiod:%d", _on, desc_to_gpio(_s->cs_gpiod));
> +	if (_s->mode & SPI_CS_HIGH)
> +		_on =3D !_on;
> +	gpiod_set_value_cansleep(_s->cs_gpiod, _on);
> +}

If the device has a GPIO chip select it should use the core support for
GPIO chip selects rather than open coding.

> +static irqreturn_t pentagram_spi_S_irq(int _irq, void *_dev)
> +{
> +	unsigned long flags;
> +	struct pentagram_spi_master *pspim =3D (struct pentagram_spi_master *)_=
dev;
> +	struct SPI_SLA *sr =3D (struct SPI_SLA *)pspim->sla_base;
> +
> +	FUNC_DBG();
> +	spin_lock_irqsave(&pspim->lock, flags);

If you're in an interrupt you should only use the regular spin lock, no
need to save IRQ status.

> +	writel(readl(&sr->RISC_INT_DATA_RDY) | CLEAR_SLAVE_INT, &sr->RISC_INT_D=
ATA_RDY);
> +	spin_unlock_irqrestore(&pspim->lock, flags);
> +	complete(&pspim->sla_isr);
> +	return IRQ_HANDLED;

This appears to unconditionally ack an interrupt regardless of any
status bits?  This seems to be a problem for all the interrupts in this
functions.

> +		writel(readl(&spis_reg->RISC_INT_DATA_RDY) | SLAVE_DATA_RDY,
> +					&spis_reg->RISC_INT_DATA_RDY);
> +		//regs1->SLV_DMA_CTRL =3D 0x4d;
> +		//regs1->SLV_DMA_LENGTH =3D 0x50;
> +		//regs1->SLV_DMA_INI_ADDR =3D 0x300;
> +		//regs1->RISC_INT_DATA_RDY |=3D 0x1;

This commented out stuff looks worrying...

> +		if (!wait_for_completion_timeout(&pspim->isr_done, timeout)) {
> +			dev_err(&dev, "wait_for_completion_timeout\n");
> +			goto exit_spi_slave_rw;
> +		}

> +exit_spi_slave_rw:
> +	mutex_unlock(&pspim->buf_lock);
> +	return 0;
> +}

If there's an error it's not reported anywhere.

> +	if (RW_phase =3D=3D SPI_SLAVE_WRITE) {
> +		DBG_INF("S_WRITE len %d", _t->len);
> +		reinit_completion(&pspim->sla_isr);
> +
> +		if (_t->tx_dma =3D=3D pspim->tx_dma_phy_base)
> +			memcpy(pspim->tx_dma_vir_base, _t->tx_buf, _t->len);
> +
> +		writel_relaxed(DMA_WRITE, &spis_reg->SLV_DMA_CTRL);
> +		writel_relaxed(_t->len, &spis_reg->SLV_DMA_LENGTH);
> +		writel_relaxed(_t->tx_dma, &spis_reg->SLV_DMA_INI_ADDR);
> +		writel(readl(&spis_reg->RISC_INT_DATA_RDY) | SLAVE_DATA_RDY,
> +				&spis_reg->RISC_INT_DATA_RDY);
> +
> +		if (wait_for_completion_interruptible(&pspim->sla_isr))
> +			dev_err(devp, "%s() wait_for_completion timeout\n", __func__);
> +
> +	} else if (RW_phase =3D=3D SPI_SLAVE_READ) {

These two cases share no code, they should probably be separate
functions (and what happens if it's an unknown phase?).

> +	}
> +}
> +void sp7021spi_wb(struct pentagram_spi_master *_m, u8 _len)

Missing blank line between functions.  In general more blank lines
between blocks would help.

> +{
> +	struct SPI_MAS *sr =3D (struct SPI_MAS *)_m->mas_base;

These _ names really aren't at all idiomatic for the kernel.  This is a
problem throughout the driver, it's a barrier to legibility.  I'm also
concerned that it looks like you're trying to do accesses to the device
via a struct dereference rather than readl/writel - this will probably
work a lot of the time but I'm not sure it's guaranteed.

> +static irqreturn_t pentagram_spi_M_irq(int _irq, void *_dev)

Nor are capitals in function names.

> +static void spspi_delay_ns(u32 _ns)
> +{
> +

Why is this open coded?

> +	if (_t->speed_hz <=3D _s->max_speed_hz)
> +		div =3D clk_rate / _t->speed_hz;
> +	else if (_s->max_speed_hz <=3D _c->max_speed_hz)
> +		div =3D clk_rate / _s->max_speed_hz;
> +	else if (_c->max_speed_hz < pspim->spi_max_frequency)
> +		div =3D clk_rate / _c->max_speed_hz;
> +	else
> +		div =3D clk_rate / pspim->spi_max_frequency;

The core will set the speed up for the transfer, don't open code this.

> +	if (pspim->tx_cur_len < data_len) {
> +		len_temp =3D min(pspim->data_unit, data_len);
> +		sp7021spi_wb(pspim, len_temp);
> +	}

What if there's more data?

> +	data_len =3D 0;
> +	t =3D first;
> +	for (i =3D 0; i < transfers_cnt; i++) {
> +		if (t->rx_buf)
> +			memcpy(t->rx_buf, &pspim->rx_data_buf[data_len], t->len);
> +
> +		data_len +=3D t->len;
> +		t =3D list_entry(t->transfer_list.next, struct spi_transfer, transfer_=
list);
> +	}

I find it difficult to convince myself that this isn't going to have any
overflow issues, and it'll break operation with anything that does any
manipulation of chip select during the message.  Given that the device
uses GPIO chip selects I'd expect it to just implement transfer_one()
and not handle messages at all.  This would greatly simplify the code.

> +#ifdef CONFIG_PM_RUNTIME_SPI
> +
> +	struct pentagram_spi_master *pspim =3D spi_controller_get_devdata(_s->c=
ontroller);
> +
> +	if (pm_runtime_enabled(pspim->dev)) {
> +		ret =3D pm_runtime_get_sync(pspim->dev)
> +		if (ret < 0)
> +			goto pm_out;
> +	}
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME_SPI

The runtime PM code compiles out when disabled, you shouldn't need these
ifdefs (and you definitely shouldn't need two blocks for the same define
together like this).

> +static int pentagram_spi_controller_unprepare_message(struct spi_control=
ler *ctlr,
> +				    struct spi_message *msg)
> +{
> +	FUNC_DBG();
> +	return 0;
> +}

Remove empty functions, the core will cope.

> +static int pentagram_spi_S_transfer_one(struct spi_controller *_c, struc=
t spi_device *_s,
> +					struct spi_transfer *_t)
> +{

So we are using transfer_one?  In that case I'm very confused why the
driver would be walking a transfer list...

> +	struct pentagram_spi_master *pspim =3D spi_master_get_devdata(_c);
> +	struct device *dev =3D pspim->dev;
> +	int mode =3D SPI_IDLE, ret =3D 0;
> +
> +	FUNC_DBG();
> +#ifdef CONFIG_PM_RUNTIME_SPI
> +	if (pm_runtime_enabled(pspim->dev)) {
> +		ret =3D pm_runtime_get_sync(pspim->dev);
> +		if (ret < 0)
> +			goto pm_out;
> +	}
> +#endif

Let the core handle runtime PM for you, don't open code it.

> +
> +	if (spi_controller_is_slave(_c)) {
> +
> +		pspim->isr_flag =3D SPI_IDLE;
> +
> +		if ((_t->tx_buf) && (_t->rx_buf)) {
> +			dev_dbg(&_c->dev, "%s() wrong command\n", __func__);

Return an error, don't just ignore problems.

> +		} else if (_t->tx_buf) {
> +			/* tx_buf is a const void* where we need a void * for
> +			 * the dma mapping
> +			 */
> +			void *nonconst_tx =3D (void *)_t->tx_buf;

Why do other drivers not need this?  Are you *sure* that's just getting
rid of a const here?

> +			} else
> +				mode =3D SPI_SLAVE_WRITE;

{ } on both sides of the ifelse.

> +		switch (mode) {
> +		case SPI_SLAVE_WRITE:
> +		case SPI_SLAVE_READ:
> +			pentagram_spi_S_rw(_s, _t, mode);
> +			break;
> +		default:
> +			DBG_INF("idle?");
> +			break;
> +		}

> +	pdev->id =3D 0;

Why?

> +	ctlr->bus_num =3D pdev->id;
> +	// flags, understood by the driver
> +	ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> +	ctlr->bits_per_word_mask =3D SPI_BPW_MASK(8);
> +	ctlr->min_speed_hz =3D 40000;
> +	ctlr->max_speed_hz =3D 50000000;
> +	// ctlr->flags =3D 0

The driver should at least be flagging itself as half duplex.

> +	/* find and map our resources */
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, MAS_REG_NAME=
);
> +	if (res) {
> +		pspim->mas_base =3D devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource_by_name().

> +	FUNC_DBG();
> +
> +	reset_control_assert(pspim->rstc);
> +
> +	return 0;
> +}
> +
> +static int pentagram_spi_controller_resume(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr =3D platform_get_drvdata(pdev);
> +	struct pentagram_spi_master *pspim =3D spi_master_get_devdata(ctlr);
> +
> +	FUNC_DBG();
> +
> +	reset_control_deassert(pspim->rstc);
> +	clk_prepare_enable(pspim->spi_clk);

There's no matching disable...

> +#ifdef CONFIG_PM_RUNTIME_SPI
> +		.pm     =3D &sp7021_spi_pm_ops,
> +#endif

There's a helper for this.

--5Un4W9GzqfBqDWZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGAM6sACgkQJNaLcl1U
h9CgFwf+NEURvsUFgW5jcXEW12Mnv+rjfz7gcDLbMxB8r6Xvj1LBbdxig0ropJtz
XkBuZH/TMiYdmPbjLQ1gqyM1vEdrMr+o837qK57lXBtWB5cP+jXurKW2SMj4xtgH
s8l2c2aUJTXInVTL12vGsbjpieGKv/ED0YG4/TepXxtcIuOE5uyt+tLg3ig/3vcj
dmqwlyQR5Dv68zp6DgJmoIq/d/LPKRWQkemp2NcirJMVHeu/oYKrZIBpi7LUwhL1
nMtx4uwYAVGmcf08N3EA+HtmCBhVImcge1seFrXc7qGxhphbC44vT16GmlBhFWFo
y9eAdQDYGunzSA3FaiMy9cacw2SB8Q==
=+SCg
-----END PGP SIGNATURE-----

--5Un4W9GzqfBqDWZE--
