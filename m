Return-Path: <linux-spi+bounces-1573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCD86BC6F
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC513287CA9
	for <lists+linux-spi@lfdr.de>; Thu, 29 Feb 2024 00:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6385F9C8;
	Thu, 29 Feb 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3RfdnXT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A4374
	for <linux-spi@vger.kernel.org>; Thu, 29 Feb 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164913; cv=none; b=tFjg7cBw35RMXjaZtYqp4RcdwrjODFcuwjS0Xa46B8MQd7WUq8JjF+GJK1gGjPAiFvQaojYBD9JSXkIASp4KGml7aYyK+jS6C9b6kp3UCyDThX4+giwcuShGxKHRr1AOA3oORw8yJZ7b4Byal6bJxeR0rcfdM6FUA4evHYOh8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164913; c=relaxed/simple;
	bh=qxsoqrA85W0ZABODeQ55zexBoMTqe+0G6tTR4C4edFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z87aOskke2QqYd9BiXav3Hw9Js5eS93GOW/0LBl5e/XyWaTuSnRe5kc8J3pz+Wz0CorFT3LIkOeA9YB2XetT9TstBGmI8B4BURSmRmKocwGKY7mEKLs5FqSLcnz3yW6p+DrU0RQhDhfqO/yYcNHLzsZrtGU1YQees3PHWuEoNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y3RfdnXT; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb9b28acb4so195729b6e.2
        for <linux-spi@vger.kernel.org>; Wed, 28 Feb 2024 16:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709164911; x=1709769711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEBIJm8L8y8D/KMJdxSN242jmeihBdO84S0mND9uaps=;
        b=Y3RfdnXTWmbJLlQXNnkjy+ZF0gXZKzA0KjRs2qwdBt21m8GvVCMIXgNMBURHBwjeKJ
         IyVQt+Po3ndN5q7/hWcZF56J5FgF+RMhrM8DzLqJmi0EnLfSTqemYneQq1kvGQU9wY3x
         Apg7VWhU2fM47BtJyjtDA9BGDyI3ypa2yFpm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164911; x=1709769711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBIJm8L8y8D/KMJdxSN242jmeihBdO84S0mND9uaps=;
        b=ay9Sw9erFh5Ohzr3z+XjCIZGMW5aLvzUpmcWjla7z8vXDnh/glrxD2H8lMbfpw86iN
         14ggreqK6qajWeFOS9cvsdDG0X4ODuQ9kNdLtFeASz13I3r34PnZGVubDV50F4Cr7q2k
         50kb92CtwDQzYLVTGbYXn4XHCKbbp8pYB9Cv/3L8P55ppb2qkS1cDgc5USaA3biZfaGT
         IE46Ie1eoNZgDmXBtOsqqewleRcgn7fv/byJktXd+4Doc5PDs+3LJDKydohNbZPNzbtt
         juy3pQS+bLEJsuheRBGjrOJKszuRc7Q9Jr2j3r0J7YeT0doBycv0mEmR/TvZ2hFOTI4O
         p3KA==
X-Forwarded-Encrypted: i=1; AJvYcCU17VeIdOdVnoHdg7FRyqipw+72Xoms2IDmpw4jjnMKkHoinnFnowUNK2CaiFal8mZJ3XlPJAOzSYN2/eKQB3cndqyVjBL5T8Pn
X-Gm-Message-State: AOJu0YwvZT/eIOgDyzHsnpsBBQzpaKvpXeVoCjYq//DRqkLrgQU4o0b9
	FQPCT4rA1F+lyLvqW0AR1Yd9Y8OpkklU1F9C7qLteVIXqVVlheEj/NJTT7pglA==
X-Google-Smtp-Source: AGHT+IGs0rI0VXo4/NJKO1cSeuk/mHsATz8xyv2BYMzSCXsOlf2JpK8n8vhC+odnJINdbkFZX6M9Dw==
X-Received: by 2002:a05:6808:19a4:b0:3c1:af9f:a866 with SMTP id bj36-20020a05680819a400b003c1af9fa866mr607658oib.45.1709164910890;
        Wed, 28 Feb 2024 16:01:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a24-20020a631a18000000b005dc491ccdcesm60329pga.14.2024.02.28.16.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:01:50 -0800 (PST)
Date: Wed, 28 Feb 2024 16:01:49 -0800
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
Message-ID: <202402281554.C1CEEF744@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228144148.5c227487@kernel.org>

On Wed, Feb 28, 2024 at 02:41:48PM -0800, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 13:46:10 -0800 Kees Cook wrote:
> > I really don't like hiding these trailing allocations from the compiler.
> > Why can't something like this be done (totally untested):
> > 
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..dae6df4fb177 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2475,6 +2475,8 @@ struct net_device {
> >  	/** @page_pools: page pools created for this netdevice */
> >  	struct hlist_head	page_pools;
> >  #endif
> > +	u32			priv_size;
> > +	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> 
> I like, FWIW, please submit! :)

So, I found several cases where struct net_device is included in the
middle of another structure, which makes my proposal more awkward. But I
also don't understand why it's in the _middle_. Shouldn't it always be
at the beginning (with priv stuff following it?)
Quick search and examined manually: git grep 'struct net_device [a-z0-9_]*;'

struct rtw89_dev
struct ath10k
etc.

Some even have two included (?)

But I still like the idea -- Gustavo has been solving these cases with
having two structs, e.g.:

struct net_device {
	...unchanged...
};

struct net_device_alloc {
	struct net_device	dev;
	u32			priv_size;
	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
};

And internals can use struct net_device_alloc...

-Kees

-- 
Kees Cook

