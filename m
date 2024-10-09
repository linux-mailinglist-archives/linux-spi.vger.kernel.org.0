Return-Path: <linux-spi+bounces-5171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115D99680D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E551B218A1
	for <lists+linux-spi@lfdr.de>; Wed,  9 Oct 2024 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487F190051;
	Wed,  9 Oct 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmyYod/I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8439618FDCC;
	Wed,  9 Oct 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472129; cv=none; b=Y7Z6YPf6dRaMrH0ifeXCd2E2r1iMktBH9aAZJLSaDuBVVWGLFhhb+sn0YgmSX8ehEV7sCYM+cfp9Vwalkr1hor34QdqQ1jhURkjO0jdUrcJWvW6ZwNEloNeUKpOKzweX5lYE5zLm3Wn5P6f2r6iRir5Wz1FwRoWbq3Dt3NDP3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472129; c=relaxed/simple;
	bh=UIAyPl+9jzUQ22laObGiczjWDSev9JKsaGvbNx7tjdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd5ksoDng+zc5cKc4s7Jo6QSwhHfymCcuObE0YrPGySZBXfdW++DtkTjrBfMSljvDEeq/WjQhPwXjRs5YbeR9xXFz+O0aCz2C76TO8pKupNizx5si/dWTbLdTLY2RHFPaDM4p6TTO+Q9n5bO/ri/giSjC295HeKvRthf0HOLBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmyYod/I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4305493bc6dso2943615e9.2;
        Wed, 09 Oct 2024 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728472126; x=1729076926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8QUDh52m9TNIJ0PZ4ww5a968ccrK59qbkwAoVHWIJQ=;
        b=EmyYod/IoOubucapsPM9ixi3OmQrL/f9Zh4RWEv2yaMmEWK1i9f4QG30j8yI3Dfl5h
         F4cuYSfschTJpZHKlsAY4JNyU21JUeahkmlEVelF/77kX5blrIDmB0WVkc/qAJ33rSWF
         udnD7oUjl3nRJXmNRVloj/+sKnSEWBGwnyNvplptTFxhKgDoJxLwxAj5vuNywU9m88Wt
         +Io1Q3ywHZ2UrIk1kW3GkDPejTpYgfoffx7OZBo85KQ7nE5Gq2gsPtGGUcpntazg85zq
         gD/+H02UUbwO8rfZ/YZEkjM0Vs2Rxhdw6w6/1V5LKV+zT6qkXsQfRwf3LjSvbHTTYa/i
         Fmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728472126; x=1729076926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8QUDh52m9TNIJ0PZ4ww5a968ccrK59qbkwAoVHWIJQ=;
        b=l5aULa3x/8k/M7lwuK0OedQrJnFTI51wYZHygYpQyYc4QBrI/CH1QcgxexwWTXEr0D
         WWR9qRLPBM9gn/Q8DwsqFHZvifVdy2Hm2Hu3oh+gKpeDmTZQ7/L8yC8GFFzrvLc1vNGN
         S0FolK1TDGWLIZ5zaoBhW4VZ6UUINg8mMOfWH99X2OLGMZQFQgodCfabJ66qrT5NjO67
         YFKJOKF4fGw/qCif8/0Kp9NonbdzOuS5MKlwrQ3kpnl4/CijCJ2sSHpUp8kWpKYrmOpF
         2sM0+UtVDwxgPZgvThlsyLtH6LEDK+/mgJcZdYZGk5DYm52CoyJQsOro9a7KU7BBzt4f
         afwA==
X-Forwarded-Encrypted: i=1; AJvYcCVbdK12fXoOqJfGt1ZT0mpjruyJTC2UoJ4isXu3PEc6exh/zPF2i0VSqEIMK7HK6Eo3pSgAlkBHypb+@vger.kernel.org, AJvYcCVgbs3TFk8nDrxIj1rkPLxKjQjGsv2ExeQPdOlmdmitXuVKCdrRgPTjOYiFKoCjxZTWOCKsRXCnG0HiTs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy549sVvTJYfte97VgUBBqD4i3TN+UHPl0vd+4ErGMor3zCrznb
	tdLeJYBJdToJz6zsAS9B044kUmUr5CbNtzXDvNEXzL0O9o9CPnSz
X-Google-Smtp-Source: AGHT+IFDU5slgFFtiAB4ooSgNPxJIbNKZJJQlZQlPymnfSlop3jhF82LyfZTOAynRIvkGDE48V/9ow==
X-Received: by 2002:a05:6000:144b:b0:378:955f:d47d with SMTP id ffacd0b85a97d-37d3aa7927amr779886f8f.11.1728472125581;
        Wed, 09 Oct 2024 04:08:45 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993897cd3csm597381066b.78.2024.10.09.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:08:44 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:08:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"frank.li@nxp.com" <frank.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: Fix Sparse warnings
Message-ID: <20241009110842.jhtyt6ckbfp6medf@skbuf>
References: <20241008055644.4900-1-hardevsinh.palaniya@siliconsignals.io>
 <20241008-impossible-mysterious-salmon-e1b8bd-mkl@pengutronix.de>
 <PN0P287MB2843E06597DD5D64BE93A8A7FF7E2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0P287MB2843E06597DD5D64BE93A8A7FF7E2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>

On Tue, Oct 08, 2024 at 08:43:51AM +0000, Hardevsinh Palaniya wrote:
> >Have you checked the code on real hardware or compared the generated
> >code on the asm level?
> 
> it's just resolve casting warnings so....
> 
> No, I haven’t tested the code on real hardware.
> 
> Are there alternative methods to verify it without using hardware?

"Comparing the generated code on the asm level" means running
"make drivers/spi/spi-imx.lst" before and after the patch, FWIW.
It's about the most you can do in absence of hardware to test on.

