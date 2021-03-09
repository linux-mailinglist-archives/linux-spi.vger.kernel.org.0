Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254393321BD
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 10:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCIJOC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 04:14:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4650 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCIJNy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 04:13:54 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DvqGk4BLtzYHF4;
        Tue,  9 Mar 2021 17:12:14 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.234) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 9 Mar
 2021 17:13:51 +0800
Subject: Re: [PATCH] spi: Add HiSilicon SPI controller driver support
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
References: <1614599771-33629-1-git-send-email-f.fangjian@huawei.com>
 <20210301135405.GC4628@sirena.org.uk> <20210307144313.GA15472@wunner.de>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <1ec74012-f5b4-214a-ed35-d9031e94e000@huawei.com>
Date:   Tue, 9 Mar 2021 17:13:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210307144313.GA15472@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2021/3/7 22:43, Lukas Wunner wrote:
> On Mon, Mar 01, 2021 at 01:54:05PM +0000, Mark Brown wrote:
>> On Mon, Mar 01, 2021 at 07:56:11PM +0800, Jay Fang wrote:
>>> +	ret = devm_request_irq(dev, hs->irq, hisi_spi_irq, IRQF_SHARED,
>>> +				dev_name(dev), master);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to get IRQ=%d, ret=%d\n", hs->irq, ret);
>>> +		return ret;
>>> +	}
>>
>> This will free the IRQ *after* the controller is unregistered, it's
>> better to manually free the interrupt
> 
> Transfers may still be ongoing until spi_unregister_controller() returns.
> (It's called from devres_release_all() in this case.)  Since the IRQ is
> presumably necessary to handle those transfers, freeing the IRQ after
> unregistering is actually correct.  So the code looks fine in principle.
> 
> However, because the IRQ is requested with IRQF_SHARED, the handler may
> be invoked at any time, even after the controller has been unregistered.
> It is therefore necessary to quiesce the SPI controller's interrupt on
> unregistering and it is also necessary to check in the IRQ handler whether
> an interrupt is actually pending (and bail out if not).
>
Thanks for your review. I will consider not using IRQF_SHARED IRQ here.


Thanks
Jay


