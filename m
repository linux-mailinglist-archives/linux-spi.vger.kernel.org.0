Return-Path: <linux-spi+bounces-11066-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16907C396DB
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F50418C8017
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671C2BE638;
	Thu,  6 Nov 2025 07:43:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A39221DAD
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415028; cv=none; b=LfxeNlpKDgoBOqP1u9JtKOWUqE/jEm67iM394R8LG86DlN+U3aN3rV7tAMD/ijCb6lD/7xYhuVNLHWIH7Hv3vcxHGPg7uQh0Trwf8sZ7PkMv8GGjrhuzxNSdY449jSHko+AjPWJuel5v+4FkaiuvIkHwiQjZr9NzC8VMr699o6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415028; c=relaxed/simple;
	bh=HEYW/yaqWZRZaZUlOkhPnuCY9Q72gDExuKNZMsprvw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsPiglwnKwy3KddLaLbj8SqnyOWJOQm8JtiPwMMfL5jZMHPp/y3HiMjf1oHg/HzjSYA9pLT1o3tWe2Rtu0y7LtX0jSXnHdD11VSrrAQLZxWKo5/LhoyXu6JyzLpQLo46NSRWYhiFwTI39VSPhuFy6bZ8vty4rjcHWSCeNt2tYi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vGuel-00017f-7R; Thu, 06 Nov 2025 08:43:43 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Lee Jones <lee@kernel.org>,  Pavel Machek <pavel@ucw.cz>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Steffen Trumtrar <kernel@pengutronix.de>,
  Pavel Machek <pavel@kernel.org>,  Mark Brown <broonie@kernel.org>,
  linux-leds@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] leds: add support for TI LP5860 LED driver chip
In-Reply-To: <5d8ec4c3-1b36-470b-a1c7-629060a154ce@gmail.com> (Jacek
	Anaszewski's message of "Sat, 11 Oct 2025 15:09:05 +0200")
References: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
	<20250911-v6-14-topic-ti-lp5860-v3-2-390738ef9d71@pengutronix.de>
	<20250916153412.GA3837873@google.com> <875xd0jslv.fsf@pengutronix.de>
	<5d8ec4c3-1b36-470b-a1c7-629060a154ce@gmail.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Thu, 06 Nov 2025 08:43:42 +0100
Message-ID: <87ldkjip1t.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org


Hi Jacek,

On 2025-10-11 at 15:09 +02, Jacek Anaszewski <jacek.anaszewski@gmail.com> w=
rote:

> Hi Steffen
>=20
> On 9/30/25 09:40, Steffen Trumtrar wrote:
> > Hi,
> > On 2025-09-16 at 16:34 +01, Lee Jones <lee@kernel.org> wrote:
> >=20
> >> > +#include <linux/gpio.h>
> >> > +#include <linux/led-class-multicolor.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/of_gpio.h>
> >> > +#include <linux/of_platform.h>
> >> > +#include <linux/regmap.h>
> >> > +
> >> > +#include <linux/platform_data/leds-lp5860.h>
> >> > +
> >> > +static struct lp5860_led *mcled_cdev_to_led(struct led_classdev_mc
> >> *mc_cdev)
> >> > +{
> >> > +=C2=A0=C2=A0=C2=A0 return container_of(mc_cdev, struct lp5860_led, =
mc_cdev);
> >> > +}
> >> > +
> >> > +LP5860_SHOW_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET,
> >> LP5860_CC_GROUP_MASK, 0)
> >> > +LP5860_STORE_MODE(r_global_brightness_set, LP5860_REG_R_CURRENT_SET,
> >> LP5860_CC_GROUP_MASK, 0)
> >> > +DEVICE_ATTR_RW(r_global_brightness_set);
> >>
> >> How is this different to /sys/class/leds/<led>/multi_intensity?
> >>
> >> # echo 43 226 138 > /sys/class/leds/multicolor:status/multi_intensity
> >> red -
> >> =C2=A0=C2=A0=C2=A0 intensity =3D 138
> >> =C2=A0=C2=A0=C2=A0 max_brightness =3D 255
> >> green -
> >> =C2=A0=C2=A0=C2=A0 intensity =3D 43
> >> =C2=A0=C2=A0=C2=A0 max_brightness =3D 255
> >> blue -
> >> =C2=A0=C2=A0=C2=A0 intensity =3D 226
> >> =C2=A0=C2=A0=C2=A0 max_brightness =3D 255
> >>
> > the LP5860 has a register for setting the maximal brightness that holds=
 for
> > all LEDs in the matrix. multi_intensity and max_brightness is only for =
that
> > one multicolor LED, right? And I can only manipulate the max_brightness=
 of
> > that one multicolor LED instance.
> > If I'm wrong, I'd be happy to not have to add the sysfs files.
>=20
> It seems that this device is similar in the aspect of LED grouping
> to LP50xx family. There is already a driver for that one [0] with
> related bindings. Grouping solution could be addressed similarly to the
> banking mechanism in that driver.
>
> That of course means that this patch needs a significant rework.
>=20
> First thing that strikes me after analyzing datasheet is that
> LEDs are not assigned to any group since LP5860_REG_GRP_SEL_START
> address is not referenced anywhere, and this is base address for
> Dot_grp_selN registers that enable affiliation of the LED to given
> group. No need for global brightness setting then.
>

The (now called) global_brightness sets the current of the three color grou=
ps respectively. These groups have a fixed mapping:

Group 1 is CS0, CS3, CS6,...
Group 2 is CS1, CS4, CS7,...
Group 3 is CS2, CS5, CS8,...

therefore setting the R, G and B channel. No need to assign any groups for =
that.

> Anyway, I'd add proper support for this device with DT knobs
> to enable both grouping and individual approach to controlling the LEDs.
>=20

As far as I can tell, both drivers are pretty similar already regarding the=
 DT description and setup.

I will just remove the global_brightness (aka global current in the datashe=
et) stuff, as I don't see that it is really, really needed alas the chip su=
pports this feature and just use the intensity and max_brightness knobs tha=
t are already there via the multicolor classdev.


Best regards,
Steffen

--=20
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

