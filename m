Return-Path: <linux-spi+bounces-12058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB457CD2C4C
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 10:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B859301176D
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E4302773;
	Sat, 20 Dec 2025 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+pY4w9H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764A22FA0DB;
	Sat, 20 Dec 2025 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766223361; cv=none; b=HOR8Gl4iS+zwD0de2cLTIgVWPGgze9VD6gkTBxaEM5EpMRewGMkvFbTkVa5ir2prQa3LPeqzmqcgRCznwLmujSmvqv1lAcnI1U7Qqs1ZgDbmbzpFCcZDaljxpjeSbdWQ6M4Jv99ETzCbRym7F2xvKQS5KNsUeVZfcFGX6AUNjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766223361; c=relaxed/simple;
	bh=OLnLlx4v/AIwvRcwbXZaYDlKruE1sfOVkuJwxYp+QPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwaLaKw6JVqgzAFOo4ZRLc/nWJ2yKmHZrHM1vr0UvDe2wnnkmpT3Jft9WZ0cvAz01LKhzQV546xaR+azD2VKi18AUdCXMLSuq3OF539Pbu+PHN9CX56wa34ljvfXa63uKNDeozjWZvupC4NciD0sIswMVYhh4x78buR0vZ3EZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+pY4w9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BB1C4CEF5;
	Sat, 20 Dec 2025 09:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766223361;
	bh=OLnLlx4v/AIwvRcwbXZaYDlKruE1sfOVkuJwxYp+QPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+pY4w9Hvd5FUbuJ+ZRmcXX2WNziypRgOlzHjASYcFTnSrOCPcKuogOj0Y/f890bb
	 ErK5bT/+96bFrEJ+A+2MP9IApmrtwbQ4zxF4mTM4mHv7vEDOwJeukKM1JYD59LAChy
	 MZbySzTor3sM6rfg6HUh75+OANhOLP10nnUUfaLc/vjN32qyu1GdjQkXOtsNQtSJ+U
	 Csx7Wu/sQlN6zF2d0/XU8xXZ6uBfhH6loiYAdf/1Y658lJOHBWN0HvHF54KfJvMqqY
	 ZXHy8yAy/F92adZJ6p7cgwHWo2TAg1pXsAr5daDXrPgEqgSmyFUas407tur0cf9JFl
	 0FMvh4rC8nUkg==
Date: Sat, 20 Dec 2025 10:35:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Vaishnav Achath <vaishnav.a@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Message-ID: <20251220-sexy-feathered-gorilla-3a6aab@quoll>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
 <20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>

On Fri, Dec 19, 2025 at 08:22:03PM +0100, Miquel Raynal (Schneider Electric) wrote:
> Add support for the Renesas RZ/N1D400 QSPI controller.
> 
> This SoC is identified in the bindings with its other name: r9a06g032.
> It is part of the RZ/N1 family, which contains a "D" and a "S"
> variant. Align the compatibles used with all other IPs from the same

I don't get it. I see only one front compatible, so what is exactly
aligned?

> SoC, which requires providing 3 compatibles (the SoC specific
> compatible, the family compatible, and the original Cadence IP).
> 
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 53a52fb8b819..62948990defb 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -80,6 +80,10 @@ properties:
>            # controllers are meant to be used with flashes of all kinds,
>            # ie. also NAND flashes, not only NOR flashes.
>            - const: cdns,qspi-nor
> +      - items:
> +          - const: renesas,r9a06g032-qspi

This should be enum, knowing how Renesas adds more devices.

> +          - const: renesas,rzn1-qspi
> +          - const: cdns,qspi-nor

Best regards,
Krzysztof


