Return-Path: <linux-spi+bounces-7090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78834A5CA3B
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A917A11F2
	for <lists+linux-spi@lfdr.de>; Tue, 11 Mar 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93A25DD06;
	Tue, 11 Mar 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIOy2yi/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DD10E5;
	Tue, 11 Mar 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709090; cv=none; b=hZ74TTryO0jR3inc+1o/9Pr4MLJmMU+YlAs67gpfZTtpNb131OEwVloaWdqJFCEiKGw6sfDRQmUwurP03Ywii5ULiHnkxQ2XItrLVh9rZySWC2B/zrVVGFcicQEbLq7gjQ/fcJgeIFa7IAnrn66BsUWvYmoqmo65gAgAeXy1ekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709090; c=relaxed/simple;
	bh=ol541gNVPkNybWxr4NC+BgFFiX7TZtmw9LNu/oPSP6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Boxk1vpwZDH/UNubnnKPRI9zVQQ/0NZ5UCAVlYYpThNUF8l6H/F/7JsyUR7V0MGr7jzdEnrY18CPx3gzNNTNYc9CwNGk25Kpp9iLeqcyAeK13iBGIBesQcNApCy3hB7jj9WLdtXzBxePrQ26UOZRpfgvdYCT2uU07n7B3rNC+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIOy2yi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6216EC4CEE9;
	Tue, 11 Mar 2025 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709089;
	bh=ol541gNVPkNybWxr4NC+BgFFiX7TZtmw9LNu/oPSP6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lIOy2yi/Gq8i+wdHBjBeBuiUwcRgl/AwBHbG96sQtzO/0phZoAfrjeSQIMv4LrRXr
	 DW7LfyiF9CgF+jhzGx0jwBS+PNsPqJD1GvvRW0iuQM4NW4+XSafchSS8l01fCGle5d
	 cdXRqta51y2Q+Mfze13VBtQBMEpiyls87/0VShwyLKZ4xNfQFdvra8MojkHLKKH35X
	 oQztRib6rDj24vZtYqrnoBtBhQDTkdZWAuPe887eDO9WHqj1oxKcTSzJhD3s/i75+6
	 L9A75ldpanNff2fngz89nxlCkmdguexnvz+AxwVNkHnUFo5/oaFevgUDvFvabLsQJ3
	 iu/LeoNDLfaqA==
Message-ID: <eaf1ecca-4fde-4128-8590-6013c3a13a04@kernel.org>
Date: Tue, 11 Mar 2025 17:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] memory: Add STM32 Octo Memory Manager driver
To: patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 christophe.kerello@foss.st.com
References: <20250219080059.367045-1-patrice.chotard@foss.st.com>
 <20250219080059.367045-5-patrice.chotard@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250219080059.367045-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2025 09:00, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Octo Memory Manager driver (OMM) manages:
>   - the muxing between 2 OSPI busses and 2 output ports.
>     There are 4 possible muxing configurations:
>       - direct mode (no multiplexing): OSPI1 output is on port 1 and OSPI2
>         output is on port 2
>       - OSPI1 and OSPI2 are multiplexed over the same output port 1
>       - swapped mode (no multiplexing), OSPI1 output is on port 2,
>         OSPI2 output is on port 1
>       - OSPI1 and OSPI2 are multiplexed over the same output port 2
>   - the split of the memory area shared between the 2 OSPI instances.
>   - chip select selection override.
>   - the time between 2 transactions in multiplexed mode.
>   - check firewall access.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Incorrect chain. You sent it, so you must be the last person signing it.

I was waiting for any ST review... did not happen, so if you wonder how
to speed things up, you got a hint. Anyway, many questions futher.


> +
> +		if (i == 1) {
> +			mm_ospi2_size = resource_size(&res);
> +
> +			/* check that OMM memory region 1 doesn't overlap memory region 2 */
> +			if (resource_overlaps(&res, &res1)) {
> +				dev_err(dev, "OMM memory-region %s overlaps memory region %s\n",
> +					mm_name[0], mm_name[1]);
> +				dev_err(dev, "%pR overlaps %pR\n", &res1, &res);
> +
> +				return -EFAULT;
> +			}
> +		}
> +	}
> +
> +	syscfg_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "st,syscfg-amcr");
> +	if (IS_ERR(syscfg_regmap)) {
> +		dev_err(dev, "Failed to get st,syscfg-amcr property\n");
> +		return PTR_ERR(syscfg_regmap);

Same comments as usual, see further.

> +	}
> +
> +	ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 1,
> +					 &amcr_base);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_property_read_u32_index(dev->of_node, "st,syscfg-amcr", 2,
> +					 &amcr_mask);
> +	if (ret)
> +		return ret;
> +
> +	amcr = mm_ospi2_size / SZ_64M;
> +
> +	if (set)
> +		regmap_update_bits(syscfg_regmap, amcr_base, amcr_mask, amcr);
> +
> +	/* read AMCR and check coherency with memory-map areas defined in DT */
> +	regmap_read(syscfg_regmap, amcr_base, &read_amcr);
> +	read_amcr = read_amcr >> (ffs(amcr_mask) - 1);
> +
> +	if (amcr != read_amcr) {
> +		dev_err(dev, "AMCR value not coherent with DT memory-map areas\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int stm32_omm_enable_child_clock(struct device *dev, bool enable)
> +{
> +	/* As there is only 2 children, remember first child in case of error */
> +	struct clk *first_child_clk = NULL;
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +	u8 i;
> +	int ret;
> +
> +	for (i = 0; i < omm->nb_child; i++) {
> +		if (enable) {
> +			ret = clk_prepare_enable(omm->child[i].clk);
> +			if (ret) {
> +				if (first_child_clk)
> +					clk_disable_unprepare(first_child_clk);

Function is called stm32_omm_enable_child_clock() but you disable.
Confusing. Probably should be called toggle.

> +
> +				dev_err(dev, "Can not enable clock\n");
> +				return ret;
> +			}
> +		} else {
> +			clk_disable_unprepare(omm->child[i].clk);
> +		}
> +
> +		first_child_clk = omm->child[i].clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_omm_configure(struct device *dev)
> +{
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +	struct reset_control *rstc;
> +	unsigned long clk_rate, clk_rate_max = 0;
> +	int ret;
> +	u8 i;
> +	u32 mux = 0;

That's one big mess. Do not mix initialized declarations with
non-initialized in the same line. Then group initialized ones together
and use some reverse christmas tree.

Then the rest also should be organized.

> +	u32 cssel_ovr = 0;
> +	u32 req2ack = 0;
> +
> +	omm->clk = devm_clk_get(dev, NULL);

So here devm_clk_get, but later of_clk_get...

> +	if (IS_ERR(omm->clk)) {
> +		dev_err(dev, "Failed to get OMM clock (%ld)\n",
> +			PTR_ERR(omm->clk));
> +

No. There is no such code anywhere. Please don't upstream downstream,
but take upstream as template.

It is *always* return dev_err_probe. You are flooding dmesg in deferral
for no reason.

> +		return PTR_ERR(omm->clk);
> +	}
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* parse children's clock */
> +	for (i = 0; i < omm->nb_child; i++) {
> +		clk_rate = clk_get_rate(omm->child[i].clk);
> +		if (!clk_rate) {
> +			dev_err(dev, "Invalid clock rate\n");
> +			pm_runtime_disable(dev);
> +			goto err_clk_disable;
> +		}
> +
> +		if (clk_rate > clk_rate_max)
> +			clk_rate_max = clk_rate;
> +	}
> +
> +	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rstc)) {
> +		ret = dev_err_probe(dev, PTR_ERR(rstc), "reset get failed\n");
> +		pm_runtime_disable(dev);

Why? It was not enabled in this function. I cannot follow the logic,
feels like random set of calls. Each of your function is supposed to
reverse ONLY what it done so far.

> +		goto err_clk_disable;
> +	}
> +
> +	reset_control_assert(rstc);
> +	udelay(2);
> +	reset_control_deassert(rstc);
> +
> +	omm->cr = readl_relaxed(omm->io_base + OMM_CR);
> +	/* optional */
> +	ret = of_property_read_u32(dev->of_node, "st,omm-mux", &mux);
> +	if (!ret) {
> +		if (mux & CR_MUXEN) {
> +			ret = of_property_read_u32(dev->of_node, "st,omm-req2ack-ns",
> +						   &req2ack);
> +			if (!ret && !req2ack) {
> +				req2ack = DIV_ROUND_UP(req2ack, NSEC_PER_SEC / clk_rate_max) - 1;
> +
> +				if (req2ack > 256)
> +					req2ack = 256;
> +			}
> +
> +			req2ack = FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
> +
> +			omm->cr &= ~CR_REQ2ACK_MASK;
> +			omm->cr |= FIELD_PREP(CR_REQ2ACK_MASK, req2ack);
> +
> +			/*
> +			 * If the mux is enabled, the 2 OSPI clocks have to be
> +			 * always enabled
> +			 */
> +			ret = stm32_omm_enable_child_clock(dev, true);
> +			if (ret) {
> +				pm_runtime_disable(dev);
> +				goto err_clk_disable;
> +			}
> +		}
> +
> +		omm->cr &= ~CR_MUXENMODE_MASK;
> +		omm->cr |= FIELD_PREP(CR_MUXENMODE_MASK, mux);
> +	}
> +
> +	/* optional */
> +	ret = of_property_read_u32(dev->of_node, "st,omm-cssel-ovr", &cssel_ovr);
> +	if (!ret) {
> +		omm->cr &= ~CR_CSSEL_OVR_MASK;
> +		omm->cr |= FIELD_PREP(CR_CSSEL_OVR_MASK, cssel_ovr);
> +		omm->cr |= CR_CSSEL_OVR_EN;
> +	}
> +
> +	omm->restore_omm = true;
> +	writel_relaxed(omm->cr, omm->io_base + OMM_CR);
> +
> +	ret = stm32_omm_set_amcr(dev, true);
> +
> +err_clk_disable:
> +	pm_runtime_put_sync_suspend(dev);
> +
> +	return ret;
> +}
> +
> +static int stm32_omm_check_access(struct device *dev, struct device_node *np)
> +{
> +	struct stm32_firewall firewall;
> +	int ret;
> +
> +	ret = stm32_firewall_get_firewall(np, &firewall, 1);
> +	if (ret)
> +		return ret;
> +
> +	return stm32_firewall_grant_access(&firewall);
> +}
> +
> +static int stm32_omm_disable_child(struct device *dev)
> +{
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +	struct reset_control *reset;
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < omm->nb_child; i++) {
> +		ret = clk_prepare_enable(omm->child[i].clk);
> +		if (ret) {
> +			dev_err(dev, "Can not enable clock\n");
> +			return ret;
> +		}
> +
> +		reset = of_reset_control_get_exclusive(omm->child[i].node, 0);
> +		if (IS_ERR(reset)) {
> +			dev_err(dev, "Can't get child reset\n");

Why do you get reset of child? Parent is not suppposed to poke there.
You might not have the reset there in the first place and it would not
be an error.


> +			return PTR_ERR(reset);
> +		};
> +
> +		/* reset OSPI to ensure CR_EN bit is set to 0 */
> +		reset_control_assert(reset);
> +		udelay(2);
> +		reset_control_deassert(reset);

No, the child should handle this, not parent.

> +
> +		reset_control_put(reset);
> +		clk_disable_unprepare(omm->child[i].clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_omm_probe(struct platform_device *pdev)
> +{
> +	struct platform_device *vdev;
> +	struct device *dev = &pdev->dev;
> +	struct stm32_omm *omm;
> +	struct clk *clk;
> +	int ret;
> +	u8 child_access_granted = 0;

Keep inits/assignments together

> +	u8 i, j;
> +	bool child_access[OMM_CHILD_NB];
> +
> +	omm = devm_kzalloc(dev, sizeof(*omm), GFP_KERNEL);
> +	if (!omm)
> +		return -ENOMEM;
> +
> +	omm->io_base = devm_platform_ioremap_resource_byname(pdev, "regs");
> +	if (IS_ERR(omm->io_base))
> +		return PTR_ERR(omm->io_base);
> +
> +	omm->mm_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory_map");
> +	if (IS_ERR(omm->mm_res))
> +		return PTR_ERR(omm->mm_res);
> +
> +	/* check child's access */
> +	for_each_child_of_node_scoped(dev->of_node, child) {
> +		if (omm->nb_child >= OMM_CHILD_NB) {
> +			dev_err(dev, "Bad DT, found too much children\n");
> +			ret = -E2BIG;
> +			goto err_clk_release;
> +		}
> +
> +		if (!of_device_is_compatible(child, "st,stm32mp25-ospi")) {
> +			ret = -EINVAL;
> +			goto err_clk_release;
> +		}
> +
> +		ret = stm32_omm_check_access(dev, child);
> +		if (ret < 0 && ret != -EACCES)
> +			goto err_clk_release;
> +
> +		child_access[omm->nb_child] = false;
> +		if (!ret) {
> +			child_access_granted++;
> +			child_access[omm->nb_child] = true;
> +		}
> +
> +		omm->child[omm->nb_child].node = child;
> +
> +		clk = of_clk_get(child, 0);

Why are you taking children clock? And why with this API, not clk_get?
This looks like mixing clock provider in the clock consumer.

> +		if (IS_ERR(clk)) {
> +			dev_err(dev, "Can't get child clock\n");

Syntax is always return dev_err_probe (or ret = dev_err_probe).

> +			ret = PTR_ERR(clk);
> +			goto err_clk_release;
> +		};
> +
> +		omm->child[omm->nb_child].clk = clk;
> +		omm->nb_child++;
> +	}
> +
> +	if (omm->nb_child != OMM_CHILD_NB) {
> +		ret = -EINVAL;
> +		goto err_clk_release;
> +	}
> +
> +	platform_set_drvdata(pdev, omm);
> +
> +	pm_runtime_enable(dev);
> +
> +	/* check if OMM's resource access is granted */
> +	ret = stm32_omm_check_access(dev, dev->of_node);
> +	if (ret < 0 && ret != -EACCES)
> +		goto err_clk_release;
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

If you have a device available, why do you create one more platform device?

> +			continue;
> +
> +		vdev = of_platform_device_create(omm->child[i].node, NULL, NULL);

Why you cannot just populate the children?

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
> +}
> +
> +static const struct of_device_id stm32_omm_of_match[] = {
> +	{ .compatible = "st,stm32mp25-omm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, stm32_omm_of_match);
> +
> +static int __maybe_unused stm32_omm_runtime_suspend(struct device *dev)
> +{
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(omm->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stm32_omm_runtime_resume(struct device *dev)
> +{
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +
> +	return clk_prepare_enable(omm->clk);
> +}
> +
> +static int __maybe_unused stm32_omm_suspend(struct device *dev)
> +{
> +	struct stm32_omm *omm = dev_get_drvdata(dev);
> +
> +	if (omm->restore_omm && omm->cr & CR_MUXEN)
> +		stm32_omm_enable_child_clock(dev, false);

Why do you enable child clock for suspend?

> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +


Best regards,
Krzysztof

