Return-Path: <linux-spi+bounces-10987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3FC2F4CF
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 05:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DFC3B5367
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73B236435;
	Tue,  4 Nov 2025 04:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVMMnhjC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A094400;
	Tue,  4 Nov 2025 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230370; cv=none; b=DjNIWMnG+tpseY4JHGl9t61N3MDw2cKH5oGtRvBb8uLSGHrFRyA9nNE8Ys/coU7CbeV4leJzL0TkXH/9ron1XoLrhrCTF2VIAR09HV+WG+7uv+HaH5TJ3a4Sxn5qZQ23b/FWeje0lTxjroxUhia4ShYnaMHzE75gBT6byWP0Pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230370; c=relaxed/simple;
	bh=AYF8e0rVqm3kzb3CWlf4llatfsXDOM6GS+Lq4uaXF9I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AlBKz3Fd3JTJGlM1pRMSPmJqda5NR8DA2Mx3WoyjZiwJB5T5D7Rk9ks0U/54nCiNKshWjdKhzbi3xtpXwjeTihwlrTslA/ZS9HPHFEa2yynWeE4V4Kf9yFbAbJnPsV1PrgWjI8CkjsZgxzZvdSFgwav6dbG0Xn8am8m92lNcEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVMMnhjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A672C4CEF7;
	Tue,  4 Nov 2025 04:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762230369;
	bh=AYF8e0rVqm3kzb3CWlf4llatfsXDOM6GS+Lq4uaXF9I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CVMMnhjCHVtTZXQLtF+yyOBA1woW3BAykCaH5ME6OKermXeaIzsy3RnlyFG/TZxk0
	 oBbwUG8AeD1fyiX7hrv1pc9+FVESa3iSe71Bu11xbM7RrnYRqsbJwVMYrU3/vSHqFI
	 kTG2Dmbwmv1z/REb2rt5y+qkl3EQG9oavuH1ebSME5NQkUY74WuoCujifq3YI+jj7F
	 2RiPl2wIDo7qXPThneq7o+Y2zuiytC8HWHwwLQIMg3LwiFcRAZxx42f+sxVE9P3TnU
	 nFXvA87wbJbzU99k7WU/R0fd10OtvvvGykQoHFa1n3VP8XrnOTl2PDZlEAGqle7OcW
	 9nu+K+3EUjtYA==
Date: Mon, 03 Nov 2025 22:26:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, Han Xu <han.xu@nxp.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
In-Reply-To: <20251104-xspi-v1-1-1502847ade40@nxp.com>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
 <20251104-xspi-v1-1-1502847ade40@nxp.com>
Message-Id: <176223036803.847185.12615558425940080887.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi


On Tue, 04 Nov 2025 11:07:36 +0800, Haibo Chen wrote:
> Document imx94 xspi that supports interface to serial flash
> supporting following features:
> 
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
> - Single Data Rate or Double Data Rate modes.
> - Direct memory mapping of all AHB memory accesses to the
>   chip system memory space.
> - Multi-master AHB accesses with priority.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-xspi.yaml      | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 92 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/spi-nxp-xspi.example.dtb: /example-0/soc/spi@42b90000: failed to match any schema with compatible: ['nxp,imx943-xspi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251104-xspi-v1-1-1502847ade40@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


