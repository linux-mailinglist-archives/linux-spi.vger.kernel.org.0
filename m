Return-Path: <linux-spi+bounces-8674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB5AE0AA4
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279F21888D79
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF735230D2B;
	Thu, 19 Jun 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="V1mSIXMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0222116F5;
	Thu, 19 Jun 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347297; cv=none; b=KH7DKfGDqrry2DJBA2bvVXU8oGHK3LCjNI7ThUao9XMcm5hd4lx52u/1cwElQSZakwRBxpm9LE2as4+yd9yJtjrw0lZWQEPgICGMEPfq84YJ5RVKoaYp86lf8rqycve5zfu6i+PT4jpioeRtWU+5907fWNQoHWN9nmBiD19ZMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347297; c=relaxed/simple;
	bh=HAfTFfbnhb9zgieWmhedggrJA3pUw8GpwtllRC46K58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw7bvoPOKyD/N7wP9qce6BbVhVGJLDTjy6T3lhwO92vBX4TAv9zC8j+cVyBtX+rTkn93KhRruGE12VGNf76hJCeaxoxL567fECWLadC0PWMen3/7z0oq0y3yaahkKS2TsP6F8t7KK4VGrL1hVOC/OGUghX72KxTUyB+0PCXVNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=V1mSIXMW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750347288;
	bh=HAfTFfbnhb9zgieWmhedggrJA3pUw8GpwtllRC46K58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1mSIXMWQguS63gpZ2fX+Px3SDHN8EZ7hHlrzrfj9k1mL81yS0Z40guwfXTADy6eg
	 OwnJN48daEvqIW5wELvz/bTVB3eVl8mKAIMeMCK1tb6UmqunpkaU53LyXIH7+D0KUg
	 4Ow5jBTyWmV3hqyLjd0KqbYvxM6qPIm45ZcYv/RI=
Date: Thu, 19 Jun 2025 17:34:46 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Lee Jones <lee@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH v7 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Message-ID: <f1cc8959-d420-4ba3-922f-ed7c6f054f22@t-8ch.de>
References: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
 <175033649656.801367.11888454651585197053.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175033649656.801367.11888454651585197053.b4-ty@kernel.org>

Hi Lee,

On 2025-06-19 13:34:56+0100, Lee Jones wrote:
> On Tue, 17 Jun 2025 19:08:13 +0200, Thomas Weißschuh wrote:
> > devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> > marked as unusable and trigger errors on usage.
> > 
> > Add the missed check.
> 
> Applied, thanks!
> 
> [2/3] leds: lp8860: Check return value of devm_mutex_init()
>       commit: 426e0c8e8eed26b67bbbd138483bb5973724adae

Thanks, but (as mentioned in the cover letter) these patches should go
together through the mutex/locking tree.
Could you drop it on your side and give an Ack instead?


Thomas

