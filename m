Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4F1DF608
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgEWIeR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 23 May 2020 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbgEWIeR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 May 2020 04:34:17 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DB4C061A0E;
        Sat, 23 May 2020 01:34:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x22so7856438lfd.4;
        Sat, 23 May 2020 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3d+o4EkQI8dzAtQgDOYEYeiYTnRl/ABUKNf5AeEWnw=;
        b=Bf8zg14ACwMjQhFGHbjNTptOzeaTrDOkvC+aQI0N4lTba1CaNsSCaL/cGUGix3MKyC
         c7JxjvNEEzJlB4wnhbFt+86gXDLCWnByhebvY8bMogcJ/n67aOTEFdNPkrHtDqKcQ4/E
         Ffr+vjYNnubjdlq32fCYEGRYgsEv8b6wujyl25vBvsM/i7UiCvS4NM2dil/Da9MuP3ar
         nMVlmdtSEbj80NTV/h2s1X8/3p7qwP+hzfTQHYCqqacBj8CnKoZSSSXIMGOS3EXg+5z4
         IZd/pR+V/CHGhh+K/DWmNS1dL5M2Im4/EDOA/mlSZF9WfwnsXFs9qQCSPP+6uIs17Q4e
         eImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3d+o4EkQI8dzAtQgDOYEYeiYTnRl/ABUKNf5AeEWnw=;
        b=TLyZ5DahLkk6rVlaomlZzkvmBzW9e4vqkbv0laWEvfvIjYcvi+Glp46wcOa3BK2MiD
         7FFS0wWSQ9WpWW71hwKSRim/jxBUSfFFyIZKhoOOzX+bziWUVnYFn+r+Eq2WU9Ji0p5r
         UpgOyprXVdl8v0dQUDPoqpFdWdpFP+sWp3pguRIKHmMqoVwJTnOuBLSZRF+/uWEQsmZA
         3aze5IK5WY3+Kqy8gIKKsWQyt+0jpCgMmFEQRK7XjiWako6Y3qHKhuHmqpMLOBdN7xvr
         N38bpRVkZ4C24jjn7j6IoQN9NL72qcwIq2oXthmEALqqQm3zYZuBWfkUIB8zRblSZcRE
         Kukw==
X-Gm-Message-State: AOAM53130GOEWlqpk/GCUkZHBQQKHtIVKNgvbYc0w8/fcz08CIiQPkQV
        sbitHWzlqpIRgPXTzFJevn8=
X-Google-Smtp-Source: ABdhPJyqdbYgA5KPOYIYWJOxpJBiM1rfOZy/+R9CbEqH2Bo1LQ3ZgVvuRJPCNMG4kBqVL+Caa3ohSw==
X-Received: by 2002:a19:c3c5:: with SMTP id t188mr9445431lff.149.1590222853772;
        Sat, 23 May 2020 01:34:13 -0700 (PDT)
Received: from mobilestation ([95.79.222.123])
        by smtp.gmail.com with ESMTPSA id 23sm2941907lfb.1.2020.05.23.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 01:34:13 -0700 (PDT)
Date:   Sat, 23 May 2020 11:34:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        Vinod Koul <vkoul@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        Alan Cox <alan@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "wuxu.wu" <wuxu.wu@huawei.com>, Clement Leger <cleger@kalray.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] spi: dw: Add Tx/Rx finish wait methods to the
 MID DMA
Message-ID: <20200523083410.3qarkfkwsmodvxwk@mobilestation>
References: <20200522121221.GA1634618@smile.fi.intel.com>
 <20200522121820.GG5801@sirena.org.uk>
 <20200522123427.GD1634618@smile.fi.intel.com>
 <20200522124406.co7gmteojfsooerc@mobilestation>
 <20200522131013.GH5801@sirena.org.uk>
 <20200522132742.taf2ixfjpyd5u3dt@mobilestation>
 <20200522140025.bmd6bhpjjk5msvsm@mobilestation>
 <20200522143639.GG1634618@smile.fi.intel.com>
 <20200522144542.brhibh453wid2d6v@mobilestation>
 <20200522152241.GK5801@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522152241.GK5801@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 04:22:41PM +0100, Mark Brown wrote:
> On Fri, May 22, 2020 at 05:45:42PM +0300, Serge Semin wrote:
> > On Fri, May 22, 2020 at 05:36:39PM +0300, Andy Shevchenko wrote:
> 
> > > My point is: let's warn and see if anybody comes with a bug report. We will
> > > solve an issue when it appears.
> 
> > In my environment the stack trace happened (strictly speaking it has been a
> > BUG() invoked due to the sleep_range() called within the tasklet) when SPI bus
> > had been enabled to work with !8MHz! clock. It's quite normal bus speed.
> > So we'll get the bug report pretty soon.)
> 
> Right, that definitely needs to be fixed then - 8MHz is indeed a totally
> normal clock rate for SPI so people will hit it.  I guess if there's a
> noticable performance hit to defer to thread then we could implement
> both and look at how long the delay is going to be to decide which to
> use, that's annoyingly complicated though so if the overhead is small
> enough we could just not bother.

As I suggested before we can implement a solution without performance drop.
Just wait for the DMA completion locally in the dw_spi_dma_transfer() method and
return 0 instead of 1 from the transfer_one() callback. In that function we'll
wait while DMA finishes its business, after that we can check the Tx/Rx FIFO
emptiness and wait for the data to be completely transferred with delays or
sleeps or whatever.

There are several drawback of the solution:
1) We need to alter the dw_spi_transfer_one() method in a way one would return
0 instead of 1 (for DMA) so the generic spi_transfer_one_message() method would
be aware that the transfer has been finished and it doesn't need to wait by
calling the spi_transfer_wait() method.
2) Locally in the dw_spi_dma_transfer() I have to implement a method similar
to the spi_transfer_wait(). It won't be that similar though. We can predict a
completion timeout better in here due to using a more exact SPI bus frequency.
Anyway in the rest of aspects the functions will be nearly the same. 
3) Not using spi_transfer_wait() means we also have to locally add the SPI
timeout statistics incremental.

So to speak the local wait method will be like this:

+static int dw_spi_dma_wait(struct dw_spi *dws, struct spi_transfer *xfer)
+{
+ 	struct spi_statistics *statm = &dws->master->statistics;
+	struct spi_statistics *stats = &dws->master->cur_msg->spi->statistics;
+	unsigned long ms = 1;
+
+	ms = xfer->len * MSEC_PER_SEC * BITS_PER_BYTE;
+	ms /= xfer->effective_speed_hz;
+	ms += ms + 200;
+
+	ms = wait_for_completion_timeout(&dws->xfer_completion,
+					msecs_to_jiffies(ms));
+
+	if (ms == 0) {
+		SPI_STATISTICS_INCREMENT_FIELD(statm, timedout);
+		SPI_STATISTICS_INCREMENT_FIELD(stats, timedout);
+		dev_err(&dws->master->cur_msg->spi->dev,
+			"SPI transfer timed out\n");
+			return -ETIMEDOUT;
+	}
+}

NOTE Currently the DW APB SSI driver doesn't set xfer->effective_speed_hz, though as
far as I can see that field exists there to be initialized by the SPI controller
driver, right? If so, strange it isn't done in any SPI drivers...

Then we can use that method to wait for the DMA transfers completion:

+static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
+{
+	...
+	/* DMA channels/buffers preparation and the transfers execution */
+	...
+
+	ret = dw_spi_dma_wait(dws, xfer);
+	if (ret)
+		return ret;
+
+	ret = dw_spi_dma_wait_tx_done(dws);
+	if (ret)
+		return ret;
+
+	ret = dw_spi_dma_wait_rx_done(dws);
+	if (ret)
+		return ret;
+
+	return 0;
+}

What do think about this?

If you don't mind I'll send this fixup separately from the patchset we discuss
here, since it's going to be a series of patches. What would be better for you:
implement it based on the current DW APB SSI driver, or on top of this
patchset "spi: dw: Add generic DW DMA controller support" (it's being under
review in this email thread) ? Anyway, if the fixup is getting to be that
complicated, will it have to be backported to another stable kernels?

-Sergey
