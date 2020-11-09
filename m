Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961142AB5B1
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgKILCQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 06:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgKILCP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 06:02:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A0C0613CF
        for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2020 03:02:15 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kc4w5-0001m3-QE; Mon, 09 Nov 2020 12:02:09 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kc4w5-0003LB-Al; Mon, 09 Nov 2020 12:02:09 +0100
Date:   Mon, 9 Nov 2020 12:02:09 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] Input: ads7846: do not overwrite spi->mode flags
 set by spi framework
Message-ID: <20201109110209.lz5polbjvvoq5fwa@pengutronix.de>
References: <20201027095724.18654-1-o.rempel@pengutronix.de>
 <20201027095724.18654-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027095724.18654-3-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:01:07 up 360 days,  2:19, 29 users,  load average: 0.49, 0.22,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Dmitry,

ping for this patch as well.

Regards,
Oleksij

On Tue, Oct 27, 2020 at 10:57:24AM +0100, Oleksij Rempel wrote:
> Do not overwrite spi->mode flags set by spi framework, otherwise the
> chip select polarity will get lost.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/input/touchscreen/ads7846.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 8fd7fc39c4fd..f2dc2c8ab5ec 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1288,7 +1288,8 @@ static int ads7846_probe(struct spi_device *spi)
>  	 * may not.  So we stick to very-portable 8 bit words, both RX and TX.
>  	 */
>  	spi->bits_per_word = 8;
> -	spi->mode = SPI_MODE_0;
> +	spi->mode &= ~SPI_MODE_X_MASK;
> +	spi->mode |= SPI_MODE_0;
>  	err = spi_setup(spi);
>  	if (err < 0)
>  		return err;
> -- 
> 2.28.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
