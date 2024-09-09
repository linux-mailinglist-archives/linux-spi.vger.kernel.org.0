Return-Path: <linux-spi+bounces-4741-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63397188F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA6EB212BE
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056411B251B;
	Mon,  9 Sep 2024 11:46:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE001B3B27;
	Mon,  9 Sep 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882387; cv=none; b=KLtzGM3jPA3+a604xdumV2KPuLOew3iVXgEpf2FFVD4FUFna5iWCT79te1Nky8NoKc6mwnVFTEUuMIuIF1tuaw3m+KCmeAAE/qpR1VoLOjINo9x7g29Gs5hBoZ80M9ZkJYaMn5Gcw5pHChJ/4x5sFjei+nE/R+uY7b9LtNkp/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882387; c=relaxed/simple;
	bh=/JvFd11iARUx/VFOhA2WfcMyHhZji4SfQt1aID7CS6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BP9An9WDTz+IbsT6SLt75yFPej3r2hHMfYntJOpMg58/LlhSrDCIB6CtKA584bG+/zBuYYHzzD8XpoiruOsXuYBS2pD6ulzoXZh3EYlU8T+XVWCRowQ6PnHpX5tySYWjKIK7yq4jiNDnBtwPu9CACOYuUi+0a6EE+MdY39G7rH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2Q5H2HLTz1j8MR;
	Mon,  9 Sep 2024 19:45:55 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EA26F180041;
	Mon,  9 Sep 2024 19:46:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 19:46:21 +0800
Message-ID: <5487bcb2-7792-e3b3-5972-d224df61b9da@huawei.com>
Date: Mon, 9 Sep 2024 19:46:20 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/3] spi: geni-qcom: Use devm functions to simplify
 code
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <broonie@kernel.org>, <akashast@codeaurora.org>, <dianders@chromium.org>,
	<vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-4-ruanjinjie@huawei.com>
 <45m7oruivszoiesijmdr66oeatvr3ff6ores4lx4kbus2ti552@5sobv4hk7laa>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <45m7oruivszoiesijmdr66oeatvr3ff6ores4lx4kbus2ti552@5sobv4hk7laa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/9 17:49, Dmitry Baryshkov wrote:
> On Mon, Sep 09, 2024 at 03:31:41PM GMT, Jinjie Ruan wrote:
>> Use devm_pm_runtime_enable(), devm_request_irq() and
>> devm_spi_register_controller() to simplify code.
>>
>> And also register a callback spi_geni_release_dma_chan() with
>> devm_add_action_or_reset(), to release dma channel in both error
>> and device detach path, which can make sure the release sequence is
>> consistent with the original one.
>>
>> 1. Unregister spi controller.
>> 2. Free the IRQ.
>> 3. Free DMA chans
>> 4. Disable runtime PM.
>>
>> So the remove function can also be removed.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v3:
>> - Land the rest of the cleanups afterwards.
>> ---
>>  drivers/spi/spi-geni-qcom.c | 37 +++++++++++++------------------------
>>  1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 6f4057330444..8b0039d14605 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -632,8 +632,10 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
>>  	return ret;
>>  }
>>  
>> -static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
>> +static void spi_geni_release_dma_chan(void *data)
>>  {
>> +	struct spi_geni_master *mas = data;
>> +
>>  	if (mas->rx) {
>>  		dma_release_channel(mas->rx);
>>  		mas->rx = NULL;
>> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, spi);
> 
> This should be mas, not spi.
> 
> Doesn't looks like this was tested. Please correct me if I'm wrong.

Yes, you are right, the data should be struct spi_geni_master, which is
mas. Sorry, only compile passed.

> 
> 

