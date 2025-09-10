Return-Path: <linux-spi+bounces-9956-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6FB50A36
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 03:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF171441B40
	for <lists+linux-spi@lfdr.de>; Wed, 10 Sep 2025 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A031F03D9;
	Wed, 10 Sep 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUqnq8E+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698E1EB5E3;
	Wed, 10 Sep 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467584; cv=none; b=hpxr2IIthLDUsljE4CUuuohAwTeLR+ufUsp5g6DeL7am4rEKbVAA6h5SDfyQhOtWP60NV5omdpz96NLcVul+wLI0PKvq6QUE3ocQxX7bQStoYMO1iDegIMbY0pDXcTsAoRdaOID+OcpoWu7tyo6NLY0jG1kn3NROmohOfbqPAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467584; c=relaxed/simple;
	bh=6H+vJE7E8FrtvtrJctIMl1VGEDdD9t6pgrkERpF0vq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ozlyTeNMrquBupv1mYpYVawD8btlqL+8lqi4Ux+D8B0LwddEIlenF0D0+XQajYdVUW0KTPHS7XyV9i8ncvKIVRURTwhgvoIwaqFRFbBTSVUVE5Xlv9tJVBSYvAbkBTef5mtoAVFIlXoU5YLEjaZfaOjwV+RKT/0C1oNeje++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUqnq8E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AF4C4CEF4;
	Wed, 10 Sep 2025 01:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467584;
	bh=6H+vJE7E8FrtvtrJctIMl1VGEDdD9t6pgrkERpF0vq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUqnq8E+dk9tqpuR5mAgbwlKZ/mvSHNMFElLfT0SXYVGch4c4zmcRfDsRkmBirOUk
	 goBT8mIpBx3qGZ/Nn38NH2HFnTtwGMCS92bgXO0hNsBTMJuI0DHbjtzd7/WSdYeWfp
	 XsS/HGVN/TG63x5XGBKoY3TVc5uNnhNasFqnlIUGC7ruNP1buMwA6I5WkpuU7uF1RM
	 QNp8aaaA3MqpwfrcXCzlmP5YnpIH4+aAQC4jQSC6wB1aIninSeWDLpnjRv8K1lfPxx
	 BtXvaP1qNu0CIySiuijCRGk2iudWcAr4LKWjkfLdQrhA8kIPfFeMYz2mzW4Ve7GYY2
	 X9zRlIuRzIxcg==
Date: Tue, 9 Sep 2025 20:26:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi: Document sam9x7 QSPI
Message-ID: <175746758262.3564926.3476770597508307840.robh@kernel.org>
References: <20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com>
 <20250908-microchip-qspi-v2-1-8f3d69fdd5c9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-microchip-qspi-v2-1-8f3d69fdd5c9@microchip.com>


On Mon, 08 Sep 2025 09:44:16 +0530, Dharma Balasubiramani wrote:
> Document the sam9x7 quad spi that supports interface to serial memories
> operating in
> 
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI
> - Single Data Rate or Double Data Rate modes
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


