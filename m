Return-Path: <linux-spi+bounces-11772-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5ACA577E
	for <lists+linux-spi@lfdr.de>; Thu, 04 Dec 2025 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134243061A52
	for <lists+linux-spi@lfdr.de>; Thu,  4 Dec 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F566303A0B;
	Thu,  4 Dec 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkLh5w//"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2F2FE58C;
	Thu,  4 Dec 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883556; cv=none; b=cfh+GnXE0YP460aDqDPO1gaAZ8SWeNZ/v+JMMHpeGHfWpT1pUsx4U0a0OK+wMqQ4YQ5MuqEwxz2JLxH7R9BWPRuGiZSjjqG4nhjS3Jcn8G7brzxLssa+UBYVV0OI4mIXLwADr+J7MHcAGSjElRlk9e7Egki7n8Imr/q1Y9OBIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883556; c=relaxed/simple;
	bh=zhNuRkd0/ZTRBmJ89KVdHGXxnAXj85yVraR7WvXublc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHwiAhSVAD55T2Ib3KVvMiozZhrlrfo3OWXz5dvE+RYTHSbt2KGagaiXnCI/wkgotgdvyht/2bi2AkMsQfgP1JjpxUFLg3AjOU1vvOc9VivEvALsf0wvYBRvgTnj6UBE92QQiQCLq9wv9TaoGLLn0Zo2IhDkGZ2fcf77TIhtCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkLh5w//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E17C4CEFB;
	Thu,  4 Dec 2025 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883555;
	bh=zhNuRkd0/ZTRBmJ89KVdHGXxnAXj85yVraR7WvXublc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkLh5w//IgLYbWS4GnNELIcNyGQx6BKzdy/3vyO93BA7DAd2cAmtHfE2JqLB6HHFx
	 S8Yr3VX9DDHaX9vNY2LGT5JFpmkeHO2Vk0WbEtukva3MwjsP7qDoD2Vzorkgc5V/Ac
	 0yJzTBhHR3l45RQTxOkrYlpL4n8unvEpoUwXDzyys3AGvkL8zBcRHntJdseHEyDDdG
	 uLqrdx7IG6q/Cw1yiMsiR8GW2I6IUuGEbmVBj79NwJhqSWH3VtTvu8DNFNPPq5xWhq
	 /D2yLfy898Wxf349ZY8fKIFQfAFVDg/BSzZ1dDdNRUlvijKhY2HEJh/x/26o3G9KJ9
	 nhKWItnUu0kMw==
Date: Thu, 4 Dec 2025 15:25:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 10/13] dt-bindings: spi: renesas,rzv2h-rspi: document
 optional support for DMA
Message-ID: <176488355189.2193483.16985299918185323167.robh@kernel.org>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251201134229.600817-11-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201134229.600817-11-cosmin-gabriel.tanislav.xa@renesas.com>


On Mon, 01 Dec 2025 15:42:26 +0200, Cosmin Tanislav wrote:
> The IP supports using DMA for reading and writing data from the FIFO,
> document it.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  .../devicetree/bindings/spi/renesas,rzv2h-rspi.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


