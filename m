Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF4406C6B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhIJMnp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 08:43:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:31920 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234122AbhIJMnp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 08:43:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18AC066J009602;
        Fri, 10 Sep 2021 07:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=dB1qF0eh5DtdsV4sdcFDMoLkZYBHekXIDy5V+Hu9gwY=;
 b=YfridiKZCVwtf2VBTYJxlKN6FczKG7LoeSKGnCfgv6zueNBJyl2QcoKT/s2qvUyZJwLx
 RtqIV1mzsH7jnq2Lt9F4lKPHhlv1o2cfptMRNH1tR08zJgGptkRFvF2T7triojYiljN+
 Nj1d47LYI6UDvGeRMkhjB0+evn6AhKrfBOtvASf/SrBg6zZ0kHqBvEMmze07S8lrZYnD
 BNL10QCaBnS4u4qSYc2QZ2qK6mSmJeuPvIIMWIhj97cVNOWqz2BcQYfNJ+0uRCv075v+
 ZgeDDBlT2K+RrZRv6syqs4qUyCDyNiEhvJD+DT5SeuuRZ1p/NpMQqHIqQxlK0hy9pRMv SQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3aytvr12tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 07:42:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 13:42:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 13:42:29 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D9F48B2F;
        Fri, 10 Sep 2021 12:42:23 +0000 (UTC)
Date:   Fri, 10 Sep 2021 12:42:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 4/4] spi: amd: Don't wait for a write-only transfer to
 finish
Message-ID: <20210910124223.GY9223@ediswmail.ad.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
 <20210910111529.12539-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210910111529.12539-4-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: CulXX1tCtsEAqK2zUicqulPxVRW14kTQ
X-Proofpoint-ORIG-GUID: CulXX1tCtsEAqK2zUicqulPxVRW14kTQ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 10, 2021 at 12:15:29PM +0100, Lucas Tanure wrote:
> Return from a write-only transfer without waiting for
> it to finish
> But wait before a new transfer as the previous may
> still happening and also wait before reading the data
> from the FIFO
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
> -static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
> +static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
>  {
> +	int ret;
> +
> +	ret = amd_spi_busy_wait(amd_spi);
> +	if (ret)
> +		return ret;
> +
>  	/* Set ExecuteOpCode bit in the CTRL0 register */
>  	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
> -	amd_spi_busy_wait(amd_spi);
> +
> +	return 0;
>  }
>  
>  static int amd_spi_master_setup(struct spi_device *spi)
> @@ -178,6 +185,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>  			amd_spi_clear_fifo_ptr(amd_spi);
>  			/* Execute command */
>  			amd_spi_execute_opcode(amd_spi);
> +			amd_spi_busy_wait(amd_spi);

Surely the previous transfer can't still be happening if this if
unconditional? Should this not be gated on rx_len?

Thanks,
Charles

>  			/* Read data from FIFO to receive buffer  */
>  			for (i = 0; i < rx_len; i++)
>  				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
> -- 
> 2.33.0
> 
