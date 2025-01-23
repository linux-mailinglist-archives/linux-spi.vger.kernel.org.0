Return-Path: <linux-spi+bounces-6439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F98A19E0E
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 06:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A107A05E5
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2025 05:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427901ADC75;
	Thu, 23 Jan 2025 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaGuuetV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D0450EE;
	Thu, 23 Jan 2025 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737611183; cv=none; b=O3aL1pbbJvPllYm9s7AbPKI0K0KJQYq+eULioPW0UhV5EybU5xeUGMIwygdK4N4pQmytPLSh0YboOin2JAaDlVTNo2H6bJRKFkmuFFsT6iOjP/qwDs/Am2lKgywBsJarsfPlp5Shya/Oft43/UNpvc/Ottt3oT1ozC3kbVfI1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737611183; c=relaxed/simple;
	bh=gYzXEE/fvex94ajgQ4ncNqZBzewWqD0E7mK1feIaoPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGpm1ytC7jQoXfrpuAzIczuJ8yTTP5ZPob6W7oOQE8dIgqVDSSxtuubhZyV2hjM2RZeW5NTf85+cRdDoxdPYZaMHd+4LAUcl2drkt9XbI65+ytYhyLxR7rPIdL7eM+JpQ0DsRb/v4yaTS22icuPyIYV3LU2AGpoDOW6bI4z2W8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaGuuetV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385de59c1a0so231282f8f.2;
        Wed, 22 Jan 2025 21:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737611180; x=1738215980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXjAxn/9wbJGkC8jm0u2f9YtmtdDoHb2EauDzRQLYR0=;
        b=PaGuuetVKPFQoaAeyxVw58P45getjiOwWa/eJ0v8VkDTcI2qwpJaZ5SjMMfGpKQi8p
         lbk9s+sjMbxgJrPrWRuYk2zq5FTkL0w5Om/PAQQBnOVRNB2YqeFdcX0epWB0uAcZi8fk
         HRsqyymzSrZN3XO9OQKHC1xdX/pntLEoeF25SOaupnZF9sp24FbNQHbnrMOPpPOPGjW6
         88OcNyMcRGdsUXwIEOxiXi879EVN5zZS5reKEl/6WxzgC8P1j8eRJmKt0MU/YHqemi/9
         y+gXaVIqbKwOCKG8UHccJQzrjB8OtSEYzSvdCmgHBCRaOtZdkqMV3grz7G1dLRlCvRK+
         ADGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737611180; x=1738215980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXjAxn/9wbJGkC8jm0u2f9YtmtdDoHb2EauDzRQLYR0=;
        b=QQowVrZT6wIuySGWVMWG43r+lcaUSmGHIL8uqczEx+TozRAxLTBdkioCIeKvQO2ab2
         fJNp3LottKZsfoh9v5PLZvADQu/zVFSTVXsc9XcKnupX0dBzcLJbb7svC8A+91z3m2j3
         RCrWgcNUFvBy0xUuS/r8jUOvoyzohXVkAPjE90wccoVAHOBAB+ktzdHJy3QcWiFlBe9d
         KhqGqdVlUrxpe5qUC7g44KXP2lxeivNHUT+2KN7NXK5HRFinQOxYt4zSjwsvNx8nEle5
         I+gLIlBKdWMtUg967sW8OTqWHuN2uiup2spy/FxwXMkYNNDrodSTpl21yg59Fu2At80w
         cpDA==
X-Forwarded-Encrypted: i=1; AJvYcCX+SNb5h+gxHAeSDADXH0eRTPj3j0DrH7Tixvu2HEPE5xyY9PGoL1py0X/mYj4wHNh3ErA7pyKQEzMndnA=@vger.kernel.org, AJvYcCXJNA3CHGyFQ3xPKJY7EaZTN/lTO2IKRZNT4mgKPvi41+hljbHkiALGUDnNY1FZlRrefTAky/3V@vger.kernel.org, AJvYcCXy2xkhiZbJ9zxEiKJeThA4iHc6Rk0bvHKFxQuVxzjS0GyNaeo5+Of4dq4++lNyAcBBTunO0aUJ63s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1GM2Ad/zQeYmCVoMM7cDCg2lmO/E7FlSDeOITYEGLdYFPCJd
	2IUJWOpHpFr0sccbr2Fovv092D4eID7VV6Yh3QL7kW0FGMC+BJZa
X-Gm-Gg: ASbGncvGvrG7TJ+KbztCjfOKZgXtYAE9VRk+rYf07lv/8S1t/NkLLIt91B/ZXCpc0RL
	tPaK1Q1IjopcViBYHPphCYNyrIMtzcJAP4vW7eCDzHo2K2DwGXTwyJoXbfLZp+hfJ++hnP8Bwh3
	n2CSZu/6ERtZUpjm/CkQV3Z0f2vUmEUa6NB15nW3eP9wQ2eZexZ6FD1mJiC+jfa91gjw23y7zQ7
	i7i0PyAqcpkkJ7/Jtu7vm6b5sfwM1p4AtaynVWr7pWl5gKW1XSsGlJPxfsHE4fuy9dyZ8lQQoPZ
	pTB9+bKc
X-Google-Smtp-Source: AGHT+IG+klG/XbdpMoEklenqILa/Ic39FEOtmc87XAwNqW9ncOi7UGbxA+N/P5FJEPIoUq46Oi+XMw==
X-Received: by 2002:a05:6000:1561:b0:38c:1270:f965 with SMTP id ffacd0b85a97d-38c1270fb77mr9637593f8f.42.1737611179404;
        Wed, 22 Jan 2025 21:46:19 -0800 (PST)
Received: from tp440p.steeds.sam ([41.84.227.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322ace8sm18292401f8f.53.2025.01.22.21.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 21:46:17 -0800 (PST)
Date: Thu, 23 Jan 2025 07:46:10 +0200
From: Sicelo <absicsz@gmail.com>
To: Lars Pedersen <lapeddk@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev, broonie@kernel.org,
	linux-spi@vger.kernel.org, psiddaiah@mvista.com,
	phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: SPI regression seen on ARM am335x in kernel 6.12.8 and 6.6.71
Message-ID: <Z5HXoq8XlduURWmw@tp440p.steeds.sam>
References: <CAKd8=GsoKj5eG6VAMkrxMbzNyoBX=JiwafrfXman8xMNK+XU_w@mail.gmail.com>
 <2025011703-erupt-oblivion-82a0@gregkh>
 <CAKd8=GtrnvEgZv4y-UYNTJWt0oU9zLxZUYGnm9__H2yXKwyOGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LgJ3JBQbceYg8kUL"
Content-Disposition: inline
In-Reply-To: <CAKd8=GtrnvEgZv4y-UYNTJWt0oU9zLxZUYGnm9__H2yXKwyOGg@mail.gmail.com>


--LgJ3JBQbceYg8kUL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

On Fri, Jan 17, 2025 at 03:49:25PM +0100, Lars Pedersen wrote:
> On Fri, 17 Jan 2025 at 13:32, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 16, 2025 at 03:21:13PM +0100, Lars Pedersen wrote:
> > > Hi. We have discovered an SPI regression when upgrading from 6.1.99 to
> > > a newer LTS version. Same error on kernel 6.6.71 and 6.12.8.

We have a very similar regression on the Nokia N900, causing everything
on the SPI bus (WLAN, screen) to stop working or be unreliable.

> > >
> > > I think we have identified the problem down to the reference clock
> > > calculation that seems to end up to zero in the spi-omap2-mcspi
> > > driver.
> > >
> > > Also we think it relates to commit
> > > 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad, where OMAP2_MCSPI_MAX_FREQ
> > > is used as fallback on error. In our case it seems to hit the else
> > > case.
> > >
> > If you revert the offending commit, does that solve the issue?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg.
> 
> No it doesn't solve the issue by reverting the commit. The commit
> isn't the regression, but it attempts to handle it in the if/else
> statement. Everything starts to work again if we hard code it to
> "mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;", so it seems like the if
> else statement isn't 100% foolproof (or we have missed a setting in
> the device tree).

The commit actually *is* the regression. The subtle issue causing it is
that devm_clk_get_optional_enabled() may also return NULL. In the
previous code, the NULL was not considered an error condition. The
change to the IS_ERR macro causes the NULL condition to be unhandled,
hence it takes the `else` path. Using IS_ERR_OR_NULL restores the
previous behavior, since changing it was not the intention of the
commit in question.

Please check if the attached patch does not fix it for you, and I can
submit it, perhaps with your Tested-by. It does resolve the issue on
the Nokia N900, for both WLAN and the screen.

Regards
Sicelo

--LgJ3JBQbceYg8kUL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-spi-omap2-mcspi-allow-NULL-from-devm_clk_get_optiona.patch"

From 451b01800b7fde7be3fa64b3eb87d8ff91628eb4 Mon Sep 17 00:00:00 2001
From: "Sicelo A. Mhlongo" <absicsz@gmail.com>
Date: Thu, 23 Jan 2025 07:38:02 +0200
Subject: [PATCH] spi: omap2-mcspi: allow NULL from
 devm_clk_get_optional_enabled

In addition to an error pointer, devm_clk_get_optional_enabled can also
return NULL, which in omap2-mcspi is not to be considered an error.
Rework  4c6ac5446d06 ("spi: omap2-mcspi: Fix the IS_ERR() bug for
devm_clk_get_optional_enabled()") so the NULL is handled correctly.

Fixes: 4c6ac5446d06 ("spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()")
Signed-off-By: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index add6247d3481..cde4416f3cb2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1561,7 +1561,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
-	if (IS_ERR(mcspi->ref_clk))
+	if (IS_ERR_OR_NULL(mcspi->ref_clk))
 		mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
 	else
 		mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
-- 
2.47.1


--LgJ3JBQbceYg8kUL--

