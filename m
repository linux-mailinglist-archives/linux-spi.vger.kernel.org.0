Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B171518D59
	for <lists+linux-spi@lfdr.de>; Thu,  9 May 2019 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfEIPun (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 May 2019 11:50:43 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:39983 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfEIPum (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 May 2019 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Kq7ywUwOI3JOsrAoGuQf9+q8JnIrY2aTgOQu3dyyMCs=;
        b=pQVJsh1GI9swASH+clP2+erqCWMUZvr+60XCFRvGVhvG8+J+qP+S4Yt8K74LydbZ3K67CKrrIjlXYRYfcDxSUlQyq2DoH8L5GI8XJkZ1QF+sVWRjOA2+BgDrWoRFKZtYqejm6wPilo0VD9+qI2PMjDM0TLVjzQEKgIXNv7/Vf7HGsgayQCX1Fxpy0EzKkrq2vym4awMxeGNFIAOdUFym04Y9ZSYcGcjgC4UQSdjkdbV9H1/17f6OztTimaXrtKJj6mLnWwc7DbT+1WCP+hzIuoCluIhQSianoC5oQzkGeG8WL3ntQAW9bAc3ZfXXt8EREPrDlEiCXVc2fUGJ4T/52w==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58548 helo=[192.168.10.178])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hOlJf-00074q-Lx; Thu, 09 May 2019 17:50:39 +0200
Subject: Re: Applied "spi: Add spi_is_bpw_supported()" to the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org
References: <20190415085333.EA6241127A64@debutante.sirena.org.uk>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <e87abf19-4616-01e3-5bca-5938dee39c63@tronnes.org>
Date:   Thu, 9 May 2019 17:50:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415085333.EA6241127A64@debutante.sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Den 15.04.2019 10.53, skrev Mark Brown:
> The patch
> 
>    spi: Add spi_is_bpw_supported()
> 
> has been applied to the spi tree at
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2
> 

I can't see this in for-5.2 or linux-next. You also gave me a topic
branch for this, but I wasn't able to get an r-b on the drm patch in the
few days left before the -rc5 cutoff in the drm subsystem. This means
that the patch didn't go in through drm for 5.2.

How do we proceed from here?

Noralf.

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From e6f3f7e4dc76eb8d8a546dc66621a02c5c84f4ac Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
> Date: Fri, 12 Apr 2019 11:41:30 +0200
> Subject: [PATCH] spi: Add spi_is_bpw_supported()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This let SPI clients check if the controller supports a particular word
> width. drivers/gpu/drm/tinydrm/mipi-dbi.c will use this to determine if
> the controller supports 16-bit for RGB565 pixels. If it doesn't it will
> swap the bytes before transfer on little endian machines.
> 
> Signed-off-by: Noralf TrÃ¸nnes <noralf@tronnes.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/spi/spi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 662b336aa2e4..b30e3d13a5ac 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -983,6 +983,26 @@ spi_max_transfer_size(struct spi_device *spi)
>  	return min(tr_max, msg_max);
>  }
>  
> +/**
> + * spi_is_bpw_supported - Check if bits per word is supported
> + * @spi: SPI device
> + * @bpw: Bits per word
> + *
> + * This function checks to see if the SPI controller supports @bpw.
> + *
> + * Returns:
> + * True if @bpw is supported, false otherwise.
> + */
> +static inline bool spi_is_bpw_supported(struct spi_device *spi, u32 bpw)
> +{
> +	u32 bpw_mask = spi->master->bits_per_word_mask;
> +
> +	if (bpw == 8 || (bpw <= 32 && bpw_mask & SPI_BPW_MASK(bpw)))
> +		return true;
> +
> +	return false;
> +}
> +
>  /*---------------------------------------------------------------------------*/
>  
>  /* SPI transfer replacement methods which make use of spi_res */
> 
