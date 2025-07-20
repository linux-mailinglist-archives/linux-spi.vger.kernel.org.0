Return-Path: <linux-spi+bounces-9140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF73B0B8E0
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 00:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB8C177D74
	for <lists+linux-spi@lfdr.de>; Sun, 20 Jul 2025 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0061E3DDE;
	Sun, 20 Jul 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+0e0fqW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624013BB48;
	Sun, 20 Jul 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050892; cv=none; b=LE2Avul+Wa+73Unx2n0OZigSJdVkWR75Fldxc9YhM9ty7a6cDifSONkQeOxAQfhMilNS4AMUtzKHlVcz80rvSPVS0l5qlKdzezje0gS7v96vOHGUk8g9PEb35VjJXKoDsqtDCF1sARHynHTkZ8F7S0ayQBfFfm3wwkmYDThuahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050892; c=relaxed/simple;
	bh=MRccUioWmEokYe39hVS4NwT8VcEut9wQ1VPK++J3drI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8jktcG+X0mQWhp7u/xqxPAteXJORlw0atIeqok1LiyynADrtMHlQ8jQ5WvoX059N0nKbWFauijcItcsZ+Wa8XKst51kAY3vIULQi9fW32JNyqIUcZ/X77XS2zX18d+rbr2/e9NM0QOpd+YelSklfa8d0v3p2QntzpMuG+A/5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+0e0fqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C165CC4CEE7;
	Sun, 20 Jul 2025 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050891;
	bh=MRccUioWmEokYe39hVS4NwT8VcEut9wQ1VPK++J3drI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+0e0fqWFsyowkUGbh5SkDx49D4KIt/ItmgkDqjkcdcaGnrrm5wwUXc+ttKKyzjlp
	 qHTMiSzd0+IYOzLXIMJAJkyzFSQxp3/zFdpgSrstSGqb4+M8zvPAnncCH/eE5AmmF2
	 d6nqKdIhmOVVJGIHwBOB0pubiP0G+NSLwoh5j5O3lNQ+bEyeGXiTzA+p5ZpHPlGJlZ
	 lKVHW2bgfT2I/LSYqNOLssiX9S4xo94oBf9MgT3/OP1rN19few7MEM95UY3QdjaryG
	 tlueu7znlS6RS3E5lNXMRdqpBEZHrgyOJkGlucpWZDCKmWB/Ub1BwI9qeop+XLCbHV
	 +XLEfEgIq3uAQ==
Date: Sun, 20 Jul 2025 17:34:51 -0500
From: Rob Herring <robh@kernel.org>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v1] dt-bindings: spi: mt65xx: Add compatible for MT6789
Message-ID: <20250720223451.GA2915764-robh@kernel.org>
References: <20250715231921.4527-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715231921.4527-1-me@adomerle.pw>

On Wed, Jul 16, 2025 at 03:19:21AM +0400, Arseniy Velikanov wrote:
> Add a SPI controller binding for the MT6789 SoC. As a note,
> MT6893 SPI is fully compatible with this SoC.

Then you should have a fallback compatible. Otherwise, there is no 
driver change here, so how would this even work?

> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 3bf3eb1f8728..0635aec29aae 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -49,6 +49,7 @@ properties:
>                - mediatek,mt2712-spi
>                - mediatek,mt6589-spi
>                - mediatek,mt6765-spi
> +              - mediatek,mt6789-spi
>                - mediatek,mt6893-spi
>                - mediatek,mt6991-spi
>                - mediatek,mt7622-spi
> -- 
> 2.50.0
> 

