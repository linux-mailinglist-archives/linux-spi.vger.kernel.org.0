Return-Path: <linux-spi+bounces-3669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B54191C2CB
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD49281AE1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DC1C8FCE;
	Fri, 28 Jun 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usZKn8ub"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5041C8FC7;
	Fri, 28 Jun 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589316; cv=none; b=rUp9aUtoH/axD80nHRPiYij53dtvImm2EgztSMsjqvpg+E6EQI/Vz3Ew8+kPEzqmf8JsEonwYm4g7W3WgPMeGcyXa42GkIWdmZExHpD512n0HcpGRWqHbu2pokWSIlnagoEJ4JvIi4ZQcKu4L4uH6F2AolZ38ZLBPexG1/TOUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589316; c=relaxed/simple;
	bh=T4tC/wd1+KKqOpJZBz2HrYj7aKSI0GXuQI2ivtJL58U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ibrCyeMMK+mZ9QpoL+bSAEBt4UJWyrNlMBF6Ri+PV/bMzRTkwaOjcSLVdrXtxYij/qurXBrL2frReB/dj8sLJYR7Dwmby9J+rjJvD0kXIGVo9I+ibMM/ImfTlNhzoc+4XpxJXudHbPFnxkQP19DOHmLQx3SCfqJYzwSeZw1pFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usZKn8ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20929C116B1;
	Fri, 28 Jun 2024 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719589316;
	bh=T4tC/wd1+KKqOpJZBz2HrYj7aKSI0GXuQI2ivtJL58U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=usZKn8ubQyj+vExmAcxWIHJ+tbOEzNyFjf42HpmSZ7dDTkMZ5w0iJfAnG3EBl6nXE
	 g8woDniDiQfdSEmyUDqSSzcoSX0OuUoUQZHXrJYLP79dSyY7cxhYFeXi+ZtXAVy8w2
	 RAuLnLJXw0r8vTJiBy1lcQAxz/AJLOaFR/X3XhIxegbCqzUVAITCoxIJyzr/LzZqP8
	 UzM0TgecJJaVO6KPemQmHpWG1qsOshmLQFNxZjOJ5MuqY8EGmh/YyOZRwM9nmq+9Pi
	 A5MqBtD4UXnf0Z70N/Ch5PU+OSxuReXesH+KVM3qcwLsUnJjENWMkce5Mw8KLdUx8x
	 +JCAfRxuL16RA==
Date: Fri, 28 Jun 2024 09:41:54 -0600
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
Cc: Vaishnav M A <vaishnav@beagleboard.org>, 
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, linux-spi@vger.kernel.org, 
 Ayush Singh <ayushdevel1325@gmail.com>, 
 Derek Kiernan <derek.kiernan@amd.com>, Nishanth Menon <nm@ti.com>, 
 linux-kernel@vger.kernel.org, robertcnelson@beagleboard.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Mark Brown <broonie@kernel.org>, jkridner@beagleboard.org
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
Message-Id: <171958904576.3122814.2779636107904629907.robh@kernel.org>
Subject: Re: [PATCH v5 0/7] misc: Add mikroBUS driver


On Thu, 27 Jun 2024 21:56:10 +0530, Ayush Singh wrote:
> MikroBUS is an open standard  developed by MikroElektronika for connecting
> add-on boards to microcontrollers or microprocessors. It essentially
> allows you to easily expand the functionality of your main boards using
> these add-on boards.
> 
> This patchset adds mikroBUS as a Linux bus type and provides a driver to
> parse and register the mikroBUS board using device tree infrastructure.
> 
> The patchset is based on work originally done by Vaishnav.
> 
> Link: https://www.mikroe.com/mikrobus
> Link: https://docs.beagleboard.org/latest/boards/beagleplay/
> Link: https://lore.kernel.org/all/20240317193714.403132-1-ayushdevel1325@gmail.com/ Patch v4
> 
> Changes v5
> - Complete rewrite to use device tree instead of mikroBUS manifest.
> - Only support for SPI.
> - Adds `mikrobus,spi` compatible property.
> 
> Changes v4:
> - Better commit messages
> - Remove clickID, serdev, pwm, regulator, clocks etc. Just the basic
>   mikroBUS driver.
> - Fix a lot of memory leaks, unused variables, etc.
> - Create accompanying PR in Greybus Spec repository
> - Switch to 80 columns formatting
> - Some other fixes pointed out in v3
> 
> Changes in v3:
> - Use phandle instead of busname for spi
> - Use spi board info for registering new device
> - Convert dt bindings to yaml
> - Add support for clickID
> - Code cleanup and style changes
> - Additions required to spi, serdev, w1 and regulator subsystems
> 
> Changes in v2:
> - support for adding mikroBUS ports from DT overlays,
> - remove debug sysFS interface for adding mikrobus ports,
> - consider extended pin usage/deviations from mikrobus standard
>   specifications
> - use greybus CPort protocol enum instead of new protocol enums
> - Fix cases of wrong indentation, ignoring return values, freeing allocated
>   resources in case of errors and other style suggestions in v1 review.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
> Ayush Singh (7):
>       dt-bindings: connector: Add mikrobus-connector
>       dt-bindings: mikrobus: Add mikrobus board base
>       dt-bindings: mikrobus: Add mikrobus-spi binding
>       spi: Make of_find_spi_controller_by_node() available
>       spi: Make of_register_spi_device() available
>       mikrobus: Add mikroBUS driver
>       dts: ti: k3-am625-beagleplay: Add mikroBUS
> 
>  .../bindings/connector/mikrobus-connector.yaml     | 107 ++++++
>  .../bindings/mikrobus/mikrobus-board.yaml          |  20 ++
>  .../devicetree/bindings/mikrobus/mikrobus-spi.yaml |  37 +++
>  MAINTAINERS                                        |   9 +
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |  94 +++++-
>  drivers/misc/Kconfig                               |  16 +
>  drivers/misc/Makefile                              |   1 +
>  drivers/misc/mikrobus.c                            | 361 +++++++++++++++++++++
>  drivers/spi/spi.c                                  | 209 ++++++------
>  include/linux/spi/spi.h                            |   7 +
>  10 files changed, 750 insertions(+), 111 deletions(-)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240627-mikrobus-scratch-spi-ad8c98dcec98
> 
> Best regards,
> --
> Ayush Singh <ayush@beagleboard.org>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y ti/k3-am625-beagleplay.dtb' for 20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org:

arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: mikrobus-connector: mikrobus-gpio-names:6: 'mosi' is not one of ['pwm', 'int', 'rx', 'tx', 'scl', 'sda', 'an', 'rst', 'cs', 'sck', 'cipo', 'copi']
	from schema $id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: mikrobus-connector: mikrobus-gpio-names:7: 'miso' is not one of ['pwm', 'int', 'rx', 'tx', 'scl', 'sda', 'an', 'rst', 'cs', 'sck', 'cipo', 'copi']
	from schema $id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: thermo-click: compatible: ['maxim,max31855k', 'mikrobus-spi'] is too long
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: thermo-click: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: thermo-click: Unevaluated properties are not allowed ('compatible', 'pinctrl-apply' were unexpected)
	from schema $id: http://devicetree.org/schemas/iio/temperature/maxim,max31855k.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: lsm6dsl-click: compatible: 'oneOf' conditional failed, one must be fixed:
	['st,lsm6ds3', 'mikrobus-spi'] is too long
	'st,lsm6ds3' is not one of ['st,asm330lhhx', 'st,asm330lhhxg1']
	'st,lsm6dstx' was expected
	'st,lsm6dsv16x' was expected
	'st,ism330is' was expected
	'st,asm330lhb' was expected
	'st,lsm6dsr' was expected
	'st,lsm6dst' was expected
	'st,lsm6dsv' was expected
	'st,lsm6dso16is' was expected
	'st,asm330lhh' was expected
	from schema $id: http://devicetree.org/schemas/iio/imu/st,lsm6dsx.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: lsm6dsl-click: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/iio/imu/st,lsm6dsx.yaml#
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dtb: lsm6dsl-click: Unevaluated properties are not allowed ('compatible', 'pinctrl-apply' were unexpected)
	from schema $id: http://devicetree.org/schemas/iio/imu/st,lsm6dsx.yaml#






