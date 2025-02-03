Return-Path: <linux-spi+bounces-6602-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C38A25388
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 09:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D991648BE
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2025 08:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC71FBE9B;
	Mon,  3 Feb 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VIP/53qZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D31FBCBA;
	Mon,  3 Feb 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569916; cv=none; b=EivyAMuj8vA4Q2C/ud2jA35mKW12PR3ZLf40WFp62hnVJRHbd50G27pgKDcVXCJfVjeXUUR9NtNKz5fhWwW2xiZIB8On2S+udHzNzlydXuXu7GrcJz1N3GPJLKLFF2QDHeFNfz5y4EQQZScnL6GBcpVpBsKvAzqF7QClcjIxp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569916; c=relaxed/simple;
	bh=vVtdkUjzTpAveHWJ8dPzZG7iYZ9wg4ehOvHWQcUQqTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xhx3lqghfowYVBm64zlFJy+xlJyA3To0x7IwQctRBx9JIUy3u3eSiQuvBfrNzTu+CxczFUfmamMVrnLRyEmMxD9BGmOxoJg+BPKJ2TmQyt74MPazrY2Etx1Asy4t7tEaPVRlqd/0ZTP2Li/wKLc5x2gbEh4j/C7uEdOYaO7EoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VIP/53qZ; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5136Kr6r016972;
	Mon, 3 Feb 2025 08:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RuCAHbevHJ5uWp3A9K/KqPfMZXRayoGge+NC8B4v7wk=; b=VIP/53qZNTOLw+0l
	tvMdXlD10Zs0SnR9DPAsIXWkJLssNDO8BWrZrDeH6C4Gi34ezgWAME5c+OWMq8aD
	Y6vUH+0KgvNa5ZaL/Im4l8AcuNpsV5YlEhH97n89jjC4QtvrSPCVNs4qeWvkHpZs
	seluT/lbxMSZWqgus/oTnPOO1oq6Sg4Gpb8SASKiEjpSws9oRzlpZMZV40e/KTUr
	KeISb83TC+7sdv23Wq2HYQPUmN2m0OMXykxF5gryc4s49jUoawHVNmMyH7DrgNQl
	PkxQ4/ouzPqeUe/WrJ0bXVXGZLFafp8U66MNgDLPGcQMdWsvGeoLNbbLNMMtId+v
	25irOQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44hdmrvr9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 08:31:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AEAD40051;
	Mon,  3 Feb 2025 08:29:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7C9E28E495;
	Mon,  3 Feb 2025 08:29:42 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 08:29:41 +0100
Message-ID: <62f719a0-357f-406a-92e1-3e8ab4ef9600@foss.st.com>
Date: Mon, 3 Feb 2025 08:29:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] memory: Add STM32 Octo Memory Manager driver
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann
	<arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-5-patrice.chotard@foss.st.com>
 <3d6cfb082ef8ee0fc66c885a84f64ae0a851234b.camel@pengutronix.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3d6cfb082ef8ee0fc66c885a84f64ae0a851234b.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_03,2025-01-31_02,2024-11-22_01



On 1/28/25 10:17, Philipp Zabel wrote:
> On Di, 2025-01-28 at 09:17 +0100, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Octo Memory Manager driver (OMM) manages:
>>   - the muxing between 2 OSPI busses and 2 output ports.
>>     There are 4 possible muxing configurations:
>>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>>         output is on port 2
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>>         OSPI2 output is on port 1
>>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>>   - the split of the memory area shared between the 2 OSPI instances.
>>   - chip select selection override.
>>   - the time between 2 transactions in multiplexed mode.
>>   - check firewall access.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>  drivers/memory/Kconfig     |  17 ++
>>  drivers/memory/Makefile    |   1 +
>>  drivers/memory/stm32_omm.c | 509 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 527 insertions(+)
>>  create mode 100644 drivers/memory/stm32_omm.c
>>
> [...]
>> diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
>> new file mode 100644
>> index 000000000000..6f20fe0183ec
>> --- /dev/null
>> +++ b/drivers/memory/stm32_omm.c
>> @@ -0,0 +1,509 @@
> [...]
>> +static int stm32_omm_configure(struct device *dev)
>> +{
>> +	struct stm32_omm *omm = dev_get_drvdata(dev);
>> +	struct reset_control *rstc;
>> +	unsigned long clk_rate, clk_rate_max = 0;
>> +	int ret;
>> +	u8 i;
>> +	u32 mux = 0;
>> +	u32 cssel_ovr = 0;
>> +	u32 req2ack = 0;
>> +
>> +	omm->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(omm->clk)) {
>> +		dev_err(dev, "Failed to get OMM clock (%ld)\n",
>> +			PTR_ERR(omm->clk));
>> +
>> +		return PTR_ERR(omm->clk);
>> +	}
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* parse children's clock */
>> +	for (i = 0; i < omm->nb_child; i++) {
>> +		clk_rate = clk_get_rate(omm->child[i].clk);
>> +		if (!clk_rate) {
>> +			dev_err(dev, "Invalid clock rate\n");
>> +			goto err_clk_disable;
>> +		}
>> +
>> +		if (clk_rate > clk_rate_max)
>> +			clk_rate_max = clk_rate;
>> +	}
>> +
>> +	rstc = devm_reset_control_get_optional(dev, NULL);
> 
> Please use devm_reset_control_get_optional_exclusive() directly.

ok

Thanks
Patrice

> 
> regards
> Philipp

