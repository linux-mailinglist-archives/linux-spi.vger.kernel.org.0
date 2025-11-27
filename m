Return-Path: <linux-spi+bounces-11626-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C9FC8F593
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38DE54EB958
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D02C0283;
	Thu, 27 Nov 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hiEqyUIC"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC83358B8;
	Thu, 27 Nov 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258673; cv=none; b=ktlzohjNcYXwhPweHnzCKiGyrzujHBWznqzQwnDw1k2fZ6scMrzHZXlJTIMombHI9TJBfdyvD2E2EFWk/y7tiD/0Wq/ZLGR9/2SN3t04ztMjvJ5XFiZxOH6tHDyBSXTFS0mXu7t8x/gG7sZJ/iODRcT5A2L5HK4/1yxBegfWqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258673; c=relaxed/simple;
	bh=OM8OeqOiYqAXE1HVHI5gDOoEDV7zl5d5Z1Sg/nT2iGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tbp86z/Y5F9m35qfGWP9aHNLeD2bi9NWUUg9mBb6c+9Nzk6MjXfpZggyQmdbq9uxvC/+r2m/ZGF8+bELHkC9KJspFoikcSc6f6tL/DcxGEqCJkIhME4n6Bef8cUfarvVnK/ZxitJatF1QQtdjTU8uodqQFKyzRpFfXfdVF7BxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hiEqyUIC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764258671; x=1795794671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OM8OeqOiYqAXE1HVHI5gDOoEDV7zl5d5Z1Sg/nT2iGk=;
  b=hiEqyUICu/B7/cVu8w+ZR83KVPOH4qxQNkwn07ONrLtkhxGZF48qxZRU
   ieSrzZAhWxrahyFlpiADINM7Te4cYWYl4KN1cWjIgOHJDG5iwLOny3M09
   /kD2C+w/+Q/f27zBm8sBk8AaWUhXf5nKEZL4sIyLBXwkATVdNdIfox6fb
   tDutupJUt1Hif20iZCSqYbVz4wN6mset77id4gHbndRwZRj38M5MXkatG
   7GyTtQTcRcA0qOKIrW79GNk9D1MsV5eLJq7wKfiaLs3bLkLGLYLtAyHck
   FyFagyvD1jB4eBWbO0K7BMGy1U2P1NJ8o9iXoTQrtVLzCOlIjD8H/pdgn
   Q==;
X-CSE-ConnectionGUID: C0HRN99ySoK3CEkuV+8jvg==
X-CSE-MsgGUID: MnTA3k7hQk+8BpUxRB3vqw==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="217099826"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:51:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 27 Nov 2025 08:50:16 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:50:15 -0700
Message-ID: <31702a10-3ec2-4e25-af25-87864cc42d2d@microchip.com>
Date: Thu, 27 Nov 2025 16:01:18 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] spi: microchip-core: Remove unneeded PM related
 macro
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Conor Dooley - M52691
	<Conor.Dooley@microchip.com>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251126075558.2035012-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 07:54, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> Static declaration by default are 0 or NULL, no need to initialise
> them explicitly. Remove unneeded PM related macro.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>   drivers/spi/spi-microchip-core-spi.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index 941b7e23eac3..1e62af20d6f2 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -398,8 +398,6 @@ static void mchp_corespi_remove(struct platform_device *pdev)
>          mchp_corespi_disable(spi);
>   }
>
> -#define MICROCHIP_SPI_PM_OPS (NULL)
> -
>   /*
>    * Platform driver data structure
>    */
> @@ -416,7 +414,6 @@ static struct platform_driver mchp_corespi_driver = {
>          .probe = mchp_corespi_probe,
>          .driver = {
>                  .name = "microchip-corespi",
> -               .pm = MICROCHIP_SPI_PM_OPS,
>                  .of_match_table = of_match_ptr(mchp_corespi_dt_ids),
>          },
>          .remove = mchp_corespi_remove,
> --
> 2.50.1
>


