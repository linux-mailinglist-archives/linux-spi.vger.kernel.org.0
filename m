Return-Path: <linux-spi+bounces-12461-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E5D38AD7
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13EB530274EA
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0923570810;
	Sat, 17 Jan 2026 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IVr8PxaP"
X-Original-To: linux-spi@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10A2AE77;
	Sat, 17 Jan 2026 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768610488; cv=none; b=DtpaV2Is74Ukp9dxa5oBRbbTPFqWRXNcD4PPJaZpdcDKficCtVwdvHQQPu0cZyyqb3fBYs1qhmHbp72c6IpebauevouyvGtnrBB80Y3lwwEI+KjQlFmsmRWytasv/bJ+phDZuweBRBQBiRMCWSebOXMMBr40PK4HTso5EOVxhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768610488; c=relaxed/simple;
	bh=8iUfIBxfO1eIJxUfuqZ8vYmze3rWa7sXVwTvt0yp4tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOE8+xJdiz9cwqLU93+XvdQyJn7WF+Vm9+giPKafBhIk61lTTK+N1EYPb7m0zHwf/H5uiv4ol0Ob1L5fZaSmtReTMbpChUW0H1A1B2X2o6x0ioz72LhJbscnYV18ru980bHEm1KAdU05JagQAvcE62zouFCpzXaEedvMwhWLsPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IVr8PxaP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6uvymewojZryJCsLththt6b69bwDDih6ton1Gz+XXhM=; b=IVr8PxaPV0S8d/tCWJCIHIvCtL
	z4nImASU68m5coDgg52WNKzv2WpuM4+tjujlJ+4ucL0/fz1sHQHBFQOH4EYHfmBTDuSYk52ATY2MR
	MOFpt7YzNUGs/N2jWCfxHzBo9/6/zMCPkDkv+QnNOsUgPB7gfWn/S4JJbBKjH08zhDbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vguNT-0038Gv-Gk; Sat, 17 Jan 2026 01:41:19 +0100
Date: Sat, 17 Jan 2026 01:41:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dt-bindings: xilinx: make interrupts optional
Message-ID: <0b4904fa-ae9f-44e0-96a8-f5f1ef57f36c@lunn.ch>
References: <20260116233535.260114-1-abdurrahman@nexthop.ai>
 <20260116233535.260114-3-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116233535.260114-3-abdurrahman@nexthop.ai>

On Fri, Jan 16, 2026 at 11:35:35PM +0000, Abdurrahman Hussain wrote:
> This makes the driver work on platforms where interrupts are either not
> provided or broken.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

To get a Reviewed-by: for this patch you will need to Cc:the device
tree Maintainers.

https://docs.kernel.org/devicetree/bindings/submitting-patches.html

This is also version 2 of the patch, so you should of marked this as v2.

https://docs.kernel.org/process/submitting-patches.html

> ---
>  Documentation/devicetree/bindings/spi/spi-xilinx.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> index 4beb3af0416d..8296edde61b0 100644
> --- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> @@ -23,7 +23,7 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    maxItems: 1 # optional

I suspect the DT Maintainer won't link this comment. All properties
are optional unless they are listed in the required: section.

	Andrew

