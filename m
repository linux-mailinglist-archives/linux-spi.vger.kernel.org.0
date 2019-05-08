Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35017284
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 09:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEHHYF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 03:24:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50158 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfEHHYE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 03:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ojHSKnfWJRRjJR0xzUZbPx2p+XGZkTxxy6eTedn1+ys=; b=pQOTmBeneb16PQTInQz2D3L6r
        GvOTzaUZtJEq8wnPxldSCTk1vM1HNL058CHgteFaTkr0+bV6c4ePJzllyXpAzXp1pZP2EQ5AzGY8N
        3PdqdeTgTdKVbmrjZMBlrRGvwJeK614JLUz6wrR8l+vwN4zR7B8KszeG+fOmOtDKzzcr4=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOGvp-0007Ix-Lw; Wed, 08 May 2019 07:24:03 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7069C440040; Wed,  8 May 2019 08:18:12 +0100 (BST)
Date:   Wed, 8 May 2019 16:18:12 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Added driver for CP2130 USB-to-SPI bridge
Message-ID: <20190508071812.GS14916@sirena.org.uk>
References: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com>
 <1557144380-19935-2-git-send-email-jh@henneberg-systemdesign.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BxpeiN0NM01wFavH"
Content-Disposition: inline
In-Reply-To: <1557144380-19935-2-git-send-email-jh@henneberg-systemdesign.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--BxpeiN0NM01wFavH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 02:06:20PM +0200, Jochen Henneberg wrote:

This driver has huge amounts of non-standard interfaces in it,
especially the userpace ABI it adds.  It would be a lot easier to review
if it were split up so that it's a series where the core SPI
functionality is added initially and then other things were layered on
top as additional patches.

> @@ -0,0 +1,1672 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Kernel driver for Silicon Labs CP2130 USB-to-SPI bridge.
> + *
> + * Copyright (C) 2019 Jochen Henneberg (jh@henneberg-systemdesign.com)
> + */

Please keep the entire comment a C++ comment, it makes things look more
intentional.

> +/* Prototypes */
> +static int cp2130_probe(struct usb_interface *intf,
> +			const struct usb_device_id *id);
> +static void cp2130_disconnect(struct usb_interface *intf);

These forward declarations are really weird in a Linux driver, normally
things like probe() are defined at the bottom of the driver just before
the driver structure which also usually goes at the end.

> +/* USB device functions */
> +static struct usb_driver cp2130_driver = {
> +	.name                 = "cp2130",
> +	.probe                = cp2130_probe,
> +	.disconnect           = cp2130_disconnect,
> +	.suspend              = NULL,
> +	.resume               = NULL,
> +	.reset_resume         = NULL,
> +	.id_table             = cp2130_devices,
> +	.supports_autosuspend = 0,
> +};

Static variables are initialized to 0 by default, no need to explicitly
do that.

> +static int __init cp2130_init(void)
> +{

module_usb_driver().

> +static int cp2130_spi_setup(struct spi_device *spi)
> +{
> +	return 0;
> +}
> +
> +static void cp2130_spi_cleanup(struct spi_device *spi)
> +{
> +}

Omit empty functions.  If the framework won't let you omit empty
functions they probably can't safely be empty.

> +	ret = sprintf(out, "channel\tcs_mode\tirq_pin\tclock_phase\tpolarity"
> +		"\tcs_pin_mode\tclock_freq\tdelay_mask"
> +		"\tinter_byte_delay\tpre_delay\tpost_delay"
> +		"\tmod_alias\n");
> +	strcat(buf, out);
> +	mutex_lock(&chip->chn_config_lock);
> +	for (i = 0; i < CP2130_NUM_GPIOS; i++) {
> +		chn = &chip->chn_configs[i];
> +		ret += sprintf(out, "%d\t%d\t%d\t%d\t\t%d\t\t%d\t\t%s\t%d"
> +			"\t\t%d\t\t\t%d\t\t%d\t\t'%s'\n",
> +			i, chn->cs_en, chn->irq_pin, chn->clock_phase,
> +			chn->polarity, chn->cs_pin_mode,
> +			cp2130_spi_speed_to_string(chn->clock_freq),
> +			chn->delay_mask, chn->inter_byte_delay,
> +			chn->pre_deassert_delay, chn->post_assert_delay,
> +			chn->modalias);
> +		strcat(buf, out);
> +	}

This looks like a bunch of mostly very generic diagnostic data, if it's
useful to have it should be added in the framework so it's available for
all drivers.

> +static ssize_t channel_config_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{

This is adding a completely non-standard ABI for configuring things -
why not use standard interfaces?

> +static DEVICE_ATTR_RW(channel_config);

Device attributes in sysfs should follow sysfs rules, including having
just a single value per file to ease machine parsing.

> +out:
> +	return (!ret ? len : ret);

Please write normal conditional statements to make things easier for
people reading the driver.

> +	mutex_lock(&dev->usb_bus_lock);

What is this protecting?

> +	/* iterate through all transfers */
> +	list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
> +		dev_dbg(&master->dev, "spi transfer stats: %p, %p, %d",
> +			xfer->tx_buf, xfer->rx_buf, xfer->len);

It's not clear to me why the driver can't use transfer_one() instead of
transfer_one_message().

--BxpeiN0NM01wFavH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSgrMACgkQJNaLcl1U
h9AJMAf9GJlsjmO778tSaLTnZBeCqJvj5RljCQMi/cmoIz15D9ZERHjkN4OKiPvp
oTllfXURblRLya3/l8kMmpxQvfs5YSYvzMU7/tNf6iorRII723jTW6V/WSZTICQC
n+RazGdJl4WsshFuNPtw++ZfHQhhrha4lez57c/HGKcNtUfuJkeWkU7cC8iP1AHH
3z28258zF8gwSvRB4B2Opmn0yD+/SUSpHC0w1870QKzwdMhHbHp9xv5ClieTvrjB
YK+eEbuPmoYjcR6FbxdadmLPm+587jZ7u3RDVppikDZ7i+KURcJJF3Ea6G33G3Vf
ptV0EjfSd7PusAL09sEVQ4NZB15rPA==
=Avbz
-----END PGP SIGNATURE-----

--BxpeiN0NM01wFavH--
