Return-Path: <linux-spi+bounces-11017-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089EC34E7C
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E939D4F3738
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AA30146A;
	Wed,  5 Nov 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oyb86cw/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646032FD688
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335365; cv=none; b=tOl0LbOB+dG+cdLcR5gQ8HOtxK2X0RoOFz0CTveJDEL+WRVCg2XObNNlowz06DqwksuFoy9ZmP84CChZKq5l8qnw0UJfdfCMy9g+dzCXVmsz7n+VkmxwIw+aG2u8/uDhmYMvPsdlyKI1YaZ1HfTizLQYrkeOtou5Ou9wdRkRTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335365; c=relaxed/simple;
	bh=1qvFsopmwgdAu8iPaOHE29Ts9hz3+IPTTaCjSjI9u0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8/DUzpTS0mw4EByrfKnuYrftMT188DyvO1TpFDabdrMkGg6BcQ8/Selo+7KfjAgSscD3RSlyIYQeaiybEahgmAfOrnSzUXvlBnlJarnaAQXL/fEyBaEZwwod+pq1gjmrNyEtxVOHiFuScO7soS7szQJ5nne4K8SKY9tJYsNvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oyb86cw/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8FD8D4E41512;
	Wed,  5 Nov 2025 09:36:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46ED560693;
	Wed,  5 Nov 2025 09:36:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70CEA10B51A41;
	Wed,  5 Nov 2025 10:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762335359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AWeVjAfEvwayrrcgeg/g3uKL1HZRS3340/63t2geN6g=;
	b=oyb86cw/BzojwJZ92zdlAfbHZrS8ukqgwp/wMRBsJo/g1M2ARfyxMT3IDPA5VxtdCBjL7e
	/74P04K3HbKdQVkylkn9zWf8ebOiA0eOq7PM6Ekqrjhg93NprxDdebhHME9QOBz88VU8kb
	Z95rSJS18vUuVp0TD/yt9mqZhlcCWHH2RgqsAz2r7gqrpQKpr4YHFf/3tZmaA55g9L3yS0
	AWDOIqedVWeoTVdWfay1f+O1iqL/szEK4PACbQRfKgKU91CEFj/Eo2Q3GqM9LBhtpIz+dn
	lh0cchJIIlsnq/kIW/HevJPhGiB014f/FoOaT6aY276SR2XUDybFWNTJCqd/Uw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <richard@nod.at>,  <vigneshr@ti.com>,  <broonie@kernel.org>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <p-mantena@ti.com>,  <linux-spi@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <a-dutta@ti.com>,  <u-kumar1@ti.com>,  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com> (Santhosh Kumar
	K.'s message of "Wed, 5 Nov 2025 14:25:58 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
	<87qzunt4n4.fsf@bootlin.com>
	<ea19bc64-a775-4309-8f3b-ce9dd8ac02ee@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 05 Nov 2025 10:35:55 +0100
Message-ID: <87ecqcakjo.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Santhosh,

>>>     - On tuning failure, retry by re-running spi_mem_needs_tuning() with
>>> the second best set of ops (max throughput - 1)
>> I would like to challenge this need. Can the same calibration fail if
>> attempted multiple times (eg. because of the heat?) If yes, then we need
>> a fallback indeed. Otherwise, I'd be in favor of just failing the
>> probe. Calibration is an opt-in -> users must allow a higher frequency
>> than they use to in order to enable the feature?
>
> It's possible the same calibration will fail intermittently for
> different reasons (temperature changes, as you mentioned). If tuning
> fails, the driver should fallback to the non-PHY frequency so the flash
> continues operating with slower reads/writes rather than failing the
> probe (availability should be prioritized, right?).

Agreed, if the tuning may fail we must fallback in this case. However
there is another situation that must be handled in this case: once
tuning is done and we want to use PHY-optimized paths, we must fallback
to more basic/slower reads if for some external reason, they start
failing, right?

The obvious choice in this case would be to let this error handling to
the controller driver. Re-using the same operation at a lower speed
would be suboptimal, because the fastest operation at a high speed might
not be the most efficient at slower speeds due to the number of dummy
cycles needed,. But I believe this is negligible based on the fact that
we already are in degraded mode at that stage.

However, this may conflict with:
- read retries
- continuous reads (?)

So in practice the fallback might be needed on the SPI NAND/NOR side
(this can be further discussed).

But once we solve this, comes a similar problem on the write side. How
do we know if a write will or did fail because of a temperature change?
What may be the heuristics to fallback in this case?

Thanks,
Miqu=C3=A8l

