Return-Path: <linux-spi+bounces-6311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B8A094A9
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52637188E23E
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384E211267;
	Fri, 10 Jan 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bM3aHv2e"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECB20B80C;
	Fri, 10 Jan 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521613; cv=none; b=RPSdrPqfCdC3WQrIvpraBhN/hFZRcPh0nKXxTfJMbCTpB6T17i9aMiclSWBV8pZ15H6B6EzBwkXlyP+PwrolP9gEg9/1YJC0Czp+6OOakffmS1hzp/nzgyE0IQatgkjc28/yV3Tufb6fuJ9T/pwEbKEUC6VMh2Ty+9pUFZvzitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521613; c=relaxed/simple;
	bh=66rT7osaJyXS243M+lc02gUGMAFMP/Ik3/pzorJoKa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRVzQQH592DBxGmm6t2cIdj8MAjqdGH/TwkfrGl2tI1gLGAMX5a4WW2rpMBo2rNcBjSnpFjg+5A55mbx1AKis1QorrRze9fJ0vp0IkYWw4markbsqoN4vC70ERPK5JLjGLCM/lHUoFxvHIR3bslKd4ChXOCQnQN83g2x+4nEEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bM3aHv2e; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CD1D1BF205;
	Fri, 10 Jan 2025 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736521608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8hqtpx7uSmFFCBt4R+XArsWuILvupPoqhgNSuXM+dY=;
	b=bM3aHv2eZDPIEogkHXuaz90KY+89c/SS6D88M5Wwse/oE9y22gsGc/f1A8uC8lhyczxePx
	Rb00zNoRl/Jqt4Rnx2w8AcwTkm4UgnSaR/HS4gHDeSMDpQTBSITwMoxgl5bMwlfDR7/2Ex
	4678QsL8tSDo270hZROIzDvS4dvPmSaDeww2Q2qXcyFoH/YdmcJiq6OWaXl/7F2wYSL727
	yhpchOJrpNEM7J52JVcWYn19Jz67QyEwTI9gquIRwE3+7wGP8GWRfXVZ+CnsGH511T/Ug0
	dK1IpVJOGgF/Nc85wZftpbWnToLYHGKcXdNY97F3DTjah4672ArjZoy9pk9bKQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
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
In-Reply-To: <c9043531-c733-4153-a814-79aab387883e@sirena.org.uk> (Mark
	Brown's message of "Fri, 10 Jan 2025 14:52:29 +0000")
References: <20241224-winbond-6-11-rc1-quad-support-v2-0-ad218dbc406f@bootlin.com>
	<20241224-winbond-6-11-rc1-quad-support-v2-20-ad218dbc406f@bootlin.com>
	<ca317e2c-cd09-4884-b9eb-9cf23ae88078@sirena.org.uk>
	<87tta6ag5b.fsf@bootlin.com>
	<c9043531-c733-4153-a814-79aab387883e@sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 10 Jan 2025 16:06:42 +0100
Message-ID: <87y0zi908t.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 10/01/2025 at 14:52:29 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jan 10, 2025 at 03:37:52PM +0100, Miquel Raynal wrote:
>> On 10/01/2025 at 12:42:47 GMT, Mark Brown <broonie@kernel.org> wrote:
>
>> > This breaks the build:
>
>> > /build/stage/linux/drivers/spi/spi-mem.c:580:5: error: conflicting typ=
es for =E2=80=98spi_mem_calc_op_duration=E2=80=99; have =E2=80=98u64(struct=
 spi_mem_op *)=E2=80=99 {aka =E2=80=98long long unsigned int(struct spi_mem=
_op *)=E2=80=99}
>> >   580 | u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
>
>> Crap, that's a fixup that landed in the wrong commit (mtd: spinand:
>> Enhance the logic when picking a variant). I'll fix it.
>
> Please only resend that patch - the rest builds and tests fine in my CI,
> I'm just checking a merge fixup.

Ah, oops, didn't see this in time and rushed v3.

