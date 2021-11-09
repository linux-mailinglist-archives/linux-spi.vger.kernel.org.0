Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB06644AFCE
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhKIO7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 09:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232619AbhKIO7f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 9 Nov 2021 09:59:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81E2C6108D;
        Tue,  9 Nov 2021 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636469809;
        bh=3klCozlBVnzBXBg6vClaYZADmZT6NoO+cjoqvUwO+eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMJ/1r7oXg05PS2Uw7GKyhTS1MFsGnxGHoJdokhAqG+vhjx8JElAJV7HfCgK+FiZo
         BiBHYbPiiMqC9SwGMIAN07sPBIxtrjJ12i+O9plLAzIzQYF9m2+qFUvwqwuwXxxTM7
         a7ykrLUT4tcu1dVjx9W0PvUH+Nnfyju09vPVT2UpHOauWAyZ5fHCQV6qYs5Vhcor5g
         0bET8lH5cbctP8/kRzOhEa2PfWOOmGUZijgJvd8kBCmtOlgbhl5BCrR9S/ugGC7rq2
         jgOoe9YF5fxzSbwJRB0JSasziiyWoo6ocX5vOm+8V9jraciK9YF4Ah7BCIVJGgoyh+
         +rIuEF08aDORQ==
Date:   Tue, 9 Nov 2021 14:56:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "LH.Kuo" <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvorkin@tibbo.com,
        qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
Message-ID: <YYqMLPB6VX9k5LUK@sirena.org.uk>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pADVUBww0TEoVRVh"
Content-Disposition: inline
In-Reply-To: <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
X-Cookie: Elevators smell different to midgets.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--pADVUBww0TEoVRVh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 09, 2021 at 05:01:27PM +0800, LH.Kuo wrote:

A lot of my previous feedback on this driver still applies, while some
of the issues have been addressed most of the major structural issues
continue to apply here.  A lot of the code is replicating code from the
core or is really hard to explain, it's hard to see anything super
unusual with the hardware here that would require such unusual code.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

> +static void sp7021_spi_set_cs(struct spi_device *_s, bool _on)
> +{
> +	if (_s->mode & SPI_NO_CS)
> +		return;
> +	if (!(_s->cs_gpiod))
> +		return;
> +	dev_dbg(&(_s->dev), "%d gpiod:%d", _on, desc_to_gpio(_s->cs_gpiod));
> +	if (_s->mode & SPI_CS_HIGH)
> +		_on = !_on;
> +	gpiod_set_value_cansleep(_s->cs_gpiod, _on);
> +}

This is *still* open coding a GPIO chip select, to repeat what I said
last time this is not OK - use the core facilities to avoid introducing
bugs like double application of SPI_CS_HIGH you have here.

> +// spi slave irq handler
> +static irqreturn_t sp7021_spi_sla_irq(int _irq, void *_dev)
> +{
> +	struct sp7021_spi_ctlr *pspim = (struct sp7021_spi_ctlr *)_dev;

If you need this cast something is very wrong, do you need it?

> +int sp7021_spi_sla_rw(struct spi_device *_s, struct spi_transfer *_t, int RW_phase)

Please use the normal kernel coding style, using _s for parameter names
or mixed case symbol names isn't normal for the kernel.  There's also
issues with line lengths over 80 columns all over, while it's not a
strict limit it's still good try to keep things to a reasonable length.

> +	if (RW_phase == SP7021_SLA_WRITE) {

This looks like a switch statement, though given how little code is
shared it's not clear why this is all in one function.

> +		if (_t->tx_dma == pspim->tx_dma_phy_base)
> +			memcpy(pspim->tx_dma_vir_base, _t->tx_buf, _t->len);

Why are we copying data into a DMA transfer buffer, doesn't this defeat
the point of DMA?  I'd expect to DMA data directly.  I'd also expect
some synchronisation operations to ensure that everything has a
consistent view of the memory.

> +// spi master irq handler
> +static irqreturn_t sp7021_spi_mas_irq_dma(int _irq, void *_dev)
> +{
> +	struct sp7021_spi_ctlr *pspim = (struct sp7021_spi_ctlr *)_dev;
> +
> +	spin_lock_irq(&pspim->lock);

Why are we using spin_lock_irq() when we're already in an interrupt
handler?

> +	}
> +}
> +void sp7021spi_wb(struct sp7021_spi_ctlr *_m, u8 _len)

Blank lines between functions.

> +fin_irq:
> +	if (isrdone)
> +		complete(&pspim->isr_done);
> +	spin_unlock_irqrestore(&pspim->lock, flags);
> +	return IRQ_HANDLED;
> +}

This unconditionally reports IRQ_HANDLED even if we didn't actually see
any interrupt status flagged, this will break shared interrupts and
reduce the ability of the interrupt core to handle errors.

> +	for (i = 0; i < transfers_cnt; i++) {
> +		if (t->tx_buf)
> +			memcpy(&pspim->tx_data_buf[data_len], t->tx_buf, t->len);
> +		if (t->rx_buf)
> +			xfer_rx = true;
> +		data_len += t->len;
> +		t = list_entry(t->transfer_list.next, struct spi_transfer, transfer_list);
> +	}

This is still copying all data for no apparent reason as highlighted
last time.

> +	dev_dbg(&(_c->dev), "data_len %d xfer_rx %d", data_len, xfer_rx);
> +
> +	// set SPI FIFO data for full duplex (SPI_FD fifo_data)  91.13
> +	if (pspim->tx_cur_len < data_len) {
> +		len_temp = min(pspim->data_unit, data_len);
> +		sp7021spi_wb(pspim, len_temp);
> +	}

Is the device full duplex or half duplex?  The code immediately above
this treats both transmit and recieve buffers as optional.  If the
device does actually need to be full duplex then the driver should flag
it as such.

> +// called when child device is registering on the bus
> +static int sp7021_spi_dev_setup(struct spi_device *_s)
> +{
> +	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(_s->controller);
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(pspim->dev);
> +		if (ret < 0)
> +			return 0;
> +
> +	pm_runtime_put(pspim->dev);
> +
> +	return 0;
> +
> +}

This function does nothing except bounce the power on the device, this
is obviously not useful and should be removed.

> +static int sp7021_spi_controller_unprepare_message(struct spi_controller *_c,
> +				    struct spi_message *msg)
> +{
> +	return 0;
> +}

Remove empty functions.

> +static size_t sp7021_spi_max_length(struct spi_device *spi)
> +{
> +	return SP7021_SPI_MSG_SIZE;
> +}

Is there any actual limit in the hardware?  This looks very much like
it's a completely artificial limit in the driver for no obvious reason.

> +static int sp7021_spi_mas_transfer_one_message(struct spi_controller *_c, struct spi_message *m)
> +{
> +	struct sp7021_spi_ctlr *pspim = spi_master_get_devdata(_c);
> +	struct spi_device *spi = m->spi;
> +	unsigned int xfer_cnt = 0, total_len = 0;
> +	bool start_xfer = false;
> +	struct spi_transfer *xfer, *first_xfer = NULL;
> +	int ret;
> +	bool keep_cs = false;
> +
> +	pm_runtime_get_sync(pspim->dev);

To repeat the feedback from last time do not open code runtime PM, use
the core support.

> +	sp7021_spi_set_cs(spi, true);
> +
> +	list_for_each_entry(xfer, &m->transfers, transfer_list) {
> +		if (!first_xfer)
> +			first_xfer = xfer;
> +		total_len +=  xfer->len;

To further repeat my prior feedback I can't see any reason why this
driver doesn't just use transfer_one().

--pADVUBww0TEoVRVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGKjCsACgkQJNaLcl1U
h9D+CwgAg05hfhwyKJDroHzo6DQPDIYOZZQ7dJ6RRuZLsKrk0JvRkDpc/R30oVFO
B+aeyqR0D6wAdPFTNyDc8wYpqbiB5V2WteSjZM14iOtykE/jCtYgYOUPRC7reQd3
d/8elkaxojMoyqXNMj5forBmwuO3KiH60ka3bqpZmFO+9n+dPrgecK6wd4k437P9
7ENoYOV4SDv6AZ3njsyEZ55Ou8xWx+d3dzOUhQeWV31Zcq140g5uJ+r36BeB9ELT
k5o/5ZFlwueO4svhts0cWn0Da8F6V4fOzElWy5VAd47S/hgSF2xdZbg8ZQrBxSi7
Nbn10hlmDnxGRlgdyIPY7JzZJlkleA==
=UItb
-----END PGP SIGNATURE-----

--pADVUBww0TEoVRVh--
