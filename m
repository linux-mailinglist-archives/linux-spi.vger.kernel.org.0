Return-Path: <linux-spi+bounces-5655-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836739C1885
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4874A282B88
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB61DEFDD;
	Fri,  8 Nov 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cePuNSJf"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01C47F69
	for <linux-spi@vger.kernel.org>; Fri,  8 Nov 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056120; cv=none; b=R18zs4yigOcPD41JtHTZreNGXQBEts/wd+zp9SNOcVxNEYDp48sEd/iacgbYI2+xp4FClsv/LZ2iOYhew/RL0ZBkYwDrGKCtNTWXvjxVEHouyOYbQhSz53I+81mPthnT3CTdihs5TANy0WRbpzkBn0chrjJ5Sw/AGYWmNcb+rpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056120; c=relaxed/simple;
	bh=lHdkzvbZ7E9+EFlXU9czvVHKs0TgqwrAtOFankLSLmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPO2afg2xkTbSCsnzD5U4SLTo9DjybsjlJhq2BgupEF78W8vx1KjmP270+dDBpjs06HgFgIophEo5aHj/EGQ8jy3ui7xZ+NagE/ZKmdZ4NInheeu24/9RR5XnnB1mmUwbdL3zk+HFGKoJyHg17pGjU2RXZyuZzRGGNlt06R2H4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cePuNSJf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D52D60005;
	Fri,  8 Nov 2024 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731056112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X94KPNwmhHzAdqRW/pWfSff8gFIpYD5QqakcI48JnXw=;
	b=cePuNSJfAYXZRpL2j7/G2hPHIgEBeR2zp+wKJC/hvotjgcPvat5CeJbluC0ERZH0bIRcN7
	ABvPW1oTC43WcVo6j2X+yom5/pm3oKb5bdjYL7rwfGrj6VcpfT+kRnqxEka9mdRUzrjlCf
	eI0Dj1zVRBkUouYVVp6d8TVNMM1ZDSiSsZ3NB4imPD0lcUKk4RYBK3GXnYiwrkkRQVTxB8
	sSTufNgiVjhYW3N4OhKTXunv5lAQ/PBgpOHDlRZMI7+kp0FupeM/LjNTKWwqxRfneyTwiQ
	rXdb4z5raHfKMp6e05rf6T8e7aFMulHbmN/PSXpfYnbiUin6njaonx/ICu6FBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush
 Yadav <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,
  linux-mtd@lists.infradead.org,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 02/24] spi: spi-mem: Add a new controller capability
In-Reply-To: <f0ea6706-17a2-4500-b426-a53c836c52b8@sirena.org.uk> (Mark
	Brown's message of "Thu, 7 Nov 2024 17:15:03 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-3-miquel.raynal@bootlin.com>
	<586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk>
	<871pznqqdb.fsf@bootlin.com>
	<f0ea6706-17a2-4500-b426-a53c836c52b8@sirena.org.uk>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 08 Nov 2024 09:55:07 +0100
Message-ID: <87ttciayvo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 07/11/2024 at 17:15:03 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Nov 07, 2024 at 11:40:00AM +0100, Miquel Raynal wrote:
>> On 01/11/2024 at 20:17:33 GMT, Mark Brown <broonie@kernel.org> wrote:
>
>> > After applying this patch (I bisected the series) my Avenger96 board
>> > started failing to probe the SPI NOR flash it has:
>
>> > [    3.567876] spi-nor spi0.0: probe with driver spi-nor failed with
>> > error -95
>
>> Would you mind testing the series with this change on top and tell me if
>> that fixes it?
>>=20
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -184,7 +184,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
>>                         return false;
>>         }
>>=20=20
>> -       if (op->max_freq < mem->spi->max_speed_hz) {
>> +       if (op->max_freq && op->max_freq < mem->spi->max_speed_hz) {
>>                 if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
>>                         return false;
>>         }
>
> Yes, that seems to have been the issue.

Great, thanks for testing. I'll soon send a v2, but I guess that's too
late for this merge window.

Regarding how to apply, I believe I'll have more spi-nand patches on top
of that in the next cycle, so either I apply them with your Ack and
share an immutable tag, or you apply it and give me one. Either ways
works fine for me. It's more work to create the branch/tag so I can
handle it (once we settle on the content ofc).

Cheers,
Miqu=C3=A8l

