Return-Path: <linux-spi+bounces-6362-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7CA12AF5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6781635FC
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2025 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5C1D61A4;
	Wed, 15 Jan 2025 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XVoQSRAs"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739701C1AAA;
	Wed, 15 Jan 2025 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965881; cv=none; b=TchFjLA4YDlKaQL8h4YqnYZs/8Zeq1akW/ZY8+ItTpA2nUU0o6V70rG0tYKuzLA6/CiiNGvBcmIp9194ZBP+i/wBmzHaZ+YxBdGuquZLnBmKdXsOr6po+b+rBb8laDG2anw/Gcd1WToAVvYOaTD1VA5aKz0oUNjdj6fx5tnWRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965881; c=relaxed/simple;
	bh=e9nl4zFZHGNpBZJqhNTI3zarOHWaiIaPGa2CaXHxtto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oum7YFSCqVdW1yicig8AmXN/WOgXSjeDZ8t6mTWDJBrzbRvTC/s+IwpLn6hJ+V0T/sZ23+/IGRU9a0/fL4WkBoBmdu1stuY89rWf1X5+LHZmXzWctd0vjcE29SgQQLOEGvCDR8mxsZNmwoezp+Euo/2hkgLEcsy9jssrJgiYwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XVoQSRAs; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 420B0FF803;
	Wed, 15 Jan 2025 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736965870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLoWi3Wg0eiQh/tot5fchMc56NRkY1AedYStPaUs9Pk=;
	b=XVoQSRAsHPXADFu3jVGI7dBwCecPD+dviwtiINSG7gG2QTYI7ZKoCGbAlzsXnHawAhGKwl
	24LiXfzCQR3pIZBqvn9qb/WI76bBR/gYM5iK3v27XfrrihWyj6I9DuAIL0fsvT3vsw3I/q
	czvnLPptcYBnGEnhrm8GhgmQ8vCeUtjENVYUkzFUKo7lU8h2121ib4vf8mK5lggJa2imhw
	wuKxnh8Eev9ag9+Xsu7zpWrkt2h27deaKdBBBwhgImA9Rm+AwpotMeHj0kiG0/Az9PUc1t
	KHhtrdM1rJLw5PWkyTBKEJFeu2A3AfGxN8CmN6JVLXE0bXGUEx1cXfp5ava0qA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v3 21/27] mtd: spinand: Create distinct fast and slow read from cache variants
Date: Wed, 15 Jan 2025 19:31:02 +0100
Message-ID: <173696548250.435435.10416906996871126975.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110-winbond-6-11-rc1-quad-support-v3-21-7ab4bd56cf6e@bootlin.com>
References: <20250110-winbond-6-11-rc1-quad-support-v3-0-7ab4bd56cf6e@bootlin.com> <20250110-winbond-6-11-rc1-quad-support-v3-21-7ab4bd56cf6e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 10 Jan 2025 15:45:23 +0100, Miquel Raynal wrote:
> So far, the SPINAND_PAGE_READ_FROM_CACHE_OP macro was taking a first
> argument, "fast", which was inducing the possibility to support higher
> bus frequencies than with the normal (slower) read from cache
> alternative. In practice, without frequency change on the bus, this was
> likely without effect, besides perhaps allowing another variant of the
> same command, that could run at the default highest speed. If we want to
> support this fully, we need to add a frequency parameter to the slowest
> command. But before we do that, let's drop the "fast" boolean from the
> macro and duplicate it, this will further help supporting having
> different frequencies allowed for each variant.
> 
> [...]

The following patches have been applied to nand/next:

[21/27] mtd: spinand: Create distinct fast and slow read from cache variants
        commit: 042087247835dad1ec5e39052abf022fd13c6326
[22/27] mtd: spinand: Add an optional frequency to read from cache macros
        commit: 7ce0d16d5802bfde4209e52ee8ad644ca1eab423
[23/27] mtd: spinand: Enhance the logic when picking a variant
        commit: 666c299be696f02c3354da104295fb94b8f65d25
[24/27] mtd: spinand: Add support for read DTR operations
        commit: 8586bc8d95488dfaadbc1af89ba59900d2c39119
[25/27] mtd: spinand: winbond: Update the *JW chip definitions
        commit: 1ea808b4d15b9bddc48af75b0668b82366b5b927
[26/27] mtd: spinand: winbond: Add comment about naming
        commit: 61c7155e3fe938d4da4671b2f84e29eaf79f5f46
[27/27] mtd: spinand: winbond: Add support for DTR operations
        commit: be7a05db4252edbffb43484b14755048fb8db710

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

