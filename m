Return-Path: <linux-spi+bounces-6984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AAA4C06E
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 13:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEA3188E9E2
	for <lists+linux-spi@lfdr.de>; Mon,  3 Mar 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40178F4F;
	Mon,  3 Mar 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ED/TNXm+"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D945661;
	Mon,  3 Mar 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005275; cv=none; b=Tq5H/dDNCsxECgthghXxplY3txRKQHqfDCgv2NU6xqWKSswFUw8QujzaNTmQW7ktAVxgJ8RJ9cNYt5DjGYYqK/r18h7pRblamDYhC5aQneJSDmCXClpQBQH/FjvURsmwjY3FhQPDQ/VGw/Q0zZCXvXmkzd8KyAy6sIaw4GRKEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005275; c=relaxed/simple;
	bh=JHN5XUVVnQv9cvYemNLq5jso/MbQRX5go/vqQODxWS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7fmjXVrq0WNu7rJq40Y1uDu3KT1WrAL0S+aS6VNhVjvJCFBXBM0PUMydBt954d/CwpvnyM64sblaJ9KbKYBvqnN+eiKiZEPmNjDm6Cf8uG9dn4AOdQjvsx8NoCMRUS/dCEY6iLrk5oMJYDMPCR5STmP72y5Vjh44H1U+zLVBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ED/TNXm+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741005270;
	bh=JHN5XUVVnQv9cvYemNLq5jso/MbQRX5go/vqQODxWS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ED/TNXm+3mmkw04O9PxoovNVGMKrA5Fe9qigZQWTOY+bD7MGMhkPtlbh0/YWyyzNQ
	 LypOt+jOFhvs37SITmauEnXctcDbJymnsiI6BeagOjVN4a3pPOWezQf1zgfTY3mxtD
	 y2aBDM1c6fr3+n6XQlD4nWyJFT89Pw1DcpqvxKB/28yrXjyDfmO6kVRgh6SQQjWh3c
	 Pdj7SIsufBMNaes6Z2v1NdIUz+/UJ3T2Eh8NRHcYyQOFIFOvnY0L6KnEl7wxIPEUST
	 ROIXu9NdBJNlXqKUMTnyjj5dF2KUAsloaCUvepT1sL6IlddaQVVdPFbp1cw/dqP7sk
	 eZ/Qf0JmTsvCA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81DC417E0607;
	Mon,  3 Mar 2025 13:34:29 +0100 (CET)
Message-ID: <12c5ba3e-a151-44a8-ace7-3d944a09ae5e@collabora.com>
Date: Mon, 3 Mar 2025 13:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] spi: spi-mtk-nor: Modify the clock architecture of nor
 controller
To: mtk22730 <Cloud.Zhang@mediatek.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250303114540.1617-1-Cloud.Zhang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250303114540.1617-1-Cloud.Zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/03/25 12:45, mtk22730 ha scritto:
> The clocks used by different platforms are not same. So it is
> necessary to modify the clock architecture to be adaptable to more
> platforms.
> 
> Signed-off-by: Cloud Zhang <cloud.zhang@mediatek.com>

You really shall fix your identity on outgoing emails: your name appears as
"mtk22730", that's not right.

Also, the title could be clarified a bit...

spi: spi-mtk-nor: Migrate to clk_bulk API

...and then: this should be a series, and the first commit shall be adjusting
the dt-binding for this driver accordigly, otherwise whatever you're doing here
will turn out to be unusable.

> ---
> Changes in v2:
>    -Use clk_bulk_xxx related functions to enable/disable clocks.
> 
> Changes in v1:
>    -Add new function mtk_nor_parse_clk() to parse nor clock parameters.
> ---
> ---
>   drivers/spi/spi-mtk-nor.c | 103 ++++++++++++++++++++------------------
>   1 file changed, 54 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 85ab5ce96c4d..4863b9cb2706 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -99,6 +99,8 @@
>   
>   #define CLK_TO_US(sp, clkcnt)		DIV_ROUND_UP(clkcnt, sp->spi_freq / 1000000)
>   
> +#define MAX_CLOCK_CNT		6
> +
>   struct mtk_nor_caps {
>   	u8 dma_bits;
>   
> @@ -116,10 +118,8 @@ struct mtk_nor {
>   	void __iomem *base;
>   	u8 *buffer;
>   	dma_addr_t buffer_dma;
> -	struct clk *spi_clk;
> -	struct clk *ctlr_clk;
> -	struct clk *axi_clk;
> -	struct clk *axi_s_clk;
> +	struct clk_bulk_data clocks[MAX_CLOCK_CNT];

What about having this as a pointer?

	struct clk_bulk_data *clks;

...Then you count the clocks, and devm allocate the number of clks that you need.

> +	int clock_cnt;

u8 clock_cnt;

>   	unsigned int spi_freq;
>   	bool wbuf_en;
>   	bool has_irq;
> @@ -703,44 +703,68 @@ static int mtk_nor_transfer_one_message(struct spi_controller *host,
>   
>   static void mtk_nor_disable_clk(struct mtk_nor *sp)

A function with one call means that you don't need a function at all.

>   {
> -	clk_disable_unprepare(sp->spi_clk);
> -	clk_disable_unprepare(sp->ctlr_clk);
> -	clk_disable_unprepare(sp->axi_clk);
> -	clk_disable_unprepare(sp->axi_s_clk);
> +	clk_bulk_disable_unprepare(sp->clock_cnt, sp->clocks);
>   }
>   
>   static int mtk_nor_enable_clk(struct mtk_nor *sp)
>   {

You can also remove this function and transfer the contents into mtk_nor_probe():
it's just something like 6 lines and even called only once, so... :-)

>   	int ret;
> +	int i;
>   
> -	ret = clk_prepare_enable(sp->spi_clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(sp->ctlr_clk);
> +	ret = clk_bulk_prepare_enable(sp->clock_cnt, sp->clocks);
>   	if (ret) {
> -		clk_disable_unprepare(sp->spi_clk);
> +		dev_err(sp->dev, "enable clk failed\n");
>   		return ret;
>   	}
>   
> -	ret = clk_prepare_enable(sp->axi_clk);
> -	if (ret) {
> -		clk_disable_unprepare(sp->spi_clk);
> -		clk_disable_unprepare(sp->ctlr_clk);
> -		return ret;
> -	}
> +	for (i = 0; i < sp->clock_cnt; i++) {
> +		if (IS_ERR(sp->clocks[i].clk)) {
> +			dev_err(sp->dev, "get %s fail\n", sp->clocks[i].id);
> +			return PTR_ERR(sp->clocks[i].clk);
> +		}
>   
> -	ret = clk_prepare_enable(sp->axi_s_clk);
> -	if (ret) {
> -		clk_disable_unprepare(sp->spi_clk);
> -		clk_disable_unprepare(sp->ctlr_clk);
> -		clk_disable_unprepare(sp->axi_clk);
> -		return ret;
> +		if (!strcmp(sp->clocks[i].id, "spi"))
> +			sp->spi_freq = clk_get_rate(sp->clocks[i].clk);
>   	}
>   
>   	return 0;
>   }
>   
> +static int mtk_nor_parse_clk(struct device *dev, struct mtk_nor *sp)
> +{
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +	const char *name;
> +	int cnt, i;

	struct device_node *np = dev->of_node;
	const char *name;
	int cnt, i, ret;


> +
> +	cnt = of_property_count_strings(np, "clock-names");
> +	if (!cnt || (cnt == -EINVAL)) {
> +		dev_err(dev, "Unable to find clocks\n");

return -EINVAL;

> +		ret = -EINVAL;
> +		goto out;
> +	} else if (cnt < 0) {
> +		dev_err(dev, "Count clock strings failed, err %d\n", cnt);

return cnt;

> +		ret = cnt;
> +		goto out;
> +	}
> +
> +	sp->clock_cnt = cnt;
> +	for (i = 0; i < cnt; i++) {
> +		ret = of_property_read_string_index(np, "clock-names", i, &name);
> +		if (ret) {
> +			dev_err(dev, "failed to get clock string\n");
> +			return ret;
> +		}
> +
> +		sp->clocks[i].id = name;
> +	}
> +
> +	ret = devm_clk_bulk_get(dev, sp->clock_cnt, sp->clocks);

	if (ret)
		return ret;

	return 0;

> +
> +out:
> +	return ret;
> +}
> +

Cheers,
Angelo


