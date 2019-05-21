Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85872246DD
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2019 06:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbfEUEZM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 May 2019 00:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfEUEZM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 May 2019 00:25:12 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA262173E;
        Tue, 21 May 2019 04:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558412712;
        bh=jhAAf7RxC6y52oAfYZUxa5FbGCzGZxoGjrYjtyPEJ10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5kJUHbazLR9Z2Q4VzC/5WrDDNx55YQt74VZ8JKUX2TXSHIrW23UTBr/26JoRDwpw
         WgaCVWAuUie3zFUK61xMhRz4N8gGmjvRBiiowzH3VELOjYg3ncOlaakvSk/S2RMni7
         O/yIFvyY/oLU/OBnRnUHvtekbXmNdfivOWGtZBMI=
Date:   Tue, 21 May 2019 09:55:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Frank Pavlic <f.pavlic@kunbus.de>, Simon Han <z.han@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: bcm2835: Drop assignment of dma_slave_config
 direction
Message-ID: <20190521042508.GI15118@vkoul-mobl>
References: <5622fbd8314cf518b9530745e49545bc6287015d.1557758205.git.lukas@wunner.de>
 <5c7b7ca7813564f062d9891847b510ce91067585.1557758205.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c7b7ca7813564f062d9891847b510ce91067585.1557758205.git.lukas@wunner.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 13-05-19, 16:48, Lukas Wunner wrote:
> The BCM2835 SPI driver still sets the "direction" member in struct
> dma_slave_config even though it was deprecated five years ago with
> commit d9ff958bb34a ("dmaengine: Mark the struct dma_slave_config
> direction field deprecated") and is no longer evaluated by the BCM2835
> DMA driver since commit 00648f4d0f41 ("dmaengine: bcm2835: remove
> dma_slave_config direction usage").

Great, thanks for doing this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Drop the superfluous assignment.
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Frank Pavlic <f.pavlic@kunbus.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Noralf Trønnes <noralf@tronnes.org>
> ---
>  drivers/spi/spi-bcm2835.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 1c34a7bcdb7f..9c03da7c18dd 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -729,7 +729,6 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
>  	}
>  
>  	/* configure DMAs */
> -	slave_config.direction = DMA_MEM_TO_DEV;
>  	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
>  	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  
> @@ -737,7 +736,6 @@ static void bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev)
>  	if (ret)
>  		goto err_config;
>  
> -	slave_config.direction = DMA_DEV_TO_MEM;
>  	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
>  	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>  
> -- 
> 2.20.1

-- 
~Vinod
