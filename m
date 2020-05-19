Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8E1D95D5
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgESMF1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 08:05:27 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:41807 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMF0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 08:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589889926; x=1621425926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q+uMgkWii/Rp8nZstyK9Xz4jIR2voQK7J5e60BEVm4E=;
  b=mS3x+eR5+4se2eSukVoJcXFJAhtcWMmjcBugA9jKg+sXkktXFHjaxgj1
   xKJKxxi6+S+tAqpzEEeQDxQc48vTanf9PY6R+bp6ovArAjDdJYxQd30Qx
   W/fNGh9SKSh6YOyFEDgms1jE7qbN0q5e3uxShOSUIIypu9PaUZrzMRvUm
   JX7jcMJL7OJ4IyENCpnV0pm1iAJh0eneEdSwRsQAGbfC6eky4U15I+ikq
   nQ/d9KXbfgbJ7IyNndzIDG0faRwnSmRKIeHd3npZ56FrXNekYs0PrGHZv
   9+5H4drRWRaXK4UUgzAeVltbhPRy7Z4u/EbfQW0bS6HO4aPcZ7knjIz2t
   w==;
IronPort-SDR: RnaVAjoz7qlXYMO1U7Qf00Q1j9MjlGTJ5imBEoeQvtjHIpfDMXUeF8auplwCmIZVc3Kf61ZPrW
 7194go2GC/2b3tc8QV/pd+xedtcmeIiyBHKZcmiZ9lZ34WrUNApXEb4J2dEB1UWSCeiKMLjTS9
 sFLtmAFWo9CiK+BITa8mB7Ka7lCPxPG50pqHKEUar6yR5l6L2VF2UWL1gGPUjhoDslBxMWqIho
 EWs9ppZc7Yi+8JLhoT1SiMcuSSWFpdraxWoyDXOMjqCUQzaz/Sz+Es4OOBFoTrLAgnyEmQKbFl
 o9s=
X-IronPort-AV: E=Sophos;i="5.73,410,1583218800"; 
   d="scan'208";a="73868962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 05:05:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 05:05:26 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 May 2020 05:05:25 -0700
Date:   Tue, 19 May 2020 14:05:19 +0200
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH 05/10] spi: spi-dw-mmio: Spin off MSCC platforms into
 spi-dw-mchp
Message-ID: <20200519120519.GE24801@soft-dev15.microsemi.net>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-6-lars.povlsen@microchip.com>
 <20200513151811.GL4803@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200513151811.GL4803@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13/05/20 16:18, Mark Brown wrote:
> Date: Wed, 13 May 2020 16:18:11 +0100
> From: Mark Brown <broonie@kernel.org>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: SoC Team <soc@kernel.org>, Microchip Linux Driver Support
>  <UNGLinuxDriver@microchip.com>, linux-spi@vger.kernel.org,
>  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, Alexandre Belloni
>  <alexandre.belloni@bootlin.com>
> Subject: Re: [PATCH 05/10] spi: spi-dw-mmio: Spin off MSCC platforms into
>  spi-dw-mchp
> User-Agent: Mutt/1.10.1 (2018-07-13)
> 
> On Wed, May 13, 2020 at 04:00:26PM +0200, Lars Povlsen wrote:
> 
> > +config SPI_DW_MCHP
> > +	tristate "Memory-mapped io interface driver using DW SPI core of MSCC SoCs"
> > +	default y if ARCH_SPARX5
> > +	default y if SOC_VCOREIII
> 
> Why the default ys?

The SoC will typically boot from SPI... But its not a requirement per
se. I will remove it.

> 
> > +++ b/drivers/spi/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_DAVINCI)		+= spi-davinci.o
> >  obj-$(CONFIG_SPI_DLN2)			+= spi-dln2.o
> >  obj-$(CONFIG_SPI_DESIGNWARE)		+= spi-dw.o
> >  obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
> > +obj-$(CONFIG_SPI_DW_MCHP)		+= spi-dw-mchp.o
> >  obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
> >  spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
> >  obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
> 
> Please keep the file alphabetically sorted.
> 

Noted.

> > +++ b/drivers/spi/spi-dw-mchp.c
> > @@ -0,0 +1,232 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Memory-mapped interface driver for MSCC SoCs
> > + *
> 
> Please make the entire comment a C++ one so things look more
> intentional.

Sure, I can do that. The presented form matches that of the other
spi-dw-* drivers, but I can see other using // blocks. Ack.

> 
> > +#define MAX_CS		4
> 
> This should be namespaced.

Ack.

> 
> > +	rx_sample_dly = 0;
> > +	device_property_read_u32(&pdev->dev, "spi-rx-delay-us", &rx_sample_dly);
> > +	dws->rx_sample_dly = DIV_ROUND_UP(rx_sample_dly,
> > +					  (dws->max_freq / 1000000));
> 
> If this is a standard feature of the DesignWare IP why parse it here and
> not in the generic code?

This is a standard feature of the DesignWare IP, so good suggestion. I
will arrange with Serge.

Thank you for your comments!

---Lars

