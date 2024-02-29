Return-Path: <linux-spi+bounces-1599-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5579E86D638
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 22:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7DDB22077
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 21:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539438DD7;
	Thu, 29 Feb 2024 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Otdgupdr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239116FF57
	for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242306; cv=none; b=oEbO1Csp870tv8qKtKIOszqe4Mmvd+rNFwL9ARDWZunWLi5u0ZKD1cE+XCIxVjwb7gA/S02nFA7s7Nja1GVXxcb3KZL3/qWvPkXJeZ02U03pbT+0nFDArgI+PYkHYxKXrMGUj82WAhOhs+k/3u0GT/3NRJeAht5djulWdWxmcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242306; c=relaxed/simple;
	bh=QzZTm6RzwKOCXz1s1DDgA6t36vWxFMgXU9qMOsdvjRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLVAldLQEn6ZYYkcKIGxhvrJyQlVSwDqYCtI0OLRSpW00UlNvUqb42YEK3gO9vmAmjYJ2Cx44qApyvslKt9Tt8QLyc2dDfb1ZHebSYKd9ocFnjrJY1TGQiMQ2o8UwMuxV0byDdOQBMh37WUavSlDfFTre+rKyL6efw4mzGywJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Otdgupdr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0e5b223eso13742455ad.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242305; x=1709847105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=OtdgupdrMqUU6v6YG5ItdSUVYWtggtW7CLi08MPwU/tGTaozH8afksz/j9WnraUdkZ
         gQO7+saJw0TruPFKJJShHIMwzH14EPnGlOS+T/kEWAOEPVR4l6UaIrHpoabCCEf3XPtP
         BuKQeG2cQ0ZPa/TIhRpwB3WIcITiVw6Bv0O6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242305; x=1709847105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=lxSgPZuImidYiy1pL9Vxg4HWphh7ETireb4P5pe9Xffbfo6Cj8jTFYJcAwm54R9BuU
         wsdPvc9TECCOxmtx+P82jhVy0yfcorf9ny9RdG3M3igoD2UW1xSGZhdchk+s4lGaWLw/
         C6V5gOoAP31cxUXdiDCQMYyUbhB4ChfrY3XkP7fO03iaqkiOennKCTP2PeeVuJslH6a/
         jbdfyFXUlyoa7obCxeMxIg2SQ7NCJB72Nxo13dzE7P4KxnvUwsChdKQdTbGVs7QPIwQF
         95WW1hCBOS0pqZDkLi/vIAJeDC8tvxedStejqFKY4soirsSAmA7KYZkfNk4qSGtfieSl
         CErg==
X-Forwarded-Encrypted: i=1; AJvYcCWHkQzns01Kj9f5TMG4+i+C9o2lAPxtAE32Bl3gMfn3B3cXhpbZI2xdlbfD0iDs33IiO53zH7edCQoepEY+f9kNqWKtm6ONNnNx
X-Gm-Message-State: AOJu0Yy2A03UYn2fy8wPc9h2XYVfSoGpubp3feEuoUPVbSQOdPgzgy28
	375f6xQLTiIrLITY1SSvwwntWfav5BCKBsO+9F+zCHdAJIWoaHMH62rFUF0xpw==
X-Google-Smtp-Source: AGHT+IE+DUv8Qdh0LZ32jo8m9iF3a01wivEsDDN/MHriPt719iWzbKIbR1Qbd56MoYjYqe7Ub9Claw==
X-Received: by 2002:a17:902:654a:b0:1dc:ca72:8318 with SMTP id d10-20020a170902654a00b001dcca728318mr2807886pln.37.1709242304905;
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm1954387pll.210.2024.02.29.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Date: Thu, 29 Feb 2024 13:31:43 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402291330.0510946B67@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <20240228165609.06f5254a@kernel.org>
 <202402291059.491B5E03@keescook>
 <20240229113706.42c877a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229113706.42c877a1@kernel.org>

On Thu, Feb 29, 2024 at 11:37:06AM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 11:08:58 -0800 Kees Cook wrote:
> > > And some seem to be cargo-culted from out-of-tree code and are unused :S  
> > 
> > Ah, which can I remove?
> 
> The one in igc.h does not seem to be referenced by anything in the igc
> directory. Pretty sure it's unused.

I'll double check. After trying to do a few conversions I really hit
stuff I didn't like, so I took a slightly different approach in the
patch I sent.

-- 
Kees Cook

