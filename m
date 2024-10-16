Return-Path: <linux-spi+bounces-5244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60499FFF2
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 06:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8681C1F268BE
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 04:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D31537C8;
	Wed, 16 Oct 2024 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dPuYbp9k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC5487A5;
	Wed, 16 Oct 2024 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051549; cv=none; b=krzLNS4uI5Bnk2Br43KKTSs39+FRa0MgECqlGO11tK3BwBHnnDxRXAxYKTtcYTRJSfu9x7LhcBWTApv7N3xpnMJG35jDkhcc/dzgLGUOFuwrfp8mnwwBZws4/52wiS+IgMvXUeEx3OyuKbUqx7giuuSWUnFfzExYvNH+V3wPQjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051549; c=relaxed/simple;
	bh=Nb3ZsxKYnLuVqULo8kN19pz9QSezoOB1Z3w/9DYEqXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXL/Pq15KntOHlCxScW2/TdPWXX+yf6j9i+YT0ijRqA5irLfwMp7OO6H7cxZhv6plV5H2SjGi0ELi0+hHaYJDFDAo+4dj4tySgznXnvd4rpqOyXlMl6O8xLZpAazNWTZUWKFuiZFh6IcGyJ/2byzFNRzysiaGzoCN5WDIMBMea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dPuYbp9k; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SrbLA9TBP4FveFtp5iVg3nOCER48OZwzq0HCka4D9ME=;
	b=dPuYbp9knlSJQ3ULuRIlPSc50BYJ/moxN4FQHBMTFaJomqiOM5RbGH3hCu9i8E
	wMxxKsPO34Nmmn6CA5dqBHj/qqclrGpMXWXWwVXAJ1IvQzXMv42WgwBSOmGNdV5H
	Px1SwvM1ypZpxND3i4Td38XnjfjQH1h32f2hnG9O1a0Ek=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCHTfV6Ow9nTMwVAA--.268S3;
	Wed, 16 Oct 2024 12:05:16 +0800 (CST)
Date: Wed, 16 Oct 2024 12:05:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: haibo.chen@nxp.com
Cc: han.xu@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, singh.kuldeep87k@gmail.com, hs@denx.de,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com,
	stable@kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: imx8ulp: correct the flexspi
 compatible string
Message-ID: <Zw87ekugHc/2YhPr@dragon>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
 <20240905094338.1986871-5-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905094338.1986871-5-haibo.chen@nxp.com>
X-CM-TRANSID:Mc8vCgCHTfV6Ow9nTMwVAA--.268S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1UAr4UXw45uFykKF4xtFb_yoWrJryUpF
	13GF9xCr48Gr4UAF47Jr4jyryUtay093WDJr1xJryFgF109r15J34xJF48KryDJFW3tFWf
	K34qgw48KFWDAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7eOJUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQx6ZWcPEbaWFQAAsO

On Thu, Sep 05, 2024 at 05:43:38PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The flexspi on imx8ulp only has 16 LUTs, and imx8mm flexspi has
> 32 LUTs, so correct the compatible string here, otherwise will
> meet below error:
> 
> [    1.119072] ------------[ cut here ]------------
> [    1.123926] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-nxp-fspi.c:855 nxp_fspi_exec_op+0xb04/0xb64
> [    1.133239] Modules linked in:
> [    1.136448] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc6-next-20240902-00001-g131bf9439dd9 #69
> [    1.146821] Hardware name: NXP i.MX8ULP EVK (DT)
> [    1.151647] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.158931] pc : nxp_fspi_exec_op+0xb04/0xb64
> [    1.163496] lr : nxp_fspi_exec_op+0xa34/0xb64
> [    1.168060] sp : ffff80008002b2a0
> [    1.171526] x29: ffff80008002b2d0 x28: 0000000000000000 x27: 0000000000000000
> [    1.179002] x26: ffff2eb645542580 x25: ffff800080610014 x24: ffff800080610000
> [    1.186480] x23: ffff2eb645548080 x22: 0000000000000006 x21: ffff2eb6455425e0
> [    1.193956] x20: 0000000000000000 x19: ffff80008002b5e0 x18: ffffffffffffffff
> [    1.201432] x17: ffff2eb644467508 x16: 0000000000000138 x15: 0000000000000002
> [    1.208907] x14: 0000000000000000 x13: ffff2eb6400d8080 x12: 00000000ffffff00
> [    1.216378] x11: 0000000000000000 x10: ffff2eb6400d8080 x9 : ffff2eb697adca80
> [    1.223850] x8 : ffff2eb697ad3cc0 x7 : 0000000100000000 x6 : 0000000000000001
> [    1.231324] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000007a6
> [    1.238795] x2 : 0000000000000000 x1 : 00000000000001ce x0 : 00000000ffffff92
> [    1.246267] Call trace:
> [    1.248824]  nxp_fspi_exec_op+0xb04/0xb64
> [    1.253031]  spi_mem_exec_op+0x3a0/0x430
> [    1.257139]  spi_nor_read_id+0x80/0xcc
> [    1.261065]  spi_nor_scan+0x1ec/0xf10
> [    1.264901]  spi_nor_probe+0x108/0x2fc
> [    1.268828]  spi_mem_probe+0x6c/0xbc
> [    1.272574]  spi_probe+0x84/0xe4
> [    1.275958]  really_probe+0xbc/0x29c
> [    1.279713]  __driver_probe_device+0x78/0x12c
> [    1.284277]  driver_probe_device+0xd8/0x15c
> [    1.288660]  __device_attach_driver+0xb8/0x134
> [    1.293316]  bus_for_each_drv+0x88/0xe8
> [    1.297337]  __device_attach+0xa0/0x190
> [    1.301353]  device_initial_probe+0x14/0x20
> [    1.305734]  bus_probe_device+0xac/0xb0
> [    1.309752]  device_add+0x5d0/0x790
> [    1.313408]  __spi_add_device+0x134/0x204
> [    1.317606]  of_register_spi_device+0x3b4/0x590
> [    1.322348]  spi_register_controller+0x47c/0x754
> [    1.327181]  devm_spi_register_controller+0x4c/0xa4
> [    1.332289]  nxp_fspi_probe+0x1cc/0x2b0
> [    1.336307]  platform_probe+0x68/0xc4
> [    1.340145]  really_probe+0xbc/0x29c
> [    1.343893]  __driver_probe_device+0x78/0x12c
> [    1.348457]  driver_probe_device+0xd8/0x15c
> [    1.352838]  __driver_attach+0x90/0x19c
> [    1.356857]  bus_for_each_dev+0x7c/0xdc
> [    1.360877]  driver_attach+0x24/0x30
> [    1.364624]  bus_add_driver+0xe4/0x208
> [    1.368552]  driver_register+0x5c/0x124
> [    1.372573]  __platform_driver_register+0x28/0x34
> [    1.377497]  nxp_fspi_driver_init+0x1c/0x28
> [    1.381888]  do_one_initcall+0x80/0x1c8
> [    1.385908]  kernel_init_freeable+0x1c4/0x28c
> [    1.390472]  kernel_init+0x20/0x1d8
> [    1.394138]  ret_from_fork+0x10/0x20
> [    1.397885] ---[ end trace 0000000000000000 ]---
> [    1.407908] ------------[ cut here ]------------
> 
> Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
> Cc: stable@kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks!


