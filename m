Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4659E43A7
	for <lists+linux-spi@lfdr.de>; Fri, 25 Oct 2019 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393165AbfJYGjv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Oct 2019 02:39:51 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:42704 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbfJYGjv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Oct 2019 02:39:51 -0400
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id CE7B6AC007D; Fri, 25 Oct 2019 08:39:48 +0200 (CEST)
Date:   Fri, 25 Oct 2019 08:39:48 +0200
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191025063947.GA19665@salem.gmr.ssr.upm.es>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
 <20191024131856.GA32609@salem.gmr.ssr.upm.es>
 <20191024134116.GF46373@sirena.co.uk>
 <20191024140731.GA2950@salem.gmr.ssr.upm.es>
 <20191024174033.GG46373@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024174033.GG46373@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 24, 2019 at 06:40:33PM +0100, Mark Brown wrote:
> On Thu, Oct 24, 2019 at 04:07:32PM +0200, Alvaro Gamez Machado wrote:
> 
> > I guess there could be some workarounds to help in that situation. But I see
> > that as an hypothetical occurrence whereas I have with me a physical board
> > that needs 32 bits in both master and slave that I want to access using
> > spidev and cannot. Lots of I's in that sentence, I know :)
> 
> If you want to access this using spidev then add support for changing
> the word size to spidev and use that as I think Geert already suggested.

I've been trying to do so for a couple hours and I've reached a conclusion.

I've been too focused on my personal use case (too many I's indeed) and
thought that the problem was in fact in spidev as Geert indicated, but now
I think it isn't, so I must present my excuses for mistakenly drive the
conversation in that direction. Geert also thought this could be an SPI core
bug, and he was right on that, I think.

In fact, not a single line of spidev is being executed when the error
message is printed:

xilinx_spi 44a00000.spi: at 0x44A00000 mapped to 0x(ptrval), irq=3
xilinx_spi 44a10000.spi: can't setup spi1.0, status -22
spi_master spi1: spi_device register error /amba_pl/spi@44a10000/spidev@0
spi_master spi1: Failed to create SPI device for /amba_pl/spi@44a10000/spidev@0

This does not come from spidev but directly from spi. What is happening is
that when SPI slaves are defined via DT, their bits_per_word value is always
unset (as 0), which turns later on in a default value of 8.

Inside spi_setup function immediately after setting this default value to 8,
__spi_validate_bits_per_word is called, that checks whether bits_per_word for
the slave matches the controller available bitwidths:

	if (!spi->bits_per_word)
		spi->bits_per_word = 8;

	status = __spi_validate_bits_per_word(spi->controller,
					      spi->bits_per_word);

	if (status)
		return status;


This means that it doesn't really matter which is the driver that is going
to claim the specific SPI slave. It may be spidev as in my use case, or it
may really be any other driver. But its probe() function is never going to
be called because the error is not raised inside the driver, but immediately
after forcibly setting the default value to 8 in spi.c

I can't modify spidev because spidev doesn't even know this is happening.

I was completely wrong in my blaming of spidev, but now I'm reassured that
my previous patches were going to core of the issue, regardless of my
mistaken initial diagnostic.

Thanks,

-- 
Alvaro G. M.
