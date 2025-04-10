Return-Path: <linux-spi+bounces-7533-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E58A84977
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 18:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BD99A1087
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 16:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6661EDA3C;
	Thu, 10 Apr 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="x6CFAcwx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB61D5CE8;
	Thu, 10 Apr 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302149; cv=none; b=SD6XoC6gjxLgxRZGTKmGBONBVuues9luNS8HNf/FIELU001M4DcmfpOFT8NKPyBSojYwKBn4D1bA/OIRmcUih5U+Tap2A7LsATRROIXAuGl3gsP0AxTRGJkiCBwLEIHOTaIrB0B088ls+WUW2u0q8H3x5y98IA/40cXwW4LrvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302149; c=relaxed/simple;
	bh=Xoy2UXN+13eDn3d9NbGQJzjAXldLD+QfeSGSQ2Ee+wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utM77tN1Wm9f/rLCP0Ve7HqQ/SUYYHKX4NH2iM0NxgY3UDD/roXEaKEqG1+x8z6Jw/UC7wlBL7RKlEDA71yoTUO7ruWtSVk1rF+Dgt3lVaf7gQINoM9PA8GZ0q37fxM3dzl1j9mtA2QlQmXFLIvfTjYnmuLcUNFfviT98wNDYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=x6CFAcwx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADlLVw001665;
	Thu, 10 Apr 2025 18:22:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	HMGtnLk9M2H509FvgAtICrK2wNS2Az56Eo03rGYmFeY=; b=x6CFAcwxG8UnUI2H
	TuaNAuR8Ypm1IcmTovy8U4tg6zbMQxa5pQB88pyjWWe8xi6hhWf9TWfcRRUawVWw
	qvKSC7QNQ0Mo5qFoe/ZZubdmOJvopfYSFOvFkqUT7TjJyiDpH2toNEs2TdCKKsV2
	JT3WaclKNglz0lCh7hCTd3N5+dNhYi35Rlw4/7yaHMTK/MMw7c9GtViQ5BM4mOtm
	0JXC8mClI6VEUJ8vjDQdh+DavUzubUvT2kW5cZZBJY5DVUMuRsbmRqTyE3i8+DM4
	0CAH2mGMReAyn+hNN+vWMDB6wQsZXYJ0F5GPfyJJw7rGpetot79n69wF2qsslFF0
	GfjLOw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw5ghh7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:22:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C33E440044;
	Thu, 10 Apr 2025 18:21:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA72298CE8C;
	Thu, 10 Apr 2025 18:20:29 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 18:20:28 +0200
Message-ID: <81d04bf3-8a7e-4287-afd0-d6a0464bb995@foss.st.com>
Date: Thu, 10 Apr 2025 18:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
 <20250410-b4-upstream_ospi_reset_update-v1-2-74126a8ceb9c@foss.st.com>
 <2bb410e34babc4c66895e8e74cf014f89127914d.camel@pengutronix.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2bb410e34babc4c66895e8e74cf014f89127914d.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01



On 4/10/25 14:48, Philipp Zabel wrote:
> On Do, 2025-04-10 at 14:23 +0200, Patrice Chotard wrote:
>> As ospi reset is consumed by both OMM and OSPI drivers, use the reset
>> acquire/release mechanism which ensure exclusive reset usage.
>>
>> This avoid to call reset_control_get/put() in OMM driver each time
>> we need to reset OSPI children and guarantee the reset line stays
>> deasserted.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/spi/spi-stm32-ospi.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
>> index 668022098b1eac3628f0677e6d786e5a267346be..96fa362432f13c19e4dde63d964a0db64c8ade95 100644
>> --- a/drivers/spi/spi-stm32-ospi.c
>> +++ b/drivers/spi/spi-stm32-ospi.c
>> @@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	ospi->rstc = devm_reset_control_array_get_optional_exclusive(dev);
>> +	ospi->rstc = devm_reset_control_array_get_exclusive_released(dev);
> 
> Why does this drop _optional?

Hi Philip

I wrongly based this patchset on the reset/next branch instead of the spi/for-next which include this ospi fix [1].
which make resets a required property. I will rebased it on last spi/for-next.

> 
> Also, since _acquire() is right below in the same function, I see no
> benefit in requesting the reset control in released state.

As explained in commit message, OSPI reset are also used by OMM driver which is parent of OSPI.

If i use devm_reset_control_array_get_exclusive() instead of devm_reset_control_array_get_exclusive_released()
here, i got the following kernel warning:

[    8.654378] ------------[ cut here ]------------
[    8.656524] WARNING: CPU: 1 PID: 385 at drivers/reset/core.c:799 __reset_control_get_internal+0x70/0x1d0
[    8.665999] Modules linked in: spi_stm32_ospi(+) hantro_vpu v4l2_vp9 dwmac_stm32(+) stmmac_platform v4l2_h264 v4l2_jpeg v4l2_mem2mem stmmac videobu6
emon.
[    8.691282] CPU: 1 UID: 0 PID: 385 Comm: (udev-worker) Not tainted 6.15.0-rc1-next-20250408-00018-g0f9105d08519 #22 PREEMPT 
[    8.691301] Hardware name: STMicroelectronics STM32MP257F-EV1 Evaluation Board (DT)
[    8.691307] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.691317] pc : __reset_control_get_internal+0x70/0x1d0
[    8.691336] lr : __of_reset_control_get+0x1a4/0x270
[    8.691348] sp : ffff80008359b5f0
[    8.691352] x29: ffff80008359b5f0 x28: 0000000000000000 x27: ffff80007b06c100
[    8.691371] x26: ffff80007b06c118 x25: 0000000000000001 x24: 0000000000000000
[    8.691385] x23: 0000000000000004 x22: ffff000082ecc780 x21: 0000000000000005
[    8.691399] x20: ffff000082ecc7a0 x19: ffff000083898d00 x18: 00000000ffffffff
[    8.691414] x17: ffff000082ff9a00 x16: ffff0000802d6800 x15: ffff80008359b4c0
[    8.691429] x14: 0000000000000001 x13: 007473696c5f7974 x12: 0000000000000001
[    8.691444] x11: 0000000000000003 x10: ffff80008257ec4f x9 : 0000000000000028
[    8.691459] x8 : 0101010101010101 x7 : 00000000736c6c65 x6 : 000000000080f2e5
[    8.691473] x5 : ffff80008359b698 x4 : 0000000000000000 x3 : 0000000000000005
[    8.691487] x2 : 0000000000000004 x1 : 0000000000000005 x0 : 0000000000000005
[    8.691501] Call trace:
[    8.691506]  __reset_control_get_internal+0x70/0x1d0 (P)
[    8.691522]  __of_reset_control_get+0x1a4/0x270
[    8.691535]  of_reset_control_array_get+0x9c/0x174
[    8.691549]  devm_reset_control_array_get+0x50/0xb0
[    8.691563]  stm32_ospi_get_resources+0xd4/0x344 [spi_stm32_ospi]
[    8.691584]  stm32_ospi_probe+0xf8/0x3d0 [spi_stm32_ospi]

Which means that bool acquired is set.

This is due to usage of devm_reset_control_array_get_exclusive() which sets flags to RESET_CONTROL_EXCLUSIVE
on an already controlled reset line.


> 
>>  	if (IS_ERR(ospi->rstc))
>>  		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
>>  				     "Can't get reset\n");
>> @@ -937,9 +937,11 @@ static int stm32_ospi_probe(struct platform_device *pdev)
>>  		goto err_pm_enable;
>>  
>>  	if (ospi->rstc) {
> 
> This check only makes sense if the reset control (array) is optional,
> otherwise ospi->rstc can never be NULL.

Right, i will remove this check.

> 
>> +		reset_control_acquire(ospi->rstc);
> 
> This is missing error handling. Alternatively, you could just use the
> normal request function to get an already-acquired reset control.

Ok, i will add a check.


[1] https://patches.linaro.org/project/linux-spi/patch/20250324-upstream_ospi_required_resets-v2-2-85a48afcedec@foss.st.com/

Thanks
Patrice

> 
>>  		reset_control_assert(ospi->rstc);
>>  		udelay(2);
>>  		reset_control_deassert(ospi->rstc);
>> +		reset_control_release(ospi->rstc);
>>  	}
>>  
>>  	ret = spi_register_controller(ctrl);
> 
> regards
> Philipp
> 

