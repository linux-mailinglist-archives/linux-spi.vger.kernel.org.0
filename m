Return-Path: <linux-spi+bounces-5643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F69C02A5
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6B128189C
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302A1EC019;
	Thu,  7 Nov 2024 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cFYIgntu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78231EBFF4
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976157; cv=none; b=tBK5CNvUN3dIfALNk4Qs0BV8/F9PuvJkAKihsG5ONKNMFuT5x7PITuUqHKg3GxyDh3c5eioB+vGDkT2DdUSzGNERJb0rCdMdpir7SG1bhJGGcve1EdNjf/cov6Ge4D/rgZRjqPqAKbGzHc4NpsDz33FoYExfwTuavboBy/D0Z0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976157; c=relaxed/simple;
	bh=dvfDmfrZFnIpSmY4l4XF1VfDqBpd+T1Z5L0vr1MkytI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kaSml2J+Ek8ITPCIJuGeZiRIo/vwmBl5Lxbggb8ucAtucu87IbpAWhZHijGEBY+968HyUDisUlh1rtgF8t+HA1hJHhSDQFg9WmGTDs+KFjr53LNP/tu5NiGKv0RFwTE24QmSLT+NnKlPg+t4t0SFwMERe4SIYplVliZ9lVJgZGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cFYIgntu; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 95D77C0111
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 10:40:10 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E87081BF209;
	Thu,  7 Nov 2024 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730976003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgSzosFJSH8w/4ycn/e9QMvALB4jweT7uSpUF3seKmA=;
	b=cFYIgntuquIvNe88nPbQ5rZSSFJJJMyAIIV3q5982B47Py6rcIwtjBnsIJeBca4j7VXDTv
	OM+4LaAEvMe9+P5p8XAXD3qZQvAlnJe14BIp62qqnwO9Vmze+o2n8Uw13Iu/VjRRDp1fJI
	+E9CqjVqTQR04sReuVFR8fZ+8nzrbPxMSC4FJphquJcI7w8JmMMX0m2G5E+TLOvtD36lvy
	VaggWdXWUi3iMISfAWuUL1Jn39WzLWWi7QV77Cbd/1cne5RkYS4yoklHelQJbpErRJLtV3
	YJeXrTZ607goiMaP+8zrd9ZzoeIwbMV9xNAJ8bCC4aw6u00vDkW1iDOsBYgx1g==
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
In-Reply-To: <586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk> (Mark
	Brown's message of "Fri, 1 Nov 2024 20:17:33 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-3-miquel.raynal@bootlin.com>
	<586cf617-37ee-4859-a11b-67654d650380@sirena.org.uk>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 07 Nov 2024 11:40:00 +0100
Message-ID: <871pznqqdb.fsf@bootlin.com>
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

Thanks a lot for the testing and sorry for being slow.

On 01/11/2024 at 20:17:33 GMT, Mark Brown <broonie@kernel.org> wrote:

> On Fri, Oct 25, 2024 at 06:14:39PM +0200, Miquel Raynal wrote:
>> There are spi devices with multiple frequency limitations depending on
>> the invoked command. We probably do not want to afford running at the
>> lowest supported frequency all the time, so if we want to get the most
>> of our hardware, we need to allow per-operation frequency limitations.
>
> After applying this patch (I bisected the series) my Avenger96 board
> started failing to probe the SPI NOR flash it has:
>
> [    3.567876] spi-nor spi0.0: probe with driver spi-nor failed with
> error -95

This is an EOPNOTSUPP so maybe there is a new check that is breaking
your board. I checked the hardware manual, they talk about a NOR
flash. Looking at the code, I believe I forgot the SPI-NOR case which
currently does not (yet?) use the op->max_freq parameter.

> Full job:
>
>    https://lava.sirena.org.uk/scheduler/job/925156
>
> I didn't spot anything with the code on a recheck but it's late on a
> Friday so I've not looked too hard.  My other boards are all fine though
> there's limited coverage.

Would you mind testing the series with this change on top and tell me if
that fixes it?

--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -184,7 +184,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
                        return false;
        }
=20
-       if (op->max_freq < mem->spi->max_speed_hz) {
+       if (op->max_freq && op->max_freq < mem->spi->max_speed_hz) {
                if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
                        return false;
        }

I don't know how easy it is for you to make that test with lava, let me
know if you prefer me to send a fixup! patch or even resend the whole
series (but it's a bit big).

Thanks,
Miqu=C3=A8l

