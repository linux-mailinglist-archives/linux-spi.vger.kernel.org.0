Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F8B1DC8FA
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgEUIqy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 04:46:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8370 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgEUIqx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 04:46:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec63f6c0001>; Thu, 21 May 2020 01:44:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 01:46:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 May 2020 01:46:52 -0700
Received: from [10.26.75.55] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 08:46:50 +0000
Subject: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        "Mark Brown" <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <af91d97e-6367-996b-a925-a5c81f6fb182@nvidia.com>
Message-ID: <046fe754-96d7-4530-2b70-e1991470ac0f@nvidia.com>
Date:   Thu, 21 May 2020 09:46:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <af91d97e-6367-996b-a925-a5c81f6fb182@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590050668; bh=wqcKSIH4pp4cK2tXITvJHzUw6hoJbcNsCjS4/KGudkE=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EK/aTQ7rz3fHlcaD5IK88IPRC9F2WKPnEk8U1kjY3eUJ4aVxQTGjZo8exZK1UGoDT
         VSL+iaoWOySo0FaGcLWp86UMMte8DBPPK90bzFD/NMty64vc2bhrqjXh5Y7qSoXIdD
         41k9xImeVn4R27lKhd48Egf3OAYlUJHWwZMaCn43XRITX4cqt5MjJ/vTxmqFDfe2jr
         /RwzeaVbMUcf8Igx8//gLJKvYWjb8bzkozqazOjq14y1KIFUxHb4HXSN8eElcOxesq
         IYBSKjlRqZnSYPxtrDH+DHZAa+eriiHszqof61od+tMtBkm4/Of5zi4P2LezBBAGEv
         vrXwXg/pZ6PvA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 21/05/2020 09:38, Jon Hunter wrote:
> 
> On 21/05/2020 09:04, Andy Shevchenko wrote:
>> On Thu, May 21, 2020 at 10:50 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>>>
>>> pm_runtime_get_sync() increments the runtime PM usage counter even
>>> when it returns an error code. Thus a pairing decrement is needed on
>>> the error handling path to keep the counter balanced.
>>
>> ...
>>
>>>         ret = pm_runtime_get_sync(&pdev->dev);
>>>         if (ret < 0) {
>>>                 dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
>>
>>> +               pm_runtime_put(&pdev->dev);
>>
>> For all your patches, please, double check what you are proposing.
>>
>> Here, I believe, the correct one will be _put_noidle().
>>
>> AFAIU you are not supposed to actually suspend the device in case of error.
>> But I might be mistaken, thus see above.
>>
>>>                 goto exit_pm_disable;
>>>         }
> 
> 
> Is there any reason why this is not handled in pm_runtime_get itself?

Ah I see a response from Rafael here:
https://lkml.org/lkml/2020/5/20/1100

OK so this is intentional and needs to be fixed.

Jon

-- 
nvpublic
