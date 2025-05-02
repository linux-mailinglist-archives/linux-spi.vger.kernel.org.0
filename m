Return-Path: <linux-spi+bounces-7823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B3AA6B3F
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 09:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2600E176FEA
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F0267386;
	Fri,  2 May 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+EUjaaI"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEF288DA;
	Fri,  2 May 2025 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169516; cv=none; b=HWa2VL+VNwN6UIdvwobzBV/uBx2POvmuRlRGAg0bbsDVX1cF7TnFUvPoATXWCYjdnqmXzC2lVtXtdvu53GlXMgsjfIJkQuoG//YHkxJUA/CMAYeMhQ694e1dakAgVFNR56pGFkZX+wUlK/wsyu4GS4wWQnQvtA2NKmEnO6mPsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169516; c=relaxed/simple;
	bh=RnLYSGQ4p/jCOLbnoXunmxOmACH3eYTRIm76JOZiHLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXf84IErrJKk9HeeGYlVl4Kjl8OMgLrZRckhclPVhWrvMQHtLk2FcTygYAoWYXvzBdo21dEOTMYptPoT5NSnBhNO2XOfB5CGC1f7cJFZv8NS4FQ4Uwc0IJpKHfQlSlaf7xVm7vubnwStGtTVA2BxFLsV9P+xTq/ABrqX2A4mkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+EUjaaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABC5C4CEE4;
	Fri,  2 May 2025 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746169514;
	bh=RnLYSGQ4p/jCOLbnoXunmxOmACH3eYTRIm76JOZiHLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+EUjaaIss2N1pcb81fW4tux45WRYmwk934PZ/s1OIOx0BEUmYLFzxOLNAuDqYRL+
	 EC2M5BwtxxDWvi05t7v0cVOCwhcZJxWR5Xl1/YOM4qdtEJV+nqjPI7QC2LtKS+EQlp
	 NHwEwWe4r4KThN4pUPiYu6UoWFAFaygAlUTHBqUPJZ1fj1o+lvQ9c2JezmhCOX8DF+
	 /gqinTjbToPierIo6cNhpYj269NR9UnZOT+TUaXtWRdUgIcyOAupVcxEJcI7Qz0kFB
	 1vTlQ/h8tDpVVkGSa/P8oA6FPtC/V4I7VDwZ76RpMVvx5WVROY/38oGIPWJnqpKgzW
	 5z9xjHb69bI0g==
Date: Fri, 2 May 2025 09:05:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	sadre Alam <quic_mdalam@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: spi-qpic-snand: Add IPQ5018
 compatible
Message-ID: <20250502-deft-imperial-swine-e6aefb@kuoka>
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
 <20250501-ipq5018-spi-qpic-snand-v1-1-31e01fbb606f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-1-31e01fbb606f@outlook.com>

On Thu, May 01, 2025 at 01:20:51PM GMT, George Moussalem wrote:
> IPQ5018 contains the QPIC-SPI-NAND flash controller which is the same as
> the one found in IPQ9574. So let's document the IPQ5018 compatible and
> use IPQ9574 as the fallback.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


