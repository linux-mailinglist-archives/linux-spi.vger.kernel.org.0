Return-Path: <linux-spi+bounces-12447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D8D333FE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 16:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B89B3011A97
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56992FFDF9;
	Fri, 16 Jan 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fPjN5OZC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5C22D781;
	Fri, 16 Jan 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577711; cv=none; b=LZPBydLhMH+YechpsyZThWaxpmfts1tGfluOd32e4qFzr6VrfsXgOSmEY6BAdBgOXuEBNRhwf+Xjc0cHnztZny2Jt0s6WGrwZJ8nWLCxVdaQgPQwjdT3S3fHDb4AEiWH4h6EzTFtpwhIFDiR+WgKJuAiyZAl00Uy3RgoeOadfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577711; c=relaxed/simple;
	bh=T0OqNHITjaB95LOzKH+6SuQQ8qMwzGVkfxulOOb7a8U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z8Q+nJzf1YRlOSzRoGgFchncvEeqsYG0MOogWXZxQGtAZ+yMP7yowVBxd/NbpY6as2chdDRnW4n0z/xB3iCYL6ow2OW82o+IqBlNOxrD36nXwvBPL6ib4GOR03quifG2e+YeWtmt1R6s5NTNomZKY/d1eGVGPacm7VMxQQTRt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fPjN5OZC; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30f051665;
	Fri, 16 Jan 2026 23:19:41 +0800 (GMT+08:00)
Message-ID: <f8658bd7-7381-4770-935a-6a98ea3f652f@rock-chips.com>
Date: Fri, 16 Jan 2026 23:19:39 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Aishwarya TCV <Aishwarya.TCV@arm.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] spi: rockchip: Use plain request_irq()
To: Mark Brown <broonie@kernel.org>
References: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc7640d8b09cckunm99e7e01e73ca7b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5IHlYfHk5CTh9IGUtIT0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fPjN5OZCavPa5KsaxCi1vx8vv+g3J2/G9w0fEZyu6dOd99f9I9VcpNlDee8dg8PNLWkH+DJavKruVTCaPEmINwS4T0F3XXi6wmPgMpwrb/vp0IIov8vB9i8df13d8CY7n8eaVGojSgFKtfwPp7v9vZbUcNdQv+LdgStyvuIiYkc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=helqByT45xgygaR3omsf6cACAEULnpjlMgPw8Kgw2w8=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/16 星期五 21:23, Mark Brown 写道:
> The Rockchip driver has since interrupt support was added used
> request_threaded_irq() but not actually supplied a threaded handler,
> handling everything in the primary handler.  This is equivalent to just
> using a plain request_irq(), and since aef30c8d569c (genirq: Warn about
> using IRQF_ONESHOT without a threaded handler) the current behaviour has
> triggered a WARN_ON().  Convert to use request_irq().
> 

Is it preferred to use threaded version if latency is not a critical
concern ? I guess the original intention was to use

ret = devm_request_threaded_irq(&pdev->dev, ret, NULL, rockchip_spi_isr,
IRQF_ONESHOT, dev_name(&pdev->dev), ctlr); ?


> Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/spi/spi-rockchip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 1a6381de6f33..62e1bc08c940 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -805,8 +805,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err_put_ctlr;
>   
> -	ret = devm_request_threaded_irq(&pdev->dev, ret, rockchip_spi_isr, NULL,
> -					IRQF_ONESHOT, dev_name(&pdev->dev), ctlr);
> +	ret = devm_request_irq(&pdev->dev, ret, rockchip_spi_isr, 0,
> +			       dev_name(&pdev->dev), ctlr);
>   	if (ret)
>   		goto err_put_ctlr;
>   
> 
> ---
> base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
> change-id: 20260115-spi-rockchip-threaded-irq-b1641d0d3919
> 
> Best regards,
> --
> Mark Brown <broonie@kernel.org>
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 


