Return-Path: <linux-spi+bounces-7598-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53924A8A7D6
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C223619033EC
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4F2475CB;
	Tue, 15 Apr 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMC9v116"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAF2356B1;
	Tue, 15 Apr 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744993; cv=none; b=VOv/ip/887qtzl4rVhSexZL6r05A+pxQ6VoYrk2IGmUlNTZL0ehuKVei5cy1yfaB2Zvha1aXil/kYdT8mvqbM0wzqGPpHiEU0tY6IlfTDb9vtwJLUC8YhZ6XdP8rI00jWJeLax1lKIeB8R41Aj5rEkxIp/sqh2GihaUtfrMdZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744993; c=relaxed/simple;
	bh=x09FjVOAZBwkbITfwM+C4hWOy9jtbp+fErNxZ4F57Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riuAtX3MxLwE4pihO9fzxD6xOdSACZTDTpo6l0dWPp8K7bk5wncUNrTfq9M9YDSMVnUDx32X16KR/ehEADyUHcq7zLfExsu5zJwEiHxgoLhlYzoEAz78XbznTpjjpApryLhQMTMKZk9t5YVqfrSq6TrWrcnSECjEyNeBFqseTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMC9v116; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB0DC4CEE7;
	Tue, 15 Apr 2025 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744744992;
	bh=x09FjVOAZBwkbITfwM+C4hWOy9jtbp+fErNxZ4F57Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMC9v116l3kDuwOh8VnyqdgEUvSUHqvSzRJWkGOhFzh0KBD+gd3Vjsx6V47nKLfG2
	 Xb8Pu12XAN7Aoq0Ts58Dz/j+YqBecvZAEYYRDqunkVaixuSI3SbX9eCJkfpBzJzP1C
	 pYsugK7hhCik+56+v5Qg1o9XkXjgTFrzZwVWVkezuakwfiP0zFipPVzXYvEH6Vo2z2
	 xQLMfX7OEsZvWxerQIsKZYtvr/gY4nHepBi4c9zZmwlTiD4tV10AnTQZ+1OZ+BBZTT
	 mHxeYRjxzc+/1Lw7+Ip5U2t+n/+T4XgrgkGzTg3diIuCkckddZIuBouU0AnTP+4E1H
	 n4RTzWysfnOpg==
Date: Tue, 15 Apr 2025 14:23:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-gpio@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Mark Brown <broonie@kernel.org>, linux-can@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH] dt-bindings: remove RZ/N1S bindings
Message-ID: <174474498632.835692.11318420233043373659.robh@kernel.org>
References: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>


On Fri, 11 Apr 2025 21:47:57 +0200, Wolfram Sang wrote:
> Except for these four quite random bindings, no further upstream
> activity has been observed in the last 8 years. So, remove these
> fragments to reduce maintenance burden.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> In the previous discussion [1], Rob offered to take this patch.
> 
> [1] https://lore.kernel.org/r/CAL_Jsq+DOp8YOcshTVqYcbmgbuc4etTQeeswmMUYjw1sws4mAA@mail.gmail.com
> 
>  .../devicetree/bindings/net/can/nxp,sja1000.yaml     |  4 +---
>  .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml       |  4 +---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml | 12 +++---------
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml     |  4 +---
>  4 files changed, 6 insertions(+), 18 deletions(-)
> 

Applied, thanks!


