Return-Path: <linux-spi+bounces-9850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CBAB3FA1C
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638CA16D525
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F62EA16B;
	Tue,  2 Sep 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eod2bVdZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7D2E9EA9;
	Tue,  2 Sep 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804907; cv=none; b=JPLjs86HeTKOyP45b7YCJP1Jd+ut2RbBjMj03ms1X6R5jZjg/pmAmUS3KY/DQQh2JPA4bg2ODsvZkhLNpQyAf6ctRG2MhtxwXRTuFiDD+X+S8uvBS/2Xc07580gwWQysG8+uWIXeAI0Yjh3V20PuYjf1fg6Ka5cMgtN9yAHwAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804907; c=relaxed/simple;
	bh=HUiiWQDITg8+MQmQcEFhCfgm6csIP75981a83wPC3pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPVmmJYVm2K4AmBRpU1y6jq62GQpjfJvfvbTboxEVFxdsYpq1kQYjItRz5xV2jWjpgOpS/1GxsE2zk2WZ9o4jgfJVNbQX0l571xBNDTkh5DhfTHnIdE9lUz5fiMx3t8tHagRnJvWAWE/bg237NshLW8RfWKW5tF6m6nSNAa3rHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eod2bVdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2624DC4CEF7;
	Tue,  2 Sep 2025 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756804906;
	bh=HUiiWQDITg8+MQmQcEFhCfgm6csIP75981a83wPC3pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eod2bVdZA1JoFnBpSlGb1uMtFbmpo/S/3ll6IHa3mIRnUT710Ldv3oYumW7C7bXp0
	 X7ZQ7eeLbYKbuhvYxs0Tm5/o3C2Hc2NgdU6aFyIpgqXmxTA2Hstdwgx0Sd6JeY07pb
	 QE97kDpMCLIWNZqiHPDHa1D6nvT8EJWhMdhKaYWMfy8e3xdi0LncKk83CrT1WGWYAB
	 ZMW9eYATgQMhKpsi0Fow5oX+NDHBNSd1LMYZ4pJ5V96ii1Ov9wzeGTK9ndR3W3T8ia
	 ExRT+VZC4Ed55yDJIVTF6IeSOok7n0XCfbClwBF0VtBM7NcGgJR2aAgLScmQ3hdC86
	 kI9EhS6ixVPqg==
Date: Tue, 2 Sep 2025 11:21:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Message-ID: <20250902-macho-violet-orangutan-faac78@kuoka>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>

On Tue, Sep 02, 2025 at 11:22:18AM +0530, Dharma Balasubiramani wrote:
> Document the sam9x75 quad spi that supports interface to serial memories

9x75 here...

> operating in
> 
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI
> - Single Data Rate or Double Data Rate modes
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
>  Documentation/devicetree/bindings/spi/atmel,quadspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> index b0d99bc10535..c17114123034 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - atmel,sama5d2-qspi
>        - microchip,sam9x60-qspi
> +      - microchip,sam9x7-ospi

... but 9x7 here. Confusing.

Best regards,
Krzysztof


