Return-Path: <linux-spi+bounces-12466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5075D38B81
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 03:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4A90302D899
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 02:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C801DF254;
	Sat, 17 Jan 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AEEmPEne"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94A74BE1;
	Sat, 17 Jan 2026 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768616132; cv=none; b=OL2RKd2PfDfFIqRiXBvstdw6OW9EyVvp0uxe26/zHVffjUv9kohYma3kbvFG5VoIWOVirxIwV6MwiE0u31mpzhPAaSgvG2cj2CYHTh8iw1Phs0YNFo4FW1vwCc4H6pY4mwi9s//vP9NO1SV/9L0uACDoDjvzk9uH+LYaK7e/ZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768616132; c=relaxed/simple;
	bh=F7w0zo/93vWNFP1CVqHZ0Sg7X88uQx5CkE+J7z00WNw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B+g9PdWP/T0IUKc2cuEfcR6MlM28ZwHdEV5cnf9nOz6d/Xopr0pSw4Bfv+8JhlZI3WO+mkZPaGp8wNCXsaN8+zDD0VqcQUq0vFw0gw8QOEJxyvvJVHVZYosNmHIMGpBLSzmiVfxDwrWFQcOM25gnK9dU1XBg/Q4O0QWzhVux+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AEEmPEne; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30f8e2691;
	Sat, 17 Jan 2026 10:10:09 +0800 (GMT+08:00)
Message-ID: <9c9d2fa3-46f3-43e6-95d0-6b5ec6b6ea78@rock-chips.com>
Date: Sat, 17 Jan 2026 10:10:09 +0800
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
 Heiko Stuebner <heiko@sntech.de>,
 "xuhui.lin@rock-chips.com" <xuhui.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip: Use plain request_irq()
To: Mark Brown <broonie@kernel.org>
References: <20260116-spi-rockchip-threaded-irq-v1-1-c45c3a5a38b1@kernel.org>
 <f8658bd7-7381-4770-935a-6a98ea3f652f@rock-chips.com>
 <a5b6c607-9b8c-4fa6-98c5-6ba848f7f2e2@sirena.org.uk>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <a5b6c607-9b8c-4fa6-98c5-6ba848f7f2e2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc9b7932709cckunm71430622777bb9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4fS1ZPSU4ZSBlMHUJPSh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AEEmPEne5H2CrfSGk3MDyhTd86aNBKC5JSFR7RBvuYjSennkbK3awJVCTgx8pT9ednbNr/KvuS6Vxo5OXdio86J7dws1sFFjvBTooExUQK3bD7bPA5UJUCm/G5gxCse/2SQF6NJakFZsK9pctoB9jlXtFnkxWaeB7Y9Ikgz522M=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Cm5Wp8stDwRLzC/ClhKyPOEbBhpVhy/nTFwwMOc004U=;
	h=date:mime-version:subject:message-id:from;

+ Xuhui from rockchip who may keep an eye on spi-rockchip related topic

在 2026/01/16 星期五 23:37, Mark Brown 写道:
> On Fri, Jan 16, 2026 at 11:19:39PM +0800, Shawn Lin wrote:
>> 在 2026/01/16 星期五 21:23, Mark Brown 写道:
> 
>>> The Rockchip driver has since interrupt support was added used
>>> request_threaded_irq() but not actually supplied a threaded handler,
>>> handling everything in the primary handler.  This is equivalent to just
>>> using a plain request_irq(), and since aef30c8d569c (genirq: Warn about
>>> using IRQF_ONESHOT without a threaded handler) the current behaviour has
>>> triggered a WARN_ON().  Convert to use request_irq().
> 
>> Is it preferred to use threaded version if latency is not a critical
>> concern ? I guess the original intention was to use
> 
>> ret = devm_request_threaded_irq(&pdev->dev, ret, NULL, rockchip_spi_isr,
>> IRQF_ONESHOT, dev_name(&pdev->dev), ctlr); ?
> 
> TBH it looked to me more like there'd been some deferral of more complex
> work at some point but that didn't make it into the final code.  In

Ah, indeed，rockchip_spi_isr() directly performs R/W pio in hardirq
context which doesn't seem advisable, so probably some better
improvement is needed in the furture. Anyway, fix the warning right
now as $subject patch looks sensible:

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

- Thanks.

> general it's better to handle things in hardirq context if they are
> appropriate for that, and for a SPI controller the end requirements are
> coming from the device so you have to assume they're going to need
> things to complete promptly.  There's overhead from scheduling a task so
> no point in incurring it if it doesn't buy you anything.


