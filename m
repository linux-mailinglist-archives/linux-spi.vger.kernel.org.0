Return-Path: <linux-spi+bounces-2177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ECA8979CD
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 22:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6FB26989
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C824155720;
	Wed,  3 Apr 2024 20:29:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958601552E2
	for <linux-spi@vger.kernel.org>; Wed,  3 Apr 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176177; cv=none; b=M4/vEChAYCNmQilALg5C8D+7NnytPIracNOs4+vKmbd5aQ5WoIb4C/mgDQd1Lz/JkMxQuLqBJaG7hCAd0oVjgHS+eAsPxlFN5RfDQcaDftsEiN2w5FDSh3LV/h6PIJA2nZ+crw/eJFWYygzl8K19u2sf520FZl9j6ES/SZQmQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176177; c=relaxed/simple;
	bh=GlL5j0u6FbLtSPo0HBXbZCK95prm9pkwGcrlO0TXeR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+sTUV/aSl1uY+ATb3TpI6xY40gMhDpo6XPApPuYXzDyEFcthSq9Av/p0kaTAsd0VoFaHMBaQ4jX2OY543FV1f6Gp53gbtXoxdN9RIo6vMzMatNq1XnxASZ+ORSACNh+A6bcrriYrlpUOiOhvmZ/FTtKuW8TdUy/UtjH1IzFx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id ddeccd9e-f1f8-11ee-a9de-005056bdf889;
	Wed, 03 Apr 2024 23:29:27 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 23:29:27 +0300
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v3 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
Message-ID: <Zg28J59MRvk3B-_J@surfacebook.localdomain>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
 <20240329114730.360313-3-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329114730.360313-3-ckeepax@opensource.cirrus.com>

Fri, Mar 29, 2024 at 11:47:29AM +0000, Charles Keepax kirjoitti:
> Add a mechanism to force the use of the fwnode name for the name of the
> SPI device itself. This is useful when devices need to be manually added
> within the kernel.

...

>  static void spi_dev_set_name(struct spi_device *spi)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
> +	struct fwnode_handle *fwnode = dev_fwnode(&spi->dev);
> +
> +	if (spi->use_fwnode_name && fwnode) {
> +		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));
> +		return;
> +	}
>  
>  	if (adev) {
>  		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));

This should be something like this

	struct device *dev = &spi->dev;
	struct fwnode_handle *fwnode = dev_fwnode(dev);

	if (is_acpi_device_node(fwnode)) {
		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
		return;
	}

	if (is_software_node(fwnode)) {
		dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));
		return;
	}

i.o.w. we don't need to have two ways of checking fwnode type and you may get
rid of unneeded variable, and always use fwnode name for swnode.

...

> +	proxy->use_fwnode_name = chip->use_fwnode_name;

Unneeded variable. See above.

-- 
With Best Regards,
Andy Shevchenko



