Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10418E6F43
	for <lists+linux-spi@lfdr.de>; Mon, 28 Oct 2019 10:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfJ1Jnw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Oct 2019 05:43:52 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:60512 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732446AbfJ1Jnw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Oct 2019 05:43:52 -0400
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id B87BAAC0B9F; Mon, 28 Oct 2019 10:43:46 +0100 (CET)
Date:   Mon, 28 Oct 2019 10:43:46 +0100
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191028094345.GA20816@salem.gmr.ssr.upm.es>
References: <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
 <20191024134116.GF46373@sirena.co.uk>
 <20191024140731.GA2950@salem.gmr.ssr.upm.es>
 <20191024174033.GG46373@sirena.co.uk>
 <20191025063947.GA19665@salem.gmr.ssr.upm.es>
 <20191025115655.GA4568@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025115655.GA4568@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 25, 2019 at 12:56:55PM +0100, Mark Brown wrote:
> On Fri, Oct 25, 2019 at 08:39:48AM +0200, Alvaro Gamez Machado wrote:
> 
> > to claim the specific SPI slave. It may be spidev as in my use case, or it
> > may really be any other driver. But its probe() function is never going to
> > be called because the error is not raised inside the driver, but immediately
> > after forcibly setting the default value to 8 in spi.c
> 
> Then you need to extend the validation the core is doing here to
> skip this parameter when registering the device and only enforce
> it after a driver is bound, we don't have a driver at the time we
> initially register the device so we can't enforce this.

Ok, so I can remove the call to __spi_validate_bits_per_word() from
spi_setup(), and instead place it on spi_drv_probe after calling
spi_drv_probe() and detach the device if it returns with an error. The
behaviour would be basically the same as it is now, but the slave driver
will have an opportunity to choose a different transfer width if it wants to
and can match the capabilities of the master.

> 
> > I can't modify spidev because spidev doesn't even know this is happening.
> 
> You are, at some point, going to need to set your spidev to 32
> bits per word (spidev does already support this).

If I do the former, spidev will then need to load the initial bits per word
value from DT before returning from probe(), otherwise it will end up detached
when the check above is performed.

Should I go for this?

Thanks

-- 
Alvaro G. M.
