Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB3406D15
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhIJNsu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 09:48:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60008 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231963AbhIJNsu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 09:48:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A4vueU005222;
        Fri, 10 Sep 2021 08:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=HNfLcNOXBjO7X7Cxd78bIBF7oo+3dgOInLWjcya6Gi8=;
 b=EV3AUWtb9J148dFmVKQZ367D0uZeEj2JNyYmRvfUFuDC7LPRORSCEjeQdWn76MPcqBFQ
 GK4xZpwgpMevZOnPmV0JlDbSqS3Phqd8r5tt9ece878z/Sok2E96kl4Bmf8SEeovuUPF
 fxzp62Q5ftqw5Yv7cO+ulC07YKwfqmGMATiNri2mm6gRIvt0gQ55zAC3WtTBrScKDlho
 7G0W8Kr58D8FXyk7q2+vX5GItp/QcrYsSigCla1Q0fdMPkCPt9s2OexpK/TKs2UeemdQ
 RRn4UvCE7614itIhJrVvOx5tw51JGoRfzh6Jpeo2bZngiMzc2hiAmULcChg8Cl5HinH/ fA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3aytg791hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 08:47:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 10 Sep
 2021 14:47:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 10 Sep 2021 14:47:33 +0100
Received: from [198.61.64.231] (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2F0FAB10;
        Fri, 10 Sep 2021 13:47:33 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] spi: amd: Don't wait for a write-only transfer to
 finish
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210910111529.12539-1-tanureal@opensource.cirrus.com>
 <20210910111529.12539-4-tanureal@opensource.cirrus.com>
 <20210910124223.GY9223@ediswmail.ad.cirrus.com>
From:   Lucas tanure <tanureal@opensource.cirrus.com>
Message-ID: <790250e3-a928-57d4-1378-bc8923163452@opensource.cirrus.com>
Date:   Fri, 10 Sep 2021 14:47:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910124223.GY9223@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -MXpDKXvqs2L9pyPPzj2NSqjOktQHSqm
X-Proofpoint-ORIG-GUID: -MXpDKXvqs2L9pyPPzj2NSqjOktQHSqm
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/10/21 1:42 PM, Charles Keepax wrote:
> On Fri, Sep 10, 2021 at 12:15:29PM +0100, Lucas Tanure wrote:
>> Return from a write-only transfer without waiting for
>> it to finish
>> But wait before a new transfer as the previous may
>> still happening and also wait before reading the data
>> from the FIFO
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>> ---
>> -static void amd_spi_execute_opcode(struct amd_spi *amd_spi)
>> +static int amd_spi_execute_opcode(struct amd_spi *amd_spi)
>>   {
>> +	int ret;
>> +
>> +	ret = amd_spi_busy_wait(amd_spi);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* Set ExecuteOpCode bit in the CTRL0 register */
>>   	amd_spi_setclear_reg32(amd_spi, AMD_SPI_CTRL0_REG, AMD_SPI_EXEC_CMD, AMD_SPI_EXEC_CMD);
>> -	amd_spi_busy_wait(amd_spi);
>> +
>> +	return 0;
>>   }
>>   
>>   static int amd_spi_master_setup(struct spi_device *spi)
>> @@ -178,6 +185,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
>>   			amd_spi_clear_fifo_ptr(amd_spi);
>>   			/* Execute command */
>>   			amd_spi_execute_opcode(amd_spi);
>> +			amd_spi_busy_wait(amd_spi);
> 
> Surely the previous transfer can't still be happening if this if
> unconditional? Should this not be gated on rx_len?
> 
> Thanks,
> Charles
> 
>>   			/* Read data from FIFO to receive buffer  */
>>   			for (i = 0; i < rx_len; i++)
>>   				buf[i] = amd_spi_readreg8(amd_spi, AMD_SPI_FIFO_BASE + tx_len + i);
>> -- 
>> 2.33.0
>>
This is executed inside an xfer->rx_buf not null if, so it`s gated in a 
read transfer and not for a write transfer only

