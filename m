Return-Path: <linux-spi+bounces-7225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331F2A68B69
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 12:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7872B1B62CAA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533F2561C5;
	Wed, 19 Mar 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNj0Ty/n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE0322F19;
	Wed, 19 Mar 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383157; cv=none; b=rQ7W7txZTmpNYyEIQ4QUEAEYxtEOF3kp0EkUymw299iK0EjK5j+AXUFpSB55cyMd7Ir1EJAnNt0IdyGl6Ka87m4cWaLyLLyJSZ3+DunUp8ODE10x9nTXNY4r9GSeF1nGJ8cFtZkGmvqZsLomuzHIdU662k/icMPp+f2wbZ1Gx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383157; c=relaxed/simple;
	bh=6R3YUsQSGMZyEiglJxOVhBZ2TR5pPzevbToMDv8MVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvtLK6rrUv0P6DCTNrBq7K9kgvwsm++QhIcL2gPBe1pd1Rqj6qbpFLV8wHya1zs4XRzew2QXFkVVba4rwF+L30vwkBHLB6OuIXbcKp3AVZU4qh4/OEeB9tXNmF+aYLNedhEjQImflwPoGeb4MdFkwaM2dpii4F7BKC3q7Qsm+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNj0Ty/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF98BC4CEE9;
	Wed, 19 Mar 2025 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742383154;
	bh=6R3YUsQSGMZyEiglJxOVhBZ2TR5pPzevbToMDv8MVEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNj0Ty/n3IGUBDZ3XHF+5VzOT4MKnlNGtDdDl1ewG9MFrQ8g+Pe+6leXQr6xy5jHk
	 JhHplJDhK/ZkBexFxvDn8PGFc2I3oaEpIPthemTHQH02wlBWvZ6nfiy2tEwRrHau/7
	 yZ6UNwVlHJP9NbKy4sWfMUJK2MaW3fo+mlRrpaKY=
Date: Wed, 19 Mar 2025 04:17:55 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Fix reference count leak in slave_show()
Message-ID: <2025031942-mountable-popular-03c1@gregkh>
References: <20250319032305.70340-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319032305.70340-1-linmq006@gmail.com>

On Wed, Mar 19, 2025 at 11:23:04AM +0800, Miaoqian Lin wrote:
> Fix a reference count leak in slave_show() by properly putting the device
> reference obtained from device_find_any_child().
> 
> Fixes: 6c364062bfed ("spi: core: Add support for registering SPI slave controllers")
> Fixes: c21b0837983d ("spi: Use device_find_any_child() instead of custom approach")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/spi/spi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index a7a4647717d4..ff07c87dbadc 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2954,9 +2954,13 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
>  	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
>  						   dev);
>  	struct device *child;
> +	int ret;
>  
>  	child = device_find_any_child(&ctlr->dev);
> -	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> +	ret = sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
> +	put_device(child);
> +
> +	return ret;
>  }
>  
>  static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
> -- 
> 2.39.5 (Apple Git-154)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

