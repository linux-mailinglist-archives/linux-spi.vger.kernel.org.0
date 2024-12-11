Return-Path: <linux-spi+bounces-6009-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272D9ED118
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C43E2907ED
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A751DAC8D;
	Wed, 11 Dec 2024 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M82ykkTd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06A24635F;
	Wed, 11 Dec 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933792; cv=none; b=F4AU0S3jPlcVM2omoHv1EX//9nMS9IMXkU4lHY9DQ+ULdkX6EhiOloqVtkuEkr+ZDrIzkrOmipAacov0/F/Kpw8Ax5roI/sUa7YlVNBXEYXMswFp6zNVJEIVSh123FHxIqk9HvAnRy9iw/IQ0sCLUMdMqCAgFCMobjcEZD9iBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933792; c=relaxed/simple;
	bh=j2B3ZtPsIlaH71L3BYRm5WtzVOJ9jt5Yl7z8kPRgOdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyHenl35oeaME7XhCJiP236NJkN6PPLywITCY42rrUwKD+lR5C0LP3/qnv20Ft8cKPN/OPHinlL/GSI/AfCWWad8SZFQegyAO1HbrUkwVZl+yhrWtWAoFsgXS0/prBakXnlp10Ed+1SUpOa4lq8E2fsQkxO/UlySANxqX7UASbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M82ykkTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF74CC4CED2;
	Wed, 11 Dec 2024 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733933790;
	bh=j2B3ZtPsIlaH71L3BYRm5WtzVOJ9jt5Yl7z8kPRgOdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M82ykkTd8xjXRBwSvWgQovHqKWlZUbMY2TEBisgB0McMvaiPso85PERd3Sx7gelo5
	 VHI80/ks0UgHnBkhWiHc86S902zVg6c0ieJWLHbMgIxteqtQJvEOpdSsrw/tUafqac
	 YRTwagblJNFGQtiocFm69/QlFpoKGPL6o9O3QZcxO9X5EwZXLYqAH5rlPp3Ty/hE2I
	 yiHX6Y+0wdmiYA7uqd9br0Ov3p2OSG3gXcn8qqJZ5RUXJC5os+uxj6vl0/+LVr/zMt
	 btgd9rOsANTwZRvkQWOSrRxrAN84KFO1UP+ck3ILnl/mBK+edWo8S4ePiAyBabIJrv
	 zeA1cp0Dnmrvg==
Date: Wed, 11 Dec 2024 10:16:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: alexandre.belloni@bootlin.com, mihai.sain@microchip.com,
	mturquette@baylibre.com, conor+dt@kernel.org,
	dharma.b@microchip.com, linux-spi@vger.kernel.org, arnd@arndb.de,
	varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
	nicolas.ferre@microchip.com, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev, romain.sioen@microchip.com,
	linux-gpio@vger.kernel.org, sboyd@kernel.org,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 04/13] dt-bindings: serial: atmel,at91-usart: add
 microchip,sama7d65-usart
Message-ID: <173393378758.3240340.14434192091992606298.robh@kernel.org>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <05baeeda872ab06d4d84718c535453b787740876.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05baeeda872ab06d4d84718c535453b787740876.1733505542.git.Ryan.Wanner@microchip.com>


On Fri, 06 Dec 2024 12:59:49 -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add SAMA7D65 USART compatible to DT bindings documentation.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


