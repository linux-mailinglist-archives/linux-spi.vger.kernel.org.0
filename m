Return-Path: <linux-spi+bounces-10396-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE1BB02EB
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A9E2A34CC
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E02DC33F;
	Wed,  1 Oct 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bFNZgG1R"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28802DAFAE;
	Wed,  1 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318457; cv=none; b=KrwrAGqwllCG+pY/O9inD9RRHvjBeC4AxDmcb+Ovx6eyh9s68W+wFoK8KysTx3m9pMAUeVqQEij/r2lCG79dCxKper45xWKxAxsbgQG27EIbGyAIk85Ls8hMNDJbmGwjBHX3RH+8A/i4gr3WVW8qb98+Qgx98aWeSvqrNGvFZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318457; c=relaxed/simple;
	bh=sCNLvEDRPWHptVbnKX/kUysdeluPFhV16BLvGX1OKjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGi7Nvl7Ugve11boQiwaHl9cW4b7Tow6Qi58XN8WVdIDMCGVBjwBBwGqrNfcfYIaOiphhb+HUhV8yMlxkAeYy7SATJXjc10LDxi2ih/Zw6/PS9l/jGyF2s+eh6GOhNerUmwHYjms8ZOv0GNrCUWzpMectHvPMOyAigcvn9J13Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bFNZgG1R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318454;
	bh=sCNLvEDRPWHptVbnKX/kUysdeluPFhV16BLvGX1OKjk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bFNZgG1RuBZO8WwGbhs2CALa8FK5aZwsdy5Qo13LkpDRaat2aopzOOhNRlm2wH80/
	 5S4/0myiLPIYMJywsSMjB8Y0/66sR3Er+B++6R4VXCxUShX/dU6chu+RuxeTt6pDO+
	 l1nnTYBI1SHVuUuWCMVJ9y2aSvzaVTPUj3stLBEWreK7bgFg2ufYnbR4rUn76A16Rd
	 0NsHQLl0+E6JyoEuTHBg2EdodlewbUJQuIlamEVjF3aYp9DvIHsMjGr/1Tv5+xGw97
	 nTM3Qg2iyzrN+7uzsYb8rYx4xfh7ypKfsmQB+Pft2BgA3tax9Qf9ONufZp4dFQZah3
	 FIvRcSPv8hFRA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF52F17E12DA;
	Wed,  1 Oct 2025 13:34:13 +0200 (CEST)
Message-ID: <5f04ce31-3f87-48b5-824b-88a28a5d1e65@collabora.com>
Date: Wed, 1 Oct 2025 13:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 02/13] spi: airoha: remove unnecessary
 restriction length
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-3-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> The "length < 160" restriction is not needed because airoha_snand_write_data()
> and airoha_snand_read_data() will properly handle data transfers above
> SPI_MAX_TRANSFER_SIZE.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



