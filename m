Return-Path: <linux-spi+bounces-7050-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F50A5453A
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C759167D5D
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20371207A34;
	Thu,  6 Mar 2025 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoOPJpKo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB26207A04;
	Thu,  6 Mar 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250588; cv=none; b=to1T98r2lZYgdhy5kOqb4pno7dmGz5jgD2iWag97qGHkalPK6S16B5NdyPYyIWqgEcawd26SJliAZn7LIBFwCRujX4A2x98x1ZO/oY8f+OUbFHoMn87Pd1RHphqjoXDNclRyNKvJA0WThcyt87982GuH/cvmp8UdSfOygEqqQ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250588; c=relaxed/simple;
	bh=Ho3+uaCNgLw/vnUKPzl1fBmRKb9nnYfx5GgZC3XDXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBj6NWStZH912aKGNm5HLsWslvMrhyvdBfSVYuZZ0Yo8u4ddvXMkTlEnrRGY2jk2fTc0MGncO3HnpB8zTvEj5kHInrrG00fbQkRQVaCAhi4vMak9yvrx1GuSzcbvE1k+ndZIbbvU1XzsPqgzLB9QBxHVaY2wy5ZCD7fVmvnX5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoOPJpKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECC4C4CEE0;
	Thu,  6 Mar 2025 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250587;
	bh=Ho3+uaCNgLw/vnUKPzl1fBmRKb9nnYfx5GgZC3XDXI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoOPJpKoce9vQ9FC/9jtw/iLyy7GtYUVSmMcqRewrSRyVa9zxu83p5EwX2MQmDpau
	 pKQEd9yYsREu5LGwqgIzwmfMRc/0eW/Cub3k8E4n7+khbWz1NRNMQSc3+jXEEH5YIM
	 uTQA9BqHs3a7A7fxoXVIL2ahT1cRKVriw1FspzjgsasNRQlbDMxEas7rcOKzqO1TEQ
	 g9kpXv2Upx59tvbHU3os9A+LiLSircxx78Q/bWaqOqL2pk2Vx24DSK9zIVD3ZSxFE8
	 oRvJ68TgkFrs6AF4eJkkJhdbzfemGCbUqZYojvEmavK4SAF95qNsO85avfxwnJsaID
	 zVgyCzMUbdqFg==
Date: Thu, 6 Mar 2025 09:43:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the
 Cadence compatible alone
Message-ID: <20250306-glossy-quaint-crow-dafbe0@krzk-bin>
References: <20250305200133.2511308-1-miquel.raynal@bootlin.com>
 <20250305200133.2511308-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305200133.2511308-3-miquel.raynal@bootlin.com>

On Wed, Mar 05, 2025 at 09:01:32PM +0100, Miquel Raynal wrote:
> The initial SPI controller IP from Cadence has always been implemented
> into controllers from various hardware manufacturers and because of
> that, it has always been (rightfully) doubled with a more specific
> compatible. There are likely no reasons to keep this compatible
> legitimate, alone. Make sure people do not get mislead by officially
> deprecating this compatible.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index c4315b2e04f2..0104cc5283db 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -81,6 +81,7 @@ properties:
>            # ie. also NAND flashes, not only NOR flashes.
>            - const: cdns,qspi-nor
>        - const: cdns,qspi-nor
> +        deprecated: true
>  

Please update the example, so non-deprecated device will be documented.

Best regards,
Krzysztof


