Return-Path: <linux-spi+bounces-12234-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC273D06A05
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781CC302EA0B
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DC15A85A;
	Fri,  9 Jan 2026 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xci21nbD"
X-Original-To: linux-spi@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26051F95C;
	Fri,  9 Jan 2026 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919288; cv=none; b=e12E7CzpqeaEuwMn1UloVvnP8gV2GfRxaooEzu4+Evgz6GwIIpjb2uF+kDCdC3E9qypDadrZms6kpC3ihmFNC3E3RDDKIzjrW1SKiHsG4N37B4ETVBYdFGD70Q4JJDR8VShoMHqzIqHtxVmBXU0qM9v25OZMl2PzDRT52R4Ug78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919288; c=relaxed/simple;
	bh=H1hpbCcT/IqWuk0YYanX/Zxdh4/gcbyo4BdLla8c7n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caeJ9aBplZoNm8yuGqiU+Hia4Rj+EuSHiuU+eBi3wQB87iQmG8XGVORk7H5Spy1lpIcc9YgO9W0a/8fjxM8f78DL/yasWO5r5JugIMYAbKPm3WTIFyVUfXaKYVbqwoGqF27xsXLowXtSNNtG1vUis1oPPzQU8Y9EkvG9j4DQt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xci21nbD; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767919281; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PlgFMmf+5c6qMQsxM9V0QDi3ZxJKdSAbxzOExlTjF2I=;
	b=xci21nbDRLaoyTWw/3xBlQA1BG5tiv21gs1SzFfxSpyUn41b0659r3G/TbMNnb85fVJA8B9XT2wGZGL97HuQTWFsn353y74cbwNPe61VMQoLzRqWFqvmHYvzBTvXrdHLWgIwGm2M60A8dWr93wkzGF00pUD9pRgkPcQI0WfU4oQ=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wwe5C3k_1767919281 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 08:41:21 +0800
Message-ID: <076ffcce-86d4-4047-9edb-cbc24f64e62b@linux.alibaba.com>
Date: Fri, 9 Jan 2026 08:41:19 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-sprd-adi: Fix double free in probe error path
To: Felix Gu <gu_0233@qq.com>, Mark Brown <broonie@kernel.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_4588081F26734D4306AEE239F31016318205@qq.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <tencent_4588081F26734D4306AEE239F31016318205@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/9/26 12:12 AM, Felix Gu wrote:
> The driver currently uses spi_alloc_host() to allocate the controller
> but registers it using devm_spi_register_controller().
> 
> If devm_register_restart_handler() fails, the code jumps to the
> put_ctlr label and calls spi_controller_put(). However, since the
> controller was registered via a devm function, the device core will
> automatically call spi_controller_put() again when the probe fails.
> This results in a double-free of the spi_controller structure.
> 
> Fix this by switching to devm_spi_alloc_host() and removing the
> manual spi_controller_put() call.
> 
> Signed-off-by: Felix Gu <gu_0233@qq.com>
> ---

Thanks. Can you add a 'Fixes:' tag? With that, you can add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   drivers/spi/spi-sprd-adi.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
> index 262c11d977ea..f25b34a91756 100644
> --- a/drivers/spi/spi-sprd-adi.c
> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -528,7 +528,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   	pdev->id = of_alias_get_id(np, "spi");
>   	num_chipselect = of_get_child_count(np);
>   
> -	ctlr = spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
> +	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(struct sprd_adi));
>   	if (!ctlr)
>   		return -ENOMEM;
>   
> @@ -536,10 +536,8 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   	sadi = spi_controller_get_devdata(ctlr);
>   
>   	sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> -	if (IS_ERR(sadi->base)) {
> -		ret = PTR_ERR(sadi->base);
> -		goto put_ctlr;
> -	}
> +	if (IS_ERR(sadi->base))
> +		return PTR_ERR(sadi->base);
>   
>   	sadi->slave_vbase = (unsigned long)sadi->base +
>   			    data->slave_offset;
> @@ -551,18 +549,15 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
>   		sadi->hwlock =
>   			devm_hwspin_lock_request_specific(&pdev->dev, ret);
> -		if (!sadi->hwlock) {
> -			ret = -ENXIO;
> -			goto put_ctlr;
> -		}
> +		if (!sadi->hwlock)
> +			return -ENXIO;
>   	} else {
>   		switch (ret) {
>   		case -ENOENT:
>   			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
>   			break;
>   		default:
> -			dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
> -			goto put_ctlr;
> +			return dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
>   		}
>   	}
>   
> @@ -579,26 +574,18 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   	ctlr->transfer_one = sprd_adi_transfer_one;
>   
>   	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register SPI controller\n");
> -		goto put_ctlr;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to register SPI controller\n");
>   
>   	if (sadi->data->restart) {
>   		ret = devm_register_restart_handler(&pdev->dev,
>   						    sadi->data->restart,
>   						    sadi);
> -		if (ret) {
> -			dev_err(&pdev->dev, "can not register restart handler\n");
> -			goto put_ctlr;
> -		}
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret, "can not register restart handler\n");
>   	}
>   
>   	return 0;
> -
> -put_ctlr:
> -	spi_controller_put(ctlr);
> -	return ret;
>   }
>   
>   static struct sprd_adi_data sc9860_data = {
> 
> ---
> base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> change-id: 20260108-spi-sprd-adi-fix-c071bf124bf6
> 
> Best regards,


