Return-Path: <linux-spi+bounces-10392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0BBB02D3
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765F17A86D5
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5302D063B;
	Wed,  1 Oct 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dCy/x7Kf"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C42882D0;
	Wed,  1 Oct 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318452; cv=none; b=neT9aYzum8bNoGzPZkFvouwhow8cCbSYxxgdhZ5I1wG4Gc3LaxObtYdW38VWKBmJSvWOTWW5vEVyQW/Vi9uLSxudot5Cdrv3w8SOQO0bXg516mTuMJRhqIHRbhvP6oxJYgsNUo9NL42cloefYryZSUMXpg/2d0E7Tg3Js2xEw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318452; c=relaxed/simple;
	bh=Q2Q12qT4e1anQPRDSKmIVi1PJqAH4mr3j7v6hwedv0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6GchPTOUT00YS0dFV5eyQspGVFNXSm+xS0rGxTvNyi1b43MlzrPvAOYIzoKh3rFizOBHqzrMfjKb6qTJGz3GKi0dCZNCWGS2rBm8y8QMUJkB0MSokz0bzWfRQ77ymDuCzmvqnyuuDvmA7hpKdKaNHS9weoUq2/lXXFgwA9P1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dCy/x7Kf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318449;
	bh=Q2Q12qT4e1anQPRDSKmIVi1PJqAH4mr3j7v6hwedv0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCy/x7KfT7QwAb1G/p3lPVCLZGeyGKm8lI514+VKyZDQs0cga52+d5T6GC/aNulX6
	 4ofOmXqtuNEnt+I94N1jVsI/oL/x0GB/1OOj2t10ske12ualkDgm3S8gCTTRd5larI
	 5pf7BHCK4Gh0ayA/zvkd9wW90NmkGSo6hiPfwt9eVUeasQVHhcOJm/w2bQqXrXOCe8
	 ac1IXoeVn9inujFHwORSOsmkBvdS1ET+uix/KXWeur0Xfc+Sz/SuGfKqGLnGKvVLWf
	 fvAv6uuVIFsnyDLmPIStxKkAsalDdn4N3hKxgFNnCpgA5cAFjweaGO+CjPbe+n+uMy
	 76myzOK9EFdNQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B2EB017E12DA;
	Wed,  1 Oct 2025 13:34:08 +0200 (CEST)
Message-ID: <34e2b620-f540-4fe7-a68f-0aaa87bacf2b@collabora.com>
Date: Wed, 1 Oct 2025 13:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 10/13] spi: airoha: reduce the number of
 modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-11-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-11-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> This just reduce the number of modification of REG_SPI_NFI_CNFG and
> REG_SPI_NFI_SECCUS_SIZE registers during dirmap operation.
> 
> This patch is a necessary step to avoid reading flash page settings
> from SNFI registers during driver startup.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



