Return-Path: <linux-spi+bounces-12080-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E7CD866A
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 08:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E8FC3014A3F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3A2FDC2C;
	Tue, 23 Dec 2025 07:39:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A7241690;
	Tue, 23 Dec 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475573; cv=none; b=PpqfSCQ9gRCz4Ca3qSC+CGuN3RKijT9ILLMKE+BsFVmgraWEkAfrBOnTkAuK9JBDYF8BEogf8FOHf148BMc/GbTPUVdt5Xq8iDeiLraA+8KMNHz1lKEhblMvigxakAX8RnlJ1Sj41Vh0oxYZpRUxdbDEk6RUnuJYrRnpobVffdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475573; c=relaxed/simple;
	bh=pfoqXMgUJnpcsP9gtPcdsMYzkDtZpzb3ZP/d7/KUILw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtqaCTB/+tdsBofwt7ITmUoNtoBcCns7ZHON/3K1kQTRyCfu6jKNHFIyTIDw2es2iomlaQlpaJBCVRE9EmeEfO/SL2mhOIw1+H6jQe6qA46s7mSMlcV8QoEndLx8OWMGT4J6Mk+0tszdzKiZuYpL6K6Ptyfi9EMu8hXH/QT4rhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1766475553t425t50352
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5829142609458046819
To: "'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>
Cc: <andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<brgl@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<dakr@kernel.org>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Tue, 23 Dec 2025 15:39:12 +0800
Message-ID: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: Adxz28xSqTk+JEooSaWYdRA317rR+Q==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZ9X7MyfBLbl3d5DzSyp3e0xrleDPfMxJsHN1cZ/HJutTQvJ/SDwN2S1
	K+42Ta8k/eaXQVsXxZoPJqPLGrzQ/XIX9vSX2m3ENMEC8iKydw0okxSjxcLxs2pK2gdz8Jn
	ypt7ciatnMUrrAMUGDVfItcZDIIrDECVXsgWH4pRwe6uB4y4E8KSKf4W9ywO3oIUp7QzSDM
	nVZE+V2Yf7KZ2VpTaDhrdYBt5TrsAFL0cVWfcVZpTOGl6bKd9T7QBFm4qY19D4H6l8FdOD3
	A/s3AITz0PCLHtjtWRkCkKy6LOHCL07GgW0QZw+gxjj+t8NNxM9acCmzm5y8VLsTNsJYM9N
	oXeCLIjJJYJfjNtaZVVOpZwwOR5gh6eleS2AN7Y2Ivlfrvndy5rRbMp8zMo2Y6oowWcv/0H
	1v7Y4OJa5QGVc2shT+d4FsXls/tDo9eohaampwLAZbttDBw+Y8nHD9tg/Ve/h3pIJJEkgcK
	rm30j0RnCtMIUUZCproWQq2AZwO+/Rflmgubuiwo1ZkfDSPdNUjyS73fmeLlfk0gysTqS3c
	mxen+sN6EarJFbv3gZvegSFgYaY9Xeon4jQhvFkPCGsbhLdrF2FNp95v2HZFJkUhCWl3CgU
	QkSrmtS0W+y4GXHFqyN8ZaxQ7rVXdGRnA06VOgMoUphwCZFupD1t1A+Msp9TpVcmZ7/ivDS
	1M8R01Yszr384MzQcc32WuKWbtClAGPJY6x1qIZTSEaC76lsmqbJeohMYubLeFOSaDSxkMP
	QdFlNCaqAqcpTDLOSHa/fBfKIKc94+yCGH14jyPxhw38g8OmIFa/6bCC080QlX6hRg6WIry
	Snk3axQWwG0u7rp7NBDLJhNJW+kBCezPDwTFX/MNN3zZLYxHHZN/uSy3wD68Zp/IaTZzYon
	9zQfU7h4wu1WNKRywvDIvg2zFGXLBBnXGV/JgXlU54iyv6t52Jzbp4lsHRDtdQEiYaRCtE2
	3o5N1FZlIq3kZGj2o3rvkE/er94KrJ4pKdEhXqhCUcDwDtiItBkizif2AZasJaKVepqw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Hi Bartosz Golaszewski,

> diff --git a/include/linux/property.h b/include/linux/property.h
> index 50b26589dd70d1..272bfbdea7bf4a 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -355,19 +355,26 @@ struct software_node;
>  
>  /**
>   * struct software_node_ref_args - Reference property with additional arguments
> - * @node: Reference to a software node
> + * @swnode: Reference to a software node
> + * @fwnode: Alternative reference to a firmware node handle
>   * @nargs: Number of elements in @args array
>   * @args: Integer arguments
>   */
>  struct software_node_ref_args {
> -	const struct software_node *node;
> +	const struct software_node *swnode;
> +	struct fwnode_handle *fwnode;
>  	unsigned int nargs;
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };
>  
>  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
>  (const struct software_node_ref_args) {				\
> -	.node = _ref_,						\
> +	.swnode = _Generic(_ref_,				\
> +			   const struct software_node *: _ref_,	\
> +			   default: NULL),			\
> +	.fwnode = _Generic(_ref_,				\
> +			   struct fwnode_handle *: _ref_,	\
> +			   default: NULL),			\
>  	.nargs = COUNT_ARGS(__VA_ARGS__),			\
>  	.args = { __VA_ARGS__ },				\
>  }

This change seems incompatible with my driver txgbe, since the software nodes
are registered in " struct software_node * " but not " const struct software_node * ".

So when I pulled the net-next-6.19-rc1 that merged this patch, to probe my driver.
The error logs shows:
 
[    5.243396] txgbe 0000:10:00.0 (unnamed net_device) (uninitialized): unable to attach SFP bus: -EINVAL
[    5.243399] txgbe 0000:10:00.0: failed to init phylink
[    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed with error -22
[    6.109548] txgbe 0000:10:00.1 (unnamed net_device) (uninitialized): unable to attach SFP bus: -EINVAL
[    6.109551] txgbe 0000:10:00.1: failed to init phylink
[    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed with error -22
 


