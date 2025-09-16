Return-Path: <linux-spi+bounces-10044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDAB591A4
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 11:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2923240DF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Sep 2025 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0428C035;
	Tue, 16 Sep 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y5Db+x4r"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806829A310;
	Tue, 16 Sep 2025 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013331; cv=none; b=Qh8dkU36vT5++zRWQPFcFKhoVApvnlUdh1XIl4ynvAX0/0MsbcA8UfKL5pJt36cJXbEev86pQid2YKkEZnHjN3WDWLVmlz055Hc5Lr/ns/rsnkZr+yHKkhmvaJuPpwgKjTsFBFwpA+fz2Xun2lehMye0r0Zj1W/HnQ29QtSefIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013331; c=relaxed/simple;
	bh=v3B0hVI686Dj3OG7cFwf+eQKcuBwiCWRRhpE80lgPZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7VliF5eaeYBgobaev/1/0aXxpCW4m7fWdr46H3RyHEEfeBEbomPX5S/7jwDama1wT6XO1dj7dU3sfmz0tngGbnu56j4vAXAckmnei5Q/oPQX7L29YeS4JJ2MklbHXckAp8EOoY5i1aubWsKv9fqJZXhclBZZWRYtjFG1vLGTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y5Db+x4r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758013327;
	bh=v3B0hVI686Dj3OG7cFwf+eQKcuBwiCWRRhpE80lgPZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y5Db+x4rrd8V2wd6WxmV+e32jR3fQImJLjYmSDX41phsBEC2oPL5Dzzb+oxS7Z8ZY
	 dmyfScInfaaoon3VSpS2VapUMRdR+XCDhHi/lEJ5SYLoTLyRCBprxLwfbIg4rdpr15
	 MCgPmZ4iPJcv2DcC4ZON/skyZp1uZ1FEHm1WBwW8yzTMdeKN49Q2qlhRBdrnjJBEsU
	 OavZs6DeuMKY7WO8cUKMRiFFVOqVY+xsApIf4SwN3QeKwln3EQzXgt04XRwNi1oNCy
	 z1mMVP8tphFmoFT9N7agtsuO/G4OMOrhg8lWZTrN2G06WrGEXtJSXeedXyPTkgjmfn
	 /3sWIwqnNH4pg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7EB7917E0F88;
	Tue, 16 Sep 2025 11:02:07 +0200 (CEST)
Message-ID: <d7a9e83d-7b79-48eb-a90a-dfe3cf26cf49@collabora.com>
Date: Tue, 16 Sep 2025 11:02:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: mt65xx: add dual and quad mode for standard spi
 device
To: Tim Kuo <Tim.Kuo@mediatek.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven Liu <Steven.Liu@mediatek.com>, Sky Huang <Skylake.Huang@mediatek.com>
References: <20250916081515.324130-1-Tim.Kuo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250916081515.324130-1-Tim.Kuo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/09/25 10:15, Tim Kuo ha scritto:
> From: "Tim Kuo" <Tim.Kuo@mediatek.com>
> 
> Mediatek SPI hardware natively supports dual and quad modes, and these
> modes are already enabled for SPI flash devices under spi-mem framework
> in MTK SPI controller spi-mt65xx. However, other SPI devices, such as
> touch panels, are limited to single mode because spi-mt65xx lacks SPI
> mode argument parsing from SPI framework for these SPI devices outside
> spi-mem framework.
> 
> This patch adds dual and quad mode support for these SPI devices by
> introducing a new API, mtk_spi_set_nbits, for SPI mode argument parsing.
> 
> Signed-off-by: Tim Kuo <Tim.Kuo@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 8a3c00c3af42..591740805740 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -563,6 +563,27 @@ static void mtk_spi_setup_packet(struct spi_controller *host)
>   	writel(reg_val, mdata->base + SPI_CFG1_REG);
>   }
>   
> +inline u32 mtk_spi_set_nbit(u32 nbit)
> +{
> +	u32 ret = 0;

You don't need ret here.

> +
> +	switch (nbit) {

	default:
		pr_warn_once("Unknown nbit mode %u. Falling back to single mode\n",
			     nbit);
		fallthrough;
	case SPI_NBITS_SINGLE:
		return 0x0;
	case SPI_NBITS_DUAL:
		return 0x1;
	case SPI_NBITS_QUAD:
		return 0x2;

> +	case SPI_NBITS_SINGLE:
> +		ret = 0x0;
> +		break;
> +	case SPI_NBITS_DUAL:
> +		ret = 0x1;
> +		break;
> +	case SPI_NBITS_QUAD:
> +		ret = 0x2;
> +		break;
> +	default:
> +		pr_info("unknown spi nbit mode, use single mode!");
> +		break;
> +	}
> +	return ret;
> +}
> +
>   static void mtk_spi_enable_transfer(struct spi_controller *host)
>   {
>   	u32 cmd;
> @@ -729,10 +750,16 @@ static int mtk_spi_transfer_one(struct spi_controller *host,
>   
>   	/* prepare xfer direction and duplex mode */
>   	if (mdata->dev_comp->ipm_design) {
> -		if (!xfer->tx_buf || !xfer->rx_buf) {
> +		if (xfer->tx_buf && xfer->rx_buf) {
> +			reg_val &= ~SPI_CFG3_IPM_HALF_DUPLEX_EN;
> +		} else if (xfer->tx_buf) {
> +			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
> +			reg_val &= ~SPI_CFG3_IPM_HALF_DUPLEX_DIR;
> +			reg_val |= mtk_spi_set_nbit(xfer->tx_nbits);
> +		} else {
>   			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_EN;
> -			if (xfer->rx_buf)
> -				reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
> +			reg_val |= SPI_CFG3_IPM_HALF_DUPLEX_DIR;
> +			reg_val |= mtk_spi_set_nbit(xfer->rx_nbits);
>   		}
>   		writel(reg_val, mdata->base + SPI_CFG3_IPM_REG);
>   	}

Everything else LGTM. So, after adding the requested changes

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

