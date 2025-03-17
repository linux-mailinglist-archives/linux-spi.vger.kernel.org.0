Return-Path: <linux-spi+bounces-7162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FFA64A6F
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 11:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA941887D90
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA524166D;
	Mon, 17 Mar 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsDWmFcu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3D236A84;
	Mon, 17 Mar 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207694; cv=none; b=nkU8tpS48XVnmJBxm7PjPly/RTKy2AtGluqL/qP/yi0TXU3wKrv6u0xQVbVJdTWrxp8EDNdQe4vNfEyWK7cFRPgbkX19Yj6Nnskn7P9aUzPGPLCjY794NV11wN38GzCGRPsEYn8uIJm/4nMNkq6pmq4L7PTQ6WPQGWRPyzfCQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207694; c=relaxed/simple;
	bh=OOWMoUFQ23UHSwIZ8BvygHyrXX9kthpv+6WpnSx7ZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/1P5PRAAEHH/sV/6jwI8S5isnLgedFEb5ZNZ/YDO1LEAaAKR44kIBZxNzq6wH2nW4bZqzB/bBlpgQvy5FhrbcWFfTqMbVUCGOkJzYGp7aNuYZuCQnfqAbi8ISCO9P5dtl71nbuRQR+ziasY2ZSRXTB99BdMxZ94D06RXnO6DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsDWmFcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0ECC4CEEE;
	Mon, 17 Mar 2025 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207693;
	bh=OOWMoUFQ23UHSwIZ8BvygHyrXX9kthpv+6WpnSx7ZNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsDWmFcuxcsgFxG+2Q5SuxHmU93c+w9J/18L5YmxK5aviJm9Z4CUyWBrYiSnWqV2e
	 C7GP8NTC6GV+/vET79P68p6yY4ndZ77nM5Qidg/EocBZRxEpLykxoK52Qq3XaAkOy8
	 KTPXVZOgV5u7aBCFQwCMzMYJxlcldpTrsKgAJlR/4Ny0tx9C890MZIKAAdjizTMV9L
	 VrzNMUMRwumMFNEbDQb1XVLR029YxilgVYa3urlPcqLBoCkLCcynRiwEcK+k2UfCEX
	 T3oAWZCtEW8lZXjXHG9Md0KYqU91/xx4AAldISNUrDm8p8IZVEkSfRfduUQb3z1dPp
	 B3NA64lusvwwA==
Date: Mon, 17 Mar 2025 11:34:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
Cc: Rob Herring <robh@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] dt-bindings: connector: Add the GOcontroll
 Moduline module slot bindings
Message-ID: <20250317-massive-calm-bat-43ff61@krzk-bin>
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
 <20250226-initial_display-v2-3-23fafa130817@gocontroll.com>
 <20250314210652.GA2300828-robh@kernel.org>
 <PA4PR04MB7630094413C8E1F3D715EE23C5DD2@PA4PR04MB7630.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PA4PR04MB7630094413C8E1F3D715EE23C5DD2@PA4PR04MB7630.eurprd04.prod.outlook.com>

On Sat, Mar 15, 2025 at 07:32:28AM +0000, Maud Spierings | GOcontroll wrote:
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reset-gpios
> >> +  - interrupts
> >> +  - sync-gpios
> >> +  - i2c-bus
> >> +  - slot-number
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/gpio/gpio.h>
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +
> >> +    spi {
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        connector@0 {
> >
> >I find this being a SPI device a bit strange. Is there a defined SPI
> >device that every slot is going to have? Or the connector has SPI
> >interface and *anything* could be attached on it?
> 
> So a module slot is like a pcie slot, it can be occupied or not, and when

But which buses...

Best regards,
Krzysztof


