Return-Path: <linux-spi+bounces-11582-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C6C89323
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38C63B21F4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586426ED4A;
	Wed, 26 Nov 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7plo0mm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B61096F;
	Wed, 26 Nov 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151893; cv=none; b=Xz5UBwqjAe1vGzARTYkMyMeUTEw83RceLEYDfZbGDICfxoVCqO8WC8xnK4mi/OJvkeQbj66DfBQKfqD6pz9hz5JbY9u2k2DWmT4rbul+9izf/6BIchB/k+Ca/YtbEfYRJYTXuA1uYoZJ3SlQitx5JXLRm0TY15GdDUlBQG8ARKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151893; c=relaxed/simple;
	bh=cv6urEPivdrRnFWWXd4jE4wE6asU3Iq0ODio/kXnXoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+7YSOQHyNn3ttxRwyTIhkMWK8x7QAu698SpTlz/3KDpHkEh156KSUyOB8DJEXq8QPtmHJLMk2N19wbli2//xJWAWxdTLo9wOMydk30QaAhxsLr3mFVzGfrBaU/A22oRtKgeLYpRucw4Fi6iCP1mUMhrsQzU7IvXwFO5OP+xAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7plo0mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB2C113D0;
	Wed, 26 Nov 2025 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764151892;
	bh=cv6urEPivdrRnFWWXd4jE4wE6asU3Iq0ODio/kXnXoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7plo0mm9ulw3zSEWkZl2NN/Ol8XlDEOdAaS2ycy55srodNmpHHOUjLftW13+yuiz
	 0rXLEt6Z5xPUKb8npwnQgb5qIOl3CDHrxL8rLk0Ia80EtjqmrHmFG8/ORgQ+TYHvgW
	 6vX6H9yyZjfd8kdHEt+stxIHQhkQffsnjqfnWLRqBRfKgDjz+fmq4Q417qDHQ/KbYs
	 VUW5KrOXEUOunr68SIQRjw6s24j7fgmlCa2xKZmRfYHKqQtNg7pbe+AAXg7KwPzIoQ
	 NE/4kFE233hc8Pi1W7LmyqSr23ScIoNz4v7cPX8Id5AFDZLRYLAG5wRLeFo85L5dE/
	 Qu6qxqK5wrE2Q==
Date: Wed, 26 Nov 2025 10:11:27 +0000
From: Lee Jones <lee@kernel.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steffen Trumtrar <kernel@pengutronix.de>,
	Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] leds: add support for TI LP5860 LED driver chip
Message-ID: <20251126101127.GD1127788@google.com>
References: <20251110-v6-14-topic-ti-lp5860-v5-0-5b777b99a905@pengutronix.de>
 <20251110-v6-14-topic-ti-lp5860-v5-2-5b777b99a905@pengutronix.de>
 <20251119153627.GT1949330@google.com>
 <ac2fc24f-e554-44df-9c28-00ac12d41af4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2fc24f-e554-44df-9c28-00ac12d41af4@gmail.com>

On Sat, 22 Nov 2025, Jacek Anaszewski wrote:

> On 11/19/25 16:36, Lee Jones wrote:
> > You left Jacek from the recipients list, despite receiving some good advice.
> 
> If we're dropping grouping then I don't have other issues than pointed
> out by you.

Okay mate, thanks for the confirmation.

-- 
Lee Jones [李琼斯]

