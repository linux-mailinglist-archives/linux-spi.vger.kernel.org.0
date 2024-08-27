Return-Path: <linux-spi+bounces-4327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B595FE65
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 03:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EB1C21A48
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12079CC;
	Tue, 27 Aug 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YwcnEvCB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m155116.qiye.163.com (mail-m155116.qiye.163.com [101.71.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E679D0;
	Tue, 27 Aug 2024 01:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722849; cv=none; b=fgFFowx5e+DyPurwm/aLjppRJzDGBaK+XM+vbgbqwODYgt54IEI98piRH7kBL0M1mxLvkn5tMaONPhkJBfR9I8N1sQEOYZWFs9vVQxwayCOSG9zEel6CNZnWjQDPM8YdFOquoqL+//vcuta5OpWuCNVUG7SO6iUOTCiKV8jqEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722849; c=relaxed/simple;
	bh=67RseptJ9zS6HPWFxA6mgoDhVt/aPRStVXtn6DisPbU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JrWMbbmgUm2Lr8RhOkjRvrwK+4zba4jd4s74V3XUGqjG8eP7D12hCx88nQXr92lmErwyzmwegvyHu2amVYQfjHiOdhLfv2SQboovTjPqkDN4NyRNis9djcCwj9CuFr0Kied8/f9Kh42fwFx4ZrHbrhuuZh2m3VTrwgfH/gyqYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YwcnEvCB; arc=none smtp.client-ip=101.71.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=YwcnEvCBSXSDD0L2/VPndhPM3BAC608LHVmbCaY2FgrSLmixGTDXK16c9laZL3Vc9zhBA79CGcacJ3buJ5kKH47oW87YRniMjjfMXheaeN6kQfiFnypvIHorTL204omol7FROzdb9AFMeP+YNmhX5PuAXuKxR4hhOKr8HF0+6qE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/Q9mCEfT7guHVPvwR6ja5s0FAEOaseOBjw07BJH8nVo=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.28] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 0C70C6E01B6;
	Tue, 27 Aug 2024 09:32:50 +0800 (CST)
Message-ID: <27302919-5bcd-4bcd-bdad-02aa48e628e9@rock-chips.com>
Date: Tue, 27 Aug 2024 09:32:52 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Lin <jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm
 operation
To: Brian Norris <briannorris@chromium.org>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
 <Zs0BRsNdZdI69aXM@google.com>
In-Reply-To: <Zs0BRsNdZdI69aXM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxMHlZITE5JHR5OGR1DTUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a919176dba609d5kunm0c70c6e01b6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDY6Cjo*CzIxKBwRPiINEDQR
	Dg8wCxFVSlVKTElPTElJSExJS0lJVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFPT09DNwY+

On 2024/8/27 6:27, Brian Norris wrote:
> (NB: I have several nearly identical copies of this email. I'm replying
> to the latest one I see.)
> 
> Hi Jon,
> 
> On Sun, Aug 25, 2024 at 11:54:22AM +0800, Jon Lin wrote:
>> Fix WARN_ON:
>> [   22.869352][ T1885] clk_spi0 already unprepared
>> [   22.869379][ T1885] WARNING: CPU: 3 PID: 1885 at drivers/clk/clk.c:813 clk_core_unprepare+0xbc4
>> [   22.869380][ T1885] Modules linked in: bcmdhd dhd_static_buf
>> [   22.869391][ T1885] CPU: 3 PID: 1885 Comm: Binder:355_2 Tainted: G        W         5.10.66 #59
>> [   22.869393][ T1885] Hardware name: Rockchip RK3588 EVB1 LP4 V10 Board (DT)
>> [   22.869397][ T1885] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>> [   22.869401][ T1885] pc : clk_core_unprepare+0xbc/0x214
>> [   22.869404][ T1885] lr : clk_core_unprepare+0xbc/0x214
> 
> I appreciate the snippet of a WARNING trace, but I'd also appreciate
> some actual explanation of what the problem is, and why you're solving
> it this way.
> 

Thank you for the reminder.

>> Fixes: e882575efc77 ("spi: rockchip: Suspend and resume the bus during NOIRQ_SYSTEM_SLEEP_PM ops")
>> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
>> ---
>>
>>   drivers/spi/spi-rockchip.c | 57 +++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index e1ecd96c7858..043a7739c330 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
> 
>> +#ifdef CONFIG_PM_SLEEP
>> +static int rockchip_spi_suspend(struct device *dev)
>>   {
>> +	int ret;
>>   	struct spi_controller *ctlr = dev_get_drvdata(dev);
>> -	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
>>   
>> -	clk_disable_unprepare(rs->spiclk);
>> -	clk_disable_unprepare(rs->apb_pclk);
>> +	ret = spi_controller_suspend(ctlr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Avoid redundant clock disable */
>> +	if (!pm_runtime_status_suspended(dev))
>> +		rockchip_spi_runtime_suspend(dev);
> 
> It seems like you'd really be served well by
> pm_runtime_force_{suspend,resume}() here, and in fact, that's what this
> driver used to use before the breaking change (commit
> e882575efc77). Why aren't you just going back to using it? (This is the
> kind of thing I might expect in your commit message -- reasoning as to
> why you're doing what you're doing.)
> 
> And in fact, I already submitted a patch that resolves the above problem
> and does exactly that:
> 
> https://lore.kernel.org/all/20240823214235.1718769-1-briannorris@chromium.org/
> [PATCH] spi: rockchip: Resolve unbalanced runtime PM / system PM handling
> 
> Do you see any problem with it?
> 

I have reviewed your submission and although the code has been 
simplified, the execution efficiency has decreased. So although it is a 
commonly used processing solution for SPI Upstream, I still hope to 
retain a more efficiency approach as I submitted.

> Thanks,
> Brian
> 
>> +	pinctrl_pm_select_sleep_state(dev);
>>   
>>   	return 0;
>>   }
> 


