Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA638CB04
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhEUQb5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 12:31:57 -0400
Received: from foss.arm.com ([217.140.110.172]:51098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhEUQb4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 12:31:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C39B81480;
        Fri, 21 May 2021 09:30:32 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401B73F93E;
        Fri, 21 May 2021 09:30:31 -0700 (PDT)
Date:   Fri, 21 May 2021 17:30:11 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210521173011.1c602682@slackpad.fritz.box>
In-Reply-To: <20210520100656.rgkdexdvrddt3upy@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 20 May 2021 12:06:56 +0200
Ralf Schlatterbeck <rsc@runtux.com> wrote:

Hi Ralf,

many thanks for taking care of upstreaming this!

> The current sun6i SPI implementation initializes the transfer too early,
> resulting in SCK going high before the transfer. When using an additional
> (gpio) chipselect with sun6i, the chipselect is asserted at a time when
> clock is high, making the SPI transfer fail.
> 
> This is due to SUN6I_GBL_CTL_BUS_ENABLE being written into
> SUN6I_GBL_CTL_REG at an early stage. Moving that to the transfer
> function, hence, right before the transfer starts, mitigates that
> problem.
> 
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>
> Signed-off-by: Mirko Vogt <mirko-dev|linux@nanl.de>

So if I get your last email correctly, your intention was to make this
Mirko's patch, which you just send?
In this case the authorship should stay with him (git commit --amend
--author "..."), and you add your S-o-b (his first, your's next).
If you use git format-patch & git send-email, it will take care of
formatting this correctly (inserting a "From" line into the body).

As for the technical part: I know as much about SPI to have quite some
respect for the subtleties of the various modes. But your second
oscilloscope shot looks much better, and matches the timing diagram in
the manual (SS is the first to go down).
So I trust you that's the right move.

One formatting thing below:

> ---
> For oscilloscope screenshots with/without the patch, see my blog post
> https://blog.runtux.com/posts/2019/04/18/
> or the discussion in the armbian forum at
> https://forum.armbian.com/topic/4330-spi-gpio-chip-select-support/
> (my logo there is a penguin).
> 
>  drivers/spi/spi-sun6i.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index cc8401980125..2db075c87f51 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -379,6 +379,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  	}
>  
>  	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
> +	/* Finally enable the bus - doing so before might raise SCK to HIGH */
> +	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
> +			sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG)
> +			| SUN6I_GBL_CTL_BUS_ENABLE);

The "|" on the new line looks a bit odd. What about you utilise "reg"
here, as the other access do, to make this more readable?
	reg = sun6i_spi_read(...);
	reg |= ...
	sun6i_spi_write(..., reg);

Cheers,
Andre

>  
>  	/* Setup the transfer now... */
>  	if (sspi->tx_buf)
> @@ -504,7 +508,7 @@ static int sun6i_spi_runtime_resume(struct device *dev)
>  	}
>  
>  	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
> -			SUN6I_GBL_CTL_BUS_ENABLE | SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
> +			SUN6I_GBL_CTL_MASTER | SUN6I_GBL_CTL_TP);
>  
>  	return 0;
>  

