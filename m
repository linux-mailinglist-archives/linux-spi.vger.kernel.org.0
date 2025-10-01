Return-Path: <linux-spi+bounces-10391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D188BB02CD
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123D916FCF2
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530B2C324F;
	Wed,  1 Oct 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E1dEv9CV"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331F2522BE;
	Wed,  1 Oct 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318451; cv=none; b=MUc3Gns3yvjU9fdNsqfExGKilejLuHa3rj5jJ8IZoJEzyBL+/7T8hWRRVvjL5FH+Z29BdjKzoN/FoLZc1ad3qNbpBDh827a6Ve2/DNchPtYBxd7W0vILjpVrWg9Fm5Zygveq5TROgTgVBlwAQ23oxPw7ZsiLquhnBJi/kdTI6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318451; c=relaxed/simple;
	bh=41SWZdcJyCda+Y1x9K2FRogst2ZLFrtZo76JuwTw8ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoVmyoAVCix8l7F1942tSCpuUMfi/TUCCrRu5rG+WE7bEkmgHN4f4WXxjXES35pPNj4idvRo6VVNjDGk5K/2zOfrvJ8t2a2V+X9ElknqKMMUXfRVUv8zSE/g/397gUEMVOOLio+s0KZBLfGKUpKNmchshJFr/qu2H+ggAnaTSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E1dEv9CV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318447;
	bh=41SWZdcJyCda+Y1x9K2FRogst2ZLFrtZo76JuwTw8ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E1dEv9CVRNQ7BJrOoKDCByEI7aAk9L85vkqjNfy4vGsrR0VJIv4Dzotn+Tc32U3Yt
	 rWiAVRauD+oXxcUXWPg7xkSLsaK7XVVbNUv31sogZnI0NjC6BPberE0V3VYMMnhkgH
	 yVmjnCirmelNzj4AkibN/UtXSStM7daaNGPF0eazzefy3yZ5v9cTWqnmX2p9ZoLEvG
	 arq0B68gxQ5K6fJr4DqKom55SXHvLr0l7Q3LTsw/ROblq/0pGwfv0Vw5vsIFBsg25e
	 qdH6XkxDY6nidGaJjSzjFVUF6FEK2EpZtoaIqfXRIebF/KrfLpY5HJBQz/MGLEOeNQ
	 3AXSyRF9b7KAA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 85DFF17E120D;
	Wed,  1 Oct 2025 13:34:07 +0200 (CEST)
Message-ID: <70083e67-242d-4f67-bd51-0638749926a1@collabora.com>
Date: Wed, 1 Oct 2025 13:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 11/13] spi: airoha: set custom sector size equal
 to flash page size
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-12-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-12-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> Set custom sector size equal to flash page size including oob. Thus we
> will always read a single sector. The maximum custom sector size is
> 8187, so all possible flash sector sizes are supported.
> 
> This patch is a necessary step to avoid reading flash page settings
> from SNFI registers during driver startup.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



