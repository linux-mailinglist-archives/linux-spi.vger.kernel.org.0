Return-Path: <linux-spi+bounces-5763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109379D363C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B35EB237F0
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39318732C;
	Wed, 20 Nov 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYmZIND2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63166171092;
	Wed, 20 Nov 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093306; cv=none; b=FOdHHqv4Hhk+O0NWxxNkrefcuJY+yHyldsqNXO+fRXri1jHMJynLHDPi3eO8Bbj5Lwb59H5KTTuHWU3HdS8pbLz4GYgqpYMOaGLBsZDSzNzuLxVTpkCMETE0Vjoeddzf4d7/6fBPuXngWQQqx2fCQCY/ItWkj/5j/3l+gXdI4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093306; c=relaxed/simple;
	bh=vQmb3ozX2WozvazAM/jZQXfMfq96gf5MaCAgcdpd67I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOX6iJOpYsrqgnHiuKxREVbdfFj3ZU5T4FAz3HVMrvmGfSZWyPbWMHoW99QNwwtnd2MyIa3bqvH+hmbf7u0qVaWvwDOn/1Qc2ArXsHLhpDEW373DWUdRBH8lSarckEp+l5jJKlWGWV9/3oIMcCmXGVtEMvE36eCi1SrfBVjbl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYmZIND2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2056EC4CECD;
	Wed, 20 Nov 2024 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093306;
	bh=vQmb3ozX2WozvazAM/jZQXfMfq96gf5MaCAgcdpd67I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYmZIND2yOy1iFWp44uBlwJOLVf2cM+qLsT5Knw64J0vnTm1tdn4jUbjLVg5PpuEH
	 Z+xFcQk6f0GW5SkJD8wGG2Bs6wOqKjfmKc1yIe6ksRpt+0k7NGZsTe/1zBDhcw+/G5
	 q4ihjk/S58QajLWEEsCakj+NzPMWMk//UIdmaWAghRS3oqEbIPAxfAWzqW1qjkKcGR
	 pPqou6gVBDdbJ0l5V8r39OY66vzyKVS+Bi/txfDim9GHMllrmc0zN39j/jFDSh8usX
	 WV2uLixBcLVFgrN16s+U/hZnmEHpgjbzYrQCIretzIJTVI7c7renQf2RYltj5K72lZ
	 NeF8f5Z5ohiKw==
Date: Wed, 20 Nov 2024 10:01:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 09/15] dt-bindings: clock: at91: Allow MCKs to be
 exported and referenced in DT
Message-ID: <cxcurxzeiygafcmrieqvsmt6f6svplzya2qxtltgnbj3t7s3av@xdpnuf5eohlu>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <726533dbd5663e95b768bd19d2d544a197e5781d.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <726533dbd5663e95b768bd19d2d544a197e5781d.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:15AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
> 
> Export MCK3 and MCK5 to be accessed and referenced in DT to assign to
> the clocks property for sama7d65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  include/dt-bindings/clock/at91.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 6ede88c3992d..e37f1b9cdabf 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -42,6 +42,10 @@
>  #define PMC_PLLADIV2		(PMC_MAIN + 11)
>  #define PMC_LVDSPLL		(PMC_MAIN + 12)
>  
> +/* SAMA7D65 */
> +#define PMC_MCK3               (PMC_MAIN + 13)
> +#define PMC_MCK5               (PMC_MAIN + 14)

This goes with the clock binding.

Best regards,
Krzysztof


