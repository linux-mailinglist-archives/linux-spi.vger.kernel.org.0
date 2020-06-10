Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008051F56C7
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jun 2020 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFJO2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 10:28:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:65429 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJO2q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Jun 2020 10:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591799326; x=1623335326;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=+jjSmmvriHDq2IKMDGiGb5G90hNLhZ/epLsZVVJPoYI=;
  b=aBduEYDfgYPmcRTE8yilLrhEj2/YsDldexRqjdcX5qMazGRMH1bOnXGI
   ho1ij9Iq8MQY1UFQdumbwtkmNs1+rRsSY+bFjPIqy+BfNku/Yv5qgoJzq
   /KOtscrplDwuojIp7syoFLHvuiVjkL+rxUZ23D//ucZeJM43AoQEqHwbe
   4eZuljlN67Uzg3e19gWqRqSDI5CaDt1sulcLEtITzd8mzC7TfDsz8IXrD
   chJKAqELv1hu5g0lj+jnRJj16e5U9Q4ZRZf5Yxoe+SyoMlSgBeP8O4D4Y
   abvLm80UBQbg5QTpKq4j1BHlGyq63KGZPNVaU4SjulBmC9aTqgBj4uXvN
   g==;
IronPort-SDR: DbPcK9BJ+sH793Gakaw6r8CMko7DoQOwQijlgsU+vYUDcj9oB+fEjURGAKSRL+iFeCx5+pl1Im
 oQY85aC5hF/r9BaHVrtOpNcme/S/cZytKwJ2Gmz601nqNTejjsDNRciCvhIWcxlMhF1g+yOaiv
 FwlOYHT03culQphd9lr76c/LewNdHCmGnVqKApoFI0otFgj/bei8mGeG1eIs9dZQEYOlbTopL4
 X/QjtZMubfBjzcZzVupxgGLt3zStSVIcDN75aRXN/BoauX0TCH2giVXIxK+GwG47udyoHI15JS
 xg4=
X-IronPort-AV: E=Sophos;i="5.73,496,1583218800"; 
   d="scan'208";a="78930383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2020 07:28:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 10 Jun 2020 07:28:44 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3
 via Frontend Transport; Wed, 10 Jun 2020 07:28:42 -0700
References: <20200513140031.25633-1-lars.povlsen@microchip.com> <20200513140031.25633-6-lars.povlsen@microchip.com> <20200513151811.GL4803@sirena.org.uk> <20200519120519.GE24801@soft-dev15.microsemi.net> <20200602211203.3lad22zvt5yagane@mobilestation>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/10] spi: spi-dw-mmio: Spin off MSCC platforms into spi-dw-mchp
In-Reply-To: <20200602211203.3lad22zvt5yagane@mobilestation>
Date:   Wed, 10 Jun 2020 16:28:40 +0200
Message-ID: <87bllrhu5j.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Serge Semin writes:

> On Tue, May 19, 2020 at 02:05:19PM +0200, Lars Povlsen wrote:
>> On 13/05/20 16:18, Mark Brown wrote:
>> > Date: Wed, 13 May 2020 16:18:11 +0100
>> > From: Mark Brown <broonie@kernel.org>
>> > To: Lars Povlsen <lars.povlsen@microchip.com>
>> > Cc: SoC Team <soc@kernel.org>, Microchip Linux Driver Support
>> >  <UNGLinuxDriver@microchip.com>, linux-spi@vger.kernel.org,
>> >  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
>> >  linux-arm-kernel@lists.infradead.org, Alexandre Belloni
>> >  <alexandre.belloni@bootlin.com>
>> > Subject: Re: [PATCH 05/10] spi: spi-dw-mmio: Spin off MSCC platforms into
>> >  spi-dw-mchp
>> > User-Agent: Mutt/1.10.1 (2018-07-13)
>> >
>> > On Wed, May 13, 2020 at 04:00:26PM +0200, Lars Povlsen wrote:
>> >
>> > > +config SPI_DW_MCHP
>> > > + tristate "Memory-mapped io interface driver using DW SPI core of MSCC SoCs"
>> > > + default y if ARCH_SPARX5
>> > > + default y if SOC_VCOREIII
>> >
>> > Why the default ys?
>>
>> The SoC will typically boot from SPI... But its not a requirement per
>> se. I will remove it.
>>
>> >
>> > > +++ b/drivers/spi/Makefile
>> > > @@ -37,6 +37,7 @@ obj-$(CONFIG_SPI_DAVINCI)               += spi-davinci.o
>> > >  obj-$(CONFIG_SPI_DLN2)                   += spi-dln2.o
>> > >  obj-$(CONFIG_SPI_DESIGNWARE)             += spi-dw.o
>> > >  obj-$(CONFIG_SPI_DW_MMIO)                += spi-dw-mmio.o
>> > > +obj-$(CONFIG_SPI_DW_MCHP)                += spi-dw-mchp.o
>> > >  obj-$(CONFIG_SPI_DW_PCI)         += spi-dw-midpci.o
>> > >  spi-dw-midpci-objs                       := spi-dw-pci.o spi-dw-mid.o
>> > >  obj-$(CONFIG_SPI_EFM32)                  += spi-efm32.o
>> >
>> > Please keep the file alphabetically sorted.
>> >
>>
>> Noted.
>>
>> > > +++ b/drivers/spi/spi-dw-mchp.c
>> > > @@ -0,0 +1,232 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > +/*
>> > > + * Memory-mapped interface driver for MSCC SoCs
>> > > + *
>> >
>> > Please make the entire comment a C++ one so things look more
>> > intentional.
>>
>> Sure, I can do that. The presented form matches that of the other
>> spi-dw-* drivers, but I can see other using // blocks. Ack.
>>
>> >
>> > > +#define MAX_CS           4
>> >
>> > This should be namespaced.
>>
>> Ack.
>>
>
>> >
>> > > + rx_sample_dly = 0;
>> > > + device_property_read_u32(&pdev->dev, "spi-rx-delay-us", &rx_sample_dly);
>> > > + dws->rx_sample_dly = DIV_ROUND_UP(rx_sample_dly,
>> > > +                                   (dws->max_freq / 1000000));
>
> Perhaps 100000 is better to be replace with macro USEC_PER_SEC...
>
> Moreover are you sure the formulae is correct?
> dws->rx_sample_dly - a number of ssi_clk periods/cycles to delay the Rx-data sample,
> dws->max_freq - ssi_clk frequency (not period).
>
> In real math the formulae would look like:
> S = d * P [s], where d - number of delay cycles, P - ssi_clk period in seconds,
> S - requested delay in seconds.
> In the driver notation: d = dws->rx_sample_dly, P = 1 / dws->max_freq,
> S = rx_sample_dly ("spi-rx-delay-us" property value).
>
> dws->rx_sample_dly * (1 / dws->max_freq) = rx_sample_dly <=>
> dws->rx_sample_dly = rx_sample_dly * dws->max_freq.
>
> Though that's represented in seconds, so if rx_sample_dly is specified in usec,
> then you'd need to scale it down dividing by USEC_PER_SEC.
>
> For example, imagine we need a delay of 1 usec with ssi_clk of 50MHz.
> By your formulae we'd have: 1 / (50000000 / 1000000) = 0 cycles (actually 1 due
> to DIV_ROUND_UP, but incorrect anyway),
> By mine: 1 * (500000000 / 1000000) = 50 cycles. Seems closer to reality.
>
> Am I missing something?

No, you are perfectly right, the calculation was wrong - and I concur
the unit should be NS.

(your example threw me off, you are using 500Mhz, typo I guess)

I believe the calculation should be:

  device_property_read_u32(&pdev->dev, "snps,rx-sample-delay-ns", &rx_sample_dly);
  dws->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly, NSEC_PER_SEC / dws->max_freq);
        
So for your example of 1us = 1000ns, we have a cycle time of 20 ns => 50 cycles.

And I assume DIV_ROUND_CLOSEST() is the better instead of explicit
rounding up/down. And I assume its fair to assume that the cycle time is
not a fraction.

Ok?

>
>> >
>> > If this is a standard feature of the DesignWare IP why parse it here and
>> > not in the generic code?
>>
>> This is a standard feature of the DesignWare IP, so good suggestion. I
>> will arrange with Serge.
>
> Regarding "spi-rx-delay-us" and the sampling delay the IP supports. Here is what
> documentation says regarding the register, which is then initialized with this
> parameter "This register controls the number of ssi_clk cycles that are
> delayed from the default sample time before the actual sample of the rxd input
> signal occurs." While the "spi-rx-delay-us" property is described as: "Delay, in
> microseconds, after a read transfer." I may misunderstand something, but IMO
> these descriptions don't refer to the same values. The only real use of the
> "spi-rx-delay-us" property I've found in "./drivers/input/rmi4/rmi_spi.c".
> That driver gets the value of the property and just sets the delay_usecs
> of some transfers, which isn't even close to the functionality the RX_SAMPLE_DLY
> register provides.
>
> To be clear the RX_SAMPLE_DLY register can be used to delay the RX-bits sample
> with respect to the normal Rx sampling timing. The delay is measured in the
> numbers of the ssi_clk periods. (Note also that the maximum delay is limited
> with a constant parameter pre-initialized at the IP-core synthesis stage. It can
> be defined within a range [4, 255]. In our IP it's limited with just 4 periods.)
>

Yes - I was not aware of the instantiation incurred limit before. Turned
our IP has up to 100ns worth of fifo depth - 25 cycles.

> As I see it, a better way would be to either define a new vendor-specific
> property like "snps,rx-sample-delay-ns" (note NS here, since normally the
> ssi_clk is much higher than 1MHz), or define a new generic SPI property.
> Mark, Andy?

I'll assume "snps,rx-sample-delay-ns" for now, its easy to rename if you
decide so.

Thanks again!

---Lars

>
> -Sergey
>
>>
>> Thank you for your comments!
>>
>> ---Lars
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lars Povlsen,
Microchip
