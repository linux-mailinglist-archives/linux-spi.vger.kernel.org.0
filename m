Return-Path: <linux-spi+bounces-3176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3178D633A
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC3A1C241A4
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583D158DA8;
	Fri, 31 May 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzLsrbog"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59983158D8C
	for <linux-spi@vger.kernel.org>; Fri, 31 May 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162777; cv=none; b=m2lcJojam/ZFt8BSHD736SItAcm/RYj8VTenI/ub1fDOpk+ZV0iUWlHTAcFjnEOQ6QJLdm3ZKW5IXpDSfzNSGcEVOLa8jXCgJRwma9BRq0xLKgIqHMTaf9quT5SvyEAxSUFvtjSpW+JIaP3ScP1U9rU1sCN8Zk0GiH+8vnOQrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162777; c=relaxed/simple;
	bh=eZuM433Rc82vfItrka5s0inCNYoFJZRArGBycTc9HQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s35PONlnIm4ZqXmuxxVkQU5N5JE6FDkzEun57jEL9GzjZ7h4hNaJbtEUJ9yFbh1+Jy0ik9SN1WhDRbdz79RDjl15267dkQDbO95RuSCilKL5ZfHbHCc8C1cBa+T7sIKDGFrL3Amur36ibACLY9v9Ud5xogdMim5dgSsIVXURUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzLsrbog; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so37200631fa.0
        for <linux-spi@vger.kernel.org>; Fri, 31 May 2024 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717162773; x=1717767573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ7UwYbRGfUf7Oy1hmHj08MhEpRdFGruUZ5Z4G9t5Dg=;
        b=XzLsrbog+lSqJ0ZCZnycPzrxnSDG4eTKML5ZDAO7j3igL481T6mhq2g3hXtbUwNlj2
         DNoIwYJzmJd1RQvNklAKsLst4vd0pNWHN3JnN4bF+OI0RN3qcpOanoJTvsbj+qTrozKj
         HHlkf3zYDGnTVlScm2iICXRvaP2gm1WaocxI1y4wuPuOxDHriWhQEtgJegOMksoIDwe4
         SyfBhpGvYgJ7LbQcle7Q9yrO/iY7g0Bd1Slxl7PtDY2i75s7lQOYojSDaBjC3XJoupAT
         tMGxmrrlnom1ygWGfuPvWU2XegEZBbxrwGkvduFBAk8U5HQxyY76NhM1JOqOTz6muzsJ
         Y79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162773; x=1717767573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ7UwYbRGfUf7Oy1hmHj08MhEpRdFGruUZ5Z4G9t5Dg=;
        b=p7hjyC6YdBYEelfVpw48OzClaeIH33lIlXC57L3BgwxS97vAQVtmT9OTl9Q2gnwcV5
         Hr+lfM4TQALaDGVMWIa4GMxVuwRFn/0uAYMSW+cK/DkJIzTtK6uNyBhE65dVsFDv15hu
         GslM9xGBb07aMaMGgXH0QiW1eAOhKCwXCV0ukKPhVP7J3IdLZ1KaJpOdoJCZelVwchOE
         e8SXMp9Kw2CkaVJMM8vHi5ds93C3pzEWqxhtxak+7ugiGbRm4Hf7E7uTCuu2zPRKh04r
         fOWM8s6KMHeiyWlk49KP8+ayubyQ7bDdsrE+oastfPn8k8tId8uxqKwz94AN/mJVt7l+
         Iyug==
X-Forwarded-Encrypted: i=1; AJvYcCWaTECX6+1U1RTHXCB3MG+OvkJv976MHMP8hT8/qDPg7J/DRTOsr+rkkLoyqAbmeRiztUtAe4nWP4SvuQ4ZbEkkrAu2Q50UM0ss
X-Gm-Message-State: AOJu0Yy/WYl0cbtXKRVVqTtlb7vbJI8mMPL1nJAOo/P9BzAokxZpNaNL
	4kgtOYwfs/+SRnCoYYOPLOqYojrPUgqy6QmWdgDHZnfN+UuSlRva
X-Google-Smtp-Source: AGHT+IFHXbVV1gXJDsNryjWBt4kgLT6GCPMCyl4FRRmFqCnttInpMoK9XC6y7/H9GGVn5cRqZDS19Q==
X-Received: by 2002:ac2:4149:0:b0:529:b6e9:79a7 with SMTP id 2adb3069b0e04-52b89563408mr1565685e87.35.1717162773207;
        Fri, 31 May 2024 06:39:33 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8a661sm335496e87.271.2024.05.31.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:39:32 -0700 (PDT)
Date: Fri, 31 May 2024 16:39:29 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	j.neuschaefer@gmx.net, Julien Su <juliensu@mxic.com.tw>, 
	Alvin Zhou <alvinzhou@mxic.com.tw>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] spi: dw: differentiate between unsupported and
 invalid requests
Message-ID: <cs6ydste7qk5wo5z4c7rgfifhqs4thsyfpcpyq5tnav4pzpayu@3vkrt2sco2th>
References: <20240522145255.995778-1-miquel.raynal@bootlin.com>
 <20240522145255.995778-2-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522145255.995778-2-miquel.raynal@bootlin.com>

On Wed, May 22, 2024 at 04:52:52PM +0200, Miquel Raynal wrote:
> The driver does not support dirmap write operations, return -EOPTNOTSUPP
> in this case.
> 
> Most controllers have a maximum linear mapping area. Requests beyond
> this limit can be considered invalid, rather than unsupported.
> 
> From a caller (and reviewer) point of view, distinguising between the
> two may be helpful because somehow one can be "fixed" while the other
> will always be refused no matter how hard we try.
> 
> As part of a wider work to bring spi-nand continuous reads, it was
> useful to easily catch the upper limit direct mapping boundaries for
> each controller, with the idea of enlarging this area from a page to an
> eraseblock, without risking too many regressions.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-dw-bt1.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
> index 5391bcac305c..4577e8096cd9 100644
> --- a/drivers/spi/spi-dw-bt1.c
> +++ b/drivers/spi/spi-dw-bt1.c
> @@ -55,13 +55,15 @@ static int dw_spi_bt1_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  	    !dwsbt1->dws.mem_ops.supports_op(desc->mem, &desc->info.op_tmpl))
>  		return -EOPNOTSUPP;
> 
> +	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
> +		return -EOPNOTSUPP;
> +
>  	/*
>  	 * Make sure the requested region doesn't go out of the physically
> -	 * mapped flash memory bounds and the operation is read-only.
> +	 * mapped flash memory bounds.
>  	 */
> -	if (desc->info.offset + desc->info.length > dwsbt1->map_len ||
> -	    desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
> -		return -EOPNOTSUPP;
> +	if (desc->info.offset + desc->info.length > dwsbt1->map_len)
> +		return -EINVAL;

Seems reasonable. Indeed the out of bounds situation is better
described by the EINVAL error. So the change looks good to me:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

But note the error number won't be propagated that far and will be
overwritten in spi_mem_dirmap_create() with either zero or
-EOPNOTSUPP.

-Serge(y)

>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 

