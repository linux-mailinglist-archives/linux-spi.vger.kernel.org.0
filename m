Return-Path: <linux-spi+bounces-5600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586479BA033
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1BE1F21826
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04EB189F5E;
	Sat,  2 Nov 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUHv4s6e"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71477EAC6;
	Sat,  2 Nov 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553115; cv=none; b=pKdq7fubn5W7cE/sWGizDqb6pcJNFk5rUuRYNQ/1HD143ylW9aMKY8WVK+CrSBKP6hXxa/8AE0NH+tew0x8drcaXHi3mY/fN+JZwVV0/OZ4ZgDSN7wfQQLkh4VEgsguUpgRHvZRs0EHAuUxCBZsJVK8ZjG3kJ+xgeirTFMD3PDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553115; c=relaxed/simple;
	bh=eGFck0cKd1Wy64d/Ev/jSEbK3IIKOXA4fI7Uzfoz+9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTYn+6LSl4k6SEORWlP/IFJwdh0n/dv6j6Y7FeEzxHT1FHo2g3UXGDmGjGm5ggwbfCv0vQ/m9BJFbu9a0+Jh6Bs9lBJBeQ0a6nSGOajk9SIfEJ9rHM8TyErNa0f/nyltnuzuMm2lGGObB5V0H75fsf95bddfD38dwxVOZJRha1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUHv4s6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21A2C4CEC3;
	Sat,  2 Nov 2024 13:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730553115;
	bh=eGFck0cKd1Wy64d/Ev/jSEbK3IIKOXA4fI7Uzfoz+9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUHv4s6eRD6BBzQHjsh+cFIyMNUx1BNkT6PJb+Vs/t6ALkfudA5Wz7c0N9VjIqXvE
	 nwOIv10w8osITYi4ymFr3BrogeMuR3Ekn+PVgFwp/7WwdtYV0wctd+0vWlEHWX9Jgt
	 GtNTStE8UN/7qVZZq9QE0hDg/d/QAyjzR0ccjazeCmeRd0QanNktUhWN6pzQ+Qp8ET
	 0WPwx9TwPKdiXKesmS8jSlfheWbruBuKz9jSMA9ZKp+jk9LSQLIH9B4DZStMRLxkNB
	 AwvsEGTXK4Qccaa9MEPrbx11qUKk2x/EV+y+08s+nkgAIgismXVnCzbUEJa00tvtTy
	 NI8Eimmavnz1A==
Date: Sat, 2 Nov 2024 14:11:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Apple SPI controller driver
Message-ID: <vzulq4ewdbrk7qdurtypxpaoe4jsswddfprtdbudoxipf6d3ya@4gnbmr722pig>
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>

On Fri, Nov 01, 2024 at 08:26:11PM +0100, Janne Grunau wrote:
> Hi all,
> 
> This updated series address the review comments from the original
> submission in 2021 [1]. It adds a new SPI controller driver for Apple
> SoCs and is based on spi-sifive. It has been tested with the generic
> jedec,spi-nor support and with a downstream driver for an Apple specific
> HID over SPI transport.
> 
> As usual, I'm splitting off the MAINTAINERS and DT binding changes.
> We would rather merge the MAINTAINERS change through the Asahi-SoC
> tree to avoid merge conflicts as things trickle upstream, since
> we have other submissions touching that section of the file.
> 
> The DT binding change can go via the SPI tree or via ours, but it's
> easier if we merge it, as then we can make the DT changes to
> instantiate it without worrying about DT validation failures depending
> on merge order.
> 
> This is mostly Hector's work with a few minor changes to address review
> comments from me.
> 
> [1] https://lore.kernel.org/linux-spi/20211212034726.26306-1-marcan@marcan.st/
> 
> v2:
> - removed '#address-cells' and '#size-cells' from the bindings and added
>   Rob's Rb:

Where?

Best regards,
Krzysztof


