Return-Path: <linux-spi+bounces-3529-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1291285D
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE061C20BB8
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5D38DD9;
	Fri, 21 Jun 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khO5EidL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28394085D;
	Fri, 21 Jun 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981264; cv=none; b=dHDH+wWy0/NDTfeaRDb41hZxvRcvhRzbNZQM+t4+wzYgGdtJ1O13IJ6QCYY70rVyWyW6dbCAk5mRmWAaAU7EmBVZJPs/s0hcHL1cRWTqZ6Hajn0tK5gwv3QRbeSmrtDVq1ll2eQG/HgpwYnmyB4+4mnuhxxO3EmyslGCrhlCkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981264; c=relaxed/simple;
	bh=eRz2vQgwJ1A+7iDLhmZYJGuIv7BJ+jvJRNy3WuWSPpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqQcGSWJGsbxfYrn5jufNbEytmFLJrJT+I+OXnBZZrzx/Fr7RFxmmgZzzLB9Ma715txXFl940R2lSHojAlnoeGavUSyVb4YCiDlqVN6+suV+5oSZO2/FFpbI0XwBCJ5rna4tiu0pl0amibfElmCBkRSw/jgWJfxJnqyPzVQj3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khO5EidL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso18282045e9.3;
        Fri, 21 Jun 2024 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718981261; x=1719586061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/z44+Phcyrx8OYVcHmZa41w4yuoKh8jjDFK/DcSA2mk=;
        b=khO5EidLpLCCgAmyLAIcTWEuADD1vlKEZ0zLh0m2gCzOe7ODRsEkLrblLnYGMaMbRa
         mVRU88vPIf22rDEMteGWpB1Wj9vep10u7/N5qeAnBq1rEPggiJ1a7GrfnzgVbx5FD42K
         24U4oedzDDDu3q3vWw5xkhet0rZO1xojKVjtoQV3BFbH7TFUu9o52pPChZbh4TdlYEpV
         FNkedfCvJCGd+FzV7RqN5mwf9i1Hrhz57fhIVia+ypOPdmoOINc/xupHG56S0FQHGQl0
         Og+z2kJ9zHtHzBtMbGzFhGVPgJbwrtVBou1UoxwJAHAJTKYCUmUh7X51eORN4w6XsmPC
         WGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718981261; x=1719586061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z44+Phcyrx8OYVcHmZa41w4yuoKh8jjDFK/DcSA2mk=;
        b=VWKxTiAbUH3KIUFrB6d+/u5tuqS+flPnl380RgJ6VDugYwPEyH79NYnTg6jKfCkghE
         6XrR1KBBOqL/ztbAucSZgoFWEuaeKyfoZ/Ml+PGDv3oXCeohNZLq4u01eIWKiQCdGjO5
         FekMeG4z02dPrvBy0nrk1LinUQJhRqIDA5MEh2G0PjT3e029Zs7XrI+Dn5dwZM0wO4Fi
         n73FT+0hHJyE2XAc0E2SwMO25XlB9A3Zr0dO8Qqy5ap2KQdy86h8RfejVO04+I+rSqmb
         ER8/NkT5rgJj0aYUmx72+Yn6Psl2icKivdXGISuJQu44AbWbnTfMGfJL9lB2d4T6W7fl
         MD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgegxxaWgM7DYfTF53tOpK+lfsVMZokKZy8+e0ZiFQIIMepH0Vw3i1BOnT0BS683cDWO5IUcT1YmNApI0sfaxzkvYwTgxj9A7FajyoaJiXsGbz1jfGmqZRPWwZzfUUHQYxCK77maxQTpptPNyOx2sGPe8QzjTS46sjdNWYZIZauXSpmQ==
X-Gm-Message-State: AOJu0YxxhgGY0ycDO6gJUTqBj3VPEyDySHX6VJPd1QoMLRhgm+jFZuIs
	zcc7BKBKP1kXF7mhYC2FgPr6cGOPZ0x/d5SLMPTzwglMV1Pu/4mljNttusvM
X-Google-Smtp-Source: AGHT+IGkUiQ8/JHxqC9cXg/EgQkUBEudQn16W8dQas9PKPraVTUmyUfCQHL+5/9JPk9VV7HjRS/MOw==
X-Received: by 2002:adf:f98c:0:b0:35f:20da:e1a2 with SMTP id ffacd0b85a97d-36317b7d57dmr6247272f8f.30.1718981260653;
        Fri, 21 Jun 2024 07:47:40 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b88easm1942929f8f.39.2024.06.21.07.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:47:40 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:47:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Message-ID: <20240621144737.l7bwipq2i3grspxa@skbuf>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
 <20240620-ls_qspi-v3-2-1a2afcf417e4@nxp.com>
 <20240621124211.pueymngpq5luokvj@skbuf>
 <ZnWQpa+rSXUhxCn7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnWQpa+rSXUhxCn7@lizhi-Precision-Tower-5810>

On Fri, Jun 21, 2024 at 10:39:33AM -0400, Frank Li wrote:
> On Fri, Jun 21, 2024 at 03:42:11PM +0300, Vladimir Oltean wrote:
> > > Use part of Vladimir Oltean's work at
> > > https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/
> > 
> > Hm, you took part of that but gave no attribution? The portion below ---
> > is also discarded when the patch is applied, so even the link is lost,
> > FYI.
> 
> I am not sure what should be added in comments? 
> 
> Ref part of Vladimir Oltean's work at https:// ... (I am not sure if allow
> http link).
>  
> Or coworked-with Vladimir Oltean ...
> Or use seperated patch for your part.
> 
> What do you like?
> 
> Frank

Well, it depends on how much from that work you end up taking.
I would recommend taking all of it :) and completing the unfinalized
review feedback with your work, plus some additions like the standard
CS timing parameters. Then, you could keep that sign off chain and add
yours at the bottom. At least that was my approach when I tried to
continue Kuldeep's work.

If you take a very small portion, I guess you could at least move the
link inside the portion of the commit message that remains visible in
the commit log.

And for a significant portion, Documentation/process/submitting-patches.rst
says you could add Co-developed-by + Signed-off-by, followed by your
sign off.

