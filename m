Return-Path: <linux-spi+bounces-3525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1866691238C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 13:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B821F278F3
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 11:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7612178375;
	Fri, 21 Jun 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFpX9f7q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A5176254;
	Fri, 21 Jun 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969166; cv=none; b=Wkk4wYB0sd+BNNYEzvJh74oqHJyhAAIiKmPp5IRWhhyhx3wBkp0blh8zDKaO2s+5sNUzsddUDidvQtf+O9aQAk0Qze35vbHeIi0QtQ25utehAp+fC1zUtAEAw3MYt2SBZHn8noT84iAxOsLkmIuEPgLgZofr8CuRPvWuqvsQQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969166; c=relaxed/simple;
	bh=Q8DyGdBcYAgq64z9X9TWI+/sf0rsMrpXcgbn82Vmdc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXiTZ2vcDfo8CoOJtbJA/laWdTUnuiYbImAOn7g4zw4VmXvNi4sk+9hJMNjjb9nSp3adIQz0n7xoNYUlZwx/d6QbP1nj04oaNCK7K8eVD7ZAMY90PZ55gvOPoIwnS4vglu29wx2K7QTn90Vi/hH7Fl7XAyDjDa4EKqP1bv+3ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFpX9f7q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso265014566b.3;
        Fri, 21 Jun 2024 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718969163; x=1719573963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i8sLZv1n+Ku2QMjcmS+4EdIPRc6Cam45MqmcajWwNAI=;
        b=iFpX9f7qrZqD2nv3NfjMY/YQhJpZxJQKuolCxt24Eu/iMdV+GbuBnZiUTiGXXi2bph
         DnlvMVqTEAFLHzCCGhU3d+cavpdKtgv9tdne0Zj4hGteS/kh6dBCjUDl+6yPr61yhmDF
         s06eCV+aRRp2iXabGHfVsNoI4HLnzO2GI+kY2kPLYAxNkUqJSzoaSs55ZhjpCmcriBD3
         HKGkZtJKqYcnNANewbZ/UYhjeNg2LC5t8nlIiVAaM//Y2VU5MgLk8J4YbpazJHUMv3bv
         akxdG2iCw+/RLJiaUI8xfXWaVcO4RUvn8y3rsBAV/JSongdoHEXaixTmRU0ZHEY1RbXz
         411w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969163; x=1719573963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8sLZv1n+Ku2QMjcmS+4EdIPRc6Cam45MqmcajWwNAI=;
        b=v3krMuxs2DMmlRQoZ3kToW8VNzdR5t9FcpfSGZnAYJ5z8yU6P6SeGRnbyCvt+odlyc
         96uPh1id1O0C0ZaKEqxi6QOVmMEdF8U47bLYGcBLn80OycMIA7K8gcaLQmiyQwiMXEMT
         E0tAKKlIRDFLZr/9BEb1EsY1x0VUQR34eriKgpjN/pirdCclXzCVtSouLHRmaM/dzLCA
         4U/Gp5eGN8gsAaQQdvlcf9J9PcqeH7WqskZuHXLl3+dsV2eGwZ7o+dk2RHkoUaldMImW
         +c+WZPNXxir8NOvPVqflism0tWnXwk/AfIMR2tBu7m+/aQztdUKipJwyD7tOU5juGfGn
         I5Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXd+5jTdgq53kP/yrXua9FtS9n7H3E3zdjGXnKb2Yyq/2aWVAaGgCCYGIcI0aNJg/aJfIthYTckJ6IyzHZYOMMcKVNkBW57a/Y1hjsy0zscezX9WEnocFop/yxf4B5rjVkne+AZ2gEvoeVdl9n8e9CiXEj7I2y2WQ4/uKu4SAtMU56SFA==
X-Gm-Message-State: AOJu0Yx6jBU7+AfT1FjxNzCFtlj6VrHisB7qnf5iNCMQAxg9Vcn+ZTGN
	xNr49cMEKZfQK/0NcKyIJgPTUPu335gBL3LZ56qOAPUlPNAupSoq
X-Google-Smtp-Source: AGHT+IEyjIILM29yLfV/vXCYggcQVFh0n6Mx/M2e70SYGzH2rtFIwFqH2zYjTAuliqRLT+DG1jMAKA==
X-Received: by 2002:a17:906:d283:b0:a6f:6701:cd5a with SMTP id a640c23a62f3a-a6fab643427mr420372166b.44.1718969162970;
        Fri, 21 Jun 2024 04:26:02 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b17esm73795266b.88.2024.06.21.04.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:26:02 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:26:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Message-ID: <20240621112600.sshdjicucwtigq64@skbuf>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>

Typo in title: property

On Thu, Jun 20, 2024 at 12:58:27PM -0400, Frank Li wrote:
> Use SPI common DT binding properties 'spi-cs-setup-delay-ns' and
> 'spi-cs-hold-delay-ns'. If these properties do not exist, fall back to
> legacy 'fsl,spi-cs-sck-delay' and 'fsl,spi-sck-cs-delay'.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0a2730cd07c6a..7c1f8af9d215e 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -1018,11 +1018,15 @@ static int dspi_setup(struct spi_device *spi)
>  	pdata = dev_get_platdata(&dspi->pdev->dev);
>  
>  	if (!pdata) {
> -		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
> -				     &cs_sck_delay);
> -
> -		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
> -				     &sck_cs_delay);
> +		cs_sck_delay = spi_delay_to_ns(&spi->cs_setup, NULL);
> +		if (!cs_sck_delay)
> +			of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
> +					     &cs_sck_delay);
> +
> +		sck_cs_delay = spi_delay_to_ns(&spi->cs_hold, NULL);
> +		if (!sck_cs_delay)
> +			of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
> +					     &sck_cs_delay);

Keep the 80 character line limit please.

