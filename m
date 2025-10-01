Return-Path: <linux-spi+bounces-10399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE4BB02FD
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4874717AD3B
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A922DF128;
	Wed,  1 Oct 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gPr8JM0r"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB02DE713;
	Wed,  1 Oct 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318461; cv=none; b=CB8vOD6Bi7UifOMb2Xq/xfGgBxLigL5VsPKE8B9bD3pB4dL4JQL8HvB5tCCuv/p2Jw56jJ1AAZTHvHMUNjXbRZ407tIC8DfCe+RBukOpi/iAdmjr2Nvr2DNY+31Yiy36AB5zD6HYTxy+5sI6Lx+RuOUcNlJ5nsQZj67QLki5DOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318461; c=relaxed/simple;
	bh=4ekgiOSsVeMhFoaUOo+lKCWR44dDBKV2EZ5bN48Q60w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBBCwTPhiuWBzOX9N3K/D2IQyyQuNaz7xNExNwbl23jEc93yFgGY5+0/VKd4xf+gvHCsDqE7lByO8rMJRvvO2U5jcrNk3Zy2+U+hbZC7erfVS7YB08QowS84CGD99g7PvI+bKmQytsup87wQYLlbo1Uxfx5BMd1zw5GH1BeVKxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gPr8JM0r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318458;
	bh=4ekgiOSsVeMhFoaUOo+lKCWR44dDBKV2EZ5bN48Q60w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPr8JM0ruBY4wWi/iSWIIPvJoU2xO1lRiMTt+vNgbQ+1L7o9kbgAIq7E4xBFaUS/D
	 6QhaSisJf+XRrYGX/6zCstIWnoEB7+DjHMfP5xQYYmJcWWy2zLQ+7FPFwZcqTEsCO7
	 HLtZxf2QiQCpRprcpmkn0vWnj7VWj2DW/32r0y5TUOTj378rnup9DhHLZ0dHr4EW5P
	 iH1y3xaDf5OeHJ056UtGat/da7188J6Y/ZiJxtKBp0sRcPYInYmJ2qt+c6oKbyx3ol
	 RcswwCKOlnlAavYAZ8MQC5vJvs0wEp5Dm2sRO47pMbkk3TsKOD1YYtJF1byS5ZiP6w
	 D3E2rrTMA2ufw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C516917E120D;
	Wed,  1 Oct 2025 13:34:17 +0200 (CEST)
Message-ID: <ff5feacb-6393-42b8-9134-46e22991e7d9@collabora.com>
Date: Wed, 1 Oct 2025 13:34:17 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 01/13] spi: airoha: return an error for
 continuous mode dirmap creation cases
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-2-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> This driver can accelerate single page operations only, thus
> continuous reading mode should not be used.
> 
> Continuous reading will use sizes up to the size of one erase block.
> This size is much larger than the size of single flash page. Use this
> difference to identify continuous reading and return an error.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


