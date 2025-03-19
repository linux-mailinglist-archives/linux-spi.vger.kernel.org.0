Return-Path: <linux-spi+bounces-7214-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B679A685D8
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC577422591
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0D20B7FA;
	Wed, 19 Mar 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWy0RlwD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D518DB0A;
	Wed, 19 Mar 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369842; cv=none; b=W/mC7aq0ar+a0jJhxqud5X7oDPTiUre2w4fKA9+LyB/h2GogXJlkMir9xSYpCJ/CNTj6PP3XUdu2rO7hwhzEF7wXWXeWdXs3+ovEkNf6ZZcVJ3M4/dR7gobjRqmkjbfJxOmyNtnVyRbG+OLvGCV92CoHpaVcWP72AC8KksSh4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369842; c=relaxed/simple;
	bh=HdltGd7siJH9RYxJ15cpnOShcpA2EJrNfVj9wn5/93k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itASZVgk96iNdFBpTvb71vXXzeYwK6Qj982JG6Ur82Y8CcgZl9ZwAH6dqLkZWw8U/UXVC07RRFjdkIJCEB+l/eeYmLUIFNsDmRfdz6j1GOtJb3x5fADd+iPMJXlSa9ghhPbOxhQiTfPZyEaxp65QeBrCRA0oPhGknPeZAhd6FhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWy0RlwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D842C4CEE9;
	Wed, 19 Mar 2025 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742369841;
	bh=HdltGd7siJH9RYxJ15cpnOShcpA2EJrNfVj9wn5/93k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DWy0RlwDvAstD9rVaFYGL04wEdoIMnLva0KwnxsBswCTR94RO7JLJqB3KN+X71iky
	 rb1wrSKhXprGdznlb3ir2JyJXrsTR8xwSBb8W2PvBo58R7SBm+2h3W8AR+UEkzHVc6
	 L09CNkQymCVs+hWaCmGQSHLnZv9IYC4bqv0bbBpidBSYZgLUKjmuUJcsw3wpLPcCXr
	 ThJ+o/OuM+bsZsEsdBneuHSa6A/BTOALjb6e5Bv/MDNG1d4b9B0l9tJq468fMCf7fX
	 Pu+qtAu7YT7BLdyeB9r/7G31xSCn+JQU3b6RwrbxnlvwL1rfJuTJVyUMGey5xdrVDE
	 Uz4FCuJnxeEiQ==
Message-ID: <f508b96e-81c8-41bd-baca-ebd1b4419904@kernel.org>
Date: Wed, 19 Mar 2025 08:37:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] memory: Add STM32 Octo Memory Manager driver
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
 <eaf1ecca-4fde-4128-8590-6013c3a13a04@kernel.org>
 <8b1b7df5-07f4-4f95-88e7-4e95ee909ffd@foss.st.com>
 <ac119dba-6e73-496c-97e1-d59ac0fe4a27@kernel.org>
 <06244bfb-1bd0-4a07-a928-3d2e68a89259@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <06244bfb-1bd0-4a07-a928-3d2e68a89259@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2025 14:40, Patrice CHOTARD wrote:
> 
> 
> On 3/13/25 08:33, Krzysztof Kozlowski wrote:
>> On 12/03/2025 15:23, Patrice CHOTARD wrote:
>>>>> +static int stm32_omm_disable_child(struct device *dev)
>>>>> +{
>>>>> +	struct stm32_omm *omm = dev_get_drvdata(dev);
>>>>> +	struct reset_control *reset;
>>>>> +	int ret;
>>>>> +	u8 i;
>>>>> +
>>>>> +	for (i = 0; i < omm->nb_child; i++) {
>>>>> +		ret = clk_prepare_enable(omm->child[i].clk);
>>>>> +		if (ret) {
>>>>> +			dev_err(dev, "Can not enable clock\n");
>>>>> +			return ret;
>>>>> +		}
>>>>> +
>>>>> +		reset = of_reset_control_get_exclusive(omm->child[i].node, 0);
>>>>> +		if (IS_ERR(reset)) {
>>>>> +			dev_err(dev, "Can't get child reset\n");
>>>>
>>>> Why do you get reset of child? Parent is not suppposed to poke there.
>>>> You might not have the reset there in the first place and it would not
>>>> be an error.
>>>
>>> By ressetting child (OSPI), we ensure they are disabled and in a known state.
>>> See the comment below.
>>>
>>>>
>>>>
>>>>> +			return PTR_ERR(reset);
>>>>> +		};
>>>>> +
>>>>> +		/* reset OSPI to ensure CR_EN bit is set to 0 */
>>>>> +		reset_control_assert(reset);
>>>>> +		udelay(2);
>>>>> +		reset_control_deassert(reset);
>>>>
>>>> No, the child should handle this, not parent.
>>>
>>> Octo Memory Manager can only be configured if both child are disabled.
>>> That's why here, parent handles this.
>>
>> So if device by any chance started and is doing some useful work, then
>> you cancel that work and reset it?
> 
> stm32_omm_configure() is only called if we get access granted on both children.
> That means we are authorized to use these devices, so we can reset them.
> 
>>
>> And what if child does not have reset line? Your binding allows that, so
>> how is it supposed to work then?
> 
> Ah yes, you are right, the OSPI bindings need to be updated
> by requiring reset lines and the driver spi-stm32-ospi.c as well.
> I will send a fix for that.
> 
> Thanks for pointing this.
> 
>>
>> This also leads me to questions about bindings - if you need to assert
>> some reset, doesn't it mean that these resets are also coming through
>> this device so they are part of this device node?
> 
> As we are able to retrieve children's reset from their respective node,
> if you don't mind, OMM bindings can be kept as it's currently.

But that is what the entire discussion is about - I do mind. I said it
already - you are not supposed to poke into child's node.

If you need to toggle child's resources, then I claim these are your
resources as well.

> 
> And another information, on some MP2 SoCs family, there is only one 
> OSPI instance. So for these SoCs, there is no Octo Memory Manager.
> 
>>
>>>
>>>>
>>>>> +
>>>>> +		reset_control_put(reset);
>>>>> +		clk_disable_unprepare(omm->child[i].clk);
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int stm32_omm_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct platform_device *vdev;
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct stm32_omm *omm;
>>>>> +	struct clk *clk;
>>>>> +	int ret;
>>>>> +	u8 child_access_granted = 0;
>>>>
>>>> Keep inits/assignments together
>>>
>>> ok
>>>
>>>>
>>>>> +	u8 i, j;
>>>>> +	bool child_access[OMM_CHILD_NB];
>>>>> +
>>>>> +	omm = devm_kzalloc(dev, sizeof(*omm), GFP_KERNEL);
>>>>> +	if (!omm)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	omm->io_base = devm_platform_ioremap_resource_byname(pdev, "regs");
>>>>> +	if (IS_ERR(omm->io_base))
>>>>> +		return PTR_ERR(omm->io_base);
>>>>> +
>>>>> +	omm->mm_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "memory_map");
>>>>> +	if (IS_ERR(omm->mm_res))
>>>>> +		return PTR_ERR(omm->mm_res);
>>>>> +
>>>>> +	/* check child's access */
>>>>> +	for_each_child_of_node_scoped(dev->of_node, child) {
>>>>> +		if (omm->nb_child >= OMM_CHILD_NB) {
>>>>> +			dev_err(dev, "Bad DT, found too much children\n");
>>>>> +			ret = -E2BIG;
>>>>> +			goto err_clk_release;
>>>>> +		}
>>>>> +
>>>>> +		if (!of_device_is_compatible(child, "st,stm32mp25-ospi")) {
>>>>> +			ret = -EINVAL;
>>>>> +			goto err_clk_release;
>>>>> +		}
>>>>> +
>>>>> +		ret = stm32_omm_check_access(dev, child);
>>>>> +		if (ret < 0 && ret != -EACCES)
>>>>> +			goto err_clk_release;
>>>>> +
>>>>> +		child_access[omm->nb_child] = false;
>>>>> +		if (!ret) {
>>>>> +			child_access_granted++;
>>>>> +			child_access[omm->nb_child] = true;
>>>>> +		}
>>>>> +
>>>>> +		omm->child[omm->nb_child].node = child;
>>>>> +
>>>>> +		clk = of_clk_get(child, 0);
>>>>
>>>> Why are you taking children clock? And why with this API, not clk_get?
>>>
>>> I need children's clock to reset them.
>>
>>
>> The device driver should reset its device. It is not a discoverable bus,
>> that would explain power sequencing from the parent.
>>
>>> Why of_clk_get() usage is a problem here ? i can't get your point ?
>>
>> Because it is not the API which device drivers should use. You should
>> use clk_get or devm_clk_get.
> 
> 
> ok, i will update this part using clk_get().
> 
>>
>>
>>>
>>>> This looks like mixing clock provider in the clock consumer.
>>>>
>>>>> +		if (IS_ERR(clk)) {
>>>>> +			dev_err(dev, "Can't get child clock\n");
>>>>
>>>> Syntax is always return dev_err_probe (or ret = dev_err_probe).
>>>
>>> ok
>>>
>>>>
>>>>> +			ret = PTR_ERR(clk);
>>>>> +			goto err_clk_release;
>>>>> +		};
>>>>> +
>>>>> +		omm->child[omm->nb_child].clk = clk;
>>>>> +		omm->nb_child++;
>>>>> +	}
>>>>> +
>>>>> +	if (omm->nb_child != OMM_CHILD_NB) {
>>>>> +		ret = -EINVAL;
>>>>> +		goto err_clk_release;
>>>>> +	}
>>>>> +
>>>>> +	platform_set_drvdata(pdev, omm);
>>>>> +
>>>>> +	pm_runtime_enable(dev);
>>>>> +
>>>>> +	/* check if OMM's resource access is granted */
>>>>> +	ret = stm32_omm_check_access(dev, dev->of_node);
>>>>> +	if (ret < 0 && ret != -EACCES)
>>>>> +		goto err_clk_release;
>>>>> +
>>>>> +	if (!ret && child_access_granted == OMM_CHILD_NB) {
>>>>> +		/* Ensure both OSPI instance are disabled before configuring OMM */
>>>>> +		ret = stm32_omm_disable_child(dev);
>>>>> +		if (ret)
>>>>> +			goto err_clk_release;
>>>>> +
>>>>> +		ret = stm32_omm_configure(dev);
>>>>> +		if (ret)
>>>>> +			goto err_clk_release;
>>>>> +	} else {
>>>>> +		dev_dbg(dev, "Octo Memory Manager resource's access not granted\n");
>>>>> +		/*
>>>>> +		 * AMCR can't be set, so check if current value is coherent
>>>>> +		 * with memory-map areas defined in DT
>>>>> +		 */
>>>>> +		ret = stm32_omm_set_amcr(dev, false);
>>>>> +		if (ret)
>>>>> +			goto err_clk_release;
>>>>> +	}
>>>>> +
>>>>> +	/* for each child, if resource access is granted and status "okay", probe it */
>>>>> +	for (i = 0; i < omm->nb_child; i++) {
>>>>> +		if (!child_access[i] || !of_device_is_available(omm->child[i].node))
>>>>
>>>> If you have a device available, why do you create one more platform device?
>>>>
>>>>> +			continue;
>>>>> +
>>>>> +		vdev = of_platform_device_create(omm->child[i].node, NULL, NULL);
>>>>
>>>> Why you cannot just populate the children?
>>>
>>> I can't use of_platform_populate(), by default it will populate all OMM's child.
>>> Whereas here, we want to probe only the OMM's child which match our criteria.  
>>
>>
>> Why wouldn't you populate everyone? The task of bus driver is not to
>> filter out DT. If you got such DT - with all device nodes - you are
>> expected to populate all of them. Otherwise, if you do not want all of
>> them, it is expected that firmware or bootloader will give you DT
>> without these nodes.
> 
> We don't want to populate every child by default because we can get 
> cases where one child is shared between Cortex A and Cortex M.

But in such case DTB would not have that child enabled.

> That's why we must check if access is granted which ensure that 
> firewall semaphore is available (RIFSC semaphore in our case).

If you do not have access, means child is assigned to other processor,
right? In that case that child would not have been enabled in your DTB.

Fix your DTB instead of creating another layer of handling children
inside drivers.


Best regards,
Krzysztof

