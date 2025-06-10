Return-Path: <linux-spi+bounces-8419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF5AD2F78
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 10:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53131894A96
	for <lists+linux-spi@lfdr.de>; Tue, 10 Jun 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B754280327;
	Tue, 10 Jun 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfQ60jpR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132694C96
	for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542637; cv=none; b=OkdcCiYtQFePbKCbVjFV7QXC8nd0iy9JjD79gtjtcnApvQc0oUex9VohYP1VJWLmowKZbO2tyCSrq3PT6Wj1DE8X2MT2G7oMI8qG0GZAxuZZXmnHkoaA2ME5nGvxWBzgkOGPgLs9mGtKbZCQ6yTU/kN5EMzhTcunQIWDtT1SyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542637; c=relaxed/simple;
	bh=pN1EVSQRIO2KMx0u9roMCOPPnmVX8ns7jaUgo+WN74w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABokr95ql4ArpWldh6Zr2L3M3R28/NaqxJccPSgTkmOgRnsdCOQd9RvjvK7cPgllnxXCuRqPzdk76yBdrPLL49tizZw46xEgHyx6K/xR3LgERFflJLIf15tn1a/ZMvpqMhn7Xk+g1ghzmCVbUOovlcTuWX80C2OjDBDuQYQmb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfQ60jpR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4273176f8f.3
        for <linux-spi@vger.kernel.org>; Tue, 10 Jun 2025 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749542634; x=1750147434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAvC7kDNTK7xR5h8hO0ZbtcbLaxyQZxjOMQz6bLjVPo=;
        b=jfQ60jpRub3kOsdBbV4rnvqetXhCEgJFHQmJS00BGpqmYtvj5AwKLHtGXXK8MtEKlA
         bO3VkNjFePpZc91/GNAhBvD+wkOkiXOHWkBXHMg5P5JjGj+3JS8DMZ4EKq55ssB4CNeg
         pr99CdoErkgGfcMAItX33bZQUvoHrBGmzcXtPQpQHB/4ZOrFWffZNnEsIQT7IjNlIBXA
         5HgljA3OO2iNnhnGRaKmOvqAOz0ClKcCzkwcDAmGEQ+35DyIh+h3hBwOajbwDOLGUZFi
         hEk0eLWhii0M8bLARUE9WBBBwfgmvoXbfOeEQkZfI4IoMpAi1F55GyzsitSRucai3TcE
         rNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749542634; x=1750147434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAvC7kDNTK7xR5h8hO0ZbtcbLaxyQZxjOMQz6bLjVPo=;
        b=eqR/BTKC5vCWvYOb6x9hAdVbszcCsqv5XyVe+Ge2eWslmg87XoDIJSve+RSchDbP2J
         nNEwBvNEAwLntnxhmRxdg53PsIeEuaF5Ec9Gn+K3W7hlyNfGw4QJekWz1JWRg7xhCCSm
         N+zOLV5F3C35twic3yr0iIA4jOK4s0JrVqUdkI+HIpK0bSDEz06WlhecnX+dA9CnUvlx
         5aYAlJJBD6V+sq5alOdsU3ybQjwXJlekf9Ta+gU6gxIVfPBP/wXMExhqIzIYBPgzqAXH
         t1R2RtBFJjwL+7/ZtS272dEslZVPIhnIstGqnhUx2/eazy7QftZoI5AJemn56AG3oCU9
         04RA==
X-Forwarded-Encrypted: i=1; AJvYcCVOE9/nUZ+t/eZwKQM7CPavKbEc0L9uStG9JYpT3HslG0+iFD1VOo0JhkN4WDH37nu2xsBz9eoCZg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgFpKMH1MDqlNSFqhLoLQc6Ic3R/MhtM8JTWFI5Du0mHiFVRr
	6B81JHGm/CG+Nk1Q1oMOndTxeTOel+wKrkoJVICwqu5VEBhk8t7n3qrxxd3NTPmgf6/cKbndWjf
	WF+kj
X-Gm-Gg: ASbGnct0prywjPWRpAbpXGvPQlq5IuD9D2/9iJumqdKm4AvGN/cSx1NWRf/glOnOzgc
	I2t/mi7LSYtDAwYi2KQY7oYRPTcbsQ+8wJE9ybmgwgHRqX5uomZ9CJoxcpbRptvx+GAZiTVBvLZ
	Dwy1lG0xbsxrljuSBY6rZUpGG1cKZ+pGzSWCOxmCjvale8AgJh+bmmg/UWUvEKUmFflwxPqMzwm
	JER2DNnjq8eXrILOgRTHF6Ttg805MmcIGIFqtX/sM1Ci649gel72XUsQfdAhUsWsPhEby9hwGjC
	amE86ggk7Z5ytnS/KpWwnfQdeYT0z0VqgSzcfFtwqC3q50VirbIhVMDmgd4yPWO5o64=
X-Google-Smtp-Source: AGHT+IEFVQS1RAQRtTYLAYAEwLnBEVZIBLQ1yFYApHM0Y5r9MiJejuGXV7Kk1Y/5jbNgSTagN19pBA==
X-Received: by 2002:a5d:5f4b:0:b0:3a3:727d:10e8 with SMTP id ffacd0b85a97d-3a531ce7122mr11097055f8f.50.1749542634410;
        Tue, 10 Jun 2025 01:03:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-452730d15f4sm134024745e9.40.2025.06.10.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 01:03:53 -0700 (PDT)
Date: Tue, 10 Jun 2025 11:03:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>, cve@kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] spi: spi-mem: Add fix to avoid divide error
Message-ID: <aEfm5ia_i4DrKnt6@stanley.mountain>
References: <20250424121333.417372-1-Raju.Rangoju@amd.com>
 <aD1ytV8kiWP9ssuv@stanley.mountain>
 <76916f5d-bf5b-4e4c-9252-d537dc00a2ed@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76916f5d-bf5b-4e4c-9252-d537dc00a2ed@amd.com>

On Mon, Jun 09, 2025 at 04:10:53PM +0530, Rangoju, Raju wrote:
> 
> 
> On 6/2/2025 3:15 PM, Dan Carpenter wrote:
> > On Thu, Apr 24, 2025 at 05:43:33PM +0530, Raju Rangoju wrote:
> > > 
> > > Fixes: 226d6cb3cb79 ("spi: spi-mem: Estimate the time taken by operations")
> > > Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> > > Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> > > Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
> > > Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> > > ---
> > >   drivers/spi/spi-mem.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > > index a31a1db07aa4..5db0639d3b01 100644
> > > --- a/drivers/spi/spi-mem.c
> > > +++ b/drivers/spi/spi-mem.c
> > > @@ -596,7 +596,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
> > >   	ns_per_cycles = 1000000000 / op->max_freq;
> > >   	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
> > >   	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
> > > -	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
> > > +
> > > +	/* Dummy bytes are optional for some SPI flash memory operations */
> > > +	if (op->dummy.nbytes)
> > > +		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
> > > +
> > 
> > Hi,
> > 
> > We were reviewing "CVE-2025-37896: spi: spi-mem: Add fix to avoid divide
> > error" which was issued for this patch, but this patch is a no-op.
> > 
> > If op->dummy.nbytes is zero then the original code does:
> > 
> > 	ncycles += 0;
> > 
> > We don't divide by op->dummy.nbytes.  Was something else intended?
> 
> Hi,
> 
> When there are no dummy bytes for an spi-mem operation, both
> op->dummy.nbytes and op->dummy.buswidth are zero.
> 
> This can lead to a divide-by-zero error.
> 

Ah.  Ok.  I didn't realize they were connected that way.  Thanks!

regards,
dan carpenter


