Return-Path: <linux-spi+bounces-5248-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D299A1CB2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB131C2724E
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426971D434F;
	Thu, 17 Oct 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urSYwt2r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F816EB76;
	Thu, 17 Oct 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152631; cv=none; b=pHT7Lhm97qBwxNGWcsYqLDCneO+22ADvyGb5AVwNREB4Pu6hNIX5SBfxkokA80KfnMYw+nJaFuFltXQCZatjyvHDCfbqszdwSTvU/otOeTbeCj/dsuRixA0fv4h4wk7u8QMgG6Z9dHIx2DBfopGuHxctQc5K+6qy6l0R9gZUWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152631; c=relaxed/simple;
	bh=64LvGzD9gEBjfxxxZ6qCqjt0JN7XE2w1oV67leFXXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrLeAG/+pWB2HSEOYKUGUzdSwQYeNO+qzt2HMgIFnogCfsC+CySPD5ulvDBwyzESiMBa5j2hJPNQoO1J+QLMfc2jj9n2+SrUZ68qLb5jEdn7szeZNLsVXMDwhzUxDONrY88PwbGiuNT4K3+iuedwjZpD8hFFpbNNz+0fCFYqrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urSYwt2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB9C4CEC3;
	Thu, 17 Oct 2024 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729152630;
	bh=64LvGzD9gEBjfxxxZ6qCqjt0JN7XE2w1oV67leFXXR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urSYwt2rcpIEZ0P3n52AxQMQp9tKPKY8oD5uONoJtFBX0buMHyrYSbyUjpMchfrm1
	 2Dvn0SooFeU3AGi1xy19BBaAzVA6qUaCwqrANCOPNu0woEKee0vww6FEUmZJCITb4g
	 hFT+PF+9agwT22HtBtX71UxYyHa+smT+bq2JIrNmMxS/khZ8znpX/uyBAZ6iZ3q3TN
	 tmi9bVoCNTGjQdj5A1QYSYqp5IrT7xRZl6AWObXa6Bi7oxRE0gXQwt4s7uiCVLzDFt
	 hL6GfsxsL08rL+1os1+T1sYOwGNTHWjfq++Jf0cyfIe4dA9xXEmfl3eY5GG3rn/f2S
	 cSwbSCo6k1m7w==
Date: Thu, 17 Oct 2024 10:10:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: spi: Convert to dtschema
Message-ID: <m5pz23mlikndtntbdktkjecgh7jjhoyjcsv7uehugg4p4psgrm@yeckjpqu4tad>
References: <ZxALy6p8m9eS9uIW@Emma>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxALy6p8m9eS9uIW@Emma>

On Wed, Oct 16, 2024 at 06:54:03PM +0000, Karan Sanghavi wrote:
> Convert bcm2835-aux-spi binding to Dt schema
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Thank you for your patch. There is something to discuss/improve.


Subject misses device prefix and considering Mark's preference about
spi: it should look like:

spi: dt-bindings: brcm,bcm2835-aux-spi: Convert to dtschema

> ---
> 
> Changes since V2:
>  - Modified the Patch subject
>  - Removed unnecessary description and example
> 

...

> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> new file mode 100644
> index 000000000..351019d68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/brcm,bcm2835-aux-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2835 Auxiliary SPI1/2 Controller
> +
> +maintainers:
> +  - Karan Sanghavi <karansanghvi98@gmail.com>
> +
> +description: The BCM2835 contains two forms of SPI master controller. One is known simply as

This feels loo long. Wrapping is according to coding style (not
checkpatch), so at 80. You can also have line break after "description"
keyword, so:

description:
  The BCM2835 contains ......

Rest looks good, so please send v4 unless Mark could fix these up when
applying.

If sending v4, remember about tag (see explanation below):

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


