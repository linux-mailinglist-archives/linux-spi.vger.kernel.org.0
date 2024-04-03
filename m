Return-Path: <linux-spi+bounces-2180-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48C897A77
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 23:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F51282689
	for <lists+linux-spi@lfdr.de>; Wed,  3 Apr 2024 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCFB156652;
	Wed,  3 Apr 2024 21:13:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF85DF0E
	for <linux-spi@vger.kernel.org>; Wed,  3 Apr 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178812; cv=none; b=sWbYDc6ll0klKMbz71Ih8RtzMk8EkYNgEhxkGF0s913hUGYu5R5qLJ5nLRq5VrlpcQPGMwi0pfuc7CbtFUo+HJPHxsNuAjJ12UoTCBF8O/SKgJsKjZGsv0KoYX9i6Px/iaVT6andUtgQDW/0oVk2Yr4wIWD30u3nvliDW8zxKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178812; c=relaxed/simple;
	bh=eupMfwrp+Cz8ikeI7PjS0/ZKJUeLsKmYnSUICd//p3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2nw5yWddtyWgSC0GnHIoH2aJf6MDgpOFYPDneL4EajhjIcBEbfYdhu0Xcgm9QhVwIfCh+e//HrqO27+0jJjJ8RxZPb13fRFWir4a6kANos5riClkizzWCMQqlA5PCTLWqASyIh8CDMWo3K9rz8+cPAgNfwh0DmJ6cophnm6jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 0290e41f-f1ff-11ee-a9de-005056bdf889;
	Thu, 04 Apr 2024 00:13:28 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Apr 2024 00:13:25 +0300
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Li Zetao <lizetao1@huawei.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Luis de Arquer <luis.dearquer@inertim.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jaewon Kim <jaewon02.kim@samsung.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 31/34] spi: remove incorrect of_match_ptr annotations
Message-ID: <Zg3GdUtBUKzB6NNZ@surfacebook.localdomain>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-32-arnd@kernel.org>
 <b4418ac1-10ba-4932-be6e-93282707024f@sirena.org.uk>
 <5f3qvhasho4mfnf6f7i6djak3ankje375mt4fzvv3gqrlj242o@zdk2ajvha6hx>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f3qvhasho4mfnf6f7i6djak3ankje375mt4fzvv3gqrlj242o@zdk2ajvha6hx>

Wed, Apr 03, 2024 at 11:05:51PM +0200, Uwe Kleine-K�nig kirjoitti:
> On Wed, Apr 03, 2024 at 10:56:58AM +0100, Mark Brown wrote:
> > On Wed, Apr 03, 2024 at 10:06:49AM +0200, Arnd Bergmann wrote:
> > 
> > > These appear to all be copied from the same original driver, so fix them at the
> > > same time by removing the unnecessary of_match_ptr() annotation. As far as I
> > > can tell, all these drivers are only actually used on configurations that
> > > have CONFIG_OF enabled.
> > 
> > Why are we not fixing of_match_ptr() here, or at least adding the ifdefs
> > in case someone does end up wanting to run without OF?
> 
> Fixing of_match_ptr =
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a0bedd038a05..d980bccffda0 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -890,7 +890,7 @@ static inline const void *of_device_get_match_data(const struct device *dev)
>  	return NULL;
>  }
>  
> -#define of_match_ptr(_ptr)	NULL
> +#define of_match_ptr(_ptr)	(0 ? (_ptr) : NULL)

FWIW, we have PTR_IF() (with a side note to split it from kernel.h in a
separate header or less twisted one).

>  #define of_match_node(_matches, _node)	NULL
>  #endif /* CONFIG_OF */
>  
> ?
> 
> Assuming this helps, I agree this would be the better fix.

Why? I mean why do we need to even have this API? It's always
good to know which devices are supported by the module even
if you have no need in such support or it's not compiled in.
One of the reasons why is to be able to google for compatible hardware,
for example.

-- 
With Best Regards,
Andy Shevchenko



