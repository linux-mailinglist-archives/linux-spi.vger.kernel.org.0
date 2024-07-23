Return-Path: <linux-spi+bounces-3932-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70CB939875
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 04:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D421C20CFE
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 02:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3313B599;
	Tue, 23 Jul 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAoNQ/v6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1571DA22;
	Tue, 23 Jul 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703450; cv=none; b=LzH//WkYKQerbXlc1nJXSbOQX94RdiNZUH+URh3GT+dopKXaL/rW/AKJdjNar7ZtSX2iKInwlzIpBelg3WkHo/AcHBiUwOuUQ2hKvwj5+m3gIhK5jQrZiRde6E/w6pFxFlUNawx4e6dLt2CDmv6zbHy/F2tZY2s/3joye+YsDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703450; c=relaxed/simple;
	bh=J5uFm6YqfgSpgo25bY/mnStZM9plVsz22J6NfkR13mQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IhQDqI8rHhpqqIZEj4h1R3smti9bwCzOcylV/7QnwcUC7dCdk5bgxcjbzGEaNhpWTXWoqeohdfQZY1J88tToP/DJwg3nSZpV5bQeY+BiQdjh9HZQEOfIsIFZat1oWwyK3/Hrbk/epF94LM8HXpofzLOK8OGezUIZN4aLyZQVRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAoNQ/v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062B6C116B1;
	Tue, 23 Jul 2024 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721703450;
	bh=J5uFm6YqfgSpgo25bY/mnStZM9plVsz22J6NfkR13mQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JAoNQ/v6N6aBGKUDl9pyh0FjyEna8BBPeXf3cG39rYzDc7oiCDuYcrhCi3IVO/BPE
	 cJ7M0dVkYOOP3YHiUOmh2NfWDVCVHBlctDzy/GS6SASfoyIJyHNLEhaMWkJ0xDFrxY
	 ySzwLWcGP5JTXxYXNu286nW68kdcxAydoCb0ujUnT58W0AvW3Ai11l9pyI/opZ/it8
	 j59fB0CgD2lC5fwTdWTKbNeLmuqLr7JO05BMPvq3s/nXLujgheVm2dwLOt3ShuGatV
	 uX9f8DWH+870jWzAupHSzHNE0NHAIrrEJIs/J2iE6tsyZWAVDTXYzdmQzZ2y/NCUO2
	 erNQhvHkiEcPQ==
Date: Mon, 22 Jul 2024 20:57:28 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: krzk+dt@kernel.org, broonie@kernel.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, otavio.salvador@ossystems.com.br, 
 heiko@sntech.de
In-Reply-To: <20240719111210.1287783-1-festevam@gmail.com>
References: <20240719111210.1287783-1-festevam@gmail.com>
Message-Id: <172170324289.205102.2615686187062234035.robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01


On Fri, 19 Jul 2024 08:12:08 -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
> 
> Add an entry for the "elgin,jg10309-01" compatible string.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Use a more specific compatible string. (Conor)
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
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


New warnings running 'make CHECK_DTBS=y rockchip/rv1108-elgin-r1.dtb' for 20240719111210.1287783-1-festevam@gmail.com:

arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: display@0: 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#






