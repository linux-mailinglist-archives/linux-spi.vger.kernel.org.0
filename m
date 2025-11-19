Return-Path: <linux-spi+bounces-11286-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D30C6CF32
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 07:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE9B4EFCA4
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843DA30FF04;
	Wed, 19 Nov 2025 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yPVSrAnt"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F08303A19;
	Wed, 19 Nov 2025 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534008; cv=none; b=kCmW6/eQYHw095lIAODY1AUKp1UkXkyUpyDEQjvU6TCDqW7FhuOxttke2+sHapOo97ZFVr6mnc0GCwpeepJzlGa/kBcgJOLXm/3OqVwoIE71vmVlBjsb41qHPkeed+U+y3dp0QnbHvvDniPKgc7trRBIWlIAPui97YbKQGh9ukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534008; c=relaxed/simple;
	bh=5pyQq1taauSh8/SJWjyOBcrg3VlOSlZouBmaXOgyFkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKFFDqcx+LuLgq2dq+Mwwix9u1yHkSL/PPlbAOXkf6yFwXD41DzFxtA7/Me4SpGkLNr0Eovkk1sL8e6aV1anApv0zYcGvB7RgMrMb7ZhDpdZQlSSE6gAdreqzR+0oFbMMcHW+KgXU0Ah3zvtdKEelmpovyzr1xUa+fUstrYiGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yPVSrAnt; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763534001; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JGBD9uIKJGsbsYHKu4gwadFTAO5yH0fx1sV5Qtqvx0U=;
	b=yPVSrAntlzPl1tLfO4F2k0+BEgLP4nJ5Dqbltn7lV6GPMtHgENvybE2vVTOFNy8HrQKD/15Ll+09visDVpYHWiTo2Z1IaJWz2R1+qPf3J2A6KnY+Y8e2pt2GPi+w59bWZ6A8fI43naj/G1n5H7Q0VjulJEwqAQirToiQSLbu4YI=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WsnYQ2Q_1763533999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 14:33:20 +0800
Message-ID: <6286c547-2710-4854-a58f-8f3aa1dfc91e@linux.alibaba.com>
Date: Wed, 19 Nov 2025 14:33:19 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mfd: sprd-sc27xx: Move poweroff/reboot support to
 the parent MFD driver
To: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
 Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Cixi Geng <cixi.geng@linux.dev>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251110-sc27xx-mfd-poweroff-v2-0-fd5842e732fe@abscue.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC Cixi.

On 2025/11/11 03:08, Otto Pflüger wrote:
> Registers for powering off the system are present in all SC27xx-series
> PMICs, although their locations vary between the specific PMIC models.
> On systems using these chips, the PMIC can always power off the system
> and is usually the only chip capable of doing this. Similarly, the PMICs
> (except for SC2731) contain a reset register that can always be used to
> restart the system.
> 
> There is an existing sc27xx-poweroff driver, but it currently only works
> on SC2731 and is not probed anywhere since it is missing an OF match
> table and is not instantiated by the MFD driver. Reboot for SC2731 is
> implemented in drivers/spi/spi-sprd-adi.c, which is not really an
> appropriate location for PMIC-specific code.
> 
> Since a separate device tree node for the poweroff support would not
> provide anything useful (see [1]) and passing platform-specific data
> between drivers is unnecessarily complex for such a simple feature,
> reimplement the poweroff functionality in the main MFD driver. While at
> it, add support for the newer SC2730 PMIC and its hardware reset
> register.
> 
> Reboot is special because it requires storing the reboot mode. Move the
> existing code for this from the SPI bus driver to the MFD driver.
> 
> [1]: https://lore.kernel.org/all/20251002025344.GA2958334-robh@kernel.org/
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

Overall, it looks reasonable to me, but I cannot test your patchset 
right now due to the lack of hardware. Cixi (who is from Unisoc), could 
you help test this patchset? Thanks.

