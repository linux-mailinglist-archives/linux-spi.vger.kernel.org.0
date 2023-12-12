Return-Path: <linux-spi+bounces-227-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C680EBE6
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAF3281308
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 12:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755965EE7E;
	Tue, 12 Dec 2023 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="asEntrfs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100EB7;
	Tue, 12 Dec 2023 04:34:54 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id BC3E071;
	Tue, 12 Dec 2023 13:34:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1702384491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVsH9JrMU+kTllg4YnT8PH24+guNEqb5IZwuUj2+thc=;
	b=asEntrfsJUlVGUOuVaMNcSEyWMez6f94TkJxrdnYBhrPGNP6VFg/a3sxhqR0hd1IkQZIWX
	EqnahLwu8JFqlCzFkksUj3ny6AojzvDwmyknQs29Xh7cB7yHi+iJ89NEu1LhvV8Llb1+zd
	wSkrrDAcq6FjbYIDRFEwzQOgl5BHZOONLlYylIO0zjx2ZQP9D+c5+gKcVTG3kvhZpLXqNY
	mKCdx5SMagAm+jyjxpETjDt5y/h48F5k1qY6TYvDLz163Po8UJjJYyzZiLbu8MikXffurA
	7uVidvriQgkThLix3x5o1jZgUWuOoCZEU7OqZpUBVmiPBx3sNZmbF6Bg9ag2TA==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Dec 2023 13:34:51 +0100
From: Michael Walle <michael@walle.cc>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: broonie@kernel.org, tudor.ambarus@linaro.org, pratyush@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 sbinding@opensource.cirrus.com, lee@kernel.org, james.schulman@cirrus.com,
 david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
 tiwai@suse.com, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel memories
In-Reply-To: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
Message-ID: <30ffd8378d3ef1c4fa6dfe4324b18345@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> This patch series updated the spi-nor, spi core and the AMD-Xilinx 
> GQSPI
> driver to add stacked and parallel memories support.

Honestly, I'm not thrilled about how this is implemented in the core
and what the restrictions are.
First, the pattern "if (n==1) then { old behavior } else { copy old
code modify for n==2 }" is hard to maintain. There should be no copy
and the old code shall be adapted to work for both n=1 and n>1.

But I agree with Tudor, some kind of abstraction (layer) would be nice.

Also, you hardcode n=2 everywhere. Please generalize that one.

Are you aware of any other controller supporting such a feature? I've
seen you also need to modify the spi controller and intercept some
commands. Can everything be moved there?

I'm not sure we are implementing controller specific things in the
core. Hard to judge without seeing other controllers doing a similar
thing. I'd like to avoid that.

If we had some kind of abstraction here, that might be easier to adapt
in the future, but just putting everything into the core will make it
really hard to maintain. So if everything related to stacked and
parallel memory would be in drivers/mtd/spi-nor/stacked.c, we'd have
at least everything in one place with a proper interface between
that and the core.

-michael

