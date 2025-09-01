Return-Path: <linux-spi+bounces-9837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE2B3EF54
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 22:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FDC1A87308
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C90D2652B4;
	Mon,  1 Sep 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sksU0OGe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9F223DF0;
	Mon,  1 Sep 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757806; cv=none; b=uWNtilAm8O/JLB1KcRaQfzUwv3rUvNwme5ExL7hTJdHiDQi9/IyadH/5oO9xUG0pYlgJCMm0Y2w9XBB5ywnCGvJxeO2Fo9Oc3qgWTb7dToMm1C/VZzhKIbas26uF8VksPv9gwruVt3T1ywz6px+MfW8aaG8nxMFHlHq9UR/MtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757806; c=relaxed/simple;
	bh=CtEv3CBI4kkNr2BDMp6aV34tV2Uzi0xNoxhyaCK/+ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZTAKV2U7sAJN1V0aLkft1UEdnGvNcbi1mfs1PR1BTP8CgTXvSePxmh7Z9I5+GmT4dzEP5jXYdXMYVQinJhL2rHsLRAdacSF3VE8puOzzXbH4M/NnsMMz01g0vrj0js4GUlxzRAXev7idX0GoIQwffVnPqAXRtRA68vu0x8YnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sksU0OGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54322C4CEF0;
	Mon,  1 Sep 2025 20:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757805;
	bh=CtEv3CBI4kkNr2BDMp6aV34tV2Uzi0xNoxhyaCK/+ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sksU0OGemksLoVqZQqK2MeENZMFvIQrqhFj58IivMXRTbo+PasivLrs4B/Yi+Hf/Q
	 CXEjb/pToy2+CxyeqF6jLALTPqXAztjRcdVSM/3orskQzdTGmEYN5DrC4iMeRLfI+B
	 yNkRg0JoYY3k1PeYuKar7wSznc737viPC8QhRPfpSbPGlU9teXb7lQkfGBtVuSA/fq
	 d29eNp0bm7XMgYk7rJw4EH69RrwRAzId19NmrYA1EAK7MHATMWysFICcvbq7iiYxrf
	 QmTtd0NmIpuOY/XLl+YiPlphDH2+i3/1gx7q5Kjhik/uy/2EMI+sXT5RROQTxYIp3m
	 XnOcNIHsiPVMg==
Date: Mon, 1 Sep 2025 15:16:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: dt-bindings: samsung: Drop S3C2443
Message-ID: <175675780389.270864.9232160041092038362.robh@kernel.org>
References: <20250830132605.311115-3-krzysztof.kozlowski@linaro.org>
 <20250830132605.311115-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830132605.311115-4-krzysztof.kozlowski@linaro.org>


On Sat, 30 Aug 2025 15:26:07 +0200, Krzysztof Kozlowski wrote:
> Samsung S3C24xx family of SoCs was removed the Linux kernel in the
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
> 2023.  There are no in-kernel users of remaining S3C24xx compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


