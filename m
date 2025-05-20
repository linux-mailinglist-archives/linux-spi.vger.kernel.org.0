Return-Path: <linux-spi+bounces-8215-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1BABD589
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A862C7A373E
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993A26B2D8;
	Tue, 20 May 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UxoPjZoU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E1269CFD
	for <linux-spi@vger.kernel.org>; Tue, 20 May 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747738281; cv=none; b=R6BDa1sN4Yjga1nt1kR+neHzwYg92TCttuuZ5riu+6ta4uT7P5x+mMb7HTcCgO2ljwaPUGcDFkdQSz1ig/pyeFkKeS4hfALVScterK31q2cA7ZAujTs1g/u5/zJrrmeZ8O9Y7zpsvfqmZLpH4iR3imonCLtRVVLMjoO+/DLbMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747738281; c=relaxed/simple;
	bh=1IVxMRT7hTE5gir+ohubrLWQS9DrJZsBgibqpQP6RLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0rSVN7YST2+83uivIVz1anxds747aFe1nf5D9LIiIN3N1KumK6toujtT7sffRDnC4Xt8p1mmK+bAg3lKRUDKq/dWzp8/SF2Imn4Elckb0QbslfX+smT1up5TfcXZDEkaSF7+X5k9tFOqhQBM8sqeDlmsKFKTDuI7uDuSALru4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UxoPjZoU; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1747738273;
 bh=IjZMD2eULGDwifJ6Eg5o2azP2kaC3eB2jYmU3yHnbXU=;
 b=UxoPjZoUJrc45g5sIvR0ZUH26COyeTPktfRjT7bkP0nsiiK+GAah3KYfa+ObaHEYCRArJmNKe
 C301BfOUXchYK4BaYifBE97R4VHMXr8jQJ7QO6/SxmXhxOixCspcylmUpVoYb5X8tU2J+S+RTNj
 sNWkgXayr+AsqjAAbHYhsIaScmsECJz6TKLoXFRE+hiFzWAGe41dmJGpDRPapp63Mv9h7txNkPr
 PXeleTsn/+1FXyivTPb5jYHVqkV4s5/JroK4HvJnB8+SEa/qsqWL/0W1/HoGHQAXIytvBo/CIur
 QIsv0hwXlXJrM/lYxuu5nRsztixkpBI6vpEPXN78j8OA==
X-Forward-Email-ID: 682c5e9c356c24cb84e6ffc4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <28b03818-0290-412a-8d1e-9b88a163d387@kwiboo.se>
Date: Tue, 20 May 2025 12:51:03 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add spi nodes for RK3528
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>, Rob Herring <robh@kernel.org>,
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <20250520100102.1226725-1-amadeus@jmu.edu.cn>
 <20250520100102.1226725-3-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250520100102.1226725-3-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-05-20 12:01, Chukun Pan wrote:
> There are 2 SPI controllers on the RK3528 SoC, describe it.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index b2724c969a76..4d60c09219f9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -371,6 +371,34 @@ ioc_grf: syscon@ff540000 {
>  			reg = <0x0 0xff540000 0x0 0x40000>;
>  		};
>  
> +		spi0: spi@ff9c0000 {
> +			compatible = "rockchip,rk3528-spi",
> +				     "rockchip,rk3066-spi";
> +			reg = <0x0 0xff9c0000 0x0 0x1000>;
> +			clocks = <&cru CLK_SPI0>, <&cru PCLK_SPI0>;
> +			clock-names = "spiclk", "apb_pclk";
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dmac 25>, <&dmac 24>;
> +			dma-names = "tx", "rx";

This is missing power-domains after "rockchip: Add power controller
support for RK3528" [1], spi0 depend on pclk_rkvenc_root:

	power-domains = <&power RK3528_PD_RKVENC>;

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@ff9d0000 {
> +			compatible = "rockchip,rk3528-spi",
> +				     "rockchip,rk3066-spi";
> +			reg = <0x0 0xff9d0000 0x0 0x1000>;
> +			clocks = <&cru CLK_SPI1>, <&cru PCLK_SPI1>;
> +			clock-names = "spiclk", "apb_pclk";
> +			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dmac 31>, <&dmac 30>;
> +			dma-names = "tx", "rx";

Same here, spi1 depend on pclk_vpu_root:

	power-domains = <&power RK3528_PD_VPU>;

[1] https://lore.kernel.org/r/20250518220707.669515-1-jonas@kwiboo.se

Regards,
Jonas

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@ff9f0000 {
>  			compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
>  			reg = <0x0 0xff9f0000 0x0 0x100>;


