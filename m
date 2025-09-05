Return-Path: <linux-spi+bounces-9916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDD3B455A5
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19174A03CAC
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF49341643;
	Fri,  5 Sep 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e/lMXPe1"
X-Original-To: linux-spi@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FED33EB1F;
	Fri,  5 Sep 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070269; cv=none; b=VkWbNgPnHef72BkMpwPam17DxHm5QblWdsLLqSsIBdauOhBdQdCWZBEHnr5b2snFbX3ztcDUZBylqH50Dd1yUmjL+pzt73DuHv08JibRHtA9uN6UAuUmxXHKTQllWVSamD5fywxfI0tb4ml5ntI20SbvIXQPuHnNK7t32Ve3TPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070269; c=relaxed/simple;
	bh=AmC3UF7X56t8MbOkEzA0Ks3gwsgyTIf+BxiYirzqRUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hHCkLMn69Z307Wu03gLNujElx2PjcmJELOadKPKp7YXeohUfgjysEaI9rFsa6C9agDvn08We9wS7BDPLx6i7eG8Hk6tNnj1wIik6NHnvq4WEAF9Ii+ZexPryOYpcRjZHIdRuCISt1YCIIqlG8pxyed3Uu4+CKnOyEJLwYrCxFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e/lMXPe1; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585B4FDP3307951;
	Fri, 5 Sep 2025 06:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757070255;
	bh=aC2fQQ/I4VHyv1syREOYU51RuC6I93oHXZndjA+RvG0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=e/lMXPe1jXJEcUT03XGzt5aiKoeLfGvhbQPtCYWhaBlp1ShPOUua92cPg4D0IUgop
	 Z79WxfnIpKzCOyYlJa0gBBv43xQHmsxMKUlz1/8faSCrmlLUpU+2oyYx1nHEqVYtUv
	 kewTVDPLh3hbwF8cSG6UC6PU+jqVQESmhChQCCUw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585B4FhF874667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 06:04:15 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 06:04:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 06:04:15 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585B4ARf345139;
	Fri, 5 Sep 2025 06:04:11 -0500
Message-ID: <ea97b0b4-3467-4e18-9e8c-80b75e067f3d@ti.com>
Date: Fri, 5 Sep 2025 16:34:10 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: cadence-quadspi: Fix cqspi_setup_flash()
To: Pratyush Yadav <pratyush@kernel.org>
CC: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>, <theo.lebrun@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
 <20250904133130.3105736-4-s-k6@ti.com> <mafs0ms7ath3l.fsf@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <mafs0ms7ath3l.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

On 04/09/25 20:11, Pratyush Yadav wrote:
> On Thu, Sep 04 2025, Santhosh Kumar K wrote:
> 
>> The 'max_cs' stores the largest chip select number. It should only
>> be updated when the current 'cs' is greater than existing 'max_cs'. So,
>> fix the condition accordingly.
>>
>> Fixes: 0f3841a5e115 ("spi: cadence-qspi: report correct number of chip-select")
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 447a32a08a93..da3ec15abb3e 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -1722,7 +1722,7 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
>>   
>>   static int cqspi_setup_flash(struct cqspi_st *cqspi)
>>   {
>> -	unsigned int max_cs = cqspi->num_chipselect - 1;
>> +	unsigned int max_cs = 0;
>>   	struct platform_device *pdev = cqspi->pdev;
>>   	struct device *dev = &pdev->dev;
>>   	struct cqspi_flash_pdata *f_pdata;
>> @@ -1740,7 +1740,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
>>   		if (cs >= cqspi->num_chipselect) {
>>   			dev_err(dev, "Chip select %d out of range.\n", cs);
>>   			return -EINVAL;
>> -		} else if (cs < max_cs) {
>> +		} else if (cs > max_cs) {
> 
> Makes sense. Out of curiosity, are you using multiple CS in a real use
> case or is this only theoretical?

Real use case,  Pratyush - we have both OSPI NOR and QSPI NAND in our 
new AM62Lx EVM - CS0 and CS3 respectively.

> 
> Also nit: this could be simplified to:
> 
> 		if (cs >= cqspi->num_chipselect) {
> 			dev_err(dev, "Chip select %d out of range.\n", cs);
> 			return -EINVAL;
> 		}
> 
> 		max_cs = max_t(unsigned int, cs, max_cs);
> 
> but I think it is fine either way.

Yeah, this one's simpler, I'll go with this. Thanks!

Regards,
Santhosh.

> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> 
>>   			max_cs = cs;
>>   		}
> 


