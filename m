Return-Path: <linux-spi+bounces-6014-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB49ED4A8
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF09168E51
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4E5201266;
	Wed, 11 Dec 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufJq4F0c"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46724632E;
	Wed, 11 Dec 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941402; cv=none; b=teqFXkeoDq1TT3p8OanyKxNpdZ1WllGqfnxhCdW6O6S8ow0DCGDEi3cfmN1uALDanDXnNmOmihtTQTYW/PpORdbMfxP26oSr1yZjizSKBMMu16lsNo0jJKPS/gtZSXcN/ahY+8l13hG7QszhpiO3/n1iB59pNL2exVhSmG8QOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941402; c=relaxed/simple;
	bh=w2M+TjlpNPYsNFuhmIFntzAXEa02IOyc1xKcuHjzAQI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=gNOtueOKxcZabaEjyBT76LeYImQFb9wXYTWghOIkhTibbPJ0aexQ15SWSs3cJnZRZQ7L6sEQ30Xo4EPmwlZGzFTiu0x913/f+rKscGoOKG7N5mIPppWNH4r1gDbn24SqBolRTvlKsyqPBD1scpSAS808dMOeM7GrFCBa/F6E1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufJq4F0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA8C4CED2;
	Wed, 11 Dec 2024 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733941401;
	bh=w2M+TjlpNPYsNFuhmIFntzAXEa02IOyc1xKcuHjzAQI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ufJq4F0cTQtxm6pWkP2NE4Y5SAsClVAuUMrj0US9cUPtgX2KVjAdv57p7IwBPTceX
	 lygWrh2Nwh0cWUYItsm77f340NIT/XNJY9rEETqtlr9TS9Q33WKPTxqnQ+5rgqRk/c
	 GIz6hRJSBj/JrlcjsSI5ZNvab8YDEcaiNKJSZDFOejZUNZBNpjoOB9OH9LeXZLQAi+
	 Gifvh0OP4+YYHUVUcY30rrrM7VVvxfJYTkvmXzarUg/JEMb0zy0/7v6M2F83OSmwo7
	 SBE2N5ijixKGcn3azwEld8EgBo1CZUs+m0LtIaqEraFj1gQ2SwXGq13Ts8Jv4PLD0f
	 kqlqJ2Wbv7yaQ==
Date: Wed, 11 Dec 2024 12:23:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 javierm@redhat.com, conor+dt@kernel.org, broonie@kernel.org
To: Iker Pedrosa <ikerpedrosam@gmail.com>
In-Reply-To: <20241211165054.254164-1-ikerpedrosam@gmail.com>
References: <20241211165054.254164-1-ikerpedrosam@gmail.com>
Message-Id: <173394139968.3514802.10365052671543587756.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: devicetree: explain how to get CS
 active-high


On Wed, 11 Dec 2024 17:50:50 +0100, Iker Pedrosa wrote:
> The current documentation does not clearly explain how to invert the SPI
> CS signal to make it active-high. This makes it very difficult to
> understand.
> 
> This patch adds a simple explanation on how to set the CS line in
> active-high and adds an example to make it easier for users who need
> that setup for their SPI peripherals.
> 
> Link: https://forums.raspberrypi.com/viewtopic.php?t=378222
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  .../bindings/spi/spi-controller.yaml          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/spi-controller.example.dtb: /example-1/spi@20204000/display@0: failed to match any schema with compatible: ['sitronix,st7920']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241211165054.254164-1-ikerpedrosam@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


