Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4262CE3508
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 16:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409295AbfJXOHf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 10:07:35 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:38928 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404950AbfJXOHf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 10:07:35 -0400
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id 96296AC0078; Thu, 24 Oct 2019 16:07:32 +0200 (CEST)
Date:   Thu, 24 Oct 2019 16:07:32 +0200
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024140731.GA2950@salem.gmr.ssr.upm.es>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
 <20191024134116.GF46373@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024134116.GF46373@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 24, 2019 at 02:41:16PM +0100, Mark Brown wrote:
> On Thu, Oct 24, 2019 at 03:18:57PM +0200, Alvaro Gamez Machado wrote:
> > On Thu, Oct 24, 2019 at 02:11:29PM +0100, Mark Brown wrote:
> 
> > > No, that still leaves the slave driver thinking it's sending 8 bits when
> > > really it's sending something else - the default is just 8 bits, if the
> > > controller can't do it then the transfer can't happen and there's an
> > > error.  It's not a good idea to carry on if we're likely to introduce
> > > data corruption.
> 
> > Well, yes. But I don't think that's a software issue but a hardware one.
> 
> > If you have a board that has a SPI master that cannot talk to an 8 bits
> > device and you expect to communicate with anything that accepts 8 bits
> > you're not going to be able to. Either the kernel raises an error or it
> > shuts up and tries its best. I understand the first option is better, but I
> > also think that's not a software issue, that hardware simply cannot work as
> > is regardless of what we do in software. The hardware devices simply can't
> > talk to each other.
> 
> Sure, but then it's going to be easier to diagnose problems if the
> software says that it's identified a data format problem than it is to
> try to figure out the results of data corruption.  There is also the
> possibility that if the formats the hardware needs to use can be made to
> align through rewriting software can persuade things to interoperate
> (eg, if all the transfers are multiples of 32 bits then a device can
> probably work with a controller that only supports 32 bit words even if
> the device expects a byte stream) but that requires explicit code rather
> than just silently accepting the data and hoping for the best.

I guess there could be some workarounds to help in that situation. But I see
that as an hypothetical occurrence whereas I have with me a physical board
that needs 32 bits in both master and slave that I want to access using
spidev and cannot. Lots of I's in that sentence, I know :)

Anyhow, if this is not acceptable, the only other alternative I see right
now is adding a new DT property, as in my emails yesterday.


diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f9502dbbb5c1..06424b7b0d73 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1792,6 +1792,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 	spi->max_speed_hz = value;
 
+	/* Bits per word */
+	if (!of_property_read_u32(nc, "spi-bits-per-word", &value))
+		spi->bits_per_word = value;
+
 	return 0;
 }

What do you think about this? This requires the user to explicitly select a
different value rather than the default, so it can't break anything and
would allow with the diagnostic of such broken hardware.

I still think I like more changing the default to something the master is
able to do. Otherwise we're going to keep trying to send 8 bits using a
master that simply cannot do that, but this solution would work fine as
well.

Regards,

-- 
Alvaro G. M.
