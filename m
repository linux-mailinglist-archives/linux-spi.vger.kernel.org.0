Return-Path: <linux-spi+bounces-8271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E70AC2292
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3884A2AE2
	for <lists+linux-spi@lfdr.de>; Fri, 23 May 2025 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424423BCE7;
	Fri, 23 May 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PViedXoz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6082F3E;
	Fri, 23 May 2025 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748002956; cv=none; b=rHFGf20LYC+n9cWV6pasgeWoBRLWvck5SmV6T38fyt011klqHqg/B8FI2R6AQaEALT8k5IjAMZY1nd25afJJ7ZAd6UXY0AZIwQfCvC00LhGVHBKewSstRJXmZaKrYH/FUCDiYO37J3WdMWNfTeDGjve9MunLTYfTHbkXtR6hap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748002956; c=relaxed/simple;
	bh=rW2jpoyMNgaGm8EWhJUy3TcoK0eOE2uriwlxOl2jhXg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WBjA6JYzT6z20Cw5AvekfjJG0BeXM4klIABVClsqvucHI2PKPAX9dO9o1IfsEAHbGkXjxHB7y6zPiznl5UdTEvQQKm+KdUS8/k0tvMEHrlM+3vqChf4H4b4+KcWQmJtjnyedlYUJ5iyhmr6pvEFjvWHU9ABXdjKO6xAGPJ1tr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PViedXoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46CFC4CEE9;
	Fri, 23 May 2025 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748002956;
	bh=rW2jpoyMNgaGm8EWhJUy3TcoK0eOE2uriwlxOl2jhXg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=PViedXozxV4KuKw/DZvEgGhS4x+3hm6GJeKtSNKyfofJu0AlPWicnAIY59xH4EhxM
	 lqKUirX6LLaDstxlJ6SXebXeUAgMYIRHzdWKUzTx7C8AHTTxytwPjN6O4X+1MTk19j
	 9UT7RJnSenAI0ZId4k9h37k300K1gXhLKvqFfKTPdt0aJAw/FMiOqb+oWVQFepQYsR
	 l+EZU5u/TulUzNrrElYCmZt9WCwERA1zQVyQESL4snH2jkt/XsFZqspPfWK/ZN3uGS
	 S+JKrKbPJLPkKtrkzsBtx9kmLMJQr0Au5X7tLFRfyYCb9SoAE/ke/VqcbzwtFAcKPh
	 7HVnMyfAkT1ig==
Date: Fri, 23 May 2025 07:22:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, 
 Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alex@ghiti.fr>, dlan@gentoo.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, sophgo@lists.linux.dev, 
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
 Longbin Li <looong.bin@gmail.com>, ziyao@disroot.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, Michael Walle <mwalle@kernel.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
To: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20250523-sfg-spifmc-v1-1-4cf16cf3fd2a@gmail.com>
References: <20250523-sfg-spifmc-v1-0-4cf16cf3fd2a@gmail.com>
 <20250523-sfg-spifmc-v1-1-4cf16cf3fd2a@gmail.com>
Message-Id: <174800295404.1369155.8184258827735093868.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add bindings for SOPHGO SG2042


On Fri, 23 May 2025 18:54:49 +0800, Zixian Zeng wrote:
> Add bindings for the SOPHGO SG2042 SPI-NOR flash controller,
> which is compatible with SOPHGO SG2044.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-sg2044-nor.example.dtb: spi@1000000 (sophgo,sg2044-spifmc-nor): compatible:0: 'sophgo,sg2044-spifmc-nor' is not one of ['sophgo,sg2042-spifmc-nor']
	from schema $id: http://devicetree.org/schemas/spi/spi-sg2044-nor.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-sg2044-nor.example.dtb: spi@1000000 (sophgo,sg2044-spifmc-nor): compatible: ['sophgo,sg2044-spifmc-nor'] is too short
	from schema $id: http://devicetree.org/schemas/spi/spi-sg2044-nor.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-sg2044-nor.example.dtb: spi@1000000 (sophgo,sg2044-spifmc-nor): Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-sg2044-nor.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250523-sfg-spifmc-v1-1-4cf16cf3fd2a@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


