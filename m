Return-Path: <linux-spi+bounces-8673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E68AE0604
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 14:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB21898E86
	for <lists+linux-spi@lfdr.de>; Thu, 19 Jun 2025 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2523A9A0;
	Thu, 19 Jun 2025 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oERole0e"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742F229B02;
	Thu, 19 Jun 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336500; cv=none; b=C0BirGYxcQ3Uj201RJeXmWPsgUtpORwBvgHz1FeoTITfYZ7XsSi4Q+ai47IMrRlUnVR89dzWoBQx+F4nLA45RRW1yuuxJ05ps+l9IWVKgVIKhOnzNX4vYODP1HKYhpzEZNpKVmm0QWNtUOvaZ+oAsBcAX/bmbr0NrBxh59Re3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336500; c=relaxed/simple;
	bh=E0VpEwPkOpNi5cm1wY1Ky8bZpc+uZlSPA0Hp6hXdw2Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OCagErGke+6yKgcqPXeETfMkPgVGTTN69OLx4BLn/0zXF75sBSNjM6yqClnzwzWj02ZcjOhvwl0D7TfdYVK3jT3myPT35NJgA48vtdK+tuLjDEXiAYQ8/DqXPwFHCjB/hbQVDQ+Lv0ljLaFYymxxG21FKiRD9DKSgHiU7ZMbYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oERole0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA42BC4CEEF;
	Thu, 19 Jun 2025 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750336500;
	bh=E0VpEwPkOpNi5cm1wY1Ky8bZpc+uZlSPA0Hp6hXdw2Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oERole0eYLCEPqWujSkraDjuR2cA0fSNCSs663e8zvhqUU+cQSLjR1OdVighE93/o
	 EYGnahf+Pt9xvhuty/ZwjgFugBT/fE6h6077p0EZuykDan3QvQHMHsPvaQBTeV1eJa
	 4qsW2dMAt2iXIHG2f+C35cF5X/UBpF3o78t7tBwe3YRYyEApMALpY1RmzKRM7b9HsJ
	 DJdXIJ3d6OOs5KieBInJ+C4b/FxKOEsb/uchv+C9OmEKP9VE0KBQieXiqzw0W47vSY
	 iBoDbcZ8qxXcxBg6I1ZxkC1lcl+gdHcGMvrdiivD3o/1zxb8E/erx4PJDkbNYmL6Tg
	 eKcbnYqal0vPg==
From: Lee Jones <lee@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, 
 Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org
In-Reply-To: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
References: <20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net>
Subject: Re: (subset) [PATCH v7 2/3] leds: lp8860: Check return value of
 devm_mutex_init()
Message-Id: <175033649656.801367.11888454651585197053.b4-ty@kernel.org>
Date: Thu, 19 Jun 2025 13:34:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 17 Jun 2025 19:08:13 +0200, Thomas Weißschuh wrote:
> devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
> marked as unusable and trigger errors on usage.
> 
> Add the missed check.
> 
> 

Applied, thanks!

[2/3] leds: lp8860: Check return value of devm_mutex_init()
      commit: 426e0c8e8eed26b67bbbd138483bb5973724adae

--
Lee Jones [李琼斯]


