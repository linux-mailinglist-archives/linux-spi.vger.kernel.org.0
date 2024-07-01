Return-Path: <linux-spi+bounces-3721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01E91E807
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E8282F4F
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB016F0E0;
	Mon,  1 Jul 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkTdsqHr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8A10F9;
	Mon,  1 Jul 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860248; cv=none; b=nPmhKPS24G3Lv4Mjwq7vQGuPkGLSxPfkIvVTTAFGpewLAcidEZ9icWGcGufElF3EKpa+H+Oq7t69WagCQKkJqzQHWjMxsVj8x+S99SrVC8JsCzKBPIupmfM2pfWG5TvtdEBTOsrhcDKUHm72U0aKFRd2w/10VwyDfVD6v9mL+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860248; c=relaxed/simple;
	bh=KtojG9gmMRaN5Thu5fzzoxUQw+xxTfLkE0GRtxsthgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9PRy/eoUP9cgwfNLF/C81Z1Z03FX1QXLwu4zQOSxfotj/9jOKeVhIbEcY45C5m0S2XTQzmJjfJRnCRZjkfbnmd60nf3DTYiG4vK/DiQq//O9DMrIX8rJSlPCvDdwZFv7zep78W+8/CWJcXh9zURc69vex0D1l7j4jOASZ2wlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkTdsqHr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295eb47b48so4108198e87.1;
        Mon, 01 Jul 2024 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719860245; x=1720465045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q49UV1fhZoJh55tliUUlhno1LHBht8m9FzffRPOFNQo=;
        b=JkTdsqHruotsJPTCuiAPtM8RFxxIK+FaHMBRYKBhPCqcIZiOkiVQfo1GNFGdsmthnO
         5CKQhqggXBt55V4jrRxUcusC8kP7i2NjbROYGDltx579+0s0DUxJJy/zU8v8ngkX0j5C
         zjoYGVQPki6cddSVHjme7cQ5d0i194hs/GGC/w3NX4VXs/nwoDACsr7sFsrbyj6h+r23
         cydJ0thaYpeHCIsFsQ+V4xBWarNXf7IMI1Z4qUyxokT1lgfVlBMHbfpGdvT+j9K9kzys
         fF+jCrxDAr0P71qHJlSpAsJCLcg4wDgXx96YmDMDNGJ9rPOjR4OdkXZhWEceO8VJPsPa
         /Z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719860245; x=1720465045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q49UV1fhZoJh55tliUUlhno1LHBht8m9FzffRPOFNQo=;
        b=FssAHxEE7y0kSUckcbUlhuqUmA93idF0UHmeZJPTW3JMYXwXNIVPqOt9rgwRrrgAnB
         pCbSylqomTwQoJCrIlgBmzZUmQsKia9LotCHnRhUEIOkZSFN2xi9eNKaIVtduowbtqCg
         At1dEdSECPw3FGnzv09rSGuFjGSBgntao8IYQCBJ6qAFbGwkQkSCnwGhhyEN/IXhQ5/u
         Xfi92NnG1YWoAaBbkyp7EyaVZS2xxhJgPxwnTKE7OLVThM7Ih/gyNg+2fXxlBG3Doqve
         3XxCXQDC/T2l6wdCyvEfzhjeq9PAFIAqgzFELNl25b9P81Xc8QA1H6/6HYB4caVyXvgf
         xvXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS4vJBbcqjyStRsI/oek5qiurfwBAWu/iFYGzM+JL7Vir1ApEFWRdCqptr3U5PsNMYX6MVB1OYf1jA5FQe53tRZ5RbhjECQYlVEJdTnLjQvGQlzKQoM/WVGO6tKm3wQqgCZPho8e0nYclNOypy2CtHEj/8eamej4WmFusiAlOpNJht1A==
X-Gm-Message-State: AOJu0YxpXiTqLV0lkSedqhBM+RfPs6EiN2Ag0dEIDP9nz9B7UAkrqTWF
	WiIW1khEUIefo/ADiQtm/6eIByFi0hmVFwpLoh/Qj2Gg6fevc7Hp
X-Google-Smtp-Source: AGHT+IFg1bUBTgjXF+dS+9kKhJxaeFGRkF8L6asmbi4XVxCVl83HmHprSX+491ZE//Y7XviS0AI7zw==
X-Received: by 2002:a05:6512:1192:b0:52c:dfa7:9f43 with SMTP id 2adb3069b0e04-52e82685fd9mr4470285e87.34.1719860244448;
        Mon, 01 Jul 2024 11:57:24 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e8b78c797sm434030e87.19.2024.07.01.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:57:23 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:57:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Kanak Shilledar <kanakshilledar@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kanak Shilledar <kanakshilledar@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] spi: dw-mmio: update dw_spi_mmio_of_match struct
 with thead
Message-ID: <23gvjkszxvf6zehiqetjfmtf67nlpnnfmhgx234jnxwrtmbdpr@4yv64sz2kpcs>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
 <20240701121355.262259-4-kanakshilledar@gmail.com>
 <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8604c68-8866-447b-a874-562bdad1df79@sifive.com>

Hi folks

On Mon, Jul 01, 2024 at 08:17:29AM -0500, Samuel Holland wrote:
> Hi Kanak,
> 
> On 2024-07-01 7:13 AM, Kanak Shilledar wrote:
> > updated the struct of_device_id dw_spi_mmio_of_match to include
> > the updated compatible value for TH1520 SoC ("thead,th1520-spi")
> > to initialize with dw_spi_pssi_init().
> > 
> > Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> > ---
> > Changes in v2:
> > - Separated from a single patch file.
> > ---
> >  drivers/spi/spi-dw-mmio.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> > index 819907e332c4..39e3d46ebf5d 100644
> > --- a/drivers/spi/spi-dw-mmio.c
> > +++ b/drivers/spi/spi-dw-mmio.c
> > @@ -419,6 +419,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
> >  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> >  	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
> >  	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
> > +	{ .compatible = "thead,th1520-spi", .data = dw_spi_pssi_init},
> 
> Your binding requires snps,dw-apb-ssi as a fallback compatible string, which is
> already supported by this driver and uses the same match data. So you don't need
> this patch; its only effect is to make the kernel larger.

Agree with Samuel comment. Indeed there is no point in adding the
vendor-specific device-name supported in the driver if the fallback
compatible works as-is.

From that perspective we shouldn't have merged in the patch adding the
Renesas RZN1 SPI device name support, since the generic fallback
compatible works for it. On the contrary the Microsemi Ocelot/Jaguar2
SoC SPI DT-bindings shouldn't have been defined with the generic
fallback compatible since should the device be bound via the generic
name it won't work as expected.

Although, it's better to hear out what Rob, Conor or Krzysztof think
about this.

-Serge(y)

> 
> Regards,
> Samuel
> 
> >  	{ /* end of table */}
> >  };
> >  MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
> 

