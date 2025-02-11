Return-Path: <linux-spi+bounces-6763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B4A313E5
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 19:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CE17A3EE1
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 18:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF948254AE8;
	Tue, 11 Feb 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ElHWnKLd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FC24FC1F;
	Tue, 11 Feb 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297890; cv=none; b=mIflqpxiP9qgoY1MrstWdZHvAVmIZ1GtC1c4jbi/H/VmM6nQbjOzIqiuL8WfXG/3/MpgDbS1ekiZTXS4tsafR4JwZlSWiM5Wdi1MOfQFbmsL5GnV5Xkb9a9T4suNJCzIZST3L8hLc5MaZWcOEgGZBDPESzxED+t2p5kbcZLLybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297890; c=relaxed/simple;
	bh=lOxxu6mhwJOy0lQ7ainU0zyB52goG9R+/pw7HK1LI2g=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=i94Te91rk6RlnIyA8ZqRcGzckrFtrddpufo3UaJ4qV4icwpWN1k/Ym81fZF0Ync+cvy7fM9oDTVQnrba+jsn9q6NDl6P3fAC9RNkpCrQh1HfmRZEKJi/X/+yeZ9PIFJTiGj0MiKQcGFyKyPjulq3iVmr92H6QG9BILg+JByTOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ElHWnKLd; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id huoTtJ358CWdAhuoWth0R8; Tue, 11 Feb 2025 19:16:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739297817;
	bh=dNf7ARSync5+2wSr35vosb1jPpHHIw0KLr6GEq+zDrQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=ElHWnKLd15/IJ43QrhjbA3T+ajrzpmMJLWYwcUBlhiOio7ctyI5K2YHpA2zMHYdJG
	 k/Bde1ML3HHwiKiDvbbwhr3X6MqTimrqG/pG5uSy8WpvpcJ2Cysm7WtBD4YP/UvHgH
	 ZAnf3uBZtW0tzEVO+4T+jwk6iuqrpHYqF64I+UyJVyzwHUC+nN6lGWExLF50sNreux
	 f6HsxMG5Ztiddnk8dDTtUmN5cLMrPEa93uPKf57Di+K+Lf1zIyNHv65gDNKrPP1EDY
	 6KsYzlmbSH9Y02V3NFL8Juf4WoXLWOZG0PsTfYgQIZ60FFXF94HPxu+QBkrzpdQJ/E
	 v81242QWjucPA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 11 Feb 2025 19:16:57 +0100
X-ME-IP: 90.11.132.44
Message-ID: <a74c3202-7a64-483d-907e-9a562e9dcd03@wanadoo.fr>
Date: Tue, 11 Feb 2025 19:16:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] memory: Add STM32 Octo Memory Manager driver
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250210131826.220318-5-patrice.chotard@foss.st.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: patrice.chotard@foss.st.com
Cc: alexandre.torgue@foss.st.com, arnd@arndb.de, broonie@kernel.org,
 catalin.marinas@arm.com, christophe.kerello@foss.st.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 p.zabel@pengutronix.de, robh@kernel.org, will@kernel.org
In-Reply-To: <20250210131826.220318-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/02/2025 à 14:18, 
patrice.chotard-rj0Iel/JR4NBDgjK7y7TUQ@public.gmane.org a écrit :
> From: Patrice Chotard <patrice.chotard-rj0Iel/JR4NBDgjK7y7TUQ@public.gmane.org>
> 
> Octo Memory Manager driver (OMM) manages:
>    - the muxing between 2 OSPI busses and 2 output ports.
>      There are 4 possible muxing configurations:
>        - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>          output is on port 2
>        - OSPI1 and OSPI2 are multiplexed over the same output port 1
>        - swapped mode (no multiplexing), OSPI1 output is on port 2,
>          OSPI2 output is on port 1
>        - OSPI1 and OSPI2 are multiplexed over the same output port 2
>    - the split of the memory area shared between the 2 OSPI instances.
>    - chip select selection override.
>    - the time between 2 transactions in multiplexed mode.
>    - check firewall access.

...

> diff --git a/drivers/memory/stm32_omm.c b/drivers/memory/stm32_omm.c
> new file mode 100644
> index 000000000000..af69137bfba2
> --- /dev/null
> +++ b/drivers/memory/stm32_omm.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL

Not sure this SPDX-License-Identifier exists.

> +/*
> + * Copyright (C) STMicroelectronics 2024 - All Rights Reserved

...

> +	pm_runtime_enable(dev);
> +
> +	/* check if OMM's resource access is granted */
> +	ret = stm32_omm_check_access(dev, dev->of_node);
> +	if (ret < 0 && ret != -EACCES)
> +		goto err_clk_release;

Should we call, here and below, pm_runtime_disable() in the error 
handling path, as done in the remove function?

> +
> +	if (!ret && child_access_granted == OMM_CHILD_NB) {
> +		/* Ensure both OSPI instance are disabled before configuring OMM */
> +		ret = stm32_omm_disable_child(dev);
> +		if (ret)
> +			goto err_clk_release;
> +
> +		ret = stm32_omm_configure(dev);
> +		if (ret)
> +			goto err_clk_release;
> +	} else {
> +		dev_dbg(dev, "Octo Memory Manager resource's access not granted\n");
> +		/*
> +		 * AMCR can't be set, so check if current value is coherent
> +		 * with memory-map areas defined in DT
> +		 */
> +		ret = stm32_omm_set_amcr(dev, false);
> +		if (ret)
> +			goto err_clk_release;
> +	}
> +
> +	/* for each child, if resource access is granted and status "okay", probe it */
> +	for (i = 0; i < omm->nb_child; i++) {
> +		if (!child_access[i] || !of_device_is_available(omm->child[i].node))
> +			continue;
> +
> +		vdev = of_platform_device_create(omm->child[i].node, NULL, NULL);
> +		if (!vdev) {
> +			dev_err(dev, "Failed to create Octo Memory Manager child\n");
> +			for (j = i; j > 0; --j) {
> +				if (omm->child[j].dev)
> +					of_platform_device_destroy(omm->child[j].dev, NULL);
> +			}
> +
> +			ret = -EINVAL;
> +			goto err_clk_release;
> +		}
> +		omm->child[i].dev = &vdev->dev;
> +	}
> +
> +err_clk_release:
> +	for (i = 0; i < omm->nb_child; i++)
> +		clk_put(omm->child[i].clk);
> +
> +	return ret;
> +}
> +
> +static void stm32_omm_remove(struct platform_device *pdev)
> +{
> +	struct stm32_omm *omm = platform_get_drvdata(pdev);
> +	int i;
> +
> +	for (i = 0; i < omm->nb_child; i++)
> +		if (omm->child[i].dev)
> +			of_platform_device_destroy(omm->child[i].dev, NULL);
> +
> +	if (omm->cr & CR_MUXEN)
> +		stm32_omm_enable_child_clock(&pdev->dev, false);
> +
> +	pm_runtime_disable(&pdev->dev);

Should we have:
	for (i = 0; i < omm->nb_child; i++)
		clk_put(omm->child[i].clk);
as done in the error handling path of the probe?

> +}
> +
> +static const struct of_device_id stm32_omm_of_match[] = {
> +	{ .compatible = "st,stm32mp25-omm", },
> +	{},

Nitpick: Unneeded , after a terminator.

> +};
> +MODULE_DEVICE_TABLE(of, stm32_omm_of_match);

...

CJ




