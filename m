Return-Path: <linux-spi+bounces-8702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B9AE3070
	for <lists+linux-spi@lfdr.de>; Sun, 22 Jun 2025 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CFA188CC9B
	for <lists+linux-spi@lfdr.de>; Sun, 22 Jun 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A31EB5E5;
	Sun, 22 Jun 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDNKZWny"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1F1DE881;
	Sun, 22 Jun 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750603062; cv=none; b=RGG8Xrxxd4qlMXNJ6f+EWNUpPeWLMNYIsoAmP/PkWNflO25qHmkRdjKN3q2U6YzN7afuz0IUZr5A5nFg4eQKXLE4qTvTIFZaae5BKYabqVXMknSEz66PMO6QAwgIBzg60/G9CimvQejIWko5GRANIOVTjVDQUZnT2vfsO0imPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750603062; c=relaxed/simple;
	bh=yOH+oUJlkW2Fc6gv0kytdJyL2h9myptZcLnyuSFdvfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3J7JrRp438+XJBRiNgq+toHG5gm5Hwz1IlG/hlqWR3bNC1WF4bgmcGGVqI9xzFgCOnDLEli8IRK3B3Q87+8LUutqCNzmgQC9+2sagK65kD4hJumKV+fI2enjDMOiD6cryqGf8w81a7W5INwXON1dMeUnphm59vcAAY1iVHk4OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDNKZWny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA451C4CEE3;
	Sun, 22 Jun 2025 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750603062;
	bh=yOH+oUJlkW2Fc6gv0kytdJyL2h9myptZcLnyuSFdvfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDNKZWnyD1zpwfYo75lB6aBKt4Hyzg2vwGBa+c/BZZedPaUhqrdzyVeGIlfE0+U98
	 YVBAQIMrlgVvJw2fIzQ9hyljYcSXNg9U/xdTsEOHrFyP+bUtbQrrPsvEGkQQNZatq2
	 kkFk95n6tIYMMbQf4845shRP/+cKW39FNdMt2LSMYnUY5PLwUiXrkvKDL+b6KXaBiJ
	 +k9vVzXWL/qcO3xg52HfxHLH0w2UM/3aT7fSwnz/DEeZfE9o261/co6CF1MHsaqa6e
	 8DD52L5INCTdH8uyZtrzu5/rTsEEBsDliObU4q+ldzxEUe+8lqPIYGsq2ALo76Dufe
	 1H04fiADccRxA==
Date: Sun, 22 Jun 2025 15:37:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: adc: ad_sigma_delta: sort includes
Message-ID: <20250622153733.44eca388@jic23-huawei>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-1-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
	<20250620-iio-adc-ad7173-add-spi-offload-support-v1-1-0766f6297430@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 17:20:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Sort includes in alphabetical order and fix grouping before we add more.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6cd3645eaaf38a23d5b6479ac598b6d276cfd81a 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -7,24 +7,22 @@
>   */
>  
>  #include <linux/align.h>
> -#include <linux/interrupt.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
Andy normally points this out (and may well do here) but in
general if we are tidying up headers we should try to drop includes
of kernel.h if favour of more specific headers.

Doesn't need to be in same patch as this one though!

This is trivial and correct as it stands and would want to be
done as a precursor to any actual changes anyway.

> +#include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
> -#include <linux/err.h>
> -#include <linux/module.h>
> +#include <linux/unaligned.h>
>  
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/adc/ad_sigma_delta.h>
> -
> -#include <linux/unaligned.h>
> -
>  
>  #define AD_SD_COMM_CHAN_MASK	0x3
>  
> 


