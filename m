Return-Path: <linux-spi+bounces-11387-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D3C73709
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 110034EB774
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BC2EF64F;
	Thu, 20 Nov 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gn98WaMM"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A42EC0AE;
	Thu, 20 Nov 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633895; cv=none; b=IqxB/sDXiIS2ApvuZdbf7ZjJNtOxJ7uFkBm6FT6Z+RpLIu70Tyhx6K5LrneCcfEeG9XYgC5RvCOe3WvSOf8PjZ23jIFMC4U9hMcU2V1RcnNuptNpUGuMWOl7vm3uxAY2IYaxXeA3z1i5T8/Ri8RknFgv/ztWtt43hNaTO520XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633895; c=relaxed/simple;
	bh=N9v693C71p7JFwlB4qoGB1WvggPJvzKD5CU0K6//7i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRU6cT18NdbPlPoAovzanoDj6A/Yn6Jyq7Kru96gfXfXsaC1X3SU9Od0su2E+iy2EpIMYhGRHm/wKynugzsDQV4/rP6+fJ3Y2yuX5ybSX5zYdCbDFeTvtwg5Kp1738eLWgENWTjOgy6EgP1GeF88VrmOME+SUl6wOaKc3ZgmoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gn98WaMM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763633891;
	bh=N9v693C71p7JFwlB4qoGB1WvggPJvzKD5CU0K6//7i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gn98WaMM5MoHPf+shmYmSr8cHZgiATwbYAeZOBC3+f/lhjCCiQjtPdqiShfvUQvjy
	 LdllZp3crc/xo+LwVTnX5mRkpRCxxAbwEoD8qbs7j78T1H7hlf5sUeL3uinfzc56L/
	 HiYZyIkxzUSfrlb7YAPRaDYcPh1nNchBgau2PvBxmNtYChFeIthfhFtbYZEYyLo3c3
	 X3fr4/uKTz35U+l7464qfH7Lx1SiMpLBrQmdzUYJts2VwSUCiYY8H3uDjkvjCgBEbr
	 YThhlG/v1vnGwsUeWl+HeV/Ke1k4qaxIeDZYsMVAW5A21gxv02mVKxIxYu5kfJgM/Y
	 0lF9pwkxNnzjA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7887C17E0CA1;
	Thu, 20 Nov 2025 11:18:11 +0100 (CET)
Message-ID: <15bf444c-0eff-4856-93a4-764668666c3c@collabora.com>
Date: Thu, 20 Nov 2025 11:18:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] spi: airoha-snfi: en7523: workaround flash
 damaging if UART_TXD was short to GND
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
 <20251120042753.640492-2-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251120042753.640492-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/11/25 05:27, Mikhail Kshevetskiy ha scritto:
> We found that some serial console may pull TX line to GROUND during board
> boot time. Airoha uses TX line as one of it's BOOT pins. This will lead
> to booting in RESERVED boot mode.
> 
> It was found that some flashes operates incorrectly in RESERVED mode.
> Micron and Skyhigh flashes are definitely affected by the issue,
> Winbond flashes are NOT affected.
> 
> Details:
> --------
> DMA reading of odd pages on affected flashes operates incorrectly. Page
> reading offset (start of the page) on hardware level is replaced by 0x10.
> Thus results in incorrect data reading. Usage of UBI make things even
> worse. Any attempt to access UBI leads to ubi damaging. As result OS loading
> becomes impossible.
> 
> Non-DMA reading is OK.
> 
> This patch detects booting in reserved mode, turn off DMA and print big
> fat warning.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

This is important enough to get a Fixes tag.

Please resend with the appropriate one, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



