Return-Path: <linux-spi+bounces-4816-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212E978C67
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 03:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9477E1C24947
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52B748F;
	Sat, 14 Sep 2024 01:18:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B379DC;
	Sat, 14 Sep 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726276687; cv=none; b=sPh42txzGWu5HvnwFenOADZD2iFpcefRmcyOb5wlR5T/kHEp8UkQpyTH5kk1uoIaq5q1pKDyjys9Uo3wBANheynN0yX5CR3MzIQFYbv6oBlMc0xqw3/XgMETllA02fMoLiy+Q9nSsbsewCZne/WWcr0sHD/G1/yrvple3rlkwZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726276687; c=relaxed/simple;
	bh=O2zZ+g2CNfoY91bgctyAl7vsHDJ5D1WTHE5tOdRaOOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QhUzk8A4RDLCBxLUWjE2JF3NceH3mC3cEyaDaY7sqrKgqgD4sW41A3rdSBdf8haXNDN+E4zNf3vhYKAb0sCjEAMMLMkUePnvRlzK8OdS5eWItMdU0oucU/NSomHYLNbAFUeLbwhN6c8tG47QKMSbw7JmECKyPrZas04GFX02Z3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X5Csx1Rpkzfbs2;
	Sat, 14 Sep 2024 09:15:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EBCD818010B;
	Sat, 14 Sep 2024 09:18:00 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Sep 2024 09:18:00 +0800
Message-ID: <37f07293-bbfa-7194-b5f7-fa2aec982a67@huawei.com>
Date: Sat, 14 Sep 2024 09:17:59 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/3] spi: geni-qcom: Use devm functions to simplify
 code
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
CC: <broonie@kernel.org>, <akashast@codeaurora.org>, <vkoul@kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240909132810.1296786-1-ruanjinjie@huawei.com>
 <20240909132810.1296786-4-ruanjinjie@huawei.com>
 <CAD=FV=XQ7uf_Y_WTv_6-DX1Mo=+RycKSyxf=E-f3TOKiuE5RMA@mail.gmail.com>
 <c662f0b9-31dc-8b97-ef3f-ea33f9fc62af@huawei.com>
 <CAD=FV=U+kc1rKSDDo-Zx+CiuapoJ8izrCW0Wh-PfR7ivY_4bXw@mail.gmail.com>
 <10e77c5a-a188-698b-0c82-86c4bcdf114d@huawei.com>
 <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAD=FV=XGKph6t9S-r9-D+LkYcGNgRbEAC-qc4OQZjZXmxrjozw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/14 0:27, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 12, 2024 at 11:44 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> On 2024/9/12 21:38, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Wed, Sep 11, 2024 at 8:53 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>>
>>>>>> @@ -1132,6 +1134,12 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>>>         if (ret)
>>>>>>                 return ret;
>>>>>>
>>>>>> +       ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
>>>>>> +       if (ret) {
>>>>>> +               dev_err(dev, "Unable to add action.\n");
>>>>>> +               return ret;
>>>>>> +       }
>>>>>
>>>>> Use dev_err_probe() to simplify.
>>>>>
>>>>> ret = devm_add_action_or_reset(dev, spi_geni_release_dma_chan, mas);
>>>>> if (ret)
>>>>>   return dev_err_probe(dev, ret, "Unable to add action.\n");
>>>>
>>>> It seems that if it only return -ENOMEM or 0, using dev_err_probe() has
>>>> not not much value for many community maintainers.
>>>
>>> While I won't insist, it still has some value to use dev_err_probe()
>>> as I talked about in commit 7065f92255bb ("driver core: Clarify that
>>> dev_err_probe() is OK even w/out -EPROBE_DEFER")
>> The main difference is that when use dev_err_probe()，there will print
>> anything on -ENOMEM now.
> 
> Oh, I see. You're saying that we should just get rid of the print
> altogether because the only error case is -ENOMEM and the kernel
> already splats there? Yeah, that sounds right to me. That doesn't
> match what you did in v5, though...

I think the following 2 soultion is both fine:

1、return ret directly.

2、dev_err() and return.

> 
> -Doug

