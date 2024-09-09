Return-Path: <linux-spi+bounces-4736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759209714C8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CB0B25D77
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151EC1B3B23;
	Mon,  9 Sep 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMytIHwH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D489F1B3B18;
	Mon,  9 Sep 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876313; cv=none; b=KQh7jKnY7fGlUkZnsTxjAOikkJdDzVCjsgzffdNSszGwHD9uVghsm/wieK4AFrC37MJuZXQqL39TVDkmZCt6xLM7iBuL+igsFAgbs2RXHV3KNPthcf7Hzx/W1wxCOCXkpRQ+d1MJbG90bxaMzTxrUrjYggzWU3mI3LjuaYrJzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876313; c=relaxed/simple;
	bh=yRFRZqHggJX0yWp4FW2ndlEU7TNI0ICDRu/OuOa5eKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyGR8w4W0dbmhKHSEuaokRHws/D7vL3w8YO0vi9E6wAK/L0ChvBbOExw8/QaemktBuHqU8cT5qaFwtO+mrl/drDsGS+POl1I7kXMbt3irlLBlRZKhFNEdgtWoMFYvEKXKoxiFdPjq6HCMrCdbAqlTJLVfghGLTsXdTB1oXDhbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMytIHwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A511AC4CEC5;
	Mon,  9 Sep 2024 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876312;
	bh=yRFRZqHggJX0yWp4FW2ndlEU7TNI0ICDRu/OuOa5eKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMytIHwHYKP5oJI5+gQ3VuHjybqEB5UzBA7MQ75qt0RDfnORi4pkClux2r88Fqc9t
	 sHb5RLVSZBP2lacVArUwhbOLOk0JG2hm9OzKoKNDwQ8+BaDj5EcTIVcwuv3fSa7iJD
	 RcYgkhzyr0we6pbx/UNi+ovvxvJVcmqi4lUKn9piz/LK6jixiSlKNSUjZgZIpFPyow
	 oyiYzNazMKaMxnjKUhadllr+2QFS83WCHP7NDmY1fgrFBrbmgePW0teAUsu0wq5ZnS
	 VZaROlKEehWAW5QJCGNFU90u916mSxXdPn6yea14J/t9+MI6tYAIIxHCLSraReoUzE
	 Jq0yjxi5WIjuA==
Date: Mon, 9 Sep 2024 12:05:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 1/3] input: touchscreem: ad7877: add match table
Message-ID: <amkfwj7etefj7oynjnymnmksva4ocu34fcemw46cyidrfzmnl6@t72ldl2qb6nk>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909093101.14113-1-antoniu.miclaus@analog.com>

On Mon, Sep 09, 2024 at 12:30:11PM +0300, Antoniu Miclaus wrote:
> Add match table for the ad7877 driver and define the compatible string.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v3.
>  drivers/input/touchscreen/ad7877.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index a0598e9c7aff..7886454a19c6 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -805,10 +805,17 @@ static int ad7877_resume(struct device *dev)
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
>  
> +static const struct of_device_id ad7877_of_match[] = {
> +	{ .compatible = "adi,ad7877", },

Bindings are before their users.

Best regards,
Krzysztof


