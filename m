Return-Path: <linux-spi+bounces-8865-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECD6AECBF4
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1070B189266D
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1DD213259;
	Sun, 29 Jun 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwTv7Wua"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA117A30F;
	Sun, 29 Jun 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751189364; cv=none; b=TFTi+ampD1+fGRcGy3OuOWLBAQT2u8JPbK/Hi8bbAaVZe99uJB25Xeh/bfZgQF8WCsvVBkZO/Crgfy5322e8s8kTJm9XWXcc86Z18c29MaWPCXQRTcZueysKxqHGCyywZsUAIQx4l291EiPzC8xPYJ9par8RYLW9rl8daPVt1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751189364; c=relaxed/simple;
	bh=hW2QT0dkXHNl3tJf1s4Ivv7cRC7FzorVHdUtVP/XD58=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FgzN1irwTn2rNTP0OCO6fQCS9A1tea4wK0S2pIKzztlDrazf94crPubsGRsSVZ3TnF7ptF3CELv4XIp3xXedjvFU3+TRpYzIYqbaRz5c4r2unsxg46aqsSZ6UjYRZk6oK0CmQFPDPGHEajMqF3GCRT3iJZYsSdS6mePmZtZYedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwTv7Wua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBA4C4CEEB;
	Sun, 29 Jun 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751189364;
	bh=hW2QT0dkXHNl3tJf1s4Ivv7cRC7FzorVHdUtVP/XD58=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YwTv7WuafqwCkunNtrXOesosznuhC5eF/imeYJpm3lQKQAQCm4JkUwc8hwxLOwqFJ
	 71sGELzn7Rc4cdspQS1ORwB7xmXWw8P7uc9Wje+2MT5w7xmZ3u4aYVleNEruEhrCmL
	 Myzf0Nn2NRjtZw8U2Z8SJ42AZpJab8ruxFtHeI1l4QPeYApGu6bd/EwKFoG+xP0Vgn
	 6cvcmRIJBJKS8arBIBlxpun1+nrcewqr1AMjGGdy1NDMPL6+8lfMFzzJPlnPG+lE5i
	 9GaLf/WEXftPRNO9l31RBM0tu9L0JQWWPgGeW4zpDSIhIF/C5FWXYYldlt0N50cudA
	 aUXXIufEacNsw==
Date: Sun, 29 Jun 2025 04:29:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, sophgo@lists.linux.dev, 
 Palmer Dabbelt <palmer@dabbelt.com>, Mark Brown <broonie@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 Michael Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@gmail.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Longbin Li <looong.bin@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
To: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
References: <20250629-sfg-spifmc-v3-0-28db1f27e999@gmail.com>
 <20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com>
Message-Id: <175118936320.3838715.11903647701453583408.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] spi: dt-bindings: spi-sg2044-nor: Change SOPHGO
 SG2042


On Sun, 29 Jun 2025 16:23:10 +0800, Zixian Zeng wrote:
> SG2042 is not fully compatiable with SG2044,
> So it is necessary to become independent const
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml: properties:compatible:oneOf: [{'const': 'sophgo,sg2044-spifmc-nor'}, {'const': 'sophgo,sg2042-spifmc-nor'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250629-sfg-spifmc-v3-1-28db1f27e999@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


