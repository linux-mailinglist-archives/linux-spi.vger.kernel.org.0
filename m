Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26EB2E8051
	for <lists+linux-spi@lfdr.de>; Thu, 31 Dec 2020 15:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLaOYD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Dec 2020 09:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaOYC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Dec 2020 09:24:02 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26CC061573;
        Thu, 31 Dec 2020 06:23:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id C39C830000899;
        Thu, 31 Dec 2020 15:23:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B1FD74EA00; Thu, 31 Dec 2020 15:23:19 +0100 (CET)
Date:   Thu, 31 Dec 2020 15:23:19 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] Add support for Realtek RTL838x/RTL839x
 SoC SPI controllers
Message-ID: <20201231142319.GA28104@wunner.de>
References: <20201229231904.2558916-1-bert@biot.com>
 <20201229231904.2558916-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229231904.2558916-2-bert@biot.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 30, 2020 at 12:19:04AM +0100, Bert Vermeulen wrote:
> +static inline void wait_ready(struct rtspi *rtspi)
> +{
> +	while (!(readl(REG(RTL8380_SPI_SFCSR)) & RTL8380_SPI_SFCSR_RDY))
> +		;
> +}

I'd suggest calling cpu_relax() in the loop's body.


> +	err = devm_spi_register_controller(&pdev->dev, ctrl);

Since you're invoking devm_spi_register_controller() on probe,
the controller must not be unregistered explicitly on remove.
So the ->remove hook can be dropped altogether:

> +static int realtek_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
> +
> +	spi_unregister_controller(ctrl);
> +
> +	return 0;
> +}
[...]
> +	.remove = realtek_spi_remove,

The ->probe hook otherwise LGTM.

Thanks,

Lukas
