Return-Path: <linux-spi+bounces-5827-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866C9D77E2
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 20:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A363B162AC2
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 19:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44002C697;
	Sun, 24 Nov 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i9VQWURe"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE22F26
	for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732476241; cv=none; b=SdYqmcsQEVkTeYWjyQnFFrT28mdtX1IgFTtT+zkaM4dzAO6Zcrx3xHRxhZTtHZ1kdEllUVb+bUrF/kxGb4Nkt26YR9ZvBPVgMQK954RW/J7ohEAj2jkpaY0dleQDTOat++Gv6EYJYHOXQqS76++ETy1rMUSjjDvO3QHohkZDGcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732476241; c=relaxed/simple;
	bh=4rFIagEkoVuNkqiUw5e0hxhMq0Sf4h7q6b9KIiYRqWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SY4eXa1qrT43/H7veQ2lqlIRi8oQX5VLyALFYp5ie7A9rjuSH84/+KtAEXCGEI3eCJ6hmhVpGSeSTKw2f45rfucnbbsRKLd+Lu1eyhN6Gv1IOpj4ydtCvxODp9KekffgcDBXByShzUOVgtreRdv0rvZTMk1iy73ND26FRJKpKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i9VQWURe; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D078E1BF204;
	Sun, 24 Nov 2024 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732476231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rFIagEkoVuNkqiUw5e0hxhMq0Sf4h7q6b9KIiYRqWE=;
	b=i9VQWUReqVVmzViaUwmcMZkAlTUPX/9cqZV/mN1SH6BDwbK4NYNXlo4bqum8vLfS+Ku7W5
	IUeBXRee6Zng8keL9BXy2GEmkgWO6AKxQZR1TKxQP+DLn4AtuhMjijUOpwuBBVdWPSDmuh
	+5MXblu/Juy6VBp90holBzn0Q+t00AJIZJtcVhPmZiCBMTKPRlZeeqjHyOz+iQ1JqamS+J
	dxpjzPa9lwOzfWNOZIOTlXsA4Tm0O9JxFZbCiGP/CV98nTW7rhErm87mUlP62zDDRQiQd4
	wBWcfrQc+5nv/+BbmqcHs18edCXT/vALSQrtCm02+6+nFdRFbcdJjSPfIj5yyg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Nov 2024 20:23:50 +0100
Message-Id: <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
To: "Stanislaw Gruszka" <stanislaw.gruszka@linux.intel.com>, "Mark Brown"
 <broonie@kernel.org>
Cc: <linux-spi@vger.kernel.org>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Hans de Goede" <hdegoede@redhat.com>
Subject: Re: [PATCH] spi: Fix acpi deferred irq probe
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
In-Reply-To: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

owning a Dell XPS 9320 and struggling to make the freshly merged IPU6
support to work on it, I was about to send a call for help on the media ML,
when I eventually spotted your observations on Redhat's bugzilla ([0]), and
this corresponding patch.

On Fri Nov 22, 2024 at 10:42 AM CET, Stanislaw Gruszka wrote:
> When probing spi device take care of deferred probe of ACPI irq gpio
> similar like for OF/DT case.
>
> From practical standpoint this fixes issue with vsc-tp driver on
> Dell XP 9340 laptop, which try to request interrupt with spi->irq
> equal to -EPROBE_DEFER and fail to probe with the following error:
>
> vsc-tp spi-INTC10D0:00: probe with driver vsc-tp failed with error -22
>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: 33ada67da352 ("ACPI / spi: attach GPIO IRQ from ACPI description t=
o SPI device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

[...]

I systematically observe this issue (probe failure with -22) on each boot,
and reached the same intermediate conclusion (IRQ failing to register, and
spi->irq value being -EPROBE_DEFER).
I can confirm that this patch makes the vsc-tp -22 error disappear on my
machine, and that I have now /sys/devices/platform/intel_vsc.

Unfortunately, I now encounter a new issue preventing the camera to work
(ipu6 still fails with -EPROBE_DEFER, I now have
ipu_bridge_get_ivsc_csi_dev failing while searching for child device
intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da). I am not familiar enough
neither with ACPI nor the exact pipeline involved to explain this yet, but
if you can affirm that is is unrelated to your change, feel free to take
my:

Tested-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> # Dell XPS9320,=
 ov01a10

Thanks,

[0] https://bugzilla.redhat.com/show_bug.cgi?id=3D2324683#c11

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

