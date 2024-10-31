Return-Path: <linux-spi+bounces-5572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767079B767C
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 09:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E28A1F23093
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF716C453;
	Thu, 31 Oct 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqMlIkR+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2651553A7;
	Thu, 31 Oct 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730363403; cv=none; b=TZzdOd8iyDBVWhTCJLlwswHsFi7ysgi2Ti8Y0smgGZdXLIWqEzdBg9Qnh/cBeF9upSkJdtmllfDNuB79+hXSm8rnZZ1MT2BsbIdYpoJik/HBFqI2p2lnrynmyrw/zXceVHX8FAhJkVAFC9GiP1H0ddhZKctqXU1OFN23ixUD9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730363403; c=relaxed/simple;
	bh=sLM3ZZBvDSqyUZsbYRazaAiCO+zpRi389nmzskpEQhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUCzp5YmG4HmHylVdFYCAUSzFYDMtz2BuZJuAHXTxR49Ts54Bb5NcDlEH46zT8ZAjOzTABKvZboGiNyrEUZIrO2SIwdBWQ7zfH/xGD1YkWPC2VKo8SxN++3qdqnHjqGIKDlXXcaBHTDapSYB8yguX/fuM0QjrGEzhcCQFtwpHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqMlIkR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67C7C4CED2;
	Thu, 31 Oct 2024 08:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730363402;
	bh=sLM3ZZBvDSqyUZsbYRazaAiCO+zpRi389nmzskpEQhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqMlIkR+INSXsNFbmspoltZOcT2gLJ2wA6IRSg9lZFlRplvOEaU3emRyM1YysclRO
	 qIhVYc8XLMU753lvT3+mE5eGxsA+p1MLfXCJlWULbOEQ3i+rQ5yiryQAISr+5yHbdu
	 4ywnp5p0GNK4hVo13l7SQBopTe+wozOs6EMsuSkIelwukEzf6a5LOnQ9FVVkH1KE3s
	 tFTnt9gSkMGuOMs9FRtVTrh/IJZwrfOXAI9m4jhFMDhPPzBhRGAodqRdkJnJdAmwkb
	 zbxnDidB+P8ShIolQg0/B690tjQ9pmcsxHwPbZMJH59imMPSGYbchVVt70Se1Ut4x/
	 llUSSLvBsvDBw==
Date: Thu, 31 Oct 2024 09:29:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: sprd,sc9860-spi: convert to YAML
Message-ID: <f524jg4lp45qeame6fequ6lnupgkkx6rz3uhfh5rqhhpkpedfd@pg5tsfgvuoj7>
References: <ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP>

On Wed, Oct 30, 2024 at 10:02:55AM +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 SPI controller bindings to DT schema.
> Adjust filename to match compatible.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-sprd.txt      | 33 ---------
>  .../bindings/spi/sprd,sc9860-spi.yaml         | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/sprd,sc9860-spi.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


