Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769AD1AD43
	for <lists+linux-spi@lfdr.de>; Sun, 12 May 2019 19:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfELRFn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 May 2019 13:05:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfELRFn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 May 2019 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NjameZdy07GXrnYB3egZ9x9jkXwU69GYuWQhuwBGLF0=; b=qbftyWRofeynHyGSqHc4PEhdC
        jJfSPVmsSR/WVOZhIM22P2KElvP8lIU/xm5KNXRO398B0W9iYMGWDnjDm8Dnh9wB9lgOhn1v9ECul
        oxkqaIHEylzKdhk4u1TYxvpLkptMHlorDOcEFLKBAB0JlqftTPccw+gliXfKIN3wW0E0k=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044b-8I; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D2BAB440052; Sun, 12 May 2019 09:26:45 +0100 (BST)
Date:   Sun, 12 May 2019 17:26:45 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc:     linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Added driver for CP2130 USB-to-SPI bridge
Message-ID: <20190512082645.GK21483@sirena.org.uk>
References: <1557144380-19935-1-git-send-email-jh@henneberg-systemdesign.com>
 <1557144380-19935-2-git-send-email-jh@henneberg-systemdesign.com>
 <20190508071812.GS14916@sirena.org.uk>
 <87sgto16kr.fsf@henneberg-systemdesign.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <87sgto16kr.fsf@henneberg-systemdesign.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2019 at 08:32:20AM +0200, Jochen Henneberg wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Mon, May 06, 2019 at 02:06:20PM +0200, Jochen Henneberg wrote:

> >> +	mutex_lock(&chip->chn_config_lock);
> >> +	for (i = 0; i < CP2130_NUM_GPIOS; i++) {
> >> +		chn = &chip->chn_configs[i];
> >> +		ret += sprintf(out, "%d\t%d\t%d\t%d\t\t%d\t\t%d\t\t%s\t%d"
> >> +			"\t\t%d\t\t\t%d\t\t%d\t\t'%s'\n",
> >> +			i, chn->cs_en, chn->irq_pin, chn->clock_phase,
> >> +			chn->polarity, chn->cs_pin_mode,
> >> +			cp2130_spi_speed_to_string(chn->clock_freq),
> >> +			chn->delay_mask, chn->inter_byte_delay,
> >> +			chn->pre_deassert_delay, chn->post_assert_delay,
> >> +			chn->modalias);
> >> +		strcat(buf, out);
> >> +	}

> > This looks like a bunch of mostly very generic diagnostic data, if it's
> > useful to have it should be added in the framework so it's available for
> > all drivers.

> The information is quite specific for the CP2130 so I cannot see how
> this could fit into the SPI framework.

All those delays, polarities and speeds look very generic.

> We could use the timing information that comes with each SPI transfer to
> setup the transport parameters of the chip, however, there are several
> settings that may be incomplete. E. g. the IRQ pin. If the SPI slave
> chip IRQ is connected to one of the GPIOs of CP2130 nobody knows upfront
> which IRQ to configure for the slave chip driver. Same issue applies for
> the CS pin, there is pre-numbered GPIO available for CS before the
> CP2130 is plugged so you cannot setup other driver in advance.

This is the same problem as all the plugin modules for non-enumerable
buses like the Raspberry Pi have, they currently use things like DT or
ACPI overlays to enumerate - there are some efforts at improving things
as it's not ideal at the minute.  I'd expect you to be trying to use
similar interfaces to them rather than inventing something completely
driver specific, users shouldn't have to figure out some random driver
specific interface for this.

> If the chip is permanently connected (e. g. in an embedded board, which
> is unlikely because those often have host SPI ports anyway) we may have
> an advantage from DT pre-configuration but I think this use-case is
> quite unlikely and then there would still be the problem to know which
> data is valid, the one that comes with the transfer message or the one
> configured from sysfs.

This is one reason why you shouldn't have a random sysfs interface.

> >> +	/* iterate through all transfers */
> >> +	list_for_each_entry(xfer, &mesg->transfers, transfer_list) {
> >> +		dev_dbg(&master->dev, "spi transfer stats: %p, %p, %d",
> >> +			xfer->tx_buf, xfer->rx_buf, xfer->len);

> > It's not clear to me why the driver can't use transfer_one() instead of
> > transfer_one_message().

> The documentation says that if both callbacks are provided the framework
> will always use transfer_one_message() which I think is the superior
> callback because we can keep the SPI configuration as it is if the same

No, it's better to use transfer_one() if you can as it means there is
less open coding of standard features in the driver.

> channel is used with subsequent transfers (performance) which we cannot
> do for transfer_one(), at least if the driver should remain stateless
> for the transfers.

It's perfectly OK to cache the last settings that were sent to the
hardware and only reconfigure if there's a change, several drivers do
that already.

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX2MUACgkQJNaLcl1U
h9C/Kwf6A8gheJrX5sK4mxJKeM6fglrDGdvaPLlu6eRuyKkTsfbQ1WLcCLB6tJyZ
WFNu6iS4uUQryGjJl5DSnx2MzEGkpcp3AUHE5g6vvgCMEl2EyqZPVNtCGwpPDnnW
h3PKTjUTJpFY+ueRnS53EdKQ+G1ZSPKdKdIpjVxfxXVByJggw/x/Nfw3ozaoOr7I
v2e2AfkeQwiIwGW+QjSd1AW7Mw5dPPscw9hT7Xr9zcBQLv2mse63opUg/LNhETaW
w58nXrkqAMIFDNeyTkx0cPGqcFL7xfjMBYdQgeMnSDSFXT5+2obAtGhOEUsSpVn2
3YdTHdMd/bfIpXpWhM7ETk6cShC7CA==
=6mdv
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
