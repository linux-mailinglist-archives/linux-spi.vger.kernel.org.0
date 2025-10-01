Return-Path: <linux-spi+bounces-10398-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D568BB02FA
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29933A10DC
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC42DEA72;
	Wed,  1 Oct 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EHVCnkW8"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E902C3770;
	Wed,  1 Oct 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318460; cv=none; b=NzF6eO3NLNsNjrA93NL5JIwCgjWg2s9BMfq3KzJ4dkw63iX8ZNww1MBsv1NBUtetao38O5nkfVP6OC3BlMFy1ShuT+rDlMuN/VvHPsvAyFK1vBs9ipoIlKASiT4/C9F8AGajtlusArdHv2WyddPCfvZ08MyBbBqwg7sb0cHQryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318460; c=relaxed/simple;
	bh=ox6s2XGlAFQMOJC4R5KYFkxyed/81WZwsUzVnJ5IZxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+X1znqAkdfQxPA6B9i7LBa1v3uGBbTgtdQTaXaBNdeva9V8z5wVVFBs78iK09ziatLXiI6U8BhK5za9V9u3p1dCcNp86sgaxs+XNO6Hd2g97BmQmikmFdYpJ3oSHKPlVHQ52U2UbQr5sIFZwtMDuzjgI7yrBHuGqnJpgmlR0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EHVCnkW8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318456;
	bh=ox6s2XGlAFQMOJC4R5KYFkxyed/81WZwsUzVnJ5IZxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EHVCnkW8v9MNkh2g3aBpf/S+H1g04R4eQK8eHnKV5Ki/8KiBQ6ZPqmTvpyIYFKIFl
	 JwVVwBFZATiGv5ckgYGRTPjaCrwePR49uBBRS1T6wGG/VRsBM9BnUIo9DOjkXtX0Qd
	 7r/2yVXgi1ek30yZX0U+2TyEtPxZV+Zh9BSN+nOY7tLBwvshghSn3fRSmJOGeJoof6
	 lXlnplK5U3yiHwNYQsOHWPC/sb8YRijm57A3IR05fXraRUzBJVfkKtR5QnGY4Kwq+A
	 kdnDm5Ih/MnNQ0IYPDfkXS0pPXr3lPbfVHq5gnh7X/AiMLrgFlhsffTA5Pknt1xJnS
	 8fsSio8obweuA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E82117E13D3;
	Wed,  1 Oct 2025 13:34:16 +0200 (CEST)
Message-ID: <6cbaa1a8-9cb2-4611-a28c-c7e160018cc9@collabora.com>
Date: Wed, 1 Oct 2025 13:34:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 04/13] spi: airoha: remove unnecessary switch to
 non-dma mode
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-5-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> The code switches to dma at the start of dirmap operation and returns
> to non-dma at the end of dirmap operation, so an additional switch to
> non-dma at the start of dirmap write is not required.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



