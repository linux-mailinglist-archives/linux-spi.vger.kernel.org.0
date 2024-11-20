Return-Path: <linux-spi+bounces-5768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C699D367E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A88B2214D
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CD1953BB;
	Wed, 20 Nov 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJNPQP8U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E216136A;
	Wed, 20 Nov 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093836; cv=none; b=po/RanqqrlfimhHipA9FXZBWmzZJ9k7vX/GTH0kMyV5YXF2+sPMCAEHjMM8i9wOm9HyXh73bZf3W14kvr+bbN1JucLl/Tj5p4APimjMAlZ11jv51rMs9bqYwlW5Or0YKBXrL7fk+qAdBHFKdx0kE968r35aIKDI0YRkhoIQAxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093836; c=relaxed/simple;
	bh=1jaJsKKteL7Dxc/ZzChtUpKlevAAkZGk4u0JO8qXnyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmbYUbaOcTzePsAK/QFJyZ/aaYgeT96u2w0tsdd6PdltRq/ujeOGXOWu0Rgn5WI64tPYcjJttW+4mNIyyzjFM3P435N6wiL9WT9cHT5T1JJyGKtxxD+p3XilvZWvo0tt5KzCR+fHpe+LcFJ1jUC52eEvWAQ0yyKKGOGFak58PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJNPQP8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7D8C4CECD;
	Wed, 20 Nov 2024 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093836;
	bh=1jaJsKKteL7Dxc/ZzChtUpKlevAAkZGk4u0JO8qXnyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJNPQP8UGS9y+f6JhF/4MX8qu2oPIklJkzHRwsKj/Oy3v+YBstHyeVr4rXP/7r0Cs
	 eKVJiPu+ipywRwip5oqqzwdRM7xlbvEoNsc2oLyCM5yj4hMqUxOkw2kn3etYApzuHt
	 gAkqtK5xqaUDJAqOBKwD1f+zJfqTfyvenJjCShF+ULsPjxWTsiiir1EajZS2ESTTSt
	 x5gsxsw6vGc1OhdNqmC/pQsuPL2sn9zV6cEDBp9zRq7gK7kNDKkBPUZWzQS5RbPXC1
	 /tfYCLoxKAkUzb5/ejG30rrJguZbAGkya44zn8NaoQsFI7CJPWLLyPPVPTbzMTrOel
	 +8DmOulLDgW4g==
Date: Wed, 20 Nov 2024 10:10:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 11/15] ARM: dts: microchip: add sama7d65 SoC DT
Message-ID: <ishcitppbc7asngzpp5dl3htkitxpeu3dgtmz44swcg2h7dmup@zc2etw2hrsbg>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <1006a1e4464ef7c46b33ad44bf71b3143283ee6e.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1006a1e4464ef7c46b33ad44bf71b3143283ee6e.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:17AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add Device Tree for sama7d65 SoC.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Co-developed-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Totally confusing SoB chain. Please read carefully submitting patches.

...

> +	clocks {
> +		slow_xtal: clock-slowxtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		main_xtal: clock-mainxtal {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	vddout25: fixed-regulator-vddout25 {

s/fixed-//

> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VDDOUT25";
> +		regulator-min-microvolt = <2500000>;
> +		regulator-max-microvolt = <2500000>;
> +		regulator-boot-on;
> +		status = "disabled";
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pioA: pinctrl@e0014000 {

labels are lowercase.

Best regards,
Krzysztof


