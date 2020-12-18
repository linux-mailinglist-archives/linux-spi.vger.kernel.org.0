Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B972DE05B
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 10:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgLRJWv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 04:22:51 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLRJWu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 04:22:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BI9LAP1008846;
        Fri, 18 Dec 2020 03:21:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608283270;
        bh=JEhxrJdzKkqBCohlls58hFvXO71eHtV3nMjA4ot8kec=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=TNkE43jsNjtIWDE7xi/763JHr1wjk9kawqnaGaQIvGzKSyREyM3WQ4UrxomrAvJUj
         RQKx5Tywu+JOqKRymxnfTSPqhsdGu7GQ+SQzs21KtND4Lnr1I2APZSUUborrJL5lK4
         OJ8M+yrBEfwEVfUeJNm6xzOwSsENlgoQd9Go7rcE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BI9LAb9021593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 03:21:10 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 03:21:09 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 03:21:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BI9L9Iu079866;
        Fri, 18 Dec 2020 03:21:09 -0600
Date:   Fri, 18 Dec 2020 14:51:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201218092106.skwej2g6bk3oksbb@ti.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
 <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sowjanya,

On 17/12/20 12:28PM, Sowjanya Komatineni wrote:
> This patch marks dummy transfer by setting dummy_data bit to 1.
> 
> Controllers supporting dummy transfer by hardware use this bit field
> to skip software transfer of dummy bytes and use hardware dummy bytes
> transfer.

What is the benefit you get from this change? You add complexity in 
spi-mem and the controller driver, so that must come with some benefits. 
Here I don't see any. The transfer will certainly take the same amount 
of time because the number or period of the dummy cycles has not 
changed. So why is this needed?
 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/spi/spi-mem.c   | 1 +
>  include/linux/spi/spi.h | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index f3a3f19..c64371c 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -354,6 +354,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>  		xfers[xferpos].len = op->dummy.nbytes;
>  		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> +		xfers[xferpos].dummy_data = 1;
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->dummy.nbytes;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc..708f2f5 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -827,6 +827,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
>   *      transfer. If 0 the default (from @spi_device) is used.
>   * @bits_per_word: select a bits_per_word other than the device default
>   *      for this transfer. If 0 the default (from @spi_device) is used.
> + * @dummy_data: indicates transfer is dummy bytes transfer.
>   * @cs_change: affects chipselect after this transfer completes
>   * @cs_change_delay: delay between cs deassert and assert when
>   *      @cs_change is set and @spi_transfer is not the last in @spi_message
> @@ -939,6 +940,7 @@ struct spi_transfer {
>  	struct sg_table tx_sg;
>  	struct sg_table rx_sg;
>  
> +	unsigned	dummy_data:1;
>  	unsigned	cs_change:1;
>  	unsigned	tx_nbits:3;
>  	unsigned	rx_nbits:3;
> -- 
> 2.7.4
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
