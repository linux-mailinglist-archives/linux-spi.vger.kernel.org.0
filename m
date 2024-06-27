Return-Path: <linux-spi+bounces-3649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1DA91AF8D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 21:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BF31F22A32
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830A41760;
	Thu, 27 Jun 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnxGjJzF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E362EAEA;
	Thu, 27 Jun 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516067; cv=none; b=p6yiCVR24bGVyEwI1cDXhR+hl1hKQFuU2JRlMXkavnf9oTY/aIVL4sBzfXCQtNGhrGK+JX03+oYzoTn3RzJOfJzwApmBoyMXxlcKZwpjBi9odQVrxcGawsYBE4dL3gCc8OaPhGyn4To9nGW0T2fKa/xCl0catpqDCB/lyo9WduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516067; c=relaxed/simple;
	bh=FOryD7S+p5aFAtNfP8udQczJBOpLw1MnsDwuV4JfYbk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dOlrn1sodz5a5Enbul061nWdjNkyUp3avGPw8gUCRofNPGy5NsBaDyArMaCK/gwOvkcbFBqigUz7qcXHlDduWjA3CgUM44zMA8AafxymM9AHCSOcQCy8xR1YGvHNEyfGFJgDtrQNU1iCh2JJFm0OwPpQZMyZkfvwY80XeOfGskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnxGjJzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F05C2BBFC;
	Thu, 27 Jun 2024 19:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719516067;
	bh=FOryD7S+p5aFAtNfP8udQczJBOpLw1MnsDwuV4JfYbk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rnxGjJzF8XxkpTx+dlI9ryECW9TLz9KVDTjv5lq5zjloUmY9HLXAoMPCNgP9WJt82
	 wMh/yHKfJiWzVA9IgsSVnYYc6vAOecjn0mxaKehy0ykVpUMcvUodDEX3v5mIxhT6Oo
	 vd6TEVWnvCJPqDgbJV0JoTMg6EXGQpTpBPIW+5J68Z3DCQ9dLXmmSVKVNO7fQfeqgU
	 EdfyiaztSl3Ab+H829rfpZigtyX0QvTIWZFYmSez2ZkI5ioEyK65eeHMZ+1FDz1iNI
	 iwcrWMUKPxXAJTC07wnQAFxAXrc9erFcse920mr56wBaP9HPjKRU37HUGQenlZKxqm
	 5K3IF9Ei1LUQA==
Date: Thu, 27 Jun 2024 13:21:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, 
 jkridner@beagleboard.org, devicetree@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
 Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Nishanth Menon <nm@ti.com>, linux-spi@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 robertcnelson@beagleboard.org, Dragan Cvetic <dragan.cvetic@amd.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Vaishnav M A <vaishnav@beagleboard.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <mwalle@kernel.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
 <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org>
Message-Id: <171951606546.381506.1857123060155544778.robh@kernel.org>
Subject: Re: [PATCH v5 3/7] dt-bindings: mikrobus: Add mikrobus-spi binding


On Thu, 27 Jun 2024 21:56:13 +0530, Ayush Singh wrote:
> Add bindings for MikroBUS boards using SPI interface.
> 
> Almost all of the properties that are valid for SPI devices can be used
> except reg. Since the goal is to allow use of the same MikroBUS board
> across different connectors, config needs to be independent of the actual
> SPI controller in mikroBUS port(s), it is not possible to define the
> chipselect by number in advance. Thus, `spi-cs-apply` property is used to
> specify the chipselect(s) by name.
> 
> Another important fact is that while there is a CS pin in the mikroBUS
> connector, some boards (eg SPI Extend Click) use additional pins as
> chipselect. Thus we need a way to specify the CS pin(s) in terms of
> mikcrobus-connector which can then handle bindings the actual CS pin(s).
> 
> Link: https://www.mikroe.com/spi-extend-click SPI Extend Click
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  .../devicetree/bindings/mikrobus/mikrobus-spi.yaml | 37 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 38 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.example.dtb: thermo-click: compatible: ['maxim,max31855k', 'mikrobus,spi'] is too long
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.example.dtb: thermo-click: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.example.dtb: thermo-click: Unevaluated properties are not allowed ('compatible', 'pinctrl-apply', 'spi-cs-apply' were unexpected)
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
Documentation/devicetree/bindings/mikrobus/mikrobus-spi.example.dtb: /example-0/thermo-click: failed to match any schema with compatible: ['maxim,max31855k', 'mikrobus,spi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


