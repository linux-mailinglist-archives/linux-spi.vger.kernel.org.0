Return-Path: <linux-spi+bounces-4708-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D681D96E858
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6211DB22B56
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFCA3BBF2;
	Fri,  6 Sep 2024 03:40:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D143D96A;
	Fri,  6 Sep 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594058; cv=none; b=FtR+ZzLF1QBshZCkHUHLOQSdL1/CWS5IZUH43PEAUpcSDYB+GrGjT/+ldXXCvZuRhl3vnBqo5RJRM8abekiV8NHKwZl8qSioFueiSyL2brdyRPuNeZ3vCfcrIYY+cABLhT1ja2uHgENG0B3OLY2wSASRXdwQPDodZCqfBT4nvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594058; c=relaxed/simple;
	bh=u27DFzBtTzlrgAjpxuI7x+uOJ5wxBQoAMqGAlnb+JpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tPezwcjQCrF4vJZEel94gcoFFu7srFiTDAMnIUOmO90U4PqPbR/myPyjn0a0l4fsnHLwYk1ifyu2HMTbYEiQMe5mV0LWh3ZBKS8joJTND0WLDprLh5Ag0FdQl5RvZMSKhNZfdNFMetMF76qFw5KldmcNpJcN1W13t+eaic5Fumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X0MMG1kBgz69Wd;
	Fri,  6 Sep 2024 11:35:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 96AE3180AE8;
	Fri,  6 Sep 2024 11:40:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 11:40:52 +0800
Message-ID: <3d48b7c3-6dba-b113-9207-f3daa874253e@huawei.com>
Date: Fri, 6 Sep 2024 11:40:52 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Fix missing undo runtime PM
 changes at driver exit time
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <broonie@kernel.org>, <vkoul@kernel.org>, <akashast@codeaurora.org>,
	<dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
References: <20240906031345.1052241-1-ruanjinjie@huawei.com>
 <20240906031345.1052241-3-ruanjinjie@huawei.com>
 <hnos3f34ejabyw2yxtpxifskhklunvnufgsuilghjeuzipqkxi@udw5xfeum37a>
 <050a6434-00f9-4bba-a122-52c3a23fcf70@huawei.com>
 <CAA8EJpod2OzNEoquSGuJXLUx8-r+J0_YjPzv5pFDFHum9siisQ@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAA8EJpod2OzNEoquSGuJXLUx8-r+J0_YjPzv5pFDFHum9siisQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/6 11:36, Dmitry Baryshkov wrote:
> On Fri, 6 Sept 2024 at 06:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>>
>> On 2024/9/6 11:15, Dmitry Baryshkov wrote:
>>> On Fri, Sep 06, 2024 at 11:13:45AM GMT, Jinjie Ruan wrote:
>>>> It's important to undo pm_runtime_use_autosuspend() with
>>>> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
>>>> initially enabled pm_runtime with devm_pm_runtime_enable()
>>>> (which handles it for you).
>>>>
>>>> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
>>>> to fix it.
>>>>
>>>> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
>>>> ---
>>>> v2:
>>>> - Fix it directly instead of use devm_pm_runtime_enable().
>>>
>>> Why?
>>
>> The devm* sequence will have some problem, which will not consistent
>> with the former.
>>
>> Link:
>> https://lore.kernel.org/all/CAD=FV=VyDk-e2KNiuiBcACFAdrQmihOH6X6BSpGB+T1MsgsiKw@mail.gmail.com/
> 
> That comment was for devm_request_irq(), not devm_pm_runtime_enable().


In the very least, ** parch #2 needs to come before this one and that
would help, but it won't fix everything **. Specifically in order to
keep the order proper you'll need to use devm_add_action_or_reset() to
"devm-ize" the freeing of the DMA channels.


> 
>>
>>>
>>>> ---
>>>>  drivers/spi/spi-geni-qcom.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index fc2819effe2d..38857edbc785 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>  spi_geni_release_dma:
>>>>      spi_geni_release_dma_chan(mas);
>>>>  spi_geni_probe_runtime_disable:
>>>> +    pm_runtime_dont_use_autosuspend(dev);
>>>>      pm_runtime_disable(dev);
>>>>      return ret;
>>>>  }
>>>> @@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platform_device *pdev)
>>>>
>>>>      spi_geni_release_dma_chan(mas);
>>>>
>>>> +    pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>>      pm_runtime_disable(&pdev->dev);
>>>>  }
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
> 
> 
> 

