Return-Path: <linux-spi+bounces-5760-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F859D361E
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD4928354A
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C299189F42;
	Wed, 20 Nov 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyXlp+xb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7B185E53;
	Wed, 20 Nov 2024 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093143; cv=none; b=BkmvugQ1HHpaEPdsVmqRcWFpzLmGNHLKYXnyFQcdT5H+AGtJUy0G+wOTlQ6dOuvgW3C27xpJeek34pDBlEi3FPhqcTiTblhuCjzzv2HFye1feNN5DwhASXTSYpn6T2GUKuao5E/eAa8KtTjmourdGmum6WzaLd381gILkuOnq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093143; c=relaxed/simple;
	bh=FSqB6Ma9NEk5mchTyPwpPByw+/YUgMeVPc7CFRfOzu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkX6glAzfd2Y3ODqb7O0mX0GCyMKG+tEow17cj6cJOGpSjZ5SmjF2p7s4tj5wjvgFa/EnWCs1EIIRp/Rr5fSH5OCzwEXIjiTg/rwHwpak/ndrJchAYH7b0JlQyyRdTih6/qyUYOl/qk8w0ef0c60J248JUqU2U5wBwSyqpRZINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyXlp+xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B7FC4CECD;
	Wed, 20 Nov 2024 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093142;
	bh=FSqB6Ma9NEk5mchTyPwpPByw+/YUgMeVPc7CFRfOzu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyXlp+xbycTok0UduEZaqH5btL55Hkbe5ORaILAS+UywoVb1ocVl70OTaqUBM4ApG
	 vrmHHJgI4hOHLrjicoS2ZazPLPGde2mkKPvV8RixZUfAsraYOHbWx6vxkUPDLYWpSi
	 GwQKHRUgiRM3R9cee1/LKjLtHRDCtA5zpx9A//JP4A4kCP4FQmJFxKYcNemWf8fSCR
	 I+7PRm1Yj8l8fhO4diJcD+onrRnn4qa66SBqYBPTHqnUv4s+o5vOaLNzlAzSWD5Nx0
	 EW1nc0yHDGNZg3Qdebd/ZCLgtrEM7YmYQuOt4S4k2krH1FRl26Ra8XqNNfJRd7uZD/
	 HLB4hvw0XMzGA==
Date: Wed, 20 Nov 2024 09:58:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add
 microchip,sama7d65-flexcom
Message-ID: <3ftlfgfumjcpkkowg4cj3ehyo4oonpingpdpz5usg37wevg7xb@n4ytc3vuvr3n>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <46928aa2d15d05fa3046c270a51a10cd56c2e919.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46928aa2d15d05fa3046c270a51a10cd56c2e919.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:08AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add flexcom binding documentation for sama7d65.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

I retract my Reviewed-by. Missing SoB.

Best regards,
Krzysztof


