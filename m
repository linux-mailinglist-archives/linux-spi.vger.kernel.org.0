Return-Path: <linux-spi+bounces-3653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338191B20B
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 00:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E4D1C210AB
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08831A0B06;
	Thu, 27 Jun 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXxsqcrj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A970266D4;
	Thu, 27 Jun 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526428; cv=none; b=VdJoOEUp4RJk+dH9Ea7IIWFSGN5wD/x5lormItu1J+dLCaRKoITfNtzFEmhpT4NMq9NdNRL4DkLDIYENyiV8cZLu49lFCXuGYttLZNC4++KZtLq+rtfKVEVYUPvfPg6Lzo2W+GSaJKuowhBlB0q3vp8LYMpZeIyyFYI5hIvw3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526428; c=relaxed/simple;
	bh=PJtHNXt5xhdpnPi1S0hdgD9An4T7UhkzlMgAiH5twrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXoLu0e43Pgn1uilaiCZqaN17pg/GUG67Wl9wU1E3nPxyDolUR8CuKLDBLadiGbu45sA7oevNLrNEa/QQTjnN6HVGRJugdvKEAA3QBaw2S/ynFkZaZ0ygl2XEqa4lrKmKo2UGGUMjkKZtxUJs+yiJ+1t4WCfu6cefmu3NUEfyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXxsqcrj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso28795175e9.1;
        Thu, 27 Jun 2024 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719526426; x=1720131226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/rFsDxh3nwIfQg18F9xjhHPwne2si1Ovzi68PnLOqk=;
        b=KXxsqcrj8j24bjS9xCvrD2KNnFJbeWW7UxZQNxxLW0slobSZkSTb2I9vbR11ZuIl5F
         UkBU36z1OQqromLcI8b5ib1S5F6k9a/JT4Oq/oN3AD4bK1GR0bn+4iU8XjSK/JQfoj6+
         5fi911m8ygmsGp2WiHDxlTTRhxdAJ7nDNJvWMixYfxNVySk3dbA9KKx7BsveNqsTc5hR
         tgg6iEA8ONS87A5Nek9NPL//H4sv0sD236UBs8gLmnBoyfFBAGIoQViLuReOhrcOujj+
         AgxYUBOtvxKRQgXt1W9cORiK/cDnf3setE1pNgqOO7DlkWjl0S88xTsvg2KkzlgBrQBq
         t96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719526426; x=1720131226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/rFsDxh3nwIfQg18F9xjhHPwne2si1Ovzi68PnLOqk=;
        b=lW9ViSJlBbS1cVLeJFbcMnWPwlwu58W9x9zHipQG+2ZmpfKnaaS6Nl4YRckjY8Kr0+
         NHIxPIffhhIvVfAx3BlYvOQiXIznJClmz3lxI0nw1MYXPi9BgdaEehLM0UFTOLRYnMho
         qv8rMw0s6z1IwuZUPCXDGchDIFWLDU3NBB1wD+LiEBFE/z6Ym8bJrSzBCHvRBZM4dyWX
         qew3oySuKvXcOeuUIOCxIK2F1GOliWu05CDgXELtIlDY54CrGi8oWLGP4X9/T0GQluVg
         ZyWxvDQBZJKgrj8S3aeL4L/cU4jit5SStjs4Ay+ojM9EOjqr7z+/cEIGy5blHks44Bbv
         8ukA==
X-Forwarded-Encrypted: i=1; AJvYcCUlROfExw1UvfVhT6gi0CHt3zLKnTbfd4Mvg2SGSYadqsQGxlUTN89HNutEHbFG+chc+veFGsmd24UVvujdbQrhFzDS1rWZIA6TGNderfsg2nl9Ty5nruplaHR2ed8ls3o+x8kxbq7XVPi5Q8VF5RsdetYTdQXcpcxu551lbuDRP3o9KA==
X-Gm-Message-State: AOJu0Yztb5FD9lLonZwtweeMDJFjdXC+zf0s8GLckUIeA2gQpVIiqBL7
	92fykVf2yY5C+6ozcwaHUYSsb75IaCcUnwJK0b9V76UtHt4Scz8yBUJ5tteI
X-Google-Smtp-Source: AGHT+IHCtSExRriW/XH2nhOc1jBWGaEOWvV7SvmGoJ3haFGm6g7tuIWcotwJ+F3u6MEYEmrMnhpXIQ==
X-Received: by 2002:a05:600c:2e04:b0:425:641c:5f40 with SMTP id 5b1f17b1804b1-425641c606amr27217095e9.39.1719526425486;
        Thu, 27 Jun 2024 15:13:45 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf90sm9222035e9.5.2024.06.27.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:13:44 -0700 (PDT)
Date: Fri, 28 Jun 2024 01:13:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names
 properties
Message-ID: <20240627221342.zi4iw5nnvumyijyc@skbuf>
References: <20240627203308.476437-1-Frank.Li@nxp.com>
 <20240627215338.qrry6zpkusw5nazw@skbuf>
 <Zn3ijCEwiqgFfwTj@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn3ijCEwiqgFfwTj@lizhi-Precision-Tower-5810>

On Thu, Jun 27, 2024 at 06:07:08PM -0400, Frank Li wrote:
> On Fri, Jun 28, 2024 at 12:53:38AM +0300, Vladimir Oltean wrote:
> > On Thu, Jun 27, 2024 at 04:33:08PM -0400, Frank Li wrote:
> > > Add dmas and dma-names properties because dspi support dma transfer.
> > > Fix below warnings:
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
> > >         from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > For the contents:
> > 
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> > and FWIW, I noticed this as well, but didn't want to put yet another
> > roadblock in the conversion of a binding which was way overdue.
> > I was planning to send a patch as well, once the binding was merged.
> > 
> > But... to whose tree is this targeted? I only got a notification
> > from Shawn for patch 3/3 (the device tree change), but none for the
> > acceptance of the other 2 patches.
> 
> This patch base on the below patch:
> https://lore.kernel.org/imx/20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com/T/#t
> 
> Sorry, I miss understand 3 patches already picked. Actually only pick 3rd
> one.
> 
> Frank
> 

Yup. I guess it's best to resend a new version of the (reduced) series
to the SPI tree now, with this patch rolled up into the dt-schema
conversion, and the review tags preserved.

But you might want to wait at least 24 hours since you sent this patch,
to allow people a chance to respond.

