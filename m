Return-Path: <linux-spi+bounces-11651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233BC92779
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8467C4E0265
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F722578A;
	Fri, 28 Nov 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yt+81PJE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69772602;
	Fri, 28 Nov 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764344424; cv=none; b=FYLhAKZEUWqqDzgWO1Xio8TtV8u6yhacNoSnssst3GXZe3GzXC57m7TmJpGozbuBFG6FJWRFHmErlt2FHZEtAfRYUSvVprXhRROC4qo8z3gZw/KcpGqnG8u1lxLzqlPB9gU4mDLk8kH4igeelSnIT+C3zdiCVP+1eOcco3F8lJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764344424; c=relaxed/simple;
	bh=iZDZGI/+tJdhPom4m/cnwBNYJAB2MOfwJDqOpNE4ky8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxNc6rdiLNscWyUZsYty5uyHgt7wqVr9AMZtGx0RosvmwCPLqINEjQI3gj/dpY5jbcIQEUUhmjpd33L5g0scbeHPkx9Ml48TjP+cxkhBQFddBgRbjPN+3cqdd821jVt1HNeFSQL+DD2hIhgNM6zh/+MjhNRf7a+sNxUjP3WRBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yt+81PJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEA7C4CEF1;
	Fri, 28 Nov 2025 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764344424;
	bh=iZDZGI/+tJdhPom4m/cnwBNYJAB2MOfwJDqOpNE4ky8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yt+81PJEJn4Lr5vm2xvgJurZMFnafda6hbB3NpVefemnziGVaALuqjJuwRAtcmyX6
	 Smkf42t5jbuOnnAj9igGP1l69RPJl1Wiu8kGEJXjTAE3qQZ0FKwmtR7DbHrreaT7vJ
	 bCTVlmDow/BTlF2JMwZAaMjg7xlm71vjVoTwfiYU=
Date: Fri, 28 Nov 2025 16:40:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ch341: fix out-of-bounds memory access in
 ch341_transfer_one
Message-ID: <2025112807-molehill-mousiness-f3a6@gregkh>
References: <20251128160630.0f922c45ec6084a46fb57099@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128160630.0f922c45ec6084a46fb57099@linux.dev>

On Fri, Nov 28, 2025 at 04:06:30PM +0800, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> The 'len' variable is calculated as 'min(32, trans->len + 1)',
> which includes the 1-byte command header.
> 
> When copying data from 'trans->tx_buf' to 'ch341->tx_buf + 1', using 'len'
> as the length is incorrect because:
> 
> 1. It causes an out-of-bounds read from 'trans->tx_buf' (which has size
>    'trans->len', i.e., 'len - 1' in this context).
> 2. It can cause an out-of-bounds write to 'ch341->tx_buf' if 'len' is
>    CH341_PACKET_LENGTH (32). Writing 32 bytes to ch341->tx_buf + 1
>    overflows the buffer.
> 
> Fix this by copying 'len - 1' bytes.
> 
> Fixes: 8846739f52af ("spi: add ch341a usb2spi driver")
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> ---
>  drivers/spi/spi-ch341.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
> index 46bc208f2..79d2f9ab4 100644
> --- a/drivers/spi/spi-ch341.c
> +++ b/drivers/spi/spi-ch341.c
> @@ -78,7 +78,7 @@ static int ch341_transfer_one(struct spi_controller *host,
>  
>  	ch341->tx_buf[0] = CH341A_CMD_SPI_STREAM;
>  
> -	memcpy(ch341->tx_buf + 1, trans->tx_buf, len);
> +	memcpy(ch341->tx_buf + 1, trans->tx_buf, len - 1);
>  
>  	ret = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, len,
>  			   NULL, CH341_DEFAULT_TIMEOUT);
> -- 
> 2.39.5
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

