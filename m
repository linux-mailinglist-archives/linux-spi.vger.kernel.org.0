Return-Path: <linux-spi+bounces-10395-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0EBB02E2
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CBB2A2ED9
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5AD2DC323;
	Wed,  1 Oct 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LMj71SZe"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EF2DA751;
	Wed,  1 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318457; cv=none; b=UFBDi3Zm5sQnHdYpFHC5CkiTnpMKa5UKjJKuWF8e0o1kRanN+yYf6TQvaCWY5lX8hamRfnNboIzjsaPYYf5xqoWQSLlYKMHRniwvc8yvJcyEkgVecQ3E+lwK+6qPIH3+b0Km61O8TpSLswfzhRDb641rEXPsnvg1J7fvCkhmpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318457; c=relaxed/simple;
	bh=zpQrOFOPqVvlT4pJe9ZkIkPzqGLH6HsuGaHlEdclWno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCyQDoV7mUhSpRUAjAa99G/gMDWNuKBHNwmt8nLCO/kZFVi2J/FSJotABHK6MKpOZ5SdsBFpYHMxNJrS4Dx9HCEkmoZV73gPtrsv8coHsvK3KMbhyHu1kdnGkYc+x7D+UGlxQ4pPsNa3p+btC8fkMtm5DFe39w9FrApiweLjTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LMj71SZe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318453;
	bh=zpQrOFOPqVvlT4pJe9ZkIkPzqGLH6HsuGaHlEdclWno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LMj71SZeBdZ34iSi+ZXBuNlrQ7SV3mbQj6v24yHTVMXg6xuBwc56hRMznrndh0cE8
	 JahUnrkXOGPjKeT5A7X/+KCKo9ZE+MBw7DRmkTkEeHsVhP0UZOKrhYOUQhHMaVXPkt
	 +k8ZnOzQxGtCQP5QDQzeZ3yL4xEevcyZpGxw42MYj+b3LqjViHxJtYxO2eHSOgGaaD
	 cW6QBcgHIanwIvxa9kk2+MsBCq79rZ8sGX87S0+xtVNSkCAhlZTpp+Du7WLc+dZgtW
	 2BGhzCfl0qQiOLeOyH5dbnXh3ltac39PKh2hIlZqrOUeNE7vse0bVkwHFGXaH/HvVn
	 RWwpzfY4Jy7pg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A0F517E120D;
	Wed,  1 Oct 2025 13:34:13 +0200 (CEST)
Message-ID: <55975f94-3655-480c-be9e-ac4075c60a7d@collabora.com>
Date: Wed, 1 Oct 2025 13:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 03/13] spi: airoha: add support of dual/quad
 wires spi modes to exec_op() handler
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-4-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> Booting without this patch and disabled dirmap support results in
> 
> [    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
> [    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
> [    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
> [    3.001075] Creating 2 MTD partitions on "spi0.0":
> [    3.005862] 0x000000000000-0x000000020000 : "bl2"
> [    3.011272] 0x000000020000-0x000010000000 : "ubi"
> ...
> [    6.195594] ubi0: attaching mtd1
> [   13.338398] ubi0: scanning is finished
> [   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
> [   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
> [   13.356897] UBI error: cannot attach mtd1
> 
> If dirmap is disabled or not supported in the spi driver, the dirmap requests
> will be executed via exec_op() handler. Thus, if the hardware supports
> dual/quad spi modes, then corresponding requests will be sent to exec_op()
> handler. Current driver does not support such requests, so error is arrised.
> As result the flash can't be read/write.
> 
> This patch adds support of dual and quad wires spi modes to exec_op() handler.
> 
> Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


