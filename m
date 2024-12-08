Return-Path: <linux-spi+bounces-5951-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D639E8596
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 15:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A181F281279
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43F14AD2E;
	Sun,  8 Dec 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buszkfdZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216413D504;
	Sun,  8 Dec 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733667366; cv=none; b=ZJWpda7gh3/d8IauRVpUodqLbHkQ3TknBYN+czvZtyUobthABmCeUscMS174LSuR6qhr8FwjkizQbV1y+aCnb2tnsSHn58A9jI6o9sC4+kqarGONYwJjoQkV1LzS2SgtrM0yv/1tKSEAVyZN7+CfcelJOKMAf2m9/pZhxqZzl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733667366; c=relaxed/simple;
	bh=+0ng45+7kJ1yT7sur2+oF61LOQgPGMdnCNycAOs/GUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po152BZFhHWtsehySAOwRDylAVtXD/uaWtzQe/3jShO0RBOwcBRQyHOH7ZEWz+OkJOHFGh/LepnkZZaiNEGTbAXMb30wI8tOsvTT1gx4h1N3Rg711Y5eg+2dbLvPDiaKaeuKY/Y/CTPjKtqWmhSX1AGH8y2Pr05u5pRwfKBQkXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buszkfdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE203C4CED2;
	Sun,  8 Dec 2024 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733667365;
	bh=+0ng45+7kJ1yT7sur2+oF61LOQgPGMdnCNycAOs/GUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buszkfdZC5LkMipnYOJQAOO6i4zNsvhOI9/GKlntUUnVIjfBIutfpDGEEJhoJfVKT
	 4APx9OzqOcOAqBnDC3FoCe9ZsbACKkVuKKgGtB0MToBKEpYFaAacfUA4fFJmlPWH5P
	 t+odPx/QPJfERMsYWajb1bcwBluM4rnzFj41hY6fgcoNG/cAJwoDYZg9yrbFc4FRpy
	 E1wZWDcgHQ/5tv3YoHdJOYSmVC7I/HHD7aGPI9A6oafUe/w0KSALOPUUNPAOouy9Vb
	 9wesrHCnux4rs0e+X5938ufy+wqeOsqZI/B4I+uq0P0ILrEFKhw4tsRmb9/uLb0fe+
	 hPMrZzn+qbraw==
Date: Sun, 8 Dec 2024 15:16:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 02/13] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,sama7d65-flexcom
Message-ID: <copmhri4e43sjk6uiahgmhkqk6kuhuvm3kmusptytww6l5qs2a@xejs5hq4a7gl>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <550a6dc244a9955782c5b9d7863df4e15bba8a26.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550a6dc244a9955782c5b9d7863df4e15bba8a26.1733505542.git.Ryan.Wanner@microchip.com>

On Fri, Dec 06, 2024 at 12:59:47PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add flexcom binding documentation for sama7d65.
> 
> Consolidated entries into one enum to match proper coding style.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml   | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


