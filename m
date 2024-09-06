Return-Path: <linux-spi+bounces-4710-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B696E867
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DB91C216F1
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 03:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3662E822;
	Fri,  6 Sep 2024 03:50:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC17A41;
	Fri,  6 Sep 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594634; cv=none; b=qBRWWUC388TG/on/QRDuFuwV4tKXxcwRQ3qfbKonFqGxShpEPh66dcQ/bHr268uN3ackkq4dURiofEPCgVbfmpPYcSfLEoiptR9DkAhazrEoCWDCsy/yLFKGL5u3h82sQFLANuZSAfovXbzBxDPGkhK7HC5nzpkL7PdT5/VcfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594634; c=relaxed/simple;
	bh=xXfohxUpTJDjz/p0HOsXR9M+PxUZSYQnzhwo8DdedY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gjy/PUdBTZSDtARQNtV6euHdPdryvQdSDghwihdBnITFs2cuOZ35Mn7Ru38IJrQzaPVE2L35b33unFJOsCYXk5nNWcTys9kguVRg3o54IkxYxxFGumnFSY2q18TtRImgorshAWNck+6TnkOqcS6REQcF6wHLy60Hj//fndijUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0Mgd4jj1z2Dbkr;
	Fri,  6 Sep 2024 11:50:05 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 31FBC180043;
	Fri,  6 Sep 2024 11:50:28 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 11:50:27 +0800
Message-ID: <a314d448-abb7-1a9c-5c45-7fce9aa69362@huawei.com>
Date: Fri, 6 Sep 2024 11:50:26 +0800
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
 <3d48b7c3-6dba-b113-9207-f3daa874253e@huawei.com>
 <CAA8EJppbuMGjo3PHBnmHF5yXFOBUon50ZSKKzWFqGs3qgFmR3g@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAA8EJppbuMGjo3PHBnmHF5yXFOBUon50ZSKKzWFqGs3qgFmR3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/6 11:43, Dmitry Baryshkov wrote:
> On Fri, 6 Sept 2024 at 06:41, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>>
>>
>> On 2024/9/6 11:36, Dmitry Baryshkov wrote:
>>> On Fri, 6 Sept 2024 at 06:31, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/9/6 11:15, Dmitry Baryshkov wrote:
>>>>> On Fri, Sep 06, 2024 at 11:13:45AM GMT, Jinjie Ruan wrote:
>>>>>> It's important to undo pm_runtime_use_autosuspend() with
>>>>>> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
>>>>>> initially enabled pm_runtime with devm_pm_runtime_enable()
>>>>>> (which handles it for you).
>>>>>>
>>>>>> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
>>>>>> to fix it.
>>>>>>
>>>>>> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
>>>>>> ---
>>>>>> v2:
>>>>>> - Fix it directly instead of use devm_pm_runtime_enable().
>>>>>
>>>>> Why?
>>>>
>>>> The devm* sequence will have some problem, which will not consistent
>>>> with the former.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/all/CAD=FV=VyDk-e2KNiuiBcACFAdrQmihOH6X6BSpGB+T1MsgsiKw@mail.gmail.com/
>>>
>>> That comment was for devm_request_irq(), not devm_pm_runtime_enable().
>>
>>
>> In the very least, ** parch #2 needs to come before this one and that
>> would help, but it won't fix everything **. Specifically in order to
>> keep the order proper you'll need to use devm_add_action_or_reset() to
>> "devm-ize" the freeing of the DMA channels.
> 
> This is patch #2. so I don't understand your comment. Moreover you
> don't have to use devm for each and every possible item. However I
> think it makes sense for pm_runtime in this case.

You are right, only use devm_pm_runtime_enable() here, there is no
change for the resource release sequence, but I have a cleanup patch
ready to replace all these with devm*, which depends on the 2 fix patch.

> 
>>
>>
>>>
>>>>
>>>>>
>>>>>> ---
>>>>>>  drivers/spi/spi-geni-qcom.c | 2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>>>> index fc2819effe2d..38857edbc785 100644
>>>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>>>> @@ -1158,6 +1158,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>>>  spi_geni_release_dma:
>>>>>>      spi_geni_release_dma_chan(mas);
>>>>>>  spi_geni_probe_runtime_disable:
>>>>>> +    pm_runtime_dont_use_autosuspend(dev);
>>>>>>      pm_runtime_disable(dev);
>>>>>>      return ret;
>>>>>>  }
>>>>>> @@ -1174,6 +1175,7 @@ static void spi_geni_remove(struct platform_device *pdev)
>>>>>>
>>>>>>      spi_geni_release_dma_chan(mas);
>>>>>>
>>>>>> +    pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>>>>      pm_runtime_disable(&pdev->dev);
>>>>>>  }
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 

