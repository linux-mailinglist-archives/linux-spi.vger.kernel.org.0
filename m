Return-Path: <linux-spi+bounces-4953-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A6984D43
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 00:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906321F24B09
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B413146A87;
	Tue, 24 Sep 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzx1FiqG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34EF80043;
	Tue, 24 Sep 2024 22:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215366; cv=none; b=cYwLgtdOrpuMsyPh5fZWyTASx2vzAf+MAacQ5aEHFP6h8K6uE39CSX3g28SNe1JcxzMUdm9UyzPRjsG7ImCHXmoP2fYtllJyclluERE+S5UObGYS+988USd+Fk11Qb+pfHR0Jhkxm+t52mJkLjw9g1u19BYREDjCvMnHIQvdKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215366; c=relaxed/simple;
	bh=OKPMiMo13DauZ+HyEOe8PQ959Vzxx6SWDp+ZboefMdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STH2m7aSsN2SK4WVMBLUIB1TRQOTvAqbbLOqo5UOC4SpfFVNE5+pkma8CEuH34uLFgWlDaWAIBwHT3CS2nl3yBInzyaxQBzgbdtKOyuos6doTb3IsPU6C6IJTA/U+HqQEF5FoSS5A9xe6ooRsqNmw2xlL89jXuUfbhE0AkaPhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzx1FiqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41970C4CEC4;
	Tue, 24 Sep 2024 22:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727215366;
	bh=OKPMiMo13DauZ+HyEOe8PQ959Vzxx6SWDp+ZboefMdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wzx1FiqGp8Xys47L5CuJRp7ARn8JZqWwtzFUVG/ioCHOUCVJVwx4bJV9dDvv6cZTP
	 BPtbs2XNuTqCDLMgoxR0/zHfLYDJrD1JsApTSgyLpW5/P4c1uhTbUA/VewMmIti6GT
	 TBuAmWCkmuMjt2Q8N4rEySqKdbPFBmPDK8F9nZVSFB/8sQj67ZGrvTufLHlfB+/wZv
	 sRWvhlyCGr5XmUFXVBG7hIQFMMJ2kll1vzhWUTAZWmzbXLF02xDiAz752Yml3tjdf7
	 gIIcmiFGCrBugKAsxKUgL6ABbbjeX5nURqEooWFd2D6v36UG5UGe1FyaZC+FIt5hc0
	 MEI9i3UY1zeYg==
Date: Tue, 24 Sep 2024 17:02:45 -0500
From: Rob Herring <robh@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	michal.simek@amd.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH] dt-bindings: spi: zynqmp-qspi: Include two 'reg'
 properties only for the Zynq UltraScale QSPI
Message-ID: <20240924220245.GA367088-robh@kernel.org>
References: <20240923044543.2222-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923044543.2222-1-amit.kumar-mahapatra@amd.com>

On Mon, Sep 23, 2024 at 10:15:43AM +0530, Amit Kumar Mahapatra wrote:
> Linear mode is only supported by the Zynq UltraScale QSPI controller,
> so update the bindings to include two 'reg' properties only for the
> Zynq UltraScale QSPI controller.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> BRANCH: for-next
> ---
>  .../bindings/spi/spi-zynqmp-qspi.yaml          | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> index e5199b109dad..2f1fca137cd3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
> @@ -12,15 +12,27 @@ maintainers:
>  allOf:
>    - $ref: spi-controller.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: xlnx,zynqmp-qspi-1.0
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2

Change this to 'minItems: 2'.

> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>  properties:
>    compatible:
>      enum:
>        - xlnx,versal-qspi-1.0
>        - xlnx,zynqmp-qspi-1.0
>  
> -  reg:
> -    maxItems: 2

Keep this and add 'minItems: 1'

> -
>    interrupts:
>      maxItems: 1
>  
> -- 
> 2.34.1
> 

