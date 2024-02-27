Return-Path: <linux-spi+bounces-1513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CD686861C
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 02:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F4828CE07
	for <lists+linux-spi@lfdr.de>; Tue, 27 Feb 2024 01:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2B525E;
	Tue, 27 Feb 2024 01:39:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from 19.mo550.mail-out.ovh.net (19.mo550.mail-out.ovh.net [178.32.97.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B96139
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.97.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997998; cv=none; b=EZc3I7JRK13Lb8yC0t/dNUhfFFVmdFyVmEUAsI/I/MIDIVIq3zHa0nc6pWi0VfAzBvNzrkfzLFLfFuvm2j5POJXkq4pbBV1bEbeJik+LKn51dS1w03DCrXT+8/eAOd6wgAovAo2u4MU35XpTW4QSo/JHbkas0gCGtfUqLFWp8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997998; c=relaxed/simple;
	bh=oP+NUZOFqM2E6ptm+fLs9NHiWljY1OQX7Li7+FuOHyQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aLJf4q46LIFpqf9Tqjo7y+cn4zES1COgAsEcyTdrVDJFfasmT7Rkb/EXFzMtUZhBf1Vyat4RrIqbQT8teHutZCK/+sQC27FNGXgIK1DfNnX7+gLrr8WgmliVxOQnU/1Awpn7gd2lApu3zYWibbElTKO+hXHouPUuvmr/+VBKxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.32.97.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.9.136])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4TkKTD3PVnz1FjW
	for <linux-spi@vger.kernel.org>; Tue, 27 Feb 2024 01:21:52 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-f4n6p (unknown [10.111.174.252])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 605D91FD7C;
	Tue, 27 Feb 2024 01:21:40 +0000 (UTC)
Received: from etezian.org ([37.59.142.108])
	by ghost-submission-6684bf9d7b-f4n6p with ESMTPSA
	id uPD7FCQ53WXtyQAAxDwYeA
	(envelope-from <andi@etezian.org>); Tue, 27 Feb 2024 01:21:40 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S002fe1109a9-1c88-4d0a-8ee4-2e8d2b473102,
                    9285090D84508773EC2C25A4099646E261C64314) smtp.auth=andi@etezian.org
X-OVh-ClientIp:89.217.109.169
From: Andi Shyti <andi.shyti@kernel.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 mturquette@baylibre.com, sboyd@kernel.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, tglx@linutronix.de, tudor.ambarus@linaro.org, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
 linus.walleij@linaro.org, sre@kernel.org, u.kleine-koenig@pengutronix.de, 
 p.zabel@pengutronix.de, olivia@selenic.com, radu_nicolae.pirea@upb.ro, 
 richard.genoud@gmail.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
 lgirdwood@gmail.com, broonie@kernel.org, wim@linux-watchdog.org, 
 linux@roeck-us.net, linux@armlinux.org.uk, andrei.simion@microchip.com, 
 mihai.sain@microchip.com, andre.przywara@arm.com, neil.armstrong@linaro.org, 
 tony@atomide.com, durai.manickamkr@microchip.com, geert+renesas@glider.be, 
 arnd@arndb.de, Jason@zx2c4.com, rdunlap@infradead.org, rientjes@google.com, 
 vbabka@suse.cz, mripard@kernel.org, codrin.ciubotariu@microchip.com, 
 eugen.hristev@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org, 
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Varshini Rajendran <varshini.rajendran@microchip.com>
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Subject: Re: (subset) [PATCH v4 00/39] Add support for sam9x7 SoC family
Message-Id: <170899689860.412407.545047377007032928.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 02:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Ovh-Tracer-Id: 4120793662683875913
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfgjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeelkefhieeljeejffdtvddthfffleffueekkefgieelveejjedtudettdeghfdutdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdekledrvddujedruddtledrudeiledpfeejrdehledrudegvddruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

Hi

On Fri, 23 Feb 2024 22:43:42 +0530, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v4:
>  --------------
> 
> [...]

Applied to i2c/i2c-host on

git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Thank you,
Andi

Patches applied
===============
[06/39] dt-bindings: i2c: at91: Add sam9x7 compatible string
        commit: a856c9e6104f7b4619f09e19ab95903c7888da96


