Return-Path: <linux-spi+bounces-11311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD41C6E598
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 12:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CECA42E41A
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22E3563D1;
	Wed, 19 Nov 2025 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="evD9q7F/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058FC33CEB7
	for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763553495; cv=none; b=j4Lv1XAvpsAGaAoBntWcDRdHJPeUO05TcZl4LUB6vVvd0FjjvqozPGZOyPTC13nZNSfGfuYzqjI1ahp0+rRNbvPwkrudoRpMljvD2vCeYroYdwpiZ+yiO+LgHvv2O84GCzj1DJ0QS2oO/BJKgQ7j0Ku7s7ODQW7iIbNeSO6O8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763553495; c=relaxed/simple;
	bh=OdzvH0s+u3tZb+jw3Z8rJ2NVcscWJg9X7eUWiOUjaB4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaM6OL9Cr0ZZJ5uMU5xJf4mrwN+GkGwbZMIEUWagOZcHRpOYmH4wtSSLuqn3b0Wv6hZ63SAz1MphxBVnj4Z57hUNFiWo39YbBM1VSElpO+GsPbwP/Wvt7BXLTx1DO9Q5ka7eN0MUVpwykjEGEa04TCL8zTGhPoyPFlyyfq2Z6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=evD9q7F/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591c9934e0cso8998952e87.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Nov 2025 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763553490; x=1764158290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0tjqIGNlFg9pXPUCAauKdmJaabA/Pi4BBjF4edbLTM=;
        b=evD9q7F/UJ0wz6ybdZNofc8z1KRUiFbyNF1nYL2Qq5u+seogugYHZq+uZinqlRzHeu
         N5JxvdwWm5z44VPU64nHQXXqXIp2g0CTmR2MPDOiHPaLXeL47iaEoprEfnleOkp7D7ub
         Zxd88D1kHocLj9ACaaPvXGJc7a3U8hcKMdIIL+D8tfPKGUsjNs4OiOAOBTBfKegGCOwZ
         ur2eTXQaR7HsWJVqjjRUVEXkNgpWeSVuKLl46tN41YZZdy548qWNnzifqdwTaphZkcej
         icwlbWba5nWUU2/siSm2bJ2sjHS7HQLcWlVRa0xviB8XqufVPFl0flh9+cQEhwNNZltV
         fOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763553490; x=1764158290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0tjqIGNlFg9pXPUCAauKdmJaabA/Pi4BBjF4edbLTM=;
        b=oYUINxSjn0+UT8e/afX0JZ9ZxEXruysEM5ehNmrFO4RRJHcUc0VrH73o2V+wAGV0ck
         cme2c/x9p3JB2k1GNwJ2iQ8vKqp77mbYPkE4vUQ5FonjHTkEiJz7wAZMBUuGcWJ/Tkc1
         uhdOTak4/G2mUukRM+Bi2S9IVeeW2VS9g/Wdpf1Ra9fUxot+viylAFEmMQHID3Ok7LbP
         5ui2JRuFollM3t7q+MFSvbIMKpjqgCnlEbSC20USR5zSidQ9If4H9/jLGda12kf7W0eO
         bNLr69VOe0peVq91KqDnp3T2GwaiuIaUs5H+locfcCVAmyUGyyxxF0BqCxcmTAj2P8mu
         FCgA==
X-Forwarded-Encrypted: i=1; AJvYcCVRZ4KoWcJIqZsrnC9tlo3NsABqPtaVOgGgYZnqoBjqfDA/3Fi2DYh4UUeY6yBSH1ZRbOe/jYBrxLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjq8vMikJkFs/gOV2qQWif1NKOs/HdKa5XxjjaVp2+iholila
	krMJWaVvg6SKq3b5PgT+Cl1xei/GfHVi9ViiUIJLsOxNrNPreuohFy85VqBIvAbVl9A85juZHhl
	AqWpE0kDvBJNk7XOyHi8u609uQWP8E0XFe3OLGC5Hjg==
X-Gm-Gg: ASbGnctY2hLs2Cq5AnFf6vOppL5I5x3MNFfuFAsOml0tRK9XA39fBJMq1Ys0edbvm1S
	Hy1ZigeatLNnuPvnf4vNWz8X/+g8AJwn/gGEQm1BL/DlTXZzrdrdxwthkJXKz1ycYa43vP4Xub9
	75/C84hazsqbV95cLJSHPNKicywIZIaDe7xMQKvmWdZgt6dLVLAJotvcc2WJGsrKEnsP/nXfKtK
	QY9D8fNn18kenj8bzQa2F5TxKXimzVDFcD0dOrsOmoT4OzqNBihbT2SQqTG50p5PMis5xbBPHkM
	LGW4WqT25nbiSSxG7R7rbZ30aTw=
X-Google-Smtp-Source: AGHT+IHHRJFbp2Y/vCUAAnpJuAbf86gj81AhBWa8fRi02OyeawS2oJnkKjUxd7QN5tgoausbWGP7tLPYr9300vmlyis=
X-Received: by 2002:a05:6512:3d21:b0:591:c346:1106 with SMTP id
 2adb3069b0e04-595841984b9mr5946591e87.9.1763553489789; Wed, 19 Nov 2025
 03:58:09 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 03:58:08 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Nov 2025 03:58:08 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aR2o2R30TbVOcqZe@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-cs42l43-gpio-swnodes-v1-1-25996afebd97@linaro.org>
 <aR2OU4se7lxcMtGW@opensource.cirrus.com> <CAMRc=Mc==X3wERStdXmr5A9p0sPe7wdrPE4GZuqPLaKoBb9O9w@mail.gmail.com>
 <aR2Uo++k1NKkk2sj@opensource.cirrus.com> <CAMRc=MdFDAmqcJ3PMsTbeZUb9imM+fzHzQ_9mQ1T=syDoCcQJw@mail.gmail.com>
 <aR2gVzKhfN38MHAR@opensource.cirrus.com> <CAMRc=Mck8MiAm_nxY_L6Zw4cH-vYf24zSkPp=bhnUw68Q6FV=g@mail.gmail.com>
 <aR2i6lNNWEbQk0fx@smile.fi.intel.com> <CAMRc=MdYcdrQSDWKDHrx4-Y4-y92AQqr73MoRC3ws-X==SL0MA@mail.gmail.com>
 <aR2o2R30TbVOcqZe@opensource.cirrus.com>
Date: Wed, 19 Nov 2025 03:58:08 -0800
X-Gm-Features: AWmQ_blIpiONedL7G3cGsLtzIKhCJ8pbYqflTbeFpKKobVpMNCmeG0pDK_3vrc8
Message-ID: <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 12:24:09 +0100, Charles Keepax
<ckeepax@opensource.cirrus.com> said:
> On Wed, Nov 19, 2025 at 12:06:57PM +0100, Bartosz Golaszewski wrote:
>> On Wed, Nov 19, 2025 at 11:58=E2=80=AFAM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> > On Wed, Nov 19, 2025 at 11:50:09AM +0100, Bartosz Golaszewski wrote:
>> > > On Wed, Nov 19, 2025 at 11:47=E2=80=AFAM Charles Keepax
>> > > <ckeepax@opensource.cirrus.com> wrote:
>> > > > On Wed, Nov 19, 2025 at 11:38:35AM +0100, Bartosz Golaszewski wrot=
e:
>> >
>> > ...
>> >
>> > > > Cool, thanks for all your help here. Might take me a couple hours
>> > > > but I will get to the bottom of the EBUSY thing, and report back.
>> > >
>> > > Sure. Could you just post the stack trace down to where the EBUSY is
>> > > returned in drivers/base/swnode.c? I'd like to analyze the logic
>> > > myself too if that's not too much work for you.
>> >
>> >
>> > FWIW, there is also an interesting debug technique. Put in your driver=
 where
>> > you get this error code something like this (after all #include direct=
ives):
>> >
>> > #undef EBUSY
>> > #define EBUSY __LINE__
>> >
>> > And then you get some error code which is line number in some C file. =
You can
>> > narrow down grepping of the EBUSY in the suspected files and get the o=
ne.
>> >
>> >         git grep -n -w EBUSY -- ...files of interest...
>> >
>> > Hope this saves some minutes for you.
>> >
>>
>> Charles confirmed he gets it from device_add_software_node(). I want
>> to know how we're getting there and how we could end up already having
>> a software node.
>
> Ok I think I see what is happening now, the swnode is created on
> the first cell (the pinctrl). Then it moves onto the second cell,
> but mfd_acpi_add_device() copies the firmware node into both
> devices, the device_set_node() call at the bottom. So it inherits
> the swnode node through that primary fwnode.
>

You probably mean this line:

     device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));

What is the actual device whose node we copy here? Would doing the followin=
g
help?

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7d14a1e7631ee..f7843f179e129 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -55,6 +55,7 @@ static void mfd_acpi_add_device(const struct mfd_cell *ce=
ll,
 				struct platform_device *pdev)
 {
 	const struct mfd_cell_acpi_match *match =3D cell->acpi_match;
+	struct fwnode_handle *acpi_fwnode;
 	struct acpi_device *adev =3D NULL;
 	struct acpi_device *parent;

@@ -87,7 +88,10 @@ static void mfd_acpi_add_device(const struct mfd_cell *c=
ell,
 		}
 	}

-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	acpi_fwnode =3D acpi_fwnode_handle(adev ?: parent);
+
+	if (!is_software_node(acpi_fwnode) || !cell->swnode)
+		device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,

> I am guessing this code has perhaps been more heavily tested on
> device tree where it is more common to have nodes for each cell,
> whereas ACPI is far more likely to have a single firmware node for
> the whole device.
>

If my logic above is right, we should not set the node here unless it's
an actual node coming from firmware OR the cell doesn't define its own
software node.

Bart

> Stack dump as requested:
>
> [    8.130022] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
> [    8.130023] Hardware name: AAEON UPX-TGL01/UPX-TGL01, BIOS UXTGBM16 03=
/31/2022
> [    8.130025] Workqueue: events_long cs42l43_boot_work [cs42l43]
> [    8.130032] Call Trace:
> [    8.130034]  <TASK>
> [    8.130037]  dump_stack_lvl+0x5d/0x80
> [    8.130048]  device_add_software_node+0x5c/0xb2
> [    8.130054]  mfd_add_device+0x248/0x447 [mfd_core]
> [    8.130061]  ? _printk+0x6b/0x90
> [    8.130069]  devm_mfd_add_devices.cold+0x3b/0x70a [mfd_core]
> [    8.130077]  cs42l43_boot_work.cold+0x1d3/0x7f7 [cs42l43]
> [    8.130084]  process_one_work+0x237/0x5c0
> [    8.130096]  worker_thread+0x1e1/0x3d0
> [    8.130103]  ? __pfx_worker_thread+0x10/0x10
> [    8.130107]  kthread+0x10d/0x250
> [    8.130112]  ? __pfx_kthread+0x10/0x10
> [    8.130117]  ret_from_fork+0x182/0x1d0
> [    8.130120]  ? __pfx_kthread+0x10/0x10
> [    8.130123]  ret_from_fork_asm+0x1a/0x30
> [    8.130134]  </TASK>
>
> Thanks,
> Charles
>

