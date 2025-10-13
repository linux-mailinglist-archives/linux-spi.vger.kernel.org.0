Return-Path: <linux-spi+bounces-10598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F35BD1D18
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F1E3A4F2D
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BED2E88AF;
	Mon, 13 Oct 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HBoiU0Zy"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C514145B3E;
	Mon, 13 Oct 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340883; cv=none; b=MXZoZ3Bk/ygSJ0bIymFchLd3rcx6f12M1M6FoOb+JhHAItlKNKJG+Y7+uDp7PLwlvHuklqQn/J6Vq3m8YLSRWUK/jPpaBpFFjSShFzP5R8dspJ8J3GudM+p66/XeUCXNwSfQaaA33VMBNGHnwdUFVeFusOm1udd3k4LPUDU3Vl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340883; c=relaxed/simple;
	bh=jELERBOJppm25MX9y7DHHg/4rSErHwNgm6Itxp2BQsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOof0fasjjU0P/tdfgUMlBQTy5e31vdGy0+oygRbslHn9xZ1J3P3ugEiNYpUSidfeqDx+r/oB8hNJJjORWaHTEvrQISCTF6DDcAq2YTBVjD0BtNf+tkeMiLyyqFhXHp4nureuW4tl/tTbAGWSosAOqDCWpUVH6FryXszCH1lAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HBoiU0Zy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760340879;
	bh=jELERBOJppm25MX9y7DHHg/4rSErHwNgm6Itxp2BQsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HBoiU0ZybLiP+XO19r6eDNk2iMlwQruWbY1at5TfKuTa0fj6ztBSG2C0+l2CH3woE
	 GW2KIL/hXMcDUAfecrht99owWFT2o7aDnZpYf8SAywaRD7W1Cvn08sdMcXiWOHUJJf
	 raURBuovOs89E/5azvgJbL73/IONu/cKE1CPuwffbZ+hjAvS9RqIX65DZIMBQttWaq
	 b0Qp+Ko6awAJcyWQXuFD6/7Cd8NXQmuPumCNjON8M9d4UUsnZukIGhEZsZbB0L9HeK
	 Ib3Ry1+cQqbQMmEUHe4+ZKM4ZAqIHkVZjR7VPb7K/BepAlnhvU4s5/XwfFB4ptRKuC
	 tOpZhyn6GGEjg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EA7317E1292;
	Mon, 13 Oct 2025 09:34:38 +0200 (CEST)
Message-ID: <11e3c3f0-005e-4ef6-9edd-136c1b956638@collabora.com>
Date: Mon, 13 Oct 2025 09:34:37 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/16] arm: dts: airoha: en7523: add SNAND node
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <20251012121707.2296160-17-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251012121707.2296160-17-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/10/25 14:17, Mikhail Kshevetskiy ha scritto:
> Add SNAND node to enable support of attached SPI-NAND on the EN7523 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   arch/arm/boot/dts/airoha/en7523.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/airoha/en7523.dtsi b/arch/arm/boot/dts/airoha/en7523.dtsi
> index b523a868c4ad..31191b8d1430 100644
> --- a/arch/arm/boot/dts/airoha/en7523.dtsi
> +++ b/arch/arm/boot/dts/airoha/en7523.dtsi
> @@ -203,4 +203,24 @@ pcie_intc1: interrupt-controller {
>   			#interrupt-cells = <1>;
>   		};
>   	};
> +
> +	spi_ctrl: spi@1fa10000 {
> +		compatible = "airoha,en7523-snand", "airoha,en7581-snand";
> +		reg = <0x1fa10000 0x140>,
> +		      <0x1fa11000 0x160>;

reg fits in one line, but in any case:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +
> +		clocks = <&scu EN7523_CLK_SPI>;
> +		clock-names = "spi";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nand: nand@0 {
> +			compatible = "spi-nand";
> +			reg = <0>;
> +			spi-max-frequency = <50000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <2>;
> +		};
> +	};
>   };



