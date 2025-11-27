Return-Path: <linux-spi+bounces-11625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D531DC8F590
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5910034C1F4
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A92C15AF;
	Thu, 27 Nov 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1cmXHtQM"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA073358A6;
	Thu, 27 Nov 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258618; cv=none; b=Bgl/oH1pPlYtdfQdngz4PebjsLaDHTlxXZhpqsYsNux21VSLsnUfn1SZSQQQ2lNUCTF7eHaxtIrDJxMSEHiu8WxwB5Tir6HdwBTwSueTjPhk8F31ymFbTPESCEastDFi9GTweat8wjuqMriBOK++kBBqneYTMRBuwThHqEZzH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258618; c=relaxed/simple;
	bh=LvFyA+gQ+9TerdeP6nbLSuqm5Kj10RunWfZiex0trwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gtnBf8fe1kShRBdKuaHOXEma3Qp50/AUosVykcasxEtNC9P4GENO6qMxddBxbKVAptS/su2h9SZH/ou+G7pwJlkBM/z/N6Na2mY22A7o9VNXt9fBPFn+EH+JiubJumvNNMhmmzMMyfrxcivVN+njtnBbLxeYDdA/Z31cBoRIhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1cmXHtQM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764258616; x=1795794616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LvFyA+gQ+9TerdeP6nbLSuqm5Kj10RunWfZiex0trwM=;
  b=1cmXHtQMqHDZ2FSPiiDE0j2vFONGROb11Nn4JG344pnN4/2dCnlEvOyJ
   quOd5ysPVTTm5VbR4DPth9KMLf37tpEY7+wDbapcLO2LZaCXAuBTCCYpI
   4anQ+W508r9ysEdnB8JwGsYvGn0usslDUpycOqfP6hkJHH1yi4KH0Qi5Q
   PSUkSHw0LlUTRyUB1ZV8zcdxq6L6zR3CK9oXV41nqVthcFyd6HAD6MQ8I
   +QtUM7dpOv5uQsxgzhk7zrtfJKYMEfVRBZ4W/vd0aiwlpA8QSe76Au3tY
   DVwY5CNRFnsRvvxCrVpSVFEVs+kFMMArUtgP4Qb77IW+g3ubAA/i2AbYZ
   A==;
X-CSE-ConnectionGUID: xkXKbOmlQV2aXwZj+808kA==
X-CSE-MsgGUID: hvBw41w6TYW6cAkDjtY7Fw==
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="217099809"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 08:50:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 27 Nov 2025 08:49:45 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 27 Nov 2025 08:49:43 -0700
Message-ID: <b2a52e01-85ba-4a98-8d4a-2cbc957865ca@microchip.com>
Date: Thu, 27 Nov 2025 16:00:47 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] spi: microchip-core: Use SPI_MODE_X_MASK
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Conor Dooley - M52691
	<Conor.Dooley@microchip.com>, Prajna Rajendra Kumar - M74368
	<prajna.rajendrakumar@microchip.com>
References: <20251126075558.2035012-1-andriy.shevchenko@linux.intel.com>
 <20251126075558.2035012-6-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <20251126075558.2035012-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2025 07:54, Andy Shevchenko wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> Use SPI_MODE_X_MASK instead of open coded variant.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>   drivers/spi/spi-microchip-core-spi.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index 0dca46dcdc2f..941b7e23eac3 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -148,8 +148,6 @@ static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
>
>   static int mchp_corespi_setup(struct spi_device *spi)
>   {
> -       u32 dev_mode = spi->mode & (SPI_CPOL | SPI_CPHA);
> -
>          if (spi_get_csgpiod(spi, 0))
>                  return 0;
>
> @@ -158,7 +156,7 @@ static int mchp_corespi_setup(struct spi_device *spi)
>                  return -EOPNOTSUPP;
>          }
>
> -       if (dev_mode & ~spi->controller->mode_bits) {
> +       if (spi->mode & SPI_MODE_X_MASK & ~spi->controller->mode_bits) {
>                  dev_err(&spi->dev, "incompatible CPOL/CPHA, must match controller's Motorola mode\n");
>                  return -EINVAL;
>          }
> --
> 2.50.1
>


