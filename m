Return-Path: <linux-spi+bounces-10281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C206CB99598
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF27321976
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B52DCBE3;
	Wed, 24 Sep 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GBTyqdBq"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB22DC341;
	Wed, 24 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708334; cv=none; b=MhJWR6EKBb1rhQJlB2OBMC35KI2869KyEEREiS1v9Rx3I6G+QVHIQD+ubDyMUsAKn+U+8He/oxYroBXH6VLFlassooJ7IqrRycHSC92cx6dFR8s2qbNkoY0RQBdfB/DwGUy6wzBzZfY5h3SlxpRkvOFVKIaaWe3lIvqf3S3WZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708334; c=relaxed/simple;
	bh=/uGlAhygClhoPDVRQPCwG9G95dwItASnVdcJVlvF1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni3ROPzgm4DxQnRjUrWt1/JAu0K7w75ak1IUppPWtnHEw3RBSILMxyoV1SrRNJgK1xtqmdep3R3lAIjc6EUmGjWP3mINdlSBGfr0rUqpVYU3K1B1run7X7sm4j1q4OSHaFWorf2qW1I/K0CmbI7MhmPV5715uM0zDIuD8X2yjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GBTyqdBq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id AE43C1E30;
	Wed, 24 Sep 2025 12:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708244;
	bh=/uGlAhygClhoPDVRQPCwG9G95dwItASnVdcJVlvF1aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBTyqdBqsGwcYQgvCkzmg1ptFgclVBZ2tr2cEBUfdb0bxQsuhoZ1X4p2l3jT1aq5b
	 WRb7o/3dNvVVj6e//lvTK+82zN0Arkx9zbOzsZp1Dagu7Y0Nps/Li10vjaOGDVbNtl
	 3Yb19zNB07cjWf1MzBTqyyKVa4YLYrSMtVSz/L/8=
Date: Wed, 24 Sep 2025 13:04:54 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 16/16] spi: cadence: Remove explicit device node
 availability check
Message-ID: <20250924100454.GN28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-17-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-17-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Sep 24, 2025 at 10:46:02AM +0300, Sakari Ailus wrote:
> Don't check the availability of child device nodes explicitly as this is
> now embedded in device_for_each_child_node().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/spi/spi-cadence-xspi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> index 6dcba0e0ddaa..23e426ef9b9c 100644
> --- a/drivers/spi/spi-cadence-xspi.c
> +++ b/drivers/spi/spi-cadence-xspi.c
> @@ -908,9 +908,6 @@ static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
>  	unsigned int cs;
>  
>  	device_for_each_child_node(&pdev->dev, fwnode_child) {
> -		if (!fwnode_device_is_available(fwnode_child))
> -			continue;
> -
>  		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
>  			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
>  			fwnode_handle_put(fwnode_child);

-- 
Regards,

Laurent Pinchart

