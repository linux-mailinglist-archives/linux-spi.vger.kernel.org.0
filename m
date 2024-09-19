Return-Path: <linux-spi+bounces-4881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01097C877
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 13:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CAD286B70
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91D198E93;
	Thu, 19 Sep 2024 11:18:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E3194083;
	Thu, 19 Sep 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744731; cv=none; b=HAsM3EMRt29MY6ccmGdwTJVBKoQaI5Gtvyqn1WV23E3njvl+4VWupyAFMQa2Qj2hsJOKA0xn8bsqEJVZCkQlgJ9Y9SGaHhMlvR3nc+slv8Ch5ObDEI1gszrMwLzOLyG0DxYufBsIJdV6G2F+1A9MlOIO4DG24p4yDXTBIwtIIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744731; c=relaxed/simple;
	bh=Xpp9F586NtJldr7JyP/lhkmt8Pz8gLkQZ7PRDSfdSLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ptgyisNT7+FIy3t55gCCMJ7S1nsguBbf2+UTwT+qZR9PwnKCgPpyr0IyEpwMvtXVY5bveaAdNwS0a55vE9H/JVbK4m+smuD8LH1xq9KHyvz7NDDRSYnHTo9tFgEL/Q7IEDLTv02gB0Vz06nC7+flhRha4RYHMNKkS0+OFkIqbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X8Xyy4XhvzmYJM;
	Thu, 19 Sep 2024 19:16:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7647C180064;
	Thu, 19 Sep 2024 19:18:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Sep 2024 19:18:45 +0800
Message-ID: <1e2f2408-b6a3-64fe-b616-05470c75b0f4@huawei.com>
Date: Thu, 19 Sep 2024 19:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Use IRQF_NO_AUTOEN flag in
 request_irq()
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <xiaoning.wang@nxp.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240906022828.891812-1-ruanjinjie@huawei.com>
 <ZuwBWofLJ3ZbKpi8@finisterre.sirena.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZuwBWofLJ3ZbKpi8@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/19 18:47, Mark Brown wrote:
> On Fri, Sep 06, 2024 at 10:28:28AM +0800, Jinjie Ruan wrote:
>> disable_irq() after request_irq() still has a time gap in which
>> interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
>> disable IRQ auto-enable when request IRQ.
> 
>> @@ -948,14 +948,10 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>>  	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
>>  	if (ret == -EPROBE_DEFER)
>>  		goto out_pm_get;
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		dev_warn(&pdev->dev, "dma setup error %d, use pio\n", ret);
>> -	else
>> -		/*
>> -		 * disable LPSPI module IRQ when enable DMA mode successfully,
>> -		 * to prevent the unexpected LPSPI module IRQ events.
>> -		 */
>> -		disable_irq(irq);
>> +		enable_irq(irq);
>> +	}
> 
> This now enabled the interrupt in the case where we previously would've
> disabled it - I would have expected the condition on the if statement to
> be reversed?

It enabled the if statement rather than the else because the else
statement has been removed.

Use IRQF_NO_AUTOEN, the irq will not be enabled in devm_request_irq(),
so if (ret < 0), we should enable it, otherwise it is same with
disable_irq(irq) if we do nothing now, the main difference is that the
irq is not enabled when return before calling enable_irq().


