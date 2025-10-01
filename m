Return-Path: <linux-spi+bounces-10397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F5BB02F4
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E9F7B065C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40422D879F;
	Wed,  1 Oct 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zs7Ejgyw"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA82DBF76;
	Wed,  1 Oct 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318458; cv=none; b=KMOwBj5lL25qLbg5xtvkNmKXWgLTVgyeDT28a+acE63EPzOEEvSeV+N6E6PelN4O9X5Cu8RJT/WUDrf/huBOGAU9THCOFWcXMWOtd5iNJclcSXAJ2JDI1OIZuQutXfpcWQV+iriau8lDY5kwrDhe9ODpdgN2d93Z5uM7B081Ddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318458; c=relaxed/simple;
	bh=RGqZAG5ZFUepNGRkuJiS/jtxSWMctgEuai/I5vyMdYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMMYr/J/shx4WJojiTTx2Zwxdxp8ifwpibKh3+DuYb+BQAhF+qb5EWzmDP3wrqstGD8jARSjB9rq0Nt2ix2k3AJELmbOO5JYvPhUJALs7Zt+kiz9ZN4qJlG8JxmI9Rav2Yi7jHfDgVIUSTb8p16IDYW4g/lD7hLiASpI+OSTq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zs7Ejgyw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318455;
	bh=RGqZAG5ZFUepNGRkuJiS/jtxSWMctgEuai/I5vyMdYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zs7EjgywF9Eewol9zMZfR3xot3u/T1kS4eP+HARGF9KYYlvJH+dUOjU5yw8d081hm
	 EgGGH8U7PxqKo/80kNhWR4hbGvFc/uQTiVaj3T8mBJfGANSYeGnQ8sJHvp0Ne4MDxy
	 QjsMG7smcCeM4DQP+QVsyCsHFN55LIYcjnNDhgDlCyLlWDjINNRv7pCfDpJzaXl7MM
	 XpKf08VJGPFvCzbhbXt+RgryDBwcJ2hBsuHc3Yit8pmDDgkN/PN923Q0ILlgptQYti
	 Ms/3rC69Pv8fjWbVFmc3WXXnMTMhU3UiHp0e1Is3tlpItjXhiCSt1U8cfV+KL6ce3p
	 9gv3x7TUZ+yaQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3192817E1345;
	Wed,  1 Oct 2025 13:34:15 +0200 (CEST)
Message-ID: <64c778bc-1a29-4ed0-96fa-dae38479813f@collabora.com>
Date: Wed, 1 Oct 2025 13:34:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 05/13] spi: airoha: switch back to non-dma mode
 in the case of error
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-6-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> Current dirmap code does not switch back to non-dma mode in the case of
> error. This is wrong.
> 
> This patch fixes dirmap read/write error path.
> 
> Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



