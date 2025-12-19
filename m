Return-Path: <linux-spi+bounces-12043-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EEFCD1C0D
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 21:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC4A3053FD1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028733ADAC;
	Fri, 19 Dec 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1SGTvLF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0731C58E;
	Fri, 19 Dec 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176086; cv=none; b=kmhJtw8q8ye10VIm2ndnlLXFtPjaA0S79ftg74+ZLegWsVT/5k34nP7/eIS0sSmlTUb80b5TlvfCusyLXHHTXbKU8WtWSElPJgDOvqea+Itsc2cap/LT3hxWGmBsd8vKh6sXQuoQv9ebQRiUR4VyA/1aPSFzpKSpz62PsMslU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176086; c=relaxed/simple;
	bh=Byj8bUjf4UKJNHcqR/2slsG0RH9VXhkNMLILVj/YTbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnfUEhTCs8gP4NYCSUSp3TZN+jWEBFqy4YC3x6Cuucl+VknzPcpu1GlsecsHkoDOmN6MBWz9fyBMv8AlcW8AUMr4krkhNTTgZYFJ9A0SwRxBEdZf7hOmCsJe5DJVBYN1dtS6e30QB7aKBtRRVBxRZUfGUho7xm7fk13xru5+eBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1SGTvLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F6C4CEF1;
	Fri, 19 Dec 2025 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766176085;
	bh=Byj8bUjf4UKJNHcqR/2slsG0RH9VXhkNMLILVj/YTbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1SGTvLF9n2t7mr/7tN2l5SsnEFoZfVtJL7S0hhfTtUPUqtdt5EC47+EY9EQm3ntE
	 GBOfdR4mz8lz5h0pM79YFAE2CuRdehvtDRpd3NVUhWQogwm4fvv42DzZthKumHZleC
	 c6sx7QYJzJOJNNI8eNnnK8m0qAi/D7cgGPrOLnLn+x3s1QJNCaUcpQmFSEKTlPLxLd
	 lky1yMDh0zQl3Oa4Q0WztaNgW2E8h1IR6LEYcXAeId8sd1bKmuDqIGOanKJl69ktDB
	 vB/VjrQxHTOHWnhUEYMitiLfwtL00tqjtLybYqulc324y2Grcr4lQIxyZ1lhOV4brj
	 d0BNx/FKpgVVw==
Date: Fri, 19 Dec 2025 14:28:03 -0600
From: Rob Herring <robh@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: cezary.rojewski@intel.com, broonie@kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-spi@vger.kernel.org,
	perex@perex.cz, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	flove@realtek.com, shumingf@realtek.com, jack.yu@realtek.com,
	derek.fang@realtek.com
Subject: Re: [PATCH v10 1/3] spi: export of_find_spi_controller_by_node()
Message-ID: <20251219202803.GA3877108-robh@kernel.org>
References: <20251216071853.3929135-1-oder_chiou@realtek.com>
 <20251216071853.3929135-2-oder_chiou@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216071853.3929135-2-oder_chiou@realtek.com>

On Tue, Dec 16, 2025 at 03:18:51PM +0800, Oder Chiou wrote:
> Some devices are primarily described on another bus (e.g. I2C) but also
> have an additional SPI connection that serves as a transport for
> firmware loading. Export of_find_spi_controller_by_node() so drivers can
> obtain the SPI controller referenced by a DT phandle.
> 
> Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> ---
>  drivers/spi/spi.c       |  3 ++-
>  include/linux/spi/spi.h | 11 +++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index e25df9990f82..ecb5281b04a2 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4771,7 +4771,7 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
>  }
>  
>  /* The spi controllers are not using spi_bus, so we find it with another way */
> -static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
> +struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
>  {
>  	struct device *dev;
>  
> @@ -4784,6 +4784,7 @@ static struct spi_controller *of_find_spi_controller_by_node(struct device_node
>  	/* Reference got in class_find_device */
>  	return container_of(dev, struct spi_controller, dev);
>  }
> +EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
>  
>  static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>  			 void *arg)
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index cb2c2df31089..1eb04a96cc1c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -882,6 +882,17 @@ extern int devm_spi_register_controller(struct device *dev,
>  					struct spi_controller *ctlr);
>  extern void spi_unregister_controller(struct spi_controller *ctlr);
>  
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)

This has nothing to do with CONFIG_OF_DYNAMIC. CONFIG_OF is what you 
want, and there's probably a section for that already.

> +extern struct spi_controller *of_find_spi_controller_by_node(
> +	struct device_node *node);
> +#else
> +static inline struct spi_controller *of_find_spi_controller_by_node(
> +	struct device_node *node)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_SPI_MASTER)
>  extern struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev);
>  extern struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
> -- 
> 2.52.0
> 

