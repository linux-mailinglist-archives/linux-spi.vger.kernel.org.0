Return-Path: <linux-spi+bounces-193-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F380B9D7
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 09:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CF7280E95
	for <lists+linux-spi@lfdr.de>; Sun, 10 Dec 2023 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09091FB6;
	Sun, 10 Dec 2023 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="id7Mif+E"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC17468;
	Sun, 10 Dec 2023 08:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76281C433C8;
	Sun, 10 Dec 2023 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702196224;
	bh=4MP+IiZQyTgAhgvxwWK9fTe8S5nqlJbp9EPDPLsqyds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=id7Mif+ETkUg+AUNse9Dqu2A10VFzTNzArnoZoaxMSbOC7h5t/k6lDLydmqAfAD/N
	 QbdjWGuMcJA8s79ckAw9B4IiXJxM/ZRjmW9c48qSVsXhHej/WIQwipXW0LdN0kXuec
	 JBlSCZ+wTC1D98CwYK56EPHTtYzmUK6izmRh2Kx0=
Date: Sun, 10 Dec 2023 09:17:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Bigler <benjamin@bigler.one>
Cc: broonie@kernel.org, linux@bigler.io, francesco@dolcini.it,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	regressions@lists.linux.dev, stefan.moring@technolution.nl,
	regressions@leemhuis.info
Subject: Re: [PATCH] spi: spi-imx: correctly configure burst length when
 using dma
Message-ID: <2023121047-unnamable-magma-2b6d@gregkh>
References: <20231209222338.5564-1-benjamin@bigler.one>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209222338.5564-1-benjamin@bigler.one>

On Sat, Dec 09, 2023 at 11:23:26PM +0100, Benjamin Bigler wrote:
> If DMA is used, burst length should be set to the bus width of the DMA.
> Otherwise, the SPI hardware will transmit/receive one word per DMA
> request.
> Since this issue affects both transmission and reception, it cannot be
> detected with a loopback test.
> Replace magic numbers 512 and 0xfff with MX51_ECSPI_CTRL_MAX_BURST.
> 
> Signed-off-by: Benjamin Bigler <benjamin@bigler.one>
> Reported-by Stefan Bigler <linux@bigler.io>
> Fixes: 15a6af94a277 ("spi: Increase imx51 ecspi burst length based on transfer length")
> Link: https://lore.kernel.org/r/8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com
> ---
>  drivers/spi/spi-imx.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
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

