Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DB81D9355
	for <lists+linux-spi@lfdr.de>; Tue, 19 May 2020 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgESJ3V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 May 2020 05:29:21 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:62993 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgESJ3U (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 May 2020 05:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589880559; x=1621416559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LaB5Sv8zHtLu9L4Qfmtj8Pn6PDVEZl9Yco0qR/2/0m8=;
  b=YYzGnQFcyDgaR+Ytrpr7QqA6scscm6Co2xe+05lcFuRaEtXy6smSeGm4
   Lzp1c7yQJSjo6qs6wMVEgDdt+7ia0AaXuGmmc6gUbtZcor92qEPL5DSlW
   jN0buoTDkPopA0uEG8CsV98FoVzstwSQ7XFEFQz1Ik6SttIMWQ8fUVp//
   Ezs6+hu61/WrKCmGCaK9Q+HGH6R+ZB7ieQ3XHocYGGJwiA+f3MiuUEWR+
   qEeXTSCBYJzLVP6x8sxtcXKfaXFS1W22qAUWWTFVmmYhNfAId9p8nM+ap
   rvAAHLtu9VO4Gms1WvMkBnjfsCHSORyceyCdTWPFDbyMZGzYBn6djfBN8
   g==;
IronPort-SDR: 0jSv+TvDQbzH9lV/jI9Rsy/kQWjkif90PfiWaRgHCo7c/7Z0zqfK/CJ0FFPd2hLgZpn9kIut+b
 P9e+46l0c/uTZnIWNyHevawBmLAJ+4vxvZVmh3LlmRwKWotrMV5ikDlNy4lEK1+xkR3dbJUOpF
 QuMevA6pIGc291C+AGZRCdOlQy3zLqKS9ACyLJfseLQagzO3VjDLdhoDkPz6v7wQ6lBhpDPxJy
 5o8jC8ZtRYgad7mo+/KkU4VaonnSn2bb6fY3Sd9uqm9hSCe8bC5CjCGlprzB0yMG8/Q5LVk69N
 ASk=
X-IronPort-AV: E=Sophos;i="5.73,409,1583218800"; 
   d="scan'208";a="12818922"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2020 02:29:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 May 2020 02:29:20 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 May 2020 02:29:18 -0700
Date:   Tue, 19 May 2020 11:29:17 +0200
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 07/10] spi: spi-dw-mchp: Add Sparx5 support
Message-ID: <20200519092917.GB24801@soft-dev15.microsemi.net>
References: <20200513140031.25633-1-lars.povlsen@microchip.com>
 <20200513140031.25633-8-lars.povlsen@microchip.com>
 <20200514102516.GD5127@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200514102516.GD5127@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


[Sorry about the slight delay on getting back on this]

On 14/05/20 11:25, Mark Brown wrote:

> Date: Thu, 14 May 2020 11:25:16 +0100
> From: Mark Brown <broonie@kernel.org>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: SoC Team <soc@kernel.org>, Microchip Linux Driver Support
>  <UNGLinuxDriver@microchip.com>, linux-spi@vger.kernel.org,
>  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, Alexandre Belloni
>  <alexandre.belloni@bootlin.com>
> Subject: Re: [PATCH 07/10] spi: spi-dw-mchp: Add Sparx5 support
> User-Agent: Mutt/1.10.1 (2018-07-13)
> 
> On Wed, May 13, 2020 at 04:00:28PM +0200, Lars Povlsen wrote:
> 
> > +static void dw_spi_mchp_set_cs_owner(struct dw_spi_mchp *dwsmchp,
> > +				     const struct dw_spi_mchp_props *props,
> > +				     u8 cs, u8 owner)
> >  {
> > +	u8 dummy = (owner == MSCC_IF_SI_OWNER_SIBM ?
> > +		    MSCC_IF_SI_OWNER_SIMC : MSCC_IF_SI_OWNER_SIBM);
> 
> Please write normal conditional statements to improve legibility.
> 

I will take your recommendation to heart.

> > +static void dw_spi_mchp_set_cs(struct spi_device *spi, bool nEnable)
> > +{
> > +	bool enable = !nEnable;	/* This keeps changing in the API... */
> 
> No, it doesn't.  The API has not changed for more than a decade.
> 

I will remove the comment.

I think the comment was related to when we got bitten by the below
change, but alas.

commit ada9e3fcc175db4538f5b5e05abf5dedf626e550
Author: Charles Keepax <ckeepax@opensource.cirrus.com>
Date:   Wed Nov 27 15:39:36 2019 +0000

    spi: dw: Correct handling of native chipselect

    This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
    of native chipselect").
    
> > +	} else if (props->ss_force_ena_off) {
> > +		if (enable) {
> > +			/* Ensure CS toggles, so start off all disabled */
> > +			regmap_write(dwsmchp->syscon, props->ss_force_val_off,
> > +				     ~0);
> 
> What's all this force_ena_off stuff about?  The controller should not be
> making decisions about management of the chip select, this will break
> users.
> 

Our controller is not using DMA, but the FIFO interface. And as the DW
controller drops CS when the FIFO runs empty, this will upset SPI
devices. The "ss_force" is something the HW designes put on top to
"override" the CS. We could of course use the GPIO's specifically to
overcome this - but the "boot" CS 0 is a builtin CS, with no
underlying GPIO.

Add to this that the HW dept decided to add *2* physical SPI busses to
the same controller. That we also need to switch between. And ensure
CS gets dropped correctly before changing tracks...

Long story, lot of grief...

> > +	if (pdev->dev.of_node) {
> > +		int i;
> > +
> > +		for (i = 0; i < dws->num_cs; i++) {
> > +			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
> > +					"cs-gpios", i);
> > +
> > +			if (cs_gpio == -EPROBE_DEFER) {
> > +				ret = cs_gpio;
> > +				goto out;
> > +			}
> > +
> > +			if (gpio_is_valid(cs_gpio)) {
> > +				ret = devm_gpio_request(&pdev->dev, cs_gpio,
> > +						dev_name(&pdev->dev));
> > +				if (ret)
> > +					goto out;
> 
> Set use_gpio_descriptors and let the core manage the GPIO.

Good suggestion, just the ticket!

And thank you very much for your time & comments.

---Lars

