Return-Path: <linux-spi+bounces-3134-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EA8D4048
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 23:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27CF1C21FD3
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003721C8FBA;
	Wed, 29 May 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGxa8ABw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44201C68AE;
	Wed, 29 May 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717018000; cv=none; b=hHmE/mrSAYIOHEYxDDZeWlKU6Cf5hAS2D/pu6L6bhRtBSCdBkq+r9PmQrdMCVYFuR3lTCLVxMCTBr6VWSjouPI2DLYtm+qsQeyb9Wfb5rU1sDoVGv28/wcm0tZjuZJPllO1SeFbICKiw2hcUfhXzVD6wuzKiTZMQFPJV75dD1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717018000; c=relaxed/simple;
	bh=yMhVKgv72XmdTEIVE7jl5MA6U3EC7uLHauQYYnht46Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oQrdCDOmgVr+twMXaxBVItHAr1PkLMPl8gz1sPNkndr2GUYy4twnOUvpBge3U8SgAjmQ5auduvMPgW6u8Nx8OuljEkucfZ79lVSA9iWuLg8fxvHYIAImdrTyhBEagE571anSuAJBNuJ0BY3HDEqtzv9VDpnri2JB+W+TzeiuTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGxa8ABw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1378FC113CC;
	Wed, 29 May 2024 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717018000;
	bh=yMhVKgv72XmdTEIVE7jl5MA6U3EC7uLHauQYYnht46Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WGxa8ABwamrm++0j8tr39vpqn0gcKamPATxEeM0zfcmO6FnNjUmmqySCXl6mw3Wc6
	 XwiWL60sJe9TCJyKjR0QO3fpPh6dF2TGkolXJxE4E2Hxb3y7BWxYlP1cBnoQDvH+GG
	 qoPw3LYT8tTG+LgTX5NitaAPPV9rS7WvH/jy3eGE5a74vvIsMTlN/f/e/3BW8yUwCC
	 MHFAF3zD18FcKqY8sbAGHYj86WUY/QGC+ijq6vZXw5e69UQeEjSeJpxV3R3i9wRB+1
	 ZwQFr9S/6gaHlR5gK5y8n5e/7WBlt6qGGOEZM4Y/yJmH4rAg5D/MHMQez2L2tiwwD6
	 jacQW+TP1JkQg==
Date: Wed, 29 May 2024 16:26:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240529193651.1029840-1-Frank.Li@nxp.com>
References: <20240529193651.1029840-1-Frank.Li@nxp.com>
Message-Id: <171701799909.3874213.18222110572993533642.robh@kernel.org>
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: Convert to yaml format


On Wed, 29 May 2024 15:36:50 -0400, Frank Li wrote:
> Convert dt-binding spi-fsl-dspi.txt to yaml format.
> 
> Addtional changes during convert:
> - compatible string "fsl,ls1028a-dspi" can be followed by
> fsl,ls1021a-v1.0-dspi
> - Change "dspi0@4002c000" to "spi@4002c000" in example
> - Reorder properties in example
> - Use GIC include in example
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     pass dt_binding_check
> 
>     make dt_binding_check DT_SCHEMA_FILES=fsl,dspi.yaml
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       CHKDT   Documentation/devicetree/bindings
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/spi/fsl,dspi.example.dts
>       DTC_CHK Documentation/devicetree/bindings/spi/fsl,dspi.example.dtb
> 
>  .../devicetree/bindings/spi/fsl,dspi.yaml     | 126 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt  |  65 ---------
>  2 files changed, 126 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/fsl,dspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/fsl,dspi.example.dtb: /example-0/spi@4002c000/flash@0: failed to match any schema with compatible: ['atmel,at26df081a']

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
MAINTAINERS: Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240529193651.1029840-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


