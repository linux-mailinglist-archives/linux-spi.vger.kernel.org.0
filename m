Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7938D2AC5A6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 20:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgKIT7S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIT7S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 14:59:18 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00B9C0613CF;
        Mon,  9 Nov 2020 11:59:17 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t13so11881260ljk.12;
        Mon, 09 Nov 2020 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S3iazPmtjzMdjRarndPr8r8baCDNuFU5wUTeFbgI2sQ=;
        b=Yscmii5OjIHoiyc3HGuG5+5bgq5BO8r2948cOAd1ItbG8PA768drEKR4S4fxiFL/lO
         n/mZ3WkP2bIUbzP+SFYrbD3JGSvYsdPJ6p+bmqxyrvmhehvAoAMmGWYc131Z4TUucC7I
         hgsWBGO0FipMkNLE6Ve5dKGMtQw8+rmzjCze5mF/vMPiEyswKoD14EpvBWf0geyIVXuZ
         0F6yzZrmpj/ivx9+A0OaILCkNutDwKVbKsPsnpgDtozA5I8UDqho79YIeoEtuFI52XPh
         0HrRE/LGTRrWqOVRYaynUp8n9uftu7Ro2FWWNDqrPdfZ5Jr1k7cCQOs7SuK7GK9W9p1i
         M5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S3iazPmtjzMdjRarndPr8r8baCDNuFU5wUTeFbgI2sQ=;
        b=uIlAQsE+IFcvk64LQljAvSbRtmPffay3INP+vQfgjkDRabIx/TVwhFxdYEwT7l5Xwj
         jYT88q6ynVhBeVoI6Kg4qFggSUyeE/08m7zzHEJXmhsv/kH6Xq8/JjLnjaad+ZtI80yu
         JQoslj+PbrEyxcHdu29X09T005Mj/5DB0y9RGhfEtNtrGRKfVM0PNyhagbMLhTWE6D1l
         F5eUwDt1oyBXLJJDQTsPvI5XWU1T7WAamPusMmhc1BATp0N6o9RzvQD6u4XrczhPn+Uw
         ZgT2L0i7xtdha2IfQvnSdMeEOp6aiDLJ7334zFpWIblUPQHdAFWggCVYeX9x5X815R9Y
         rctw==
X-Gm-Message-State: AOAM531hPK/6a0fTRz+gQ6zNIURMMnsjJeJlKrVJDweJVH++hQ4mfe+j
        I9lmm9+MuHXIxJLimd13CM0=
X-Google-Smtp-Source: ABdhPJzZmgrWnRvtkYdvSKe5iYqnKYNSn92AAZUaNbioHnovUHyViefzfa6TyUqom+q15qRa/ht1nw==
X-Received: by 2002:a05:651c:1256:: with SMTP id h22mr7331152ljh.263.1604951956194;
        Mon, 09 Nov 2020 11:59:16 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id p25sm783725lfc.125.2020.11.09.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 11:59:15 -0800 (PST)
Date:   Mon, 9 Nov 2020 22:59:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 04/32] spi: dw: Introduce polling device tree property
Message-ID: <20201109195913.itgfj2ga5y7sr6zx@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107081420.60325-5-damien.lemoal@wdc.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Nov 07, 2020 at 05:13:52PM +0900, Damien Le Moal wrote:
> With boards that have slow interrupts context switch, and a fast device
> connected to a spi master, e.g. an SD card through mmc-spi,

> using
> dw_spi_poll_transfer() intead of the regular interrupt based
> dw_spi_transfer_handler() function is more efficient and

I can believe in that. But the next part seems questionable:

> can avoid a lot
> of RX FIFO overflow errors while keeping the device SPI frequency
> reasonnably high (for speed).

No matter whether it's an IRQ-based or poll-based transfer, as long as a
client SPI-device is connected with a GPIO-based chip-select (or the
DW APB SSI-controller feature of the automatic chip-select toggling is
fixed), the Rx FIFO should never overrun. It's ensured by the transfer
algorithm design by calculating the rxtx_gap in the dw_writer()
method. If the error still happens then there must be some bug in
the code.

It's also strange to hear that the polling-based transfer helps
to avoid the Rx FIFO overflow errors, while the IRQ-based transfer
causes them. Both of those methods are based on the same dw_writer()
and dw_reader() methods. So basically they both should either work
well or cause the errors at same time.

So to speak could you more through debug your case?

On the other hand the errors (but not the Rx FIFO overflow) might be
caused by the DW APB SSI nasty feature of the native chip-select
automatic assertion/de-assertion. So if your MMC-spi port is handled
by the native DW APB SSI CS lane, then it won't work well for sure.
No matter whether you use the poll- or IRQ-based transfers.

-Sergey


> Introduce the "polling" device tree
> property to allow requesting polled processing of transfer depending on
> the connected device while keeping the spi master interrupts property
> unschanged. E.g. device trees such as:
> 
> Generic soc.dtsi dts:
> 
> spi0: spi@53000000 {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	compatible = "snps,dw-apb-ssi";
> 	reg = <0x53000000 0x100>;
> 	interrupts = <2>;
> 	...
> }
> 
> Board specific dts:
> 
> ...
> &spi0 {
> 	polling;
> 	status = "okay";
> 
> 	slot@0 {
> 		compatible = "mmc-spi-slot";
> 		reg = <0>;
> 		voltage-ranges = <3300 3300>;
> 		spi-max-frequency = <4000000>;
> 	};
> }
> 
> will result in using polled transfers for the SD card while other boards
> using spi0 for different peripherals can use interrupt based transfers
> without needing to change the generic base soc dts.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/spi/spi-dw-mmio.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> index d0cc5bf4fa4e..3f1bc384cb45 100644
> --- a/drivers/spi/spi-dw-mmio.c
> +++ b/drivers/spi/spi-dw-mmio.c
> @@ -20,6 +20,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/interrupt.h>
>  
>  #include "spi-dw.h"
>  
> @@ -246,9 +247,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>  
>  	dws->paddr = mem->start;
>  
> -	dws->irq = platform_get_irq(pdev, 0);
> -	if (dws->irq < 0)
> -		return dws->irq; /* -ENXIO */
> +	if (device_property_read_bool(&pdev->dev, "polling")) {
> +		dws->irq = IRQ_NOTCONNECTED;
> +	} else {
> +		dws->irq = platform_get_irq(pdev, 0);
> +		if (dws->irq < 0)
> +			return dws->irq; /* -ENXIO */
> +	}
>  
>  	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dwsmmio->clk))
> -- 
> 2.28.0
> 
