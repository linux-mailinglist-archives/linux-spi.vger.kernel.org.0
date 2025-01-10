Return-Path: <linux-spi+bounces-6280-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A8A093A9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692D2188295C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A324B211283;
	Fri, 10 Jan 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m/PU3jSV"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE720E709;
	Fri, 10 Jan 2025 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519889; cv=none; b=n5zSxRyv6CrYzLQujinE1l7JrxQgCn5fj/YpRc691yGYRBOjt33tVOFeTfNTh4FVSVz9h7MDEv9oyWcYauG51ODPBhit1U4mh4XB2Di6BVknl2rC/K0SlBRGyR70ChkqKOQiyjU813dvVEMX4Nd+dV4Qta8HUegx6FPwccOkUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519889; c=relaxed/simple;
	bh=3efU/lF9TXV2pK1IRNYs/1/MY0mtKMppkHPq9Aki5lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLUeZ+Q3Z8waHU9AOMLufUZKeRnGn9n4qY6q/edW/BF+vIYaxvoWHEiqvcEpvRADKVeU+kPybBZ4Px1WzksnA/Nslp/eoH61hP4kIkqbWaHmjBE4M5v1xjTtirUkNRNGXlXiF9ScqzpDJ6cUa6MgS6oVA5lHRnPdCPV6IBI0fFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m/PU3jSV; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 980E5C0007;
	Fri, 10 Jan 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736519880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AqHOTtKrS2nK6owEMQCN+3bics3pst072/Bpdc2sk1Q=;
	b=m/PU3jSVOUgUfNeqSsjZfGTt+SAIExnswQ4nJ1ydWLAlAqDyJgvFnyk8HKoBD9BUxG16hy
	Kxy9n0Cwf1Hc7YihZi5k5w9nwTsGIYKn4FnnKxNF0C/9/xC2AA8aQ8o73ouUrLBlKrfiyx
	AyjzfEzOaOEu/KSVKY/wAa4K7WUjTk5cuP80r3I36oJZfq/WPge2eyw/Q2gARWb7KL+upy
	Ls5pf4WYuuJ+rGBVEyY/yx0BMp8H7ueg0TrVzxvdSUOcEZM3LoiSsfBxWSFXKt701XzzPJ
	/SMNBlfNJ7hqRZFrr0ROsFwE2/gIY4flK+fkxxJW4GO12ujEoN3r4OMJKmWnZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,  Serge Semin
 <fancer.lancer@gmail.com>,  Han Xu <han.xu@nxp.com>,  Conor Dooley
 <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  Jacky Huang <ychuang3@nuvoton.com>,  Shan-Chun Hung <schung@nuvoton.com>,
  Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater
 <clg@kaod.org>,  Joel Stanley <joel@jms.id.au>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Avi Fishman <avifishman70@gmail.com>,
  Tomer Maimon <tmaimon77@gmail.com>,  Tali Perry <tali.perry1@gmail.com>,
  Patrick Venture <venture@google.com>,  Nancy Yuen <yuenn@google.com>,
  Benjamin Fair <benjaminfair@google.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>,  Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Raju Rangoju <Raju.Rangoju@amd.com>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin
 <stlin2@winbond.com>,  linux-spi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  imx@lists.linux.dev,
  linux-riscv@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  linux-rockchip@lists.infradead.org,
  linux-mtd@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
  openbmc@lists.ozlabs.org,  linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 20/27] spi: spi-mem: Estimate the time taken by
 operations
In-Reply-To: <ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk> (Mark
	Brown's message of "Fri, 10 Jan 2025 12:42:47 +0000")
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
	<20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
	<ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 10 Jan 2025 15:37:52 +0100
Message-ID: <87tta6ag5b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

On 10/01/2025 at 12:42:47 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 24, 2024 at 06:06:05PM +0100, Miquel Raynal wrote:
>> In the SPI-NAND layer, we currently make list of operation variants from
>> the fastest one to the slowest and there is a bit of logic in the core
>> to go over them and pick the first one that is supported by the
>> controller, ie. the fastest one among the supported ops.
>
> This breaks the build:
>
> /build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting types =
for =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct sp=
i_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem_op=
 *)=E2=80=99}
>   580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)

Crap, that's a fixup that landed in the wrong commit (mtd: spinand:
Enhance the logic when picking a variant). I'll fix it.

Thanks,
Miqu=C3=A8l

