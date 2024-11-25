Return-Path: <linux-spi+bounces-5830-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAAE9D8577
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 13:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4B284D33
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864118F2FD;
	Mon, 25 Nov 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IPDpoNOB"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43C18AFC
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538076; cv=none; b=hPPYV0GcTAggvOJooaZ5flt+xDb9mm2us6ElR49kLnTBrxxPT3AWDcpS9OBX5kDwPwDGDJoQyUsYe1adqqa5ivjmSgoWNIocLrGnVV9tnBxmjTnazyQ1lntKwB0uAmTdnYQd8YU/tMZ9WsDZTX9rVWrNXV/0DXF/mCB6rFmscl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538076; c=relaxed/simple;
	bh=Rymrxz0XTIumy1ez/aFLqqqxGYYmGWWpppNL7GZ9yak=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=gliFJZW2LCaiX0DIvFtdYnTPz8O8mR6/cmZ0e6GcLzdpVhTesJtPucDoWaJyayVar+XLy7cG6tfre/aqGwMDqi04JyTpd+ndcnHxOloo1iHhe9VEqlz9323wJ6zz/mqD8qdj2SWVlocqU+92z8AcoBdcTNcJmsQUlHmiJbX6WGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IPDpoNOB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5DD02000E;
	Mon, 25 Nov 2024 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732538064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrxfxzIyqEMHgJTqwlVefdO82E3yvSdGhJEhPaO2hKE=;
	b=IPDpoNOBVQglzH2OEjWK5YnZhojck87yHXBn6spcmOQmK74Mcp9C50Q8fvKjaZPmLrn6Fo
	OKRa6jv5RwLggX/OrsfNUayqL3o9F4lHX/oh/NaRpEq/gMh53Us2K6CH7xT6oQGYS8WK3Z
	qoOKWDJQX+Ia+N9c+ZEfMtdmk9+SUGv799aQw9hdy5mJLvKkHfUPliqaaHNUa9BKYAJO5C
	/aA8KV4HjjBpMcMMJ+BDPY1R2j/VT323dY7F2NaVdjezEWkUNjJigLLuyQBfoukIovNTds
	LpX/y0TYfDgEoI8K1O5QictZTQdfL5RewHGTfQ/F9RMOmXTPGdNdDvT9+o+YPA==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Nov 2024 13:34:23 +0100
Message-Id: <D5V9HIKF2P4H.33JQG23AJP4K8@bootlin.com>
Cc: <linux-spi@vger.kernel.org>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] spi: Fix acpi deferred irq probe
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Hans de Goede" <hdegoede@redhat.com>, "Stanislaw Gruszka"
 <stanislaw.gruszka@linux.intel.com>, "Mark Brown" <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
 <D5UNKGVDHH2G.308OGWQSNXP21@bootlin.com>
 <3ee5e7bb-2f54-4051-b36b-5e2d4be7cd42@redhat.com>
In-Reply-To: <3ee5e7bb-2f54-4051-b36b-5e2d4be7cd42@redhat.com>
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Hans, thanks a lot for the the help !

On Mon Nov 25, 2024 at 11:05 AM CET, Hans de Goede wrote:
> Hi Alexis,
>
> On 24-Nov-24 8:23 PM, Alexis Lothor=C3=A9 wrote:
> > Hello,
[...]

> > I systematically observe this issue (probe failure with -22) on each bo=
ot,
> > and reached the same intermediate conclusion (IRQ failing to register, =
and
> > spi->irq value being -EPROBE_DEFER).
> > I can confirm that this patch makes the vsc-tp -22 error disappear on m=
y
> > machine, and that I have now /sys/devices/platform/intel_vsc.
> >=20
> > Unfortunately, I now encounter a new issue preventing the camera to wor=
k
> > (ipu6 still fails with -EPROBE_DEFER, I now have
> > ipu_bridge_get_ivsc_csi_dev failing while searching for child device
> > intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da).
>
> This sounds like you may not have the actual MEI driver enabled or
> that it is not binding.

You were right, it looks like I have been missing CONFIG_INTEL_MEI_VSC. My
config is comming from the archlinux kernel, there may be a miss here.

> Do you have both CONFIG_INTEL_MEI_VSC_HW and CONFIG_INTEL_MEI_VSC enabled=
?

So now with this change, I still have no success with ipu loading, because
of new errors on vsc-tp, but those errors have actually changed:

$ dmesg|grep vsc
[    8.594501] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
[    8.594506] intel_vsc intel_vsc: hw_reset failed ret =3D -110
[    9.138269] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
[    9.138287] intel_vsc intel_vsc: hw_reset failed ret =3D -110
[    9.678712] vsc-tp spi-INTC1094:00: wait rom failed ret: -110
[    9.678729] intel_vsc intel_vsc: hw_reset failed ret =3D -110
[    9.678750] intel_vsc intel_vsc: reset: reached maximal consecutive rese=
ts: disabling the device
[    9.678755] intel_vsc intel_vsc: reset failed ret =3D -19
[    9.678758] intel_vsc intel_vsc: link layer initialization failed.
[    9.678761] intel_vsc intel_vsc: error -ENODEV: init hw failed

I have seen some mentions of this -110 error in the many redhat bugzilla
issues you have been helping with, I'll check more thoroughly if some hints
and/or patches have emerged from there.

For the record, I am doing my tests with the current Archlinux kernel
(6.12.1-arch1), with those 3 patches on top:

"mei: vsc: Do not re-enable interrupt from vsc_tp_reset()"
"media: intel/ipu6: do not handle interrupts when device is disabled"
"spi: Fix acpi deferred irq probe"

> And do you get a driver symlink under /sys/devices/platform/intel_vsc
> indicating that a driver has bound to it ?

With the updated config: no, but I guess the dmesg output above explains it=
.

> If not any related messages in dmesg ?
>
> If yes what is the output of:
>
> ls /sys/bus/mei/devices

With the updated config:
0000:00:16.0-082ee5a7-7c25-470a-9643-0c06f0466ea1 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-082ee5a7-7c25-470a-9643-0c06f0466ea1
0000:00:16.0-309dcde8-ccb1-4062-8f78-600115a34327 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-309dcde8-ccb1-4062-8f78-600115a34327
0000:00:16.0-3c4852d6-d47b-4f46-b05e-b5edc1aa440e -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-3c4852d6-d47b-4f46-b05e-b5edc1aa440e
0000:00:16.0-42b3ce2f-bd9f-485a-96ae-26406230b1ff -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-42b3ce2f-bd9f-485a-96ae-26406230b1ff
0000:00:16.0-4fcc395c-a9e5-4647-bc68-47bad7cc6bd3 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-4fcc395c-a9e5-4647-bc68-47bad7cc6bd3
0000:00:16.0-55213584-9a29-4916-badf-0fb7ed682aeb -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-55213584-9a29-4916-badf-0fb7ed682aeb
0000:00:16.0-5565a099-7fe2-45c1-a22b-d7e9dfea9a2e -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-5565a099-7fe2-45c1-a22b-d7e9dfea9a2e
0000:00:16.0-6861ec7b-d07a-4673-856c-7f22b4d55769 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-6861ec7b-d07a-4673-856c-7f22b4d55769
0000:00:16.0-8c2f4425-77d6-4755-aca3-891fdbc66a58 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-8c2f4425-77d6-4755-aca3-891fdbc66a58
0000:00:16.0-8e6a6715-9abc-4043-88ef-9e39c6f63e0f -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-8e6a6715-9abc-4043-88ef-9e39c6f63e0f
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04
0000:00:16.0-cea154ea-8ff5-4f94-9290-0bb7355a34db -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-cea154ea-8ff5-4f94-9290-0bb7355a34db
0000:00:16.0-dba4d603-d7ed-4931-8823-17ad585705d5 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-dba4d603-d7ed-4931-8823-17ad585705d5
0000:00:16.0-dd17041c-09ea-4b17-a271-5b989867ec65 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-dd17041c-09ea-4b17-a271-5b989867ec65
0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1 -> ../../../devices/pci00=
00:00/0000:00:16.0/0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1
>
> and of:
>
> ls -l /sys/bus/mei/devices/*/driver

No driver bound to any MEI device

Sorry for the thread hijack, that's totally fine for me to continue the
discussions elsewhere if relevant.

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


