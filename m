Return-Path: <linux-spi+bounces-5584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07B9B94A4
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 16:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8341C20F5A
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0F1C7B82;
	Fri,  1 Nov 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGqhRb8j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BE1C32E2;
	Fri,  1 Nov 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730475795; cv=none; b=WZUlpne7MGLVSP6iZv/VzU7pnfQaqz/dW1gTUIPbrfGJsbGeyk9qmOeIIdJ0c1Uc2rIkqmQrJn23ohNqAvHG58aZgiiTCT6f/eOebRXuROdiVjVvLT4HWutxxkbsXzQPHBLq6U5vZMnRKI7ifQpN50a5LiFSLSY99EiZT+ycxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730475795; c=relaxed/simple;
	bh=irRgyaZNL3QbES2BKZpFC5HFrUeyLhBKBuQONdo5KOg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LQNobOLssH7m631CKogdOxBIGv3aee01TfYKK5pXqZjxPzuuXcqrQoJBzk8SonfRmxrt4GsXiF2la6BN4H+OVLt+JBn36JChwMNXLOvJcLbhNnuV3Kbv+fR/MbBfEHCgzYZvCaP2vCYUBPC09dtYeFfqW5QdoFTQXE+2Cw1prek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGqhRb8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277FEC4CECD;
	Fri,  1 Nov 2024 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730475795;
	bh=irRgyaZNL3QbES2BKZpFC5HFrUeyLhBKBuQONdo5KOg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iGqhRb8jR4HXevjHc8GpzO5tk/iTgRBDJAhlmEszyFfNIfToCBXDMMpnPyx1YyG0G
	 UyT/L0bngIoQ19hvlGOS7ZBCE5FjRpbj0CfRO9K8+s2VyWd6qo4wJRZOGMgPEy0YvI
	 yTewADkihAH/QKVdQj2cTVDXG0FVQBpJqxwiPgIKRrhi0AD/LJeHHodQSnPvqtc4Gt
	 TCmm7BTfa9hJX3s5aZez/Hrh/9tbYXjLxrYtnKp3raOryFi12UlC0cjBAOhlTvI6hC
	 y/f19yAtUUem5jGZOqULHJMjj1vTJx81NUJh9Jzm95puOEwFeCib9t7BgSnFjhPhbd
	 1JvhK64JRtEmg==
Date: Fri, 01 Nov 2024 10:43:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>, 
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241101-asahi-spi-v2-1-763a8a84d834@jannau.net>
References: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
 <20241101-asahi-spi-v2-1-763a8a84d834@jannau.net>
Message-Id: <173047579349.3488175.222264580667894425.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: apple,spi: Add binding for
 Apple SPI controllers


On Fri, 01 Nov 2024 15:25:03 +0100, Janne Grunau wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> The Apple SPI controller is present in SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
> doesn't need any special properties, so the binding is trivial.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  .../devicetree/bindings/spi/apple,spi.yaml         | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/apple,spi.yaml:10:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241101-asahi-spi-v2-1-763a8a84d834@jannau.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


