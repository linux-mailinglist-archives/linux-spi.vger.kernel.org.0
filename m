Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900791AC0B2
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634619AbgDPMGO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634924AbgDPMGK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 08:06:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72DC061A0C;
        Thu, 16 Apr 2020 05:06:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5F9EB2A1171;
        Thu, 16 Apr 2020 13:06:08 +0100 (BST)
Date:   Thu, 16 Apr 2020 14:06:04 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>
Cc:     broonie@kernel.org, frieder.schrempf@kontron.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v3] spi: spi-fsl-qspi: Reduce devm_ioremap size to 4
 times AHB buffer size
Message-ID: <20200416140604.3d8c9d78@collabora.com>
In-Reply-To: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1587037399-18672-1-git-send-email-Ashish.Kumar@nxp.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Apr 2020 17:13:19 +0530
Ashish Kumar <Ashish.Kumar@nxp.com> wrote:

> Reduce devm_ioremap size to (4 * AHB_BUFER_SIZE) rather than mapping
> complete QSPI-Memmory as driver is now independent of flash size.
> Flash of any size can be accessed.
> 
> Issue was reported on platform where devm_ioremap failure is observed
> with size > 256M.
> Error log on LS1021ATWR :
>  fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x40000000-0x7fffffff]
>  fsl-quadspi 1550000.spi: Freescale QuadSPI probe failed
>  fsl-quadspi: probe of 1550000.spi failed with error -12
> 
> This change was also suggested previously:
> https://patchwork.kernel.org/patch/10508753/#22166385
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Ashish Kumar <Ashish.kumar@nxp.com>
> ---
> v3: 
> Update comment
> v2:
> Add Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Incorrporate review comments from Frieder
>  drivers/spi/spi-fsl-qspi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
> index 63c9f7e..8b95e2f 100644
> --- a/drivers/spi/spi-fsl-qspi.c
> +++ b/drivers/spi/spi-fsl-qspi.c
> @@ -859,14 +859,15 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					"QuadSPI-memory");
> -	q->ahb_addr = devm_ioremap_resource(dev, res);
> +	q->memmap_phy = res->start;
> +	/* Since there are 4 cs, map size required is 4 times ahb_buf_size */
> +	q->ahb_addr = devm_ioremap(dev, q->memmap_phy,
> +				   (q->devtype_data->ahb_buf_size * 4));
>  	if (IS_ERR(q->ahb_addr)) {
>  		ret = PTR_ERR(q->ahb_addr);
>  		goto err_put_ctrl;
>  	}
>  
> -	q->memmap_phy = res->start;
> -

Looks like this line move is unrelated to the ioremap range change. Not
a big but I thought I'd mention it. In any case,

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

>  	/* find the clocks */
>  	q->clk_en = devm_clk_get(dev, "qspi_en");
>  	if (IS_ERR(q->clk_en)) {

