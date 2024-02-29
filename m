Return-Path: <linux-spi+bounces-1594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604586D2DC
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 20:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781501C21808
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1595113C9DE;
	Thu, 29 Feb 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPFTpjyi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA513C9C4
	for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233742; cv=none; b=hFkkyCwnVwmPfoSS6JQGmSAfu1ZfEHKhW21dplwBxgdgXnbrivTjn9EgJDWPpUP99b951u4VqZMiNQZXWQn5es8yvMnALI7vVqGkjmeJm+52gdWWPm806aZ98A64W8JWSNXBHHruHCjqEJIP6GzpUptHHA6xfXyULNBrJYhvX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233742; c=relaxed/simple;
	bh=XhYVxNr3yIQGYfPBq8eZl7fW5SFxmb1whNnII5+VYe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3lVB6biIHMf4iw+ainrrtBWIhneFrC85eGI2iJOJs7VgBB7aFtfIyS8wizLcwfZT65cqWCpbYpoSQ+E2j6/X2gGvGybpBri7HpOInqum+XqvV5+EgeKVjVg8STnO95e0KgcafGal9iBKIDsD6RXHmUZMMlL9Ls46rzcq9PwQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WPFTpjyi; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e480fe439aso666260a34.0
        for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709233739; x=1709838539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPNx03vL5gJBUsLY5izQNSc5f5aQFQJTo3mFc1Gcb0A=;
        b=WPFTpjyiRDs+msv4Rcc4/qQvq3jlA5SfObvFs8J1jxZ+hsqoA8y2mmS/xj0bHHmGxt
         4RQ+Vbpb7J99vt2blfAzhImkl3cMVSnvDq/urcg/XftJn0Pc/UZqL0z2YxSQtfwPOIwG
         q5FuNu5UmCxQohquaFF0QadN7TK8tF6YHwPZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709233739; x=1709838539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPNx03vL5gJBUsLY5izQNSc5f5aQFQJTo3mFc1Gcb0A=;
        b=ewNlfzliyAvResq+pmAT3BFY6g6u7a8TMz0j2wFt8fHyzmeNpupDLOa0M1FwwsijBH
         zEsH/FILIFmm/BxYanbmJMjIzPkZZCJXBefM8ctSEKBYQySNmY1qdnZfCv4DNhZPZco1
         TrPCyhgIBlr+ot5B+CsKAaOqkZq6lDU1v9ojah7cSJXPvCBXOL5J15MrswjhUuel82S1
         d/MZ2YefTOgbVyCMrseDAcuW8sSDv63a6FuPaOxd/n8UNJh1Ek9RPrJkcB0K7LEKKh+c
         02D4kUkPmwmEJPB4b3mn+A+z6oB8+/vqHbzdmnOAeAaZvszdmTSSX30iRz1vjGDY9w1n
         StUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSgq7oNWqnRrybPM/AzucLH/pUjFd+RMXxqrCLFoKF65K6sZQQHXrOewEqAMkAbmavTrceeTxhyvWTHDVcLupLxCmrDY3K4tIA
X-Gm-Message-State: AOJu0YysWfOwjogb+PECs/rWpbsBtqD8bOJW1oLm8HTXBqefeDpOPG83
	5nNqHUywgxSZR/QGZpZf/CRi5SI9SHA4e/ZTkZ9Ubpie7f7Ic0H0cfYN8vXUCA==
X-Google-Smtp-Source: AGHT+IHgyC7clemZIshyNx4SoJ7Udvxw9GwegtcRM1FBJfrzoLTLgcJeKmWLE72ksvmhiwetvndvRw==
X-Received: by 2002:a9d:618c:0:b0:6e4:9e38:37a7 with SMTP id g12-20020a9d618c000000b006e49e3837a7mr2725366otk.23.1709233739242;
        Thu, 29 Feb 2024 11:08:59 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b006e05c801748sm1613455pfo.199.2024.02.29.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:08:58 -0800 (PST)
Date: Thu, 29 Feb 2024 11:08:58 -0800
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
Message-ID: <202402291059.491B5E03@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <20240228165609.06f5254a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228165609.06f5254a@kernel.org>

On Wed, Feb 28, 2024 at 04:56:09PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 16:01:49 -0800 Kees Cook wrote:
> > So, I found several cases where struct net_device is included in the
> > middle of another structure, which makes my proposal more awkward. But I
> > also don't understand why it's in the _middle_. Shouldn't it always be
> > at the beginning (with priv stuff following it?)
> > Quick search and examined manually: git grep 'struct net_device [a-z0-9_]*;'
> > 
> > struct rtw89_dev
> > struct ath10k
> > etc.
> 
> Ugh, yes, the (ab)use of NAPI.
> 
> > Some even have two included (?)
> 
> And some seem to be cargo-culted from out-of-tree code and are unused :S

Ah, which can I remove?

> That's... less pretty. I'd rather push the ugly into the questionable
> users. Make them either allocate the netdev dynamically and store 
> a pointer, or move the netdev to the end of the struct.
> 
> But yeah, that's a bit of a cleanup :(

So far, it's not too bad. I'm doing some test builds now.


As a further aside, this code:

        struct net_device *dev;
	...
        struct net_device *p;
	...
        /* ensure 32-byte alignment of whole construct */
        alloc_size += NETDEV_ALIGN - 1;
        p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
	...
        dev = PTR_ALIGN(p, NETDEV_ALIGN);

Really screams for a dynamic-sized (bucketed) kmem_cache_alloc
API. Alignment constraints can be described in a regular kmem_cache
allocator (rather than this open-coded version). I've been intending to
build that for struct msg_msg for a while now, and here's another user. :)

-Kees

-- 
Kees Cook

