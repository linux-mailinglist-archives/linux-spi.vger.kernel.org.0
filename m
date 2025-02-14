Return-Path: <linux-spi+bounces-6831-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764BA358A1
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 09:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8A3AA946
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B23207662;
	Fri, 14 Feb 2025 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQdThSWL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4D1632C8;
	Fri, 14 Feb 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521018; cv=none; b=JjaTZJ7wdK3wi3/j9U9vnZ34Xj1FzLLsmMqAmZli4jqTeA4/1OAiaPpzWlZ++9ifyeyVwcwgecsIsNP4fygT2Fqy7BgXTX67y/nQRMrvL6MOCVS4tAuX1ca/NnK6dwgqb+xDod8sskYaexdhaamaTPrsM2JMRZ7Igg4Ir+c50Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521018; c=relaxed/simple;
	bh=C9PejOUD39fGJmShIEpkP1R0NrPHjbzcGvp53tfao3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2HKqCZUEhbGHcSraELTdB51p3t1giu4ugbCGf1ibaq/f1kdo/lDg7vSnTqwwqpOc9ymYsZmvoCOS8bej7eunowHCcZpe+NSlh2wSIRL2thopW1QWpKWNxZpqttOGYi6xHz+LD+6hu7jMto3bYvAJBoAXyl/O3dqNl+J/79v+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQdThSWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2D3C4CED1;
	Fri, 14 Feb 2025 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739521017;
	bh=C9PejOUD39fGJmShIEpkP1R0NrPHjbzcGvp53tfao3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQdThSWLJu3SARHeoXBYF9uFjHeBCiMXiG7Mkil4l2gy094jGGg/5Ht0ijBt5wWDB
	 rfqImKEjWZ2KXjsPBhr7VR5dlPmwH9N83wqigJwAN5qttr47lFrPo48vnC8yjC6Rsl
	 cbBvrlwHD9YBKQawp9pVkQtP2QAiN+M8yAWA0fTdd36X+lH4yWd2pBRvCGw+zeijQ2
	 fSKq+0emyGXsmjFN0c9L2zGU/TWted7aEvTU7SA/CYwvWlIc7nnNQqGO7wv2iqoFMV
	 MHsryN3NfTuHFwL1Orrkvwmg7x43qZkpGo4qP4wEeqZGITteeM59kU5YmTFWJYQAas
	 7NhUuf2+743cw==
Date: Fri, 14 Feb 2025 09:16:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: samsung: add
 samsung,exynos990-spi compatible
Message-ID: <20250214-adventurous-earwig-of-perspective-b5cd91@krzk-bin>
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
 <20250214043343.263-2-wachiturroxd150@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214043343.263-2-wachiturroxd150@gmail.com>

On Fri, Feb 14, 2025 at 04:33:41AM +0000, Denzeel Oliva wrote:
> Add "samsung,exynos990-spi" dedicated compatible for the SPI controller
> on Exynos990 SoC. This ensures proper representation of the hardware
> in the device tree.
> 
> Signed-off-by: Denzeel Oliva <wachiturroxd150@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


