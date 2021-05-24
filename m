Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3F038E6A3
	for <lists+linux-spi@lfdr.de>; Mon, 24 May 2021 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhEXMeq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 May 2021 08:34:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232401AbhEXMep (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 08:34:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E77113E;
        Mon, 24 May 2021 05:33:17 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72CD3F719;
        Mon, 24 May 2021 05:33:15 -0700 (PDT)
Date:   Mon, 24 May 2021 13:33:01 +0100
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
Message-ID: <20210524133301.32c74794@slackpad.fritz.box>
In-Reply-To: <20210521201913.2gapcmrzynxekro7@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
        <20210521173011.1c602682@slackpad.fritz.box>
        <20210521201913.2gapcmrzynxekro7@runtux.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 May 2021 22:19:13 +0200
Ralf Schlatterbeck <rsc@runtux.com> wrote:

Hi,

> From: Mirko Vogt <mirko-dev|linux@nanl.de>
> 
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
> Signed-off-by: Mirko Vogt <mirko-dev|linux@nanl.de>
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

Looks good to me now, thanks for the changes!

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Some comments for future contributions (should not hold back that
patch, I think):
- Single patch set series don't bother to have a "1/1" after the
  "PATCH".
- You are expected to increase the version number when you send a new
  version, to show that *this* is better than the previous post and
  this version should be merged. Otherwise the maintainer might pick
  the wrong version. "git format-patch -v2" and "git send-email" will
  automatically take care of this.

> ---
> Updated patch with suggested improvements by Andre Przywara
> For oscilloscope screenshots with/without the patch, see my blog post
> https://blog.runtux.com/posts/2019/04/18/
> or the discussion in the armbian forum at
> https://forum.armbian.com/topic/4330-spi-gpio-chip-select-support/
> (my logo there is a penguin).

Please keep in mind that text after the dashes doesn't make it in it
repo, so this information would be lost there. Also, in general links in
commit messages are somewhat frowned upon, since they tend to 404
sooner or later. So ideally you can put a condensed version of your
findings into the commit message? Don't worry if it grows long, it is
not uncommon to have a 2 page commit message for a one-liner patch.

Cheers,
Andre



> 
>  drivers/spi/spi-sun6i.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index cc8401980125..23ad052528db 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -379,6 +379,10 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  	}
>  
>  	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
> +	/* Finally enable the bus - doing so before might raise SCK to HIGH */
> +	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
> +	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
> +	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
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

