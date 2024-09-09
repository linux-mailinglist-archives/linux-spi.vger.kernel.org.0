Return-Path: <linux-spi+bounces-4732-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AE971427
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFBD1F24C5B
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831831B3F08;
	Mon,  9 Sep 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF/Qz2rK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D901B3B3F;
	Mon,  9 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875110; cv=none; b=iLNsshFitPK40dYmwLSn0xQzomOCV+QgcZIAMoIwN9x/cqvdOTl2GhE+1wUFK53Twotz7ggXHGtnFUM4QD/IqK5CaAntSlb3FckTQcvLlvRQ0zM5GinTXeVH7/9NIAZEeY/jiOiEne/xCV3opXIu2Hw6F+bdQvOkQgA8jAkx61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875110; c=relaxed/simple;
	bh=+tBUPMWdi7XKGaq0cur7BT3ayJpmy1rXgipiK4N0NsU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=N94PCaL4bmnZxFYOS5O56Q3XmEL+02uV5lcvXONAn8aMM+v9ixJ/XoENQvFwASoy3Y698/5RUtW6aKPdZuqs9V2KkzX6FEaOw82JQygwAZstDb9ZJmTgycmnnT9q6QiDM8+GFYMFj7U+a+O6MBSMCcEk+deex0uf11N5Rc2dJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF/Qz2rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF1FC4CEC8;
	Mon,  9 Sep 2024 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875109;
	bh=+tBUPMWdi7XKGaq0cur7BT3ayJpmy1rXgipiK4N0NsU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IF/Qz2rKZXLCJGzZwkVe3KYQRWyuQn09jWwVEMfvzAbPn4a453Z/ZUPLBBH+D2rEl
	 /Ao3JkqgRbzIOgWl3ifl48a/THijrm2A6iYTdHVP4uktW+b0IzyUoa6t0HQizty1kO
	 gmjw5q5rItj7SfhMujfhqnlh8nEaLlSjBCKnBRD70O+0ZIaSIKKHnbbFUk/F55plv+
	 FVQKF2dHIa7an8yCLfnQV66f/y5g7m4s61K97hBJsAisqBF61tm5aWTtr4bAvjt10o
	 N1GTCwNU8C26tnVWoeUaFndBhW1oB1AnCs8GIOklKAxvaG/q3elIIuW8TNQUpLIi09
	 WJkYqENIeL3Kw==
Date: Mon, 09 Sep 2024 04:45:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240909-ep93xx-v12-14-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-14-e86ab2423d4b@maquefel.me>
Message-Id: <172587509922.3289122.15017920373921987693.robh@kernel.org>
Subject: Re: [PATCH v12 14/38] dt-bindings: spi: Add Cirrus EP93xx


On Mon, 09 Sep 2024 11:10:39 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC SPI.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  .../devicetree/bindings/spi/cirrus,ep9301-spi.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-14-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


