Return-Path: <linux-spi+bounces-4217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE070956535
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15B61C21829
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143115820F;
	Mon, 19 Aug 2024 08:08:05 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EFA41;
	Mon, 19 Aug 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054885; cv=none; b=nW1RXVVQOlPgN4Em3CjvtS34QgaAFY+8kSkitFPc9lCiVnDSd+DsmtPSEbzTmCTt0pys0fgP64JRBQY+diA3wU5yHOmKDDwaKGkoW/OWNNx0Ivzyc4q81us5/CPpaYSiax7OAB9uID/lvFPZkjkEVMSTzBZ2iilmZKExJp+KI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054885; c=relaxed/simple;
	bh=/2Uyq1xfnnYVyRAxAuEIooMCY8k5oxftkTiJs9YEaUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WyqAHfuTT1AIC4q0TjMP8TjAhpMgOZ1tZHwsePe+ihn8BfUn/Urk7Zti4acrsl4neg05dthgV67+vfI+FnL1FPbKKiJsEEfRwCEcs0ChBMRSZ5xdsaqboRonK5zUtpEMhZ1NunFBnVYQ4InwAXGlOt3TxVtVAOgxA1VxcjyVoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnQ9t171sz1HGnd;
	Mon, 19 Aug 2024 16:04:50 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id DDD361A0188;
	Mon, 19 Aug 2024 16:07:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Aug 2024 16:07:59 +0800
Message-ID: <cb368941-b9a1-f673-85e0-b98bd947e0c3@huawei.com>
Date: Mon, 19 Aug 2024 16:07:58 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] spi: bcm63xx: Fix module autoloading
Content-Language: en-US
To: Jonas Gorski <jonas.gorski@gmail.com>
CC: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240819040709.2801490-1-ruanjinjie@huawei.com>
 <CAOiHx=kutdcmATMQNsp+aYvAm7g2u+GDRfdg6Oe1fcE7XNRbTA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAOiHx=kutdcmATMQNsp+aYvAm7g2u+GDRfdg6Oe1fcE7XNRbTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/19 15:47, Jonas Gorski wrote:
> Hi,
> 
> On Mon, 19 Aug 2024 at 05:59, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
>> based on the alias from of_device_id table.
> 
> Your code change adds a MODULE_DEVICE_TABLE() to platform_device_id,
> not of_device_id (which is also missing it). Please align change and
> message.
> 
> Also since this is a fix, please add an appropriate Fixes tag and Cc stable.
> 
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Apart from that the change looks good.
> 
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Jonas, Thank you, I'll fix it, thank you!

> 
> Best Regards,
> Jonas

