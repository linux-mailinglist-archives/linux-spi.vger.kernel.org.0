Return-Path: <linux-spi+bounces-10688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45ABE0B37
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E81A208A5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492F2C324E;
	Wed, 15 Oct 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAkJY6bp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E22580F2
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561541; cv=none; b=hOc5jdULL5XtKFgJ5LX2ynzL3xU9rQP93dcFjrpR33wGyRZBIrpc2aL34orraZM42fdU0gbgqXl/w8lHV3m4VW7b3Fauw5qXOzSi5hAv3XF1h9ZNztwqrxm83HPILvRrQ9ogjYJ3i+hmhx19tAFQLMFjUTCaftO01Mxm0HqtrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561541; c=relaxed/simple;
	bh=hsD+aslz1OkQOnpQ7vD/eAIL2an/1I+2GU4RtlCHgkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojWlF1oI4oXk3FKqm21MS71xzo8XDSXiMy+6PLmG5cO/NzcCgWKUZVzd9rx29a40n0u7v8zrtYyrjAApqtZdNBQLsT/XAt+nK+WyBx2YNZgrVOlFFj6e4PxDItbhRvArsuf/YsVA0H4sR6lNxRQBVEsoQYvrW0/UpU7W+khSIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAkJY6bp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so61899b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561540; x=1761166340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q3l3wXZP1srYTWBx6D17j0OpQl3qJmuJ/CIapeLh80=;
        b=aAkJY6bpYgLrhjydCSaF0WEz401VhyQpHjxyiS1q5/0W1/vaZ+X9DuAjUczWx0RZSH
         06V9jGc7zHjJj+3wP77haSL3AoQtwd1cSbRajrXKLNXbkha3bm608AYK7pnP2MIVK09R
         ACysIjOAmj/BktLKnlzgm/HHpOrxg9blGOK1x36imA3HCfEdbRxcOlzg1a6BfYf2hC0g
         h5zSWPPHR1LfNOQE8RO1FvkLdB/cKO0yo+X41oab3LBDt7h4wogSl9ZvQtb9RQTGYmhK
         gPMl4MqOQXxLp6QzKQhNee6QoTvdI5wasLLRZht7VOVrD02FJPBU0qdJOMeZrMvomY9Y
         Mc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561540; x=1761166340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q3l3wXZP1srYTWBx6D17j0OpQl3qJmuJ/CIapeLh80=;
        b=t4s90qYaE8ViBugmC0USnyyb4CxpkFFbPBeCEZr0H1REQSCA5ven+L0L3+JB1FKYNs
         E+0a/OIUKYVfwZM6oejn+F5/PXpoBNVigEuTtXJt9JsF0+wncMZIgi+r9DwXMicfeMok
         XO3P08u4SEOvfxZlArCeT9mjzLel3W/9Wb4pJ1Ab1jRJJrcYB43DuXp9B1jUb0EvKUP7
         73TgpsOCS4vCezulD8/+L0h9U3C/VHwxisyib+WL4/7BXa9rRmwLAqCTi887mekf8d4T
         XT158jWyeXYRia9S56F4T1epS+V6/C7kv8u6pozeMHd3HVaSTqNKMgYmJPwqVD9AFO/W
         N/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHk0TwD37Wlrh/JsmJ+ufkdIw8XH46OTrr0MrDIRDYb3i+BKwA7RJlg0/Aq88nDPanGvbCH1idQTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeluceFX8yf750CFIPAE8tIt4LGcoji+XPyZz1PGUt3NFR4fg
	g66F8rz8OuR2B0tgyszUUhBnJIsgmWA9de1U7YUeVSQUMzOr9hGbew01
X-Gm-Gg: ASbGncsofAYTqN6az47ZTvbYyKidGjZ34HN/0zR0Mmypx2tv1x97yHbpD58dSxbXEcq
	Zdu5xI5hmZaHjE/JBxp8KO7nN8U09e8hgrYQ4p5IfwKqSJ0YNBm+PBN3M1Du2mTKLuU/jmkMMN1
	AgHOcAyLR8LNiJU4SS/iwmcPWWn2x07WD3pfnSWb6oN51cKbeejFSI1ql13/0y6deVi20svp7F8
	fRXXQwA7V97jXHkIgNslojpxnfY7mJCayaqWS37rxkFgEUqQ5S1ekiEx4jtm37L1LM5+ujgnf1e
	+EiVQK1ghFxW0WDeSZK9BZTpILYbgwVresXPfXwYdj+cISRf5I9bH736PWn0Lbov06hGgbzmEHW
	ifwXm2zQmWifEB8uNUWlLYxyTYV3HukwpQCjRroLRlERapfsQxRlM3JWvTGKwPXLh5EMVtq1vPX
	5NAqqRQVKd1A==
X-Google-Smtp-Source: AGHT+IHSyWgfprtuMBAJxkjGFH7PXnZ2eurong9CmDGzEOpx+NucIlNRXvqcw5rqha+z6ylJLfGOQg==
X-Received: by 2002:a17:90b:17c2:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33b510ff5dfmr43287001a91.6.1760561539548;
        Wed, 15 Oct 2025 13:52:19 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b6a22b7a625sm514092a12.24.2025.10.15.13.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:52:18 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:53:22 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
Message-ID: <aPAJwqdFY7ldtt-F@debian-BULLSEYE-live-builder-AMD64>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>

On 10/14, David Lechner wrote:
> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
> 
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 128 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 124 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index e06f412190fd243161a0b3df992f26157531f6a1..707e5108efec41f7eff608a09fcebd9d28fa2d70 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -23,6 +23,9 @@
>  #include <linux/spi/spi.h>
>  #include <trace/events/spi.h>
>  
> +#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
> +#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(24, 16)
would it be 8-bit mask?
#define   SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK   GENMASK(23, 16)

> +#define   SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
>  #define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
>  #define SPI_ENGINE_REG_RESET			0x40
>  
...
>  
> +	data_width_reg_val = readl(spi_engine->base + SPI_ENGINE_REG_DATA_WIDTH);
> +
>  	if (adi_axi_pcore_ver_gteq(version, 1, 1)) {
>  		unsigned int sizes = readl(spi_engine->base +
>  				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
> @@ -1097,6 +1214,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>  	}
>  	if (adi_axi_pcore_ver_gteq(version, 1, 3))
>  		host->mode_bits |= SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;
> +	if (adi_axi_pcore_ver_gteq(version, 2, 0))
> +		host->num_data_bus = FIELD_GET(SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK,
> +					       data_width_reg_val);
>  
Not sure I'm following the use of DATA_WIDTH and NUM_OF_SDIO.
HDL doc [1] states NUM_OF_SDIO 'is equal with the maximum supported SDI lines in
bits'. And the code sets that to be the number of buses. That should work for
AD7380 because each AD7380 SDO bus has only one line. But, it won't support
AD4630 (or even AD4030) because each AD4630 rx bus has 4 data lines. I can't
find it in HDL, but I'd expect to also have something like NUM_OF_SDIO_PER_BUS.
Or DATA_WIDTH is the number of lines per bus and HDL doc is unclear to me?
Well, it would be nice if we can have host->num_data_bus set in a way that
minimizes diff when multiple lines per bus gets implemented (if that's not
currently supported).

[1]: https://github.com/analogdevicesinc/hdl/pull/1808/files#diff-d1274cfe2e206aa66a0ecd3da04b3e62fc5fad9e12029b34b226c6f91454d34dR77

