Return-Path: <linux-spi+bounces-4715-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0E96EAEF
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079BC1F2571A
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7412C475;
	Fri,  6 Sep 2024 06:47:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC813B590;
	Fri,  6 Sep 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605250; cv=none; b=gs4U28dwlY8KnEu2bYYFzDbTSlbCq0F+oE/PfskhXhe7roUe2BcKT3mwsl8OGxryUKJcpnA74VgWfQXv/xbgaFbATQRjpMawApBpTW4ksbq+iwRfTlUrSLw7+UTt2RTcMJlOw/ZBNuH8per22pibQNj3kbzo7bXmaTP9GxrlsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605250; c=relaxed/simple;
	bh=C7HBGYnur8m2vEPU7j62/VTlQdK9omSEY2LO+REggrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eoo4SokuGW4ToYnB41Ge2SBiVn6xfqHJmAMtYxRizssgmk8a4BUvVW13+f1e9BHtWqnY0M6SCH/wJIiDPgYprSDjLGxQT5oSMftkcUcmKSuA/fhVJeZs5gEovE5k6yrlJgHLSR3dipxHpG8ll/Epbcm0Z7azs+eHVZDrvq6MTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0RZ0696zzpVVQ;
	Fri,  6 Sep 2024 14:45:28 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 47E141800F2;
	Fri,  6 Sep 2024 14:47:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 14:47:23 +0800
Message-ID: <2fd2b482-3d87-b95e-570a-10bee284d2da@huawei.com>
Date: Fri, 6 Sep 2024 14:47:22 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/2] spi: geni-qcom: Fix incorrect free_irq() sequence
Content-Language: en-US
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, <broonie@kernel.org>,
	<vkoul@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
 <20240906031345.1052241-2-ruanjinjie@huawei.com>
 <cff36a59-6f4f-4ae9-b5b9-e6e1ae822e41@quicinc.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <cff36a59-6f4f-4ae9-b5b9-e6e1ae822e41@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/6 12:27, Mukesh Kumar Savaliya wrote:
> Hi Jinjie,
> 
> On 9/6/2024 8:43 AM, Jinjie Ruan wrote:
>> In spi_geni_remove(), the IRQ will still remain and it's interrupt
>> handler
>> may use the dma channel after release dma channel and before free irq,
>> which is not secure, fix it.
>>
> What's the possibility of having irq if spi_geni_release_dma_chan(mas)
> is completed ? As such controller is already unregistered so transfer
> request can't come.

The irq is not freed, the IRQ can come and then it may enter the irq
handler with the registered one.

>> Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 37ef8c40b276..fc2819effe2d 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -1170,9 +1170,10 @@ static void spi_geni_remove(struct
>> platform_device *pdev)
>>       /* Unregister _before_ disabling pm_runtime() so we stop
>> transfers */
>>       spi_unregister_controller(spi);
>>   +    free_irq(mas->irq, spi);
>> +
>>       spi_geni_release_dma_chan(mas);
>>   -    free_irq(mas->irq, spi);
>>       pm_runtime_disable(&pdev->dev);
>>   }
>>   
> 

