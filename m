Return-Path: <linux-spi+bounces-5766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7319D3669
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E980B241B3
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FB18B46C;
	Wed, 20 Nov 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZttFMoJi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155518952C;
	Wed, 20 Nov 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093621; cv=none; b=nkJpBw1SivPRFigJKglb6WiDSS3rTjDxnojPOdd8w+nNPReYiGM+SWRht/K9ddtuT5fYrul993pV1mNFDaNhdcjp4H5vPRprd9oTJqhPo9EtaSSUtFHfuqdkhWXsDan7+Yn7qaHhngmFy8PnvgheQGUg00GbzcAAmqWRRE+Ixck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093621; c=relaxed/simple;
	bh=228tLL5YvusIZ8n2D+dM7gRvmeHVb1pF88JU6BheBIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJPlbLxrUzn6y9+xn69uUg8Z9WhZR2j2YFqY3PeDq7HLfEGs15BTqlpKm0SuOCJgDqieeRhw4S09E/MLyCs7j9HPwp4FoSf/DtJBj3fxKwgcKf0HcZE99IjHsKTc6qO/Y88wVifzFBmzxuJSnXKL/ijMqPnAcpygU0xFMJaD9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZttFMoJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B6C4CED0;
	Wed, 20 Nov 2024 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093620;
	bh=228tLL5YvusIZ8n2D+dM7gRvmeHVb1pF88JU6BheBIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZttFMoJimtL64/vxXUtFUpLK2Wmix9LrjUq6616E7P7z205sdGwzx7rS0twwH4U32
	 QVGe6Flp+E/1AqFJ/voT69JzJxAHvOsPSMIOGm3Irj8eLhABNyu3VAyIwyEeyVqxuH
	 +d+Yeo+7CSsbv77mVs0rGSdH8vUR1cvf1NU+Ph2mFzccjvniHj02Sv3JdnWzQJcRGK
	 hhWLkwtYkomnkHrlR1ySKC60kG9dZurRGvPHNSCpFpTKKbboqEPx4q36EOUbn+Elpb
	 j4aXE3klQqiAJUyS/xm8eba6brBV2oQPFcLgby2wzgIRXHKVxN8b3ZkzMHa0B53ytb
	 V1CACEVWF+NSQ==
Date: Wed, 20 Nov 2024 10:06:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 13/15] clk: at91: clk-master: increase maximum number of
 clocks
Message-ID: <274yn2xnep6hblxecoe3zm7tssj37pqwiyjwrscrweowtqhm6j@hiywf65q32nr>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <cd6c8be4b476e04b2d18562bf72cc9387227e765.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd6c8be4b476e04b2d18562bf72cc9387227e765.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:19AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Increase maximum number of valid master clocks. The PMC for the SAMA7D65
> requires 9 master clocks.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/clk-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

This goes with the driver change using more clocks, no? Why this is
suitable as separate patch (without the user)?

Best regards,
Krzysztof


