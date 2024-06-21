Return-Path: <linux-spi+bounces-3523-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B5E912253
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756AD1C23A4F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251A6171090;
	Fri, 21 Jun 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9cbJDMk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F416DEA9;
	Fri, 21 Jun 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965378; cv=none; b=AMnqv33R4PjbDz2gUDoVKUSbecIBKCoicMl7GUHhRYklDR/3Gd8xcpfy2qAGxNhuBUmkF18BV3axeERU59qnh424//LTWvxsgUB7sMMlbq5jhx1lizga2OkyGUExLaM23c4cGAjEQOuVTc7U25eNJAiilMGCbEUKEkSoJR/nznU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965378; c=relaxed/simple;
	bh=TSwRMDRga/1dOIySBpm82JhQM0xRqtYGsuG5K6KhxEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEw/DrY2Zfj/fB2vZFJzVexNnZoCK9YAHO8tBTGtCRmndxfDtGu+w5Kg8Aa26VyglsYkYpPnTNir7Jr8+JjnomgFXkEFlJEvBvD1VNPDsuU9XqAvKvZTifjVCB0uMcuh+/zEFpk8RD6DYkFJGWf2dVvl/te0/ZQm6u5Ni7UwQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9cbJDMk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so3032948a12.0;
        Fri, 21 Jun 2024 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718965374; x=1719570174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRU/CLMPMIdyJLsUDddkWEnZJa3UQNsHKLmP0cyv9wU=;
        b=i9cbJDMklYT6l8Oi+gyKIdUUridFoUTGVayevJA7X0JFb8M1UPXzAZYO97VTZAc1sv
         Ij3NuZNJlTHExlvec9fpuGOKld0ZYZFyGxqPLF+zWcThFPgIFhNv8jjoiUbZQZ6C+/41
         WeflDtKWdmDqXHHk6xTO2rIbL2o6BAWx2/44Tj6BNCx7QD3cDlVOyAp7Dz8PtYXtXf2u
         mdUhfwQruSq/6wv0OkPePZLLSOeESkxkYZVswaHdvXZkqeJbXEsxBaAl3670SdlYF0Lf
         w7c1i6GiR2gSGA1NhtjhukC7XMaFrKIGmZR8N+Jpxi37xBktxzpU0p1T7TcMGqNrYwmO
         YmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718965374; x=1719570174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRU/CLMPMIdyJLsUDddkWEnZJa3UQNsHKLmP0cyv9wU=;
        b=HV23yHdnfFL2sxRleKPA5pVxEqEatRHVR7DPXOX0t8HIo6P56Oljlv2pbgUBgd+p0g
         AQht4RuK3TUEJYtEjz92P1I+MQGiNZ8Nh6/CpmuSBiCUC1/8iXvB1Ewk8XzikAlwGGV9
         vgbpCdMUs5YiaprcXShRfjoWzV0NGCdddzkd64z/cDw6Cj3en+Zb4Tjo0SeWVS33s9q1
         h4Pf0eQjN+tMzPwxbqChwV1VGUxtK621kbTzoYF0Kbb4SvixqxRJMJuCDRWnKqv2x56j
         Gi+gzq4XtHf4BE2NhTIEPdXsXPa8ojhIW2RT7ZC+S2OZGpTcGrp49jQ+urRonV+EK+7s
         /viw==
X-Forwarded-Encrypted: i=1; AJvYcCV46saGmxRyMIh2bl5KUU9TEb2WjDCMNHzQE5pDvHMlEHWZLuOiHk/CvRhu4GeGjpviwc7gSlRwcRksaVnHNxKg8jecePdLlQwBWfNSZmQxGxlLtwrtPgZ1NGXb+bB1eYoVcRg92gXrEYdSG2I+OJDb51uTYfbWWBjU0FJOQ4TC1NDJWA==
X-Gm-Message-State: AOJu0Yx+bBWoqDRh5kppQdWhAKPyOMeWLeUDY62jpCvGHqlhNn1nEm2C
	PulB6N1EL0kxsZ7+ln3mrdDu0nlnwlvz9OBAYuiERzqx0JvVqBRR
X-Google-Smtp-Source: AGHT+IGwy3qhXOfp29GIKRxhqtXvx9J6dgCw1Tr9xWky4wRxbgPQtZwYLyM+DZSsRDqAp9hh6L6OqA==
X-Received: by 2002:aa7:c603:0:b0:578:6360:aa11 with SMTP id 4fb4d7f45d1cf-57cf7a5732fmr8074633a12.5.1718965374192;
        Fri, 21 Jun 2024 03:22:54 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30564be6sm723550a12.93.2024.06.21.03.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 03:22:53 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:22:50 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v3 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Message-ID: <20240621102250.oc2cck26tpoqsywz@skbuf>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>
 <AM6PR04MB5941CD3048D65DABD19256A488C92@AM6PR04MB5941.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5941CD3048D65DABD19256A488C92@AM6PR04MB5941.eurprd04.prod.outlook.com>

On Fri, Jun 21, 2024 at 01:28:28AM +0000, Peng Fan wrote:
> > +		cs_sck_delay = spi_delay_to_ns(&spi->cs_setup, NULL);
> > +		if (!cs_sck_delay)
> 
> `if (cs_sck_delay <= 0)` ?

spi_delay_to_ns() returns error only for SPI_DELAY_UNIT_SCK and for
unknown units.

The first case never appears to be set by the core. Only spi-dw-core.c
and spi-dw-dma.c set SPI_DELAY_UNIT_SCK.

The latter case seems to be mostly avoidable defensive programming.
spi_alloc_device() gives you zero-initialized memory, which means
spi->cs_hold.unit is by default SPI_DELAY_UNIT_USECS (0) and so is
spi->cs_setup.unit. Nothing seems to set the unit to an invalid value,
so the default case appears dead code. If "u8 unit" from within
struct spi_delay was an enum type, it would have likely been fine to
even omit the default case altogether.

There's also the curious case of integer type (signedness) mismatch
between:
- the u32 type of "delay" processed and returned by spi_delay_to_ns()
- the int return type of spi_delay_to_ns()
- the u32 type of the "cs_sck_delay" and "sck_cs_delay" variables used
  by Frank to store the output from spi_delay_to_ns() inside the dspi
  driver

The interaction between these data types means that:
- The "if (cs_sck_delay <= 0)" snippet you suggest will simply not work,
  because the spi_delay_to_ns() function output is assigned to an
  unsigned variable, which is never negative.
- There is a theoretical possibility that a large u32 delay returned by
  spi_delay_to_ns() is misinterpreted as an error by a caller which does
  make an attempt to check for negative values. However, simply casting
  the value back to unsigned as Frank does eliminates that possibility.
  Given that ultimately, the setup and hold times come from u32 device
  tree properties which aren't range-checked, it might just well happen
  for someone who does check for < 0 to trip over this. It might be
  worth somebody having a closer look at this situation.

I don't think that your suggestion will produce better code.

