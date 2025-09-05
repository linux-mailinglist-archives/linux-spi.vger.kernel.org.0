Return-Path: <linux-spi+bounces-9918-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E1B455B5
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887A65A85A3
	for <lists+linux-spi@lfdr.de>; Fri,  5 Sep 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59005341643;
	Fri,  5 Sep 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oW+xQZat"
X-Original-To: linux-spi@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C43126D3;
	Fri,  5 Sep 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070317; cv=none; b=ezkJz3Rmup+q6iJYDLJNKHLAD7jwoeaOHLjLxLX5yboKV9qeuzfiIl5eBsHaIRLOXO+9BVsycxfhIQtnpladZKUf3bYkmlTRCB5f9gnNCET+B2/yGCHwkmQgbNssv7Ir9sXzHT87RTbSf8r5LQc4H2MLlYWtvLWOjEiAXBPtB3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070317; c=relaxed/simple;
	bh=UVbHEFgL9WUzT3tgOODZPddTWM6/t0Mw2S1iMDzbJ6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MQUq6uvNBaWrKJmnwDM20qfSIWkLuvtZSxTavaJ+tL6yDEnK+pTdfjzFEom8oFsmavmIxzlPOYj4JZy3SOC/YiTGqg//FM1RQ0cAFq2x+i76mXNwaJc9oDFwx3EHtsq+zZVQP4lLPBvQ1IARcZL/b+jTeU7vVHjlgBjxPWwFDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oW+xQZat; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 585B54nc3698684;
	Fri, 5 Sep 2025 06:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757070304;
	bh=pNrAGaC2H81AXXTw2vLR/9Xu4RQmYDEI79rPoLV9H0w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oW+xQZatgU45uo3noTgdhi0Je+cwZbTtpkBWGIvFkCbVezes9+LVd9XezK0m1v/FG
	 xwgE38vdBC1gO6/b3NsRwNycYWSqnxG44NMAk444lk6qk8URt+qsApFjszNqVim5hw
	 4kqGGaLw1oj3QfzNljW8LKLbTf3N0Oa4cji6K9ug=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 585B54VK1596459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 06:05:04 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 06:05:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 06:05:04 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 585B4x7C640025;
	Fri, 5 Sep 2025 06:05:00 -0500
Message-ID: <580f00f4-ee1a-4e78-a028-18cdb3b01119@ti.com>
Date: Fri, 5 Sep 2025 16:34:59 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: cadence-quadspi: Use BIT() macros where possible
To: Pratyush Yadav <pratyush@kernel.org>
CC: <miquel.raynal@bootlin.com>, <broonie@kernel.org>, <vigneshr@ti.com>,
        <marex@denx.de>, <computersforpeace@gmail.com>,
        <grmoore@opensource.altera.com>, <theo.lebrun@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
 <20250904133130.3105736-5-s-k6@ti.com> <mafs0bjnqtgr0.fsf@kernel.org>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <mafs0bjnqtgr0.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 04/09/25 20:19, Pratyush Yadav wrote:
> On Thu, Sep 04 2025, Santhosh Kumar K wrote:
> 
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> Convert few open coded bit shifts to BIT() macro for better readability.
>> No functional changes intended.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> 
> I see there are total 7 hits for the pattern "1 <<". Why not convert
> them all while you're at it?

Yeah, I just checked - I'll convert them as well.

Regards,
Santhosh.

> 
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index da3ec15abb3e..b18f095516f2 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -335,7 +335,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
>>   {
>>   	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>>   
>> -	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
>> +	return reg & BIT(CQSPI_REG_CONFIG_IDLE_LSB);
>>   }
>>   
>>   static u32 cqspi_get_rd_sram_level(struct cqspi_st *cqspi)
>> @@ -571,7 +571,7 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
>>   		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
>>   		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
>>   
>> -	reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
>> +	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
>>   
>>   	/* 0 means 1 byte. */
>>   	reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
>> @@ -1191,7 +1191,7 @@ static void cqspi_chipselect(struct cqspi_flash_pdata *f_pdata)
>>   		 * CS2 to 4b'1011
>>   		 * CS3 to 4b'0111
>>   		 */
>> -		chip_select = 0xF & ~(1 << chip_select);
>> +		chip_select = 0xF & ~BIT(chip_select);
>>   	}
>>   
>>   	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
> 


