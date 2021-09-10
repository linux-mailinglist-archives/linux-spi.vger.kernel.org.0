Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C44068CA
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhIJI7G (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 04:59:06 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19190 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhIJI7G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 04:59:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A6UIwZ018935;
        Fri, 10 Sep 2021 03:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Ng6fl+LjSMMDnLGolzdyDkr3lgU0oG0a4p27ETtGecY=;
 b=SYAIQzUZiJnhMpKhJaJGPD/9fKUKPupM5InvHm9jpPSFYmbCcsk4RKbkiJH40NhxD8Hs
 yBdpubdNwoQBXaOXSq2BRgpDneU1YBfEnzDDBMjJ57WQS5r91/G5yJCDZoI5sfmCg/P6
 ryi6ZQOokq0cI4iorxWbhSPKIsegoy4aihtqX70O6wIzrUwJIqnA7v+VUGy2PUNqVz0S
 x8Jp8Yaa228zMbg/yPxapgEf1oSRMWX7eckHAR1ETnTe2lIFK5DE2HiHGkO/4TPwUcPR
 Mc5cI1hGeVzclxguJ5WXHdKebRt3ydh6LjdA9WnfR4EDUz4adc9jQCg4G0Jpz/XvYxMk nA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3aytg78sbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 03:57:52 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 09:57:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 09:57:36 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BDC8EB2F;
        Fri, 10 Sep 2021 08:57:30 +0000 (UTC)
Date:   Fri, 10 Sep 2021 08:57:30 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/4] spi: amd: Check for idle bus before execute opcode
Message-ID: <20210910085730.GX9223@ediswmail.ad.cirrus.com>
References: <20210909111005.304101-1-tanureal@opensource.cirrus.com>
 <20210909111005.304101-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210909111005.304101-4-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: hxjhjQ3NIX_x0ohRmMZ-Bsf_d-hnqd8V
X-Proofpoint-ORIG-GUID: hxjhjQ3NIX_x0ohRmMZ-Bsf_d-hnqd8V
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Sep 09, 2021 at 12:10:05PM +0100, Lucas Tanure wrote:
> Check if the bus is not in use before starting the
> transfer
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---
>  drivers/spi/spi-amd.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
> index 97838b57871c..99b2b0ccff08 100644
> --- a/drivers/spi/spi-amd.c
> +++ b/drivers/spi/spi-amd.c
> @@ -115,11 +115,18 @@ static int amd_spi_busy_wait(struct amd_spi *amd_spi)
>  	return 0;
>  }
>  
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

This feels like the commit message could use come additional
explanation. The message states we are moving the wait, but not
why? Also the original code looks slightly more logical, as
in amd_spi_fifo_xfer we read the receive buffer immediately after
calling this function.

Thanks,
Charles
