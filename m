Return-Path: <linux-spi+bounces-3651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C740C91B1B8
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 23:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0EB2175D
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 21:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6CE1A08AB;
	Thu, 27 Jun 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9ryXnR4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9419AD51;
	Thu, 27 Jun 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525225; cv=none; b=XLi6U//LPGQpngpEq32uoTsV+D8D62HF2QmGIhso4ckfnfdGLK40n1+5PoWj4WhfGwNvjyeRGlWg/GlWCAWXNHG+3OZcPPK+Kry18terdOhgeEL7d2MOvPpNOY1DwXaeD5IM3BVepvqz+WgRyU3CWPFvkwSO/vWv5MmlCJQfKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525225; c=relaxed/simple;
	bh=U7A8clRBR8yY3OiIGAJIPF3Dri5hzryL27vRbcT/Nds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqjO2QB35zhJOo/sc6YLQ9wswNqzyEZ5RHtQu0HA9e0l0usLtM0SgXx30O23smxB5/GbwOYamgz5ojKyRedk8fzGcw183FDW3vmCfn3Iq0Yr6nbK7+LJxhat2wXTON6dVRWe5qSAH2PPPHwACloal/E96FVZYOpkRXGjEXEbWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9ryXnR4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso12200935e9.3;
        Thu, 27 Jun 2024 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719525222; x=1720130022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiC8OyZo5GtQNpDjXs/Yb176j6rjJFHOHOaqhOxIjOY=;
        b=L9ryXnR4s07VXGdal6rMksZMMNttEwmTIbNWBpSG9IcM+IonC8LxlGLlM+ltIFydxi
         22jXY31D76ScsNKzgVeqza3bVIt+7NKcGAuBVE2lPosshBlCWZNdTt2mwgdB3s6+YfRw
         ifWCDmQ2nnyLIZmTOz2AHFnsdqe3lGH67JBGMwPnA6f3b+FyEAc2g3kZhNV8qI2SwN7C
         cnqAe4uwcFI6P/W1wXNKrXLStpqC0Tpw0aqFIIugjS3NBn3EXRiEH9Gtz2rd05ccQdAS
         iw0aEJ0f8q4nxeYKm7VpULU3mFNkqloepWR6MF3hLJN+sW9lQYg9LwVxb17Q2DOwVw0A
         Axww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719525222; x=1720130022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiC8OyZo5GtQNpDjXs/Yb176j6rjJFHOHOaqhOxIjOY=;
        b=WoBS0jhPwlto+pHZaHT0K9VjGlcs7C+uOeCKa9hSIXLuwATyxXUMr7SGleoVf+3jjF
         g+RAwFpQjDRgn4SVeyIjgl9FaEapWeVjNrymYn8o4rbWbKGWHPOSpP9l8Y0gRJj+0XuG
         k6DHiQWlwdZ6evLsM2HodA0Cn7xR2MtuRmu2LbFC/YOo3dDkUySKBS0hlbmH0QXU/C0f
         qFjWxk0Cp2QHd24MJX6GQrJ1/lR3sH1JjuryJA2xL/HRuwBtnwgYsi9Ap9vLr/t4D5zf
         NXtRj0lEce4wplwcvZcp7HCS9KsSeWMg2Pv803ZCmHAi4aOXJfl4uJYo+2wUGJPiviSU
         4oNg==
X-Forwarded-Encrypted: i=1; AJvYcCV4inq5LZNC3Xdye0QhOs/KjP8jmXO9JhGJKJwH/ayuYkY0qoFr+vnZd1VanwKD1aLsoC/QxsE9G60KF0egYsMDDG+jWi1Q6C2GpE7RM8HcJb0PR1VnsK9JB3dz5RfuhiiNA1SMcyBZ8urmPdh9CTOm6THKIszw3P6YpYIFoYeKLsOp1A==
X-Gm-Message-State: AOJu0YzbFhmz/CL0fXn6xVBBwh7vGFEE0fg9YpRKv2De3P1+G0/ASleu
	XPzvDMOL0GrXwll9IhYoTV++ClMNz9ifDpg8TpC04NSd0FkcbqSL
X-Google-Smtp-Source: AGHT+IFPuvuGJJ94i4NKhFeIfuJoJov7wY5cyHstcVN1Fc9I1AyuZ6EBpfOPhEwan6qRgjLBbTwknA==
X-Received: by 2002:a05:600c:3042:b0:424:aa40:88ae with SMTP id 5b1f17b1804b1-424aa40890amr67416705e9.3.1719525221682;
        Thu, 27 Jun 2024 14:53:41 -0700 (PDT)
Received: from skbuf ([79.115.210.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5ba67sm8712375e9.19.2024.06.27.14.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 14:53:40 -0700 (PDT)
Date: Fri, 28 Jun 2024 00:53:38 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] spi: dt-bindings: fsl-dspi: add dmas and dma-names
 properties
Message-ID: <20240627215338.qrry6zpkusw5nazw@skbuf>
References: <20240627203308.476437-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627203308.476437-1-Frank.Li@nxp.com>

On Thu, Jun 27, 2024 at 04:33:08PM -0400, Frank Li wrote:
> Add dmas and dma-names properties because dspi support dma transfer.
> Fix below warnings:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb: spi@2120000: Unevaluated properties are not allowed ('dma-names', 'dmas', 'little-endian' were unexpected)
>         from schema $id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

For the contents:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

and FWIW, I noticed this as well, but didn't want to put yet another
roadblock in the conversion of a binding which was way overdue.
I was planning to send a patch as well, once the binding was merged.

But... to whose tree is this targeted? I only got a notification
from Shawn for patch 3/3 (the device tree change), but none for the
acceptance of the other 2 patches.

