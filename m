Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9963347B35E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Dec 2021 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhLTTCs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Dec 2021 14:02:48 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60442 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhLTTCr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Dec 2021 14:02:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKJ2Vj2025580;
        Mon, 20 Dec 2021 13:02:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640026951;
        bh=C6Putjc76a73Bvho+VgAgzsKc6LMAMneY1xU02Zh4AQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=N2D+dIU0js6Hh5NyZouJQ9n50hPXhtoJFtYQAQU4f6hysdh9GG+XAj+cmZUQYgXh+
         zkg7GePYuT8qYw0PBoP9lDvpkkF2LLshq9+Epc9eZRu3Im+k9jT+QT9QzS81pZN+Be
         TieUZHFc//c0ME3j9Mhd8myeOhwo0Z/UOCES9ZHk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKJ2VN4118115
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 13:02:31 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 13:02:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 13:02:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKJ2Thp044388;
        Mon, 20 Dec 2021 13:02:30 -0600
Date:   Tue, 21 Dec 2021 00:32:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 07/14] spi: spi-mem: Add an ecc_en parameter to the
 spi_mem_op structure
Message-ID: <20211220190227.oqvpcfrro32ic32b@ti.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
 <20211217161654.367782-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217161654.367782-8-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17/12/21 05:16PM, Miquel Raynal wrote:
> Soon the SPI-NAND core will need a way to request a SPI controller to
> enable ECC support for a given operation. This is because of the
> pipelined integration of certain ECC engines, which are directly managed
> by the SPI controller itself.
> 
> Introduce a spi_mem_op additional field for this purpose: ecc_en.
> 
> So far this field is left unset and checked to be false by all
> the SPI controller drivers in their ->supports_op() hook, as they all
> call spi_mem_default_supports_op().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-mem.c       | 5 +++++
>  include/linux/spi/spi-mem.h | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index cfe1c99db5f3..94758e7e747d 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -178,6 +178,11 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>  			return false;
>  	}
>  
> +	if (op->ecc_en) {
> +		if (!spi_mem_controller_is_capable(ctlr, ecc))
> +			return false;
> +	}
> +
>  	return spi_mem_check_buswidth(mem, op);
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index d7787c8f3746..e9238a858109 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -94,6 +94,7 @@ enum spi_mem_data_dir {
>   *		 operation does not involve transferring data
>   * @data.buf.in: input buffer (must be DMA-able)
>   * @data.buf.out: output buffer (must be DMA-able)
> + * @ecc_en: error correction is required
>   */
>  struct spi_mem_op {
>  	struct {
> @@ -126,6 +127,8 @@ struct spi_mem_op {
>  			const void *out;
>  		} buf;
>  	} data;
> +
> +	bool ecc_en;

ECC should only concern the data phase right? Would it make more sense 
to move this field under data?

Anyway, I don't know much about NAND or ECC so either way,

Acked-by: Pratyush Yadav <p.yadav@ti.com>

>  };
>  
>  #define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
> @@ -223,9 +226,11 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
>  /**
>   * struct spi_controller_mem_caps - SPI memory controller capabilities
>   * @dtr: Supports DTR operations
> + * @ecc: Supports operations with error correction
>   */
>  struct spi_controller_mem_caps {
>  	bool dtr;
> +	bool ecc;
>  };
>  
>  #define spi_mem_controller_is_capable(ctlr, cap)		\
> -- 
> 2.27.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
