Return-Path: <linux-spi+bounces-11862-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A91CB4C53
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 06:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD59B300F5B3
	for <lists+linux-spi@lfdr.de>; Thu, 11 Dec 2025 05:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF628312D;
	Thu, 11 Dec 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbQz5u9O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB9271A9D;
	Thu, 11 Dec 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431087; cv=none; b=EoY8l9xd6Dc7602rMDLBlsaVCNC6ghsyXDj3Z6APLKQ0VrKKDR61K5jIbS6Jr6V4oNxeYC5CYQ7RxeXkqpiWvXM1Keejn36cSdNhUHCEQORSSdtg/icakhvTvjZl+qRzVRVxkEEpxqcY8VWMkrbwo9lZTdzjLx997a6aRf/R58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431087; c=relaxed/simple;
	bh=as+KhL5yWPyDK+HZmsYSr6hD8Hukg0C+YsVELJdc0nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV+6ifi/oXHrYBK7hojde7A+IzPgILqkVR8QXenlrE3qJZZapQdR1b4hkP2sPn+6h9YJqeqcPkPBiY4EWknnfebCfJO71qkixqvhpBGSJrSvbiROp+8Eud120f4g734ZJV4aOqO1cfzjpLUI8R+7NcW6ofmB/UAxf390A2LcW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbQz5u9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91539C4CEFB;
	Thu, 11 Dec 2025 05:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765431087;
	bh=as+KhL5yWPyDK+HZmsYSr6hD8Hukg0C+YsVELJdc0nM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EbQz5u9ObfpoZXqidzPNzzzk6Zct//roJvxvDrZSudr1u+0EOSeTDJtLviz1DQhvi
	 uIKEcoeOmyBMuzzjOQ8qCH29bZFi/whR6ZmyG/CEdaAz8S0lkZJKw1XrH6SkgUvVoD
	 nYdEuRQjLszWB11JHaZ/Getvrc1IrH8wHTQ94pBfQ+RHOlqGqKPKbn+FoquFDCfNOX
	 UKEMmZngnkXInXvvwzyHrEf7CvGMSQ4+STFmogxHMPZp0NgFEB3rKe/6T/dN5Bw13U
	 2/V+eUlxX2+V7jH8ff0YL2RP1gT4KKHuSctJulLBWL2ATRcPzGP61eiDJxYAm+GI4d
	 Sqt42NoE5KZ3g==
Message-ID: <33e24f43-53d3-46cf-9012-aed67230723b@kernel.org>
Date: Thu, 11 Dec 2025 06:31:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] dt-bindings: spi: Add support for ATCSPI200 SPI
 controller
To: CL Wang <cl634@andestech.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tim609@andestech.com
References: <20251210090430.3602380-1-cl634@andestech.com>
 <20251210090430.3602380-2-cl634@andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251210090430.3602380-2-cl634@andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2025 10:04, CL Wang wrote:
> Document devicetree bindings for the Andes ATCSPI200 SPI controller.
> 
> Signed-off-by: CL Wang <cl634@andestech.com>
>   - Dropped the "spi_" prefix from dma-names as suggested.
>   - Updated the DT binding and documented all compatible strings.
>   - Added the "andestech,ae350-spi" compatible string.
>     
>     AE350 is part of the AndeShape™ platform family and is a commercially
>     supported product with a fixed, documented SoC-level architecture (memory
>     map, interrupt topology, and peripheral integration). Although AE350 is
>     often deployed on FPGA boards, the platform behaves as a stable SoC
>     integration rather than a prototype.
>     
>     Upstream Linux already accepts FPGA-based platform-level compatible strings
>     for stable SoC-like integrations. For example, the Tensilica FPGA platform
>     uses:
>     compatible = "cdns,xtfpga-spi";
>    
>     Following the same rationale, "andestech,ae350-spi" is proposed as the
>     platform-level compatible string for AE350-based devices.
> 
>     More information about AE350 can be found at:
>     https://www.andestech.com/en/products-solutions/andeshape-platforms/ae350-axi-based-platform-pre-integrated-with-n25f-nx25f-a25-ax25/
> 

That's a completely corrupted changelog.

Please apply your patch and look. Or run checkpatch. Does it look good?

Best regards,
Krzysztof

