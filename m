Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F925565E
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgH1I0y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 04:26:54 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:37934 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgH1I0u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Aug 2020 04:26:50 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 07S8QeQP016300
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 10:26:40 +0200
Received: from [167.87.19.148] ([167.87.19.148])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07S8Qd9Q013834;
        Fri, 28 Aug 2020 10:26:40 +0200
Subject: Re: [PATCH] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA
 reads
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200828074726.24546-1-vigneshr@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8828e301-a7b7-d837-dc60-6c5101cdac90@siemens.com>
Date:   Fri, 28 Aug 2020 10:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828074726.24546-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 28.08.20 09:47, Vignesh Raghavendra wrote:
> Buffers need to mapped to DMA channel's device pointer instead of SPI
> controller's device pointer as its system DMA that actually does data
> transfer.
> Data inconsistencies have been reported when reading from flash
> without this fix.
> 
> Fixes: 31fb632b5d43c ("spi: Move cadence-quadspi driver to drivers/spi/")

This looks wrong, ...

> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> This issue was present in the original driver under SPI NOR framework as well.
> But only got exposed as driver started handling probe deferral for DMA channel
> request and thus uses DMA almost always unlike before.

...you rather want 935da5e5100f57d843cac4781b21f1c235059aa0 then.

Other than that:

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks!
Jan

> 
>  drivers/spi/spi-cadence-quadspi.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 508b219eabf8..c6795c684b16 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -907,14 +907,16 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>  	struct dma_async_tx_descriptor *tx;
>  	dma_cookie_t cookie;
>  	dma_addr_t dma_dst;
> +	struct device *ddev;
>  
>  	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
>  		memcpy_fromio(buf, cqspi->ahb_base + from, len);
>  		return 0;
>  	}
>  
> -	dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(dev, dma_dst)) {
> +	ddev = cqspi->rx_chan->device->dev;
> +	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(ddev, dma_dst)) {
>  		dev_err(dev, "dma mapping failed\n");
>  		return -ENOMEM;
>  	}
> @@ -948,7 +950,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
>  	}
>  
>  err_unmap:
> -	dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
> +	dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
>  
>  	return ret;
>  }
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
