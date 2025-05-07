Return-Path: <linux-spi+bounces-7984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF145AAE5FB
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8E05022B3
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611528BA9C;
	Wed,  7 May 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="G25/85P6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C328BA86;
	Wed,  7 May 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634016; cv=none; b=tSNU4NK1qKR1kVVU/G+RwITtEOCwY9guh1WLCkJmTr6eqwJ6EkotBH9uZB875krHrmU70fIdxpc0DrtSNaB+FIqlH8xyO7vXqqBt+2Yq30wNZvn+YhRlD0eJRTVCzeu4A2NSIOsnz244clk9nTSSA1qVxaCEM/EabTnmz0R/En8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634016; c=relaxed/simple;
	bh=bIAYDCUuTCKBfv0za5ss8WsVL/17cINwXF1JWCyM5CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VT5s9sbD+PmY1ioof/WzNzGYsGni3HzeLAs5oSad11rwHcQyb7Q6Ry03Rp3GIURTBEhpqvraHNnrhRrKNTAFuTjBll1uCc0WhHj0zvE0H3hBQOz6T4CgZ8TW9WsBZx+K8Vvc3vkgEUgnTFxJn23AZ8yiwv+U0omOfotyduAhki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=G25/85P6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547DogUs012755;
	Wed, 7 May 2025 18:06:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6Bj8KOiEcnsmz5xmKsrZ1JKbRMUANWee2a/AUbn8PbY=; b=G25/85P6kJWaHyE/
	U/FFOlfzznc+gVOlABxZ9/bsW8itl+DseWaOjVsmFvMOevmL1rJcWEkOZkJh5KOe
	ZeEtlAyGg6GUm0t0rg6l67b085C/42/s1G6ZlW32HRhiAfPFuS/U8RRTcq6FOI0m
	XCl/5hti/bkt/k3xYXzJVmbBwFJtnxpwXPBn8cVOWnCLu00qH9H0YBeY02FrarzY
	kG7LiKj1jVVuGqxW5JYCxFNAyHrqY6XcQ8u8i/ZZ4mI8H9nHwAmBAo0oI/zjFYkw
	4yGomokhAL4MHWhiDr1yBReNL/oFC1goaoSh5nH6xQCOa7p54TEgLF4y9QtZxpUj
	mPxHyQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbf3h3fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 18:06:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7E4AD40088;
	Wed,  7 May 2025 18:05:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F20EEA56C3E;
	Wed,  7 May 2025 18:04:33 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 18:04:33 +0200
Message-ID: <721ec8c6-ceb5-4e6c-91f6-2e234f12ff2b@foss.st.com>
Date: Wed, 7 May 2025 18:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
 <20250411-b4-upstream_ospi_reset_update-v2-2-4de7f5dd2a91@foss.st.com>
 <3685c6351d8b940abe70ccf22d783e71ced6f6da.camel@pengutronix.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3685c6351d8b940abe70ccf22d783e71ced6f6da.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01



On 5/5/25 15:12, Philipp Zabel wrote:
> Hi Patrice,
> 
> On Fr, 2025-04-11 at 14:41 +0200, Patrice Chotard wrote:
>> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
>> acquire/release mechanism which ensure exclusive reset usage.
>>
>> This avoid to call reset_control_get/put() in OMM driver each time
>> we need to reset OSPI children and guarantee the reset line stays
>> deasserted.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/spi/spi-stm32-ospi.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
>> index d002b9c16714684e4e4623f9255a7f2660c46fd1..ef840f377459891b559be6d6c0435408fb58a1e9 100644
>> --- a/drivers/spi/spi-stm32-ospi.c
>> +++ b/drivers/spi/spi-stm32-ospi.c
>> @@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	ospi->rstc = devm_reset_control_array_get_exclusive(dev);
>> +	ospi->rstc = devm_reset_control_array_get_exclusive_released(dev);
>>  	if (IS_ERR(ospi->rstc))
>>  		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
>>  				     "Can't get reset\n");
>> @@ -936,11 +936,14 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_pm_enable;
>>  
>> -	if (ospi->rstc) {
>> -		reset_control_assert(ospi->rstc);
>> -		udelay(2);
>> -		reset_control_deassert(ospi->rstc);
>> -	}
>> +	ret = reset_control_acquire(ospi->rstc);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Can not acquire reset %d\n", ret);
>> +
>> +	reset_control_assert(ospi->rstc);
>> +	udelay(2);
>> +	reset_control_deassert(ospi->rstc);
>> +	reset_control_release(ospi->rstc);
> 
> Could you keep the reset control (mostly) acquired from probe() to
> remove()? The reset control would have to be released/acquired in OSPI
> suspend/resume so that OMM can temporarily acquire control during OMM
> resume.

Ok

Thanks
Patrice

> 
> regards
> Philipp

