Return-Path: <linux-spi+bounces-10492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1ECBC918C
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 14:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28F81A6255D
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AEB2E267D;
	Thu,  9 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFFQez6X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755631DE8B3;
	Thu,  9 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013873; cv=none; b=qWXnZfMGfQslMpHVKpQ2jngbLst1zRGm8Ygk+WYGURioLpqXZq+rYqHTUyAkVBdE9IXkhttZ1YizBZtnFW50ORZjCdLEOjqMczW25onx+jVy0MPiaVELMBxpr3WF7XmBoNYcSWIzBcxJ/DDc2VHkUDCAYqSVADlh/M0z1eDmxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013873; c=relaxed/simple;
	bh=5xe6Ytzs8KZ8O9dv9Ntfv5ptgH5y/irf7RE2r0MbrEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONEcwhY90BEfuSI81eLMZ1/5X0yQWeCWr37Uf20nzLH1aQr/Hz1cZKQW2yunS/1BL3IG/hCjZkC9g01XWZUzjl/8+rwCbqVoe4NOZeunCIkGs/zr6JqitWoCOdQ67wKPdVGIZzARnsl6vBrpYZjZ6SWcOOaR04vkOyQv+SsRHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFFQez6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925D4C4CEE7;
	Thu,  9 Oct 2025 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760013873;
	bh=5xe6Ytzs8KZ8O9dv9Ntfv5ptgH5y/irf7RE2r0MbrEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jFFQez6XjHhQT93r5q1c9+yfThNXZH+w9Vj5CNYQGlHgg42cjJfaXFms+qecvnxw2
	 fk7rP6E9P0JFjCoc781UfkkC7Agq70FqIvCs6+YNigvOoclWKcQcB0QkEl1L/I1EgV
	 O+EyY492mAg3/D2Ht9heyw2qH7WZzbIyZBTnbVNQABUDqs4/ozyZ4SC8r1lgRfy1D1
	 VN4CasfsWp98kkeeb8RM9F2U3eYB+IDZ5Q97rwhoPEy+jsykCWWAWLVW+ZN0OLciDH
	 jnXeZAGMiCS1AiPsJS9nC4aC0gvMimfrzrB1TXMyT5wGWeAOtbQA1A6VMpSLRQKAaZ
	 nP8JHw1KwpMuA==
Date: Thu, 9 Oct 2025 13:44:27 +0100
From: Lee Jones <lee@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steffen Trumtrar <kernel@pengutronix.de>,
	Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: add support for TI LP5860 LED driver chip
Message-ID: <20251009124427.GC2796410@google.com>
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
 <20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>
 <20250916153412.GA3837873@google.com>
 <875xd0jslv.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xd0jslv.fsf@pengutronix.de>

On Tue, 30 Sep 2025, Steffen Trumtrar wrote:

> 
> Hi,
> 
> On 2025-09-16 at 16:34 +01, Lee Jones <lee@kernel.org> wrote:
> 
> > > +#include <linux/gpio.h>
> > > +#include <linux/led-class-multicolor.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include <linux/platform_data/leds-lp5860.h>
> > > +
> > > +static struct lp5860_led *mcled_cdev_to_led(struct led_classdev_mc *mc_cdev)
> > > +{
> > > +	return container_of(mc_cdev, struct lp5860_led, mc_cdev);
> > > +}
> > > +
> > > +LP5860_SHOW_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> > > +LP5860_STORE_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET, LP5860_CC_GROUP_MASK, 0)
> > > +DEVICE_ATTR_RW(r_global_brightness_set);
> > 
> > How is this different to /sys/class/leds/<led>/multi_intensity?
> > 
> > # echo 43 226 138 > /sys/class/leds/multicolor:status/multi_intensity
> > red -
> >     intensity = 138
> >     max_brightness = 255
> > green -
> >     intensity = 43
> >     max_brightness = 255
> > blue -
> >     intensity = 226
> >     max_brightness = 255
> > 
> 
> the LP5860 has a register for setting the maximal brightness that holds for all LEDs in the matrix. multi_intensity and max_brightness is only for that one multicolor LED, right? And I can only manipulate the max_brightness of that one multicolor LED instance.
> If I'm wrong, I'd be happy to not have to add the sysfs files.

Does group_multicolor help?  Or can it be expanded for future similar use-cases?

-- 
Lee Jones [李琼斯]

