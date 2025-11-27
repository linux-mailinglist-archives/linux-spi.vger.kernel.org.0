Return-Path: <linux-spi+bounces-11623-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD7C8F56D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E63A434FB2F
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA4335553;
	Thu, 27 Nov 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xqvc4EMk"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A02C158D;
	Thu, 27 Nov 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258513; cv=none; b=cyAws+H2bQ3k1l/i0Dy98K4K4THHROiV/ZzAFeaDTb3iw2sJ0+xkUCwQ7erH/FbBt+0KYXF4MoZE8hsHp/1+JM/xYof7a+6IUdKIDqpr17/IqCKhg6wOHr7I9tRUMaf+n7hwvSIYLmzWvNVJW0lUluKHkWvr/BlP8s6Yz52acaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258513; c=relaxed/simple;
	bh=0/6ojzN3J8aHEJwTKyDSSoNFlaDqtNDY4MG9uMPavj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dgPsq+IfZ+XBkStM13ZoByluwdY8OYgy2CTzhPHnNZXQ1IwC0sm5/OR5L9rfWjln8ZHNOs5RF4pToqdCDnPyGKijV1XRoz80j8w5khaihxp0CbtdOPvX8VBQ1xnttzA9D1AYZd9p45MBqYdBx22fOEOZhsKqbGkQANLaxrUyMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xqvc4EMk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764258511; x=1795794511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0/6ojzN3J8aHEJwTKyDSSoNFlaDqtNDY4MG9uMPavj8=;
  b=Xqvc4EMk6V/2v6qkbMYcuIjoPZAkDip7L90q+uCimq8jW1d/m+3GoYvz
   S/M5oKMePa1ZO6JLvUpcqcjhsYZFNuSdQlL5KlW/7igybge7ikPoqKNLf
   QDGSiWW32hKP6wo1nFnyoNuXlJo1XJJGigofjbDJW6IwHvzcs+lZwFrzs
   i7exqfWYA8Yyrb/QlrZ5eM+pcSJuQpZq6t1zrtDhG7iR1nqkEvnVrPEcK
   g33u2YytdsOYzL2jburs/qjgDis0FK8jSB2W41n3c8tOXQm60eWIJsp+1
   80kFcAoPO++XYTBqshMb7SPIQ33T7Jrxs1kuQM8Nt6k2Uk7mwZzTONQXP
   w==;
X-CSE-ConnectionGUID: x8zuWQllQY+dDB5F7XWDhQ==
X-CSE-MsgGUID: fwItq9SeQ0yowpqpV7E3FA==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="50260184"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2025 08:48:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 27 Nov 2025 08:47:57 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:47:56 -0700
Message-ID: <d7bc73f8-c103-4b54-a6f0-ed0c72371349@microchip.com>
Date: Thu, 27 Nov 2025 15:58:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] spi: microchip-core: Replace dead code (-ENOMEM
 error message)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Conor Dooley - M52691
	<Conor.Dooley@microchip.com>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251126075558.2035012-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 07:54, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> First of all, the convention in the kernel that we do not issue
> error messages for -ENOMEM. Second, it's ignored by dev_err_probe().
> Replace dead code by a simple return statement.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>   drivers/spi/spi-microchip-core-spi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index f8184b711272..8ea382c6fee7 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -293,8 +293,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>
>          host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
>          if (!host)
> -               return dev_err_probe(&pdev->dev, -ENOMEM,
> -                                    "unable to allocate host for SPI controller\n");
> +               return -ENOMEM;
>
>          platform_set_drvdata(pdev, host);
>
> --
> 2.50.1
>


