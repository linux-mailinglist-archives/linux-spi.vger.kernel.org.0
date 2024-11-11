Return-Path: <linux-spi+bounces-5682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C274F9C46FC
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 21:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8331F2200B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088011AF0A1;
	Mon, 11 Nov 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+ImfXkP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201213A250;
	Mon, 11 Nov 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357485; cv=none; b=hvsUtYEtxNQeSPuzh+F+Uyi41O9A3olZvJPdtvl7f25qmoi3+ZAHBjSfmjzxpreCuLqaum1UtzT4Nnq7B0xVQuspRdmYP1w91IK/XTWpRwuY2ck4MV23trhlr2dCGGa4SIIJRbnvx/Jyu7YWkGRic7fUtED2OhDb7mwjbfiCEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357485; c=relaxed/simple;
	bh=KwaHLfJUIhXroumjHZ4bZlkQwpn6earNMC5wOJS8F3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFADYrDxMPf4jNRC2/mBNmkm5OneZ4v4o3BQt+lWljIJYZRuOPN2aV6xP3FRh3jnVUBMAlji85qoeC9WLwTt21tkE/abRNfmaPv3RTYguAj0DMJ3PrwS3Nyu6LZHOfRXYP89KUX7JNwaK0GY6mQjKfZv8YlxK2k1AuAT0wn38y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+ImfXkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D41CC4CECF;
	Mon, 11 Nov 2024 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357485;
	bh=KwaHLfJUIhXroumjHZ4bZlkQwpn6earNMC5wOJS8F3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s+ImfXkPI1O4CAQC7LGmSngp4INKqyeJCveS2DSuVJVX1UgzHimen+i0RyVKBvEk6
	 hQN4Z9wDYJzrqvLNKWD7+hhjC761myQjPqeqfGAb9PwqGcW0JzjQF8UtGdneSpGBho
	 qitioKlKlvo5kwuGk61r6IeO/Ve+XjrpQkXg+xWY1vizwq/d7F2ZpCLLBMUKfQMqWK
	 bYiq2qedk57RKVeHa6XzX+cOI7Qsjr2GqkiJ17Jwl/dCS77Foo2Qhla7+yuLsWyC/+
	 3A8d2XysWw8y7QiUgl3smDorGRCHuTQ+0t54NHPTGgJqXGgciIoN6HKu0R7Il42VPM
	 t12XXSrSSZFCg==
Date: Mon, 11 Nov 2024 14:38:03 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: add compatibles for mt7988
Message-ID: <20241111203803.GA1917413-robh@kernel.org>
References: <20241109105029.52748-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109105029.52748-1-linux@fw-web.de>

On Sat, Nov 09, 2024 at 11:50:28AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> MT7988 has 2 different spi controllers. Add their compatibles.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index e1f5bfa4433c..ed17815263a8 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -35,6 +35,8 @@ properties:
>            - enum:
>                - mediatek,mt7981-spi-ipm
>                - mediatek,mt7986-spi-ipm
> +              - mediatek,mt7988-spi-quad
> +              - mediatek,mt7988-spi-single
>                - mediatek,mt8188-spi-ipm
>            - const: mediatek,spi-ipm

Does the fallback make sense for both? Is there some common subset of 
functionality where they are the same?

Rob

