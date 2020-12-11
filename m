Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF962D806C
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 22:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394850AbgLKVH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 16:07:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6867 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394863AbgLKVHR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 16:07:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3df5a0000>; Fri, 11 Dec 2020 13:06:34 -0800
Received: from [10.2.60.59] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 21:06:30 +0000
Subject: Re: [PATCH v2 5/9] spi: spi-mem: Allow masters to transfer dummy
 cycles directly by hardware
To:     Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <lukas@wunner.de>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <1607706088-1437-1-git-send-email-skomatineni@nvidia.com>
 <1607706088-1437-8-git-send-email-skomatineni@nvidia.com>
 <20201211183320.GH4929@sirena.org.uk>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2af1ff76-9777-2f8c-4e69-16fd8efcdcc0@nvidia.com>
Date:   Fri, 11 Dec 2020 13:06:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211183320.GH4929@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607720794; bh=NdMvXT6GLEua2PDhvhLaSJgxe9zBQCQl5ivJsSvOKHU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=QkZZd6qoM4WFIZr0RPOR18LQptTmkK9Tn9/HXliC4uAPXoEnFvNd2WQNIC7m/AHXS
         NxYnwwiPhcbTzapIOumOOGSEeEmKDuY2zJXUOGE4m48hHcbjMfg1KqDCi8lXaQG1Yp
         wu7Xzd0jEmchAFRqyKbdmFhXVSy6dbq+h04LPFqRfUmdfRLlvD9xCbl/8BgdEzQjw7
         GY01PmXsVGOvF2hGrzdckIzovhtIMJOdmlcoHf/vnCxcm08gNHvE/9AI5Q5nUwDXyF
         mazd+2kSuejngNdorgaGcG2miM8ovRG5KIjLsQVH2BC8HZ2a77THO+SZP2TnPVuiVl
         WHWn5JYeMGwDA==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Sorry mark mixed patches went out.

Will resend v2 and will add other people you have CC'd as well

On 12/11/20 10:33 AM, Mark Brown wrote:
> On Fri, Dec 11, 2020 at 09:01:24AM -0800, Sowjanya Komatineni wrote:
>> This patch adds a flag SPI_MASTER_USES_HW_DUMMY_CYCLES for the controllers
>> that support transfer of dummy cycles by the hardware directly.
>>
>> For controller with this flag set, spi-mem driver will skip dummy bytes
>> transfer in the spi message.
>>
>> Controller drivers can get the number of dummy cycles from spi_message.
> Copying more people who've worked on spi-mem for their review - I've not
> got such a good perspective on controller features.
>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/spi/spi-mem.c   | 18 +++++++++++-------
>>   include/linux/spi/spi.h |  8 ++++++++
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index f3a3f19..38a523b 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -350,13 +350,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>   	}
>>   
>>   	if (op->dummy.nbytes) {
>> -		memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
>> -		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>> -		xfers[xferpos].len = op->dummy.nbytes;
>> -		xfers[xferpos].tx_nbits = op->dummy.buswidth;
>> -		spi_message_add_tail(&xfers[xferpos], &msg);
>> -		xferpos++;
>> -		totalxferlen += op->dummy.nbytes;
>> +		if (ctlr->flags & SPI_MASTER_USES_HW_DUMMY_CYCLES) {
>> +			msg.dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
>> +		} else {
>> +			memset(tmpbuf + op->addr.nbytes + 1, 0xff, op->dummy.nbytes);
>> +			xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>> +			xfers[xferpos].len = op->dummy.nbytes;
>> +			xfers[xferpos].tx_nbits = op->dummy.buswidth;
>> +			spi_message_add_tail(&xfers[xferpos], &msg);
>> +			xferpos++;
>> +			totalxferlen += op->dummy.nbytes;
>> +		}
>>   	}
>>   
>>   	if (op->data.nbytes) {
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index aa09fdc..2024149 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -512,6 +512,8 @@ struct spi_controller {
>>   
>>   #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
>>   
>> +#define SPI_MASTER_USES_HW_DUMMY_CYCLES	BIT(6)	/* HW dummy bytes transfer */
>> +
>>   	/* flag indicating this is an SPI slave controller */
>>   	bool			slave;
>>   
>> @@ -1022,6 +1024,12 @@ struct spi_message {
>>   	unsigned		actual_length;
>>   	int			status;
>>   
>> +	/*
>> +	 * dummy cycles in the message transfer. This is used by the controller
>> +	 * drivers supports transfer of dummy cycles directly by the hardware.
>> +	 */
>> +	u8			dummy_cycles;
>> +
>>   	/* for optional use by whatever driver currently owns the
>>   	 * spi_message ...  between calls to spi_async and then later
>>   	 * complete(), that's the spi_controller controller driver.
>> -- 
>> 2.7.4
