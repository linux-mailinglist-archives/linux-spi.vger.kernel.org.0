Return-Path: <linux-spi+bounces-8610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A84ADBEE2
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3804E3AE459
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A81C7009;
	Tue, 17 Jun 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R42I15/W"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D51EB2F;
	Tue, 17 Jun 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750125600; cv=none; b=dkWdAgZMtD2MRcyIfjTeOH4tDVVao6fKYXm9RwgQb2m0xRiCw/kpMUoSpUJc0HbcrVz3KTZXO8aKZm23ECBjk8wVIUtuSHMQ8vcZgwdbfaiXqXSpNEfk8u8B0ye03Mu4Gsz1HeyZNoX/oEAAEgWoXaswTBY7I25ak3hiJx/Ju0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750125600; c=relaxed/simple;
	bh=8AHskTTSmpL1cVyJIzyA7INB00VBnp62zgkfDcOrtS0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lozVE6xaZRxUBVnLQtvWHY2TQ7cY/xV5NIPmteHAP1q26GUCBLv4G3oPDcO6blBxMdReHnpJGDeqVU0piiC0fTDd2II4MmiOFk99qbmPA8FZRhwkat5Lf/np/p1sMLcl50TQm1PCQI4wy6jaWd7bF6DD74X3UOCddctURKsg42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R42I15/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95901C4CEEA;
	Tue, 17 Jun 2025 01:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750125599;
	bh=8AHskTTSmpL1cVyJIzyA7INB00VBnp62zgkfDcOrtS0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=R42I15/WkdBn4FZ6+Rja1IQ1QOAbBCsq0EtRuDOa0VNQFd72Q2luG+ZgvHaRBitCV
	 hpwn65LydAI8h2a4EWCti/O9yGwt4nIAnihrfgZIFFXK21sX6zGK0n/zufBd14YgoE
	 kKn9sCOzipPfOS+0SwpHqmU4g4tolPPIuYq6q+Y1AM7xWT8S0Le0LULOwjQqbSliAS
	 c1kHdG1n65CtjzuSwURDdzuO/vkd+rlp7qxTJHutUkUA46iZfNzTjQm4AHhlAXX1YO
	 2J83Wwd8raNbgO3TXFTx5qmUGNjHEkTsHTLcIBV6uzyqpUDJEoJNxF/0qbobwZVYkP
	 tK4ZXnfGK5ZCg==
Date: Mon, 16 Jun 2025 20:59:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jinjie Ruan <ruanjinjie@huawei.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org
To: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250616220054.3968946-3-sean.anderson@linux.dev>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-3-sean.anderson@linux.dev>
Message-Id: <175012559872.3174543.9779809862801791863.robh@kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: spi: zynqmp-qspi: Add example dual
 upper/lower bus


On Mon, 16 Jun 2025 18:00:47 -0400, Sean Anderson wrote:
> Add an example of the spi-buses property showcasing how to have devices
> on both the upper and lower buses.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>  .../bindings/spi/spi-zynqmp-qspi.yaml         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:40.15-25: Warning (reg_format): /example-0/soc/spi-controller@ff0f0000/flash@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:46.15-25: Warning (reg_format): /example-0/soc/spi-controller@ff0f0000/flash@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:52.15-25: Warning (reg_format): /example-0/soc/spi-controller@ff0f0000/flash@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:39.21-43.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@0: Relying on default #address-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:39.21-43.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@0: Relying on default #size-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:45.21-49.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@1: Relying on default #address-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:45.21-49.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@1: Relying on default #size-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:51.21-55.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@2: Relying on default #address-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dts:51.21-55.15: Warning (avoid_default_addr_size): /example-0/soc/spi-controller@ff0f0000/flash@2: Relying on default #size-cells value
Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: spi-controller@ff0f0000 (xlnx,zynqmp-qspi-1.0): $nodename:0: 'spi-controller@ff0f0000' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/spi/spi-zynqmp-qspi.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.example.dtb: spi-controller@ff0f0000 (xlnx,zynqmp-qspi-1.0): Unevaluated properties are not allowed ('cs-gpios', 'flash@0', 'flash@1', 'flash@2', 'num-cs' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/spi-zynqmp-qspi.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250616220054.3968946-3-sean.anderson@linux.dev

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


