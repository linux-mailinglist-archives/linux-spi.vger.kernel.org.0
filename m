Return-Path: <linux-spi+bounces-2260-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395689E21E
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 20:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA241F2314F
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7A85276;
	Tue,  9 Apr 2024 18:07:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C34156883;
	Tue,  9 Apr 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686021; cv=none; b=fIPNjFpMvWCxb1o4piDiMbLsT+9DwnFBf2kwCqosLLcgeQQ1WPrTPDXxq3NRt9+MljitvobMEXUzf04IbWWEfWSH5gcGqoDddGPvPXEENlNZ8/Ho2ors6a9rM5hKuX0F+aNnDxHxphihk0slCC4wTRglkp7aXjerEU7UWUXQKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686021; c=relaxed/simple;
	bh=iDxuXGuTVPTXOSqFXbw72DQRiluHb0grPLKkOdSUrq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqW4tfpp06r7AxzL8OYIbj1iYKUJsJ4VYLN6MOHk5Sbq5ZWCnEdpo1IzT+SJMF4ZlSuyTT4qWd/OzU7lhoLwc9Dpo6IKGi7684e+NmnW6XzeQLgYVheuNV5bVlex6Pyp3hz+xIqWNfwzRQu1kTX2squxhhC/c5APejPlHRFlizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: jT4wBIdkQTOEUEn50cuCdA==
X-CSE-MsgGUID: WYY9/vYTRBePQ7KlReGqAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11859203"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11859203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093714"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937093714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 11:06:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DE852E9; Tue,  9 Apr 2024 21:06:56 +0300 (EEST)
Date: Tue, 9 Apr 2024 21:06:56 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v4 2/3] spi: Add a mechanism to use the fwnode name for
 the SPI device
Message-ID: <ZhWDwIZe8b0lqe8o@black.fi.intel.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
 <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>

On Tue, Apr 09, 2024 at 02:21:25PM +0100, Charles Keepax wrote:
> Add a mechanism to force the use of the fwnode name for the name of the
> SPI device itself. This is useful when devices need to be manually added
> within the kernel.

Same comment, we don't need two ways to handle fwnode type
(and effectivelly code duplication to some extent).

...

>  	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);

>  	if (adev) {

Replace this to be is_acpi_device_node() check...

>  		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));

...and derive adev from fwnode.

>  		return;
>  	}

> +	if (is_software_node(fwnode)) {
> +		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));

While at this, you can also introduce

	struct device *dev = &spi->dev;

to make these dev_set_name() be shorter.

> +		return;
> +	}

-- 
With Best Regards,
Andy Shevchenko



