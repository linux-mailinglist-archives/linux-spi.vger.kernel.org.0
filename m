Return-Path: <linux-spi+bounces-11479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB61C81255
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 15:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AF883477FC
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3930CD89;
	Mon, 24 Nov 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t/fjJ/Tn"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1397286422;
	Mon, 24 Nov 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995810; cv=none; b=PjYp3nKrPFCy+NxG68YXXsEjRTvvTo8b2BUBUzH/ttrLkm1yQJwfzFavFcc/qZD/nuHb79N7n7ooDj8e4bXH5tP3ey2B/pV7iut3m1ECq/JB0Z7gceKkcQUNuzbHgDnNaYnzGoNifU1SnayIa8EHeHalxDhsBWNJqC9a1IIgw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995810; c=relaxed/simple;
	bh=ldR9Jbkn+lG8+Fw1qz6qmlfFqMRuk5844+RygMXc0QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GP2yG1C06xAklzKksrqdd5ePxmggTWmOsjOPfhn/bRlleaG+atvU20SSQn7P1xDHNW1B0AL3kOtJdl7FyjvpZENVx0g0+lm8ISQQKrzYb2oYT+hzNDoIdB2t3ADW+1GuWYyGTE7LrHA10iEAQP+hfQ9Dd4p2wy5xHsSfVc64tQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t/fjJ/Tn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763995807; x=1795531807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ldR9Jbkn+lG8+Fw1qz6qmlfFqMRuk5844+RygMXc0QE=;
  b=t/fjJ/Tn/Ma/J7trnD2N1rPxDiad/VHFHTbwUa1Ii7xJHwoEvsBVOcZI
   SI3BIkVTNg5cqyJarxwRqccT/mwh7tsx/4sP/3IeHQo/0c9FSkXYaACGL
   RmwnRn6EtlKpIWiXeg75GRNPrc+x+D6Xd6ATqxP/rbJ3CesjYUXsyqV19
   T+owh8TP7XvSlhQn6CruB8kx4skv1oHzOfoEqypPZk5aB/EPtCHgrTUuT
   jSHcHXf3P+cBD6H4TcMhVvgx7ZaMn7H70l8GpAL7C3z/Vx24EPYhNx9wQ
   Lmmm0W+sN1Eyz01x/cU8ovHxv6FtBIdbdMYoD/bLsgADKfyfp8LZOsqRR
   A==;
X-CSE-ConnectionGUID: OeN9174cR8eHEXvZOy+fKg==
X-CSE-MsgGUID: DtLvZ2mDQxKim2utQ5AXiA==
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="56142126"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2025 07:50:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 24 Nov 2025 07:49:47 -0700
Received: from [10.205.167.104] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 24 Nov 2025 07:49:46 -0700
Message-ID: <48ad36dc-613f-401f-a8e2-dec832bd6ee1@microchip.com>
Date: Mon, 24 Nov 2025 15:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2] spi: Fix potential uninitialized variable in
 probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mark Brown <broonie@kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <aSQPkfkiJ0w-FJMW@stanley.mountain>
Content-Language: en-US
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
In-Reply-To: <aSQPkfkiJ0w-FJMW@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2025 07:56, Dan Carpenter wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> If the device tree is messed up, then potentially the "protocol" string
> could potentially be uninitialized.  The property is supposed to default
> to "motorola" so if the of_property_read_string() function returns
> -EINVAL then default to "motorola".
>
> Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
> v2: Add an error message on failure.
>      Default to "motorola".
>
>   drivers/spi/spi-microchip-core-spi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
> index b8738190cdcb..16e0885474a0 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -295,10 +295,10 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
>
>   static int mchp_corespi_probe(struct platform_device *pdev)
>   {
> +       const char *protocol = "motorola";
>          struct spi_controller *host;
>          struct mchp_corespi *spi;
>          struct resource *res;
> -       const char *protocol;
>          u32 num_cs, mode, frame_size;
>          bool assert_ssel;
>          int ret = 0;
> @@ -320,6 +320,8 @@ static int mchp_corespi_probe(struct platform_device *pdev)
>           */
>          ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
>                                        &protocol);
> +       if (ret && ret != -EINVAL)
> +               return dev_err_probe(&pdev->dev, ret, "Error reading protocol-configuration\n");
>          if (strcmp(protocol, "motorola") != 0)
>                  return dev_err_probe(&pdev->dev, -EINVAL,
>                                       "CoreSPI: protocol '%s' not supported by this driver\n",
> --
> 2.51.0
>


