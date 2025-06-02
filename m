Return-Path: <linux-spi+bounces-8352-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027AACAA3E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 09:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 430EF7A56F4
	for <lists+linux-spi@lfdr.de>; Mon,  2 Jun 2025 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9E19CC36;
	Mon,  2 Jun 2025 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG7iR5UU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CA2C3255;
	Mon,  2 Jun 2025 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851120; cv=none; b=pr/rOoYGAplaMJ+F6w+AIWo1MSXvwyjSYnd94a/2CfyAJ42Hh/USWrbrVMgQR2DOb6fMkVmU3lryajEOw8fVyJ/n4fTjuimtXFKeqluawzSpvFXYlBd7Q8z+YqRobStmdXWyTgDO79zYQFJpFAZ/q4iLlyap/IKh53a/gXHmjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851120; c=relaxed/simple;
	bh=544lQiqDWQm+uX2Zups+rNvGYpg3RDJp/RoqS3mQbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km2PC7F5cCvScNIbUKV8/nXbFt8TOEmgGFj1esskai5VivnHOgF2q14crZXw+PWEydFax3Wh8xPLirLQsunp6cPbkwsZR+1AM7G97Q6hyDubhyuxEioumu0+j/WN6C//OKGfEqEs52kFmzTTb4YGfsSNQl2DsDJNuXKUSAmJzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG7iR5UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09459C4CEEB;
	Mon,  2 Jun 2025 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748851119;
	bh=544lQiqDWQm+uX2Zups+rNvGYpg3RDJp/RoqS3mQbXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YG7iR5UUTf4WRRRbxYFk0IlK8l9Vbh57IGFkUQ69NdQC0dbuApSDMY7VQ1zAenXVo
	 jQfUmja+Wrix6TMloeCtNEyLX+lADPCdCwYj7Uu61Rss/vLn/WeiaxneQgWZZOepdn
	 6mEU6zWB9z8OA8NSkm6kiCZf4xkM8ii5pgUT61frSV0R0s7QQhzFfU39NB9NU9HO9I
	 mMsoTELnmF9yX0yU5ew6M2ItuRbbjn6ZdDDfiXksUlFAYX2m75k8SeI1WSlFvE5QmI
	 3nnKhZwMraeWYs5Ssf9iZSnA/tsOxv6PeIXg1KEZQ3emmzur9vWTmkdO+Htbjh1GBk
	 m7vel9um4Imig==
Date: Mon, 2 Jun 2025 09:58:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v3] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Message-ID: <20250602-precious-hound-of-argument-de01be@kuoka>
References: <20250527063438.504207-1-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250527063438.504207-1-amit.kumar-mahapatra@amd.com>

On Tue, May 27, 2025 at 12:04:38PM GMT, Amit Kumar Mahapatra wrote:
> The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires only
> one reset entry. To reflect this, the maxItems for "resets" and
> "reset-names" has been set to 1 for AMD Versal SoCs.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> BRANCH: mtd/next
> 
> Changes in v3:
>  - Updates to 'resets' and 'reset-names' removed for non-Versal platforms.
>  - Updated patch description.
>  - Added Mark's Acked-by tag.
> 
> Changes in v2:
>  - Removed "resets" & "reset-names" from required properties.
>  - To address review comments, removed "maxItems" from "reset-names".
>  ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index d48ecd6cd5ad..81e8342db4bc 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -17,6 +17,13 @@ allOf:
>            contains:
>              const: xlnx,versal-ospi-1.0
>      then:
> +      properties:
> +        resets:
> +          maxItems: 1

And now this is not synced with top-level properties. They say
minItems:2. I never asked to drop update of top-level - read carefully
v1 feedback.

Best regards,
Krzysztof


