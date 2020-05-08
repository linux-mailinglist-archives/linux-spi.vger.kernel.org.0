Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769581CA9BF
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHLh4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 07:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLh4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 8 May 2020 07:37:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C197720870;
        Fri,  8 May 2020 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588937874;
        bh=k8fC3Rc3/kU/7pCZDuV9/xXsQEEdbFVMU4be5d0n8P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaBZkD0TliGk20MveuXOFenI+PttMo9PUAlCOUTShriIDrFc4V9p+L58Eg6nhD37N
         a2CBBgNw5DsipnEwV3aUTjfv0XdxZdxumFGBgDFMBjgCeciiX7R/+3pERw109QGiVr
         jp3igJokxRJFTEWp+V4+9GlMidZbhxpOJZFZEoOo=
Date:   Fri, 8 May 2020 12:37:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: Add Baikal-T1 System Boot SPI Controller driver
Message-ID: <20200508113751.GD4820@sirena.org.uk>
References: <20200508093621.31619-1-Sergey.Semin@baikalelectronics.ru>
 <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <20200508093621.31619-3-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 12:36:21PM +0300, Serge Semin wrote:

Your CC list on this series is *very* wide - are you sure that this is
relevant to everyone you're sending things to?  Kernel developers often
get a lot of mail meaning that extra mail can become a bit overwhelming
and cause things to get lost in the noise.

> This SPI-controller is a part of the Baikal-T1 System Controller and
> is based on the DW APB SSI IP-core, but with very limited resources:
> no IRQ, no DMA, only a single native chip-select and just 8 bytes Tx/Rx
> FIFO available. In order to provide a transparent initial boot code
> execution this controller is also utilized by an vendor-specific block,
> which provides an CS0 SPI flash direct mapping interface. Since both
> direct mapping and SPI controller normal utilization are mutual exclusive
> only a one of these interfaces can be used to access an external SPI
> slave device. Taking into account the peculiarities of the controller
> registers and physically mapped SPI flash access, very limited resources
> and seeing the normal usecase of the controller is to access an external
> SPI-nor flash, we decided to create a dedicated SPI driver for it.

My overall impression reading this is that there could be a lot more
reliance on both generic functionality and as Andy suggested the spi-dw
driver - the headers seem easy for example.  As far as I can tell the
main things this is adding compared to spi-dw are the dirmap code and
the IRQ disabling around the PIO on the FIFO both of which seem like
relatively small additions which it should be possible to accomodate
within spi-dw.  For example the driver could have multiple transfer
functions and pick a different one with the interrupt disabling when
running on this hardware.

> --- /dev/null
> +++ b/drivers/spi/spi-bt1-sys.c
> @@ -0,0 +1,873 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC

Please make the entire comment a C++ one so things look a bit cleaner
and more intentional.

> +	writel(BIT(req->cs), bs->regs + BC_SPI_SER);
> +	if (req->cs_gpiod) {
> +		gpiod_set_value_cansleep(req->cs_gpiod,
> +					 !!(bs->cfg.mode & SPI_CS_HIGH));

If you have a GPIO chip select you should just let the core manage it
through cs_gpiod rather than open coding.

> +	} else if (!req->dirmap) {
> +		local_irq_save(bs->cfg.flags);
> +		preempt_disable();
> +	}

This is obviously not great, especially for larger transfers.  It would
be a lot easier to review and manage this if the IRQ disabling was done
around the transfers in a single function rather than separately, that
way everything is next to each other and it's clearer that we're doing
this for the minimum time and didn't miss anything.  Right now it's hard
to tell if everything is joined up.

> +static void bs_update_cfg(struct bt1_spi *bs, struct spi_transfer *xfer)
> +{

This has exactly one caller, perhaps it could just be inlined there?  I
think this applies to some of the other internal functions.

> +static int bs_check_status(struct bt1_spi *bs)
> +{

It's not obvious from the name that this function will busy wait rather
than just reading some status registers.

> +	/*
> +	 * Spin around the BUSY-state bit waiting for the controller to finish
> +	 * all the requested IO-operations.
> +	 */
> +	do {
> +		data =3D readl(bs->regs + BC_SPI_SR);
> +	} while ((data & BC_SPI_SR_BUSY) || !(data & BC_SPI_SR_TFE));

We could use a timeout or something here in case something goes wrong,
as things stand we could end up spinning for ever.

It's also not clear to me why we only check for over/underrun before we
do the busy wait, especially a RX overrun could happen and cause us to
loose data while things are finishing up.

> +	while (txlen || rxlen) {
> +		cnt =3D BC_SPI_FIFO_LVL - __raw_readl(bs->regs + BC_SPI_TXFLR);
> +		cnt =3D min(cnt, txlen);
> +		txlen -=3D cnt;
> +		while (cnt--) {
> +			data =3D src ? *src++ : 0xFF;
> +			__raw_writel(data, bs->regs + BC_SPI_DR);
> +		}

It's more typical to write zeros when there's no data.

> +static int bs_exec_mem_op(struct spi_mem *mem,
> +			  const struct spi_mem_op *op)
> +{

It's not clear to me that this hardware actually supports spi_mem in
hardware? =20

> +	if (!bs->cfg.cs_gpiod) {
> +		bs_push_bytes(bs, cmd, len);
> +
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +			ret =3D bs_pull_bytes(bs, op->data.buf.in,
> +					    op->data.nbytes);
> +	} else {
> +		bs_pp_bytes(bs, cmd, NULL, len);
> +
> +		if (op->data.dir =3D=3D SPI_MEM_DATA_IN)
> +			bs_pp_bytes(bs, NULL, op->data.buf.in,
> +				    op->data.nbytes);
> +	}

The actual transfers here are done using the same PIO functions as
everything else as far as I can see which makes me wonder what this
spi_mem implementation is adding over the standard SPI flash support.
I've not checked but if we need this to get the dirmap support to kick
in then we should fix this by making the core not have that requirement.

> +static void bs_copy_from_map(void *to, void __iomem *from, size_t len)
> +{
> +	size_t shift, chunk;
> +	u32 data;

This feels like something that is likely to be suitable for a generic
implementation?  Indeed I'd kind of expect that the architecture
memcpy_to/fromio() would try to copy aligned blocks since it's usually
going to perform better (which I assume is why this function is doing
it).

> +	if (shift) {
> +		chunk =3D min_t(size_t, 4 - shift, len);
> +		data =3D readl_relaxed(from - shift);
> +		memcpy(to, &data + shift, chunk);

It's a little unclear what we're actually doing though - we read a data
address from the hardware?

> +static int bs_prepare_message(struct spi_controller *ctrl,
> +			      struct spi_message *msg)
> +{
> +	struct bt1_spi *bs =3D spi_controller_get_devdata(ctrl);
> +	struct spi_transfer *xfer;
> +	struct bt1_spi_cfg req;
> +
> +	/*
> +	 * Currently the driver doesn't support the generic messages-based
> +	 * SPI interface with pure native chip-select signal. This is due
> +	 * to the automatic native chip-select toggle peculiarity described
> +	 * in the comment of the bs_set_cfg() method. Alas we can't use the
> +	 * IRQ-disable-based boost approach here since the native queue-based
> +	 * SPI messages transfer method can sleep waiting for the
> +	 * transfers/CS-change delays.
> +	 */
> +	if (!msg->spi->cs_gpiod)
> +		return -ENOTSUPP;

This seems a bit much - we can validate that the message doesn't contain
any delays (which is going to be the overwhelming majority of devices)
or multiple transfers and reject just those transfers we can't support.
Multiple transfers are an issue with this hardware but you could
implement support in the core for coalescing them into single transfers,
this isn't the only hardware with automatic chip select handling that
can't cope with scatter/gather so it would be a useful thing to have.

> +	/*
> +	 * Collect the controller configuration common for all transfers and
> +	 * specific to the very first one.
> +	 */
> +	xfer =3D list_first_entry(&msg->transfers, typeof(*xfer), transfer_list=
);
> +	req.dirmap =3D false;
> +	req.cs =3D msg->spi->chip_select;
> +	req.cs_gpiod =3D msg->spi->cs_gpiod;
> +	req.flags =3D 0;
> +	req.mode =3D msg->spi->mode;
> +	req.tmode =3D BC_SPI_CTRL0_TMOD_TR;
> +	req.ndf =3D 0;
> +	req.dfs =3D xfer->bits_per_word;
> +	req.freq =3D xfer->speed_hz;
> +
> +	bs_set_cfg(bs, &req);

It's not clear to me what the benefit is in this indirection through
req?

> +static int bs_transfer_one(struct spi_controller *ctrl, struct spi_devic=
e *spi,
> +			   struct spi_transfer *xfer)
> +{
> +	struct bt1_spi *bs =3D spi_controller_get_devdata(ctrl);
> +
> +	bs_update_cfg(bs, xfer);
> +
> +	if (bs->cfg.dfs <=3D 8)
> +		bs_pp_bytes(bs, xfer->tx_buf, xfer->rx_buf, xfer->len);
> +	else
> +		bs_pp_words(bs, xfer->tx_buf, xfer->rx_buf, xfer->len / 2);

This will have issues with transfers with an odd number of bytes won't
it?

> +static struct bt1_spi *bs_create_data(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct bt1_spi *bs;

As with some of the other functions this has exactly one caller and
barely any content in it, just inline it.

> +	bs->dev =3D dev;
> +	bs->pdev =3D pdev;

Do you really need to separately save these (and is there a context
where you have the driver data but not the device anyway)?

> +#ifdef CONFIG_DEBUG_FS
> +
> +#define BC_SPI_DBGFS_REG(_name, _off)	\
> +{					\
> +	.name =3D _name,			\
> +	.offset =3D _off			\
> +}

Perhaps consider regmap_mmio?

> +static int bs_dbgfs_open_regs(struct inode *inode, struct file *file)
> +{
> +	struct bt1_spi *bs =3D inode->i_private;
> +	int ret;
> +
> +	ret =3D single_open(file, bs_dbgfs_show_regs, bs);
> +	if (!ret) {
> +		mutex_lock(&bs->ctrl->io_mutex);

Holding a mutex over the entire time that a file is open is not good,
it's also not clear to me what this mutex is supposed to be protecting
given that it's only referenced in these debugfs functions.

> +		writel(BC_CSR_SPI_RDA, bs->regs + BC_CSR);

Whatever this write is doing we never seem to undo it?

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61RI8ACgkQJNaLcl1U
h9D1Uwf/TBmBhHo7fKNiQCxqbOOc004sw/O9ZVtPw7gJLrVT+11j/IDggUNg7PuT
pZs9bRz5Bw8XhkPg//TqhimQS7f226tjbzRjFavwP2sBhFTE13+LyjsCBtSi4/cK
q4bHDKbbt4JQtmpJzLcxbbu6pxZ2oTlcrKLqvJFNhyTVhw97yaO9vtmaBKHmSxbF
DhvoMEGINDP2KYodtPVY1kiVPFOdmfTnybPpZSTdcvdFELNbAMZOaFexevCWhQXM
W7YXepA3F3wRllrpYTXQ3qx5CaEHwqSRWquOfCrMqPB4VIa7dST9laCnjXT0eWEp
rb3hrzlhyxcJuthhd2B6pQ7CmXE9Og==
=b8h+
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
