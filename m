Return-Path: <linux-spi+bounces-11386-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F84BC736F1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13C9F4E9E71
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DF92FD68D;
	Thu, 20 Nov 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U9FGjQGU"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0382FDC4F;
	Thu, 20 Nov 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633867; cv=none; b=qO9zXEXZwxSiQNkU+ikx6NoJ89EZUw80fA8tiv/Q46azX4SVN/jhdZVlLL1hDt2zz4DgmOtmzqnsMaPDpIW1/SSw8CEAi96kmzwHeH0o2bCpC5Zde+kfoCQpeV/ug50VNyRveV1hagoeEnO0ZpWmOmXhHTBXhlw0I6K+VSyFb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633867; c=relaxed/simple;
	bh=oj3XXa4I6VaWw2BCv50Gz8e0+tE79Q6lQpDSY4nSM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4OdgQ+oxNMSduSwlQHb5r3jmKJC/keHugo1Xi6QNaauTl1jewMohPuXdbV/NJSHDfLSaJIJR9tIlrxpmUUXs36feKBLKh22yE5RiaMBHAwzePkZSj4cwG+jhKDjP1ThU4Zs85TKSvqnCCn1FGH0pNSikc1LBrU6vOAx/jJOP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U9FGjQGU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763633857;
	bh=oj3XXa4I6VaWw2BCv50Gz8e0+tE79Q6lQpDSY4nSM5Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U9FGjQGUwWioE5NB9i9posewenwjNK4FZ5Mu9/mNuWXlRKzgqes2ELoDnW/EhfUE5
	 RdP8DsB2Yn86UnI1qjLSWfZipqfgORbNt08nbGjPCJg2KhLcTA6B6+vWXDQn58aZ3O
	 fTvRT+yaUX95valvaxU1vbcXPZbyYMfpKbgOdNUSLfdlVOQS0jXgUWREX8VcDFxI3T
	 PJbRwA8MzcZVnzynZairjtvr2YWRWPM05EuDiC/8BZ3BfSrBKh0/GVbz0rj9B5vu9e
	 USNly/whU5958/E/Q8Ushx0gBPGyVoYlkmPvpwPRXTvHR9utL3PH0Vq+GcDAMhG1Li
	 ZHj5TnFFqIMIw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C1D1217E0CA1;
	Thu, 20 Nov 2025 11:17:36 +0100 (CET)
Message-ID: <18d49588-2c1e-4546-a258-7b063ac64b36@collabora.com>
Date: Thu, 20 Nov 2025 11:17:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: spi: airoha: add compatible for
 EN7523
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
 <20251120042753.640492-3-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251120042753.640492-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/11/25 05:27, Mikhail Kshevetskiy ha scritto:
> Add dt-bindings documentation of SPI NAND controller
> for Airoha EN7523 SoC platform.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



