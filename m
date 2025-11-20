Return-Path: <linux-spi+bounces-11428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C249C756DC
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 17:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0515E4E9C94
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A636358D22;
	Thu, 20 Nov 2025 16:33:18 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDE331A6B
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656398; cv=none; b=rceE6s3DylFhVQPRP3pAjal0rD1LaaLG5aghL+oxh9f/OeRqI9s568BVHZWQfZ98qE6BGEgABRLgA8zD6NJKmHMj8u7yO9yF0NIadbBE1V9qcwLuP7kEuXtEbzJaUE0vtxwn+di0O4MtAhkKu1RSn7FQk1rxdvSR24aEBm+XVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656398; c=relaxed/simple;
	bh=73XsPhx2c3nGgibr//sd4fPhn8bIZngrIJyJokW5wT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epQhVS4XIvDZvRFRgXufokY3WXu7oH2E1uhrrqbpyGRoLpUCH+UhJw3kwaX5rb8qU0+WZQsW6lPADpVo/DXRpf/c0dY1owaJoba7RTtz/iUQ5Tdb7pwZp1TlUEaU2Fi6gK6+87CSfTZgxA5PJvpwN90uUCCmb1Inh3wgc1LAyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM7aS-0004YP-9t; Thu, 20 Nov 2025 17:32:48 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM7aQ-001RqE-2W;
	Thu, 20 Nov 2025 17:32:46 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM7aQ-00000000Bax-2qXE;
	Thu, 20 Nov 2025 17:32:46 +0100
Message-ID: <4e26c38c17fdcecc0e3fc119222568bc543f870b.camel@pengutronix.de>
Subject: Re: [PATCH v7 0/9] reset: rework reset-gpios handling
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>,
 David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald	
 <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, Maciej Strozek
	 <mstrozek@opensource.cirrus.com>, Charles Keepax
 <ckeepax@opensource.cirrus.com>,  Andy Shevchenko	 <andy@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-spi@vger.kernel.org, Bartosz
 Golaszewski	 <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org
Date: Thu, 20 Nov 2025 17:32:46 +0100
In-Reply-To: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

On Do, 2025-11-20 at 14:23 +0100, Bartosz Golaszewski wrote:
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
>=20
> In this case using fwnode lookup makes more sense. However, since the
> reset provider is created dynamically, it doesn't have a corresponding
> firmware node (in this case: an OF-node). That leaves us with software
> nodes which currently cannot reference other implementations of the
> fwnode API, only other struct software_node objects. This is a needless
> limitation as it's imaginable that a dynamic auxiliary device (with a
> software node attached) would want to reference a real device with an OF
> node.
>=20
> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.
>=20
> Another user of the software node changes in the future could become the
> shared GPIO modules that's in the works in parallel[1].
>=20
> Merging strategy: the series is logically split into four parts: driver
> core, SPI, GPIO and reset respectively. However there are build-time
> dependencies between all three parts so I suggest the reset tree as the
> right one to take it upstream with an immutable branch provided to
> driver core, SPI and GPIO.

Applied to reset/next, thanks!

[1/9] software node: read the reference args via the fwnode API
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Df11a8e996d5e
[2/9] software node: increase the reference of the swnode by its fwnode
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D0651933c117e
[3/9] software node: allow referencing firmware nodes
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dd7cdbbc93c56
[4/9] spi: cs42l43: Use actual ACPI firmware node for chip selects
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dd2a6cea44acc
[5/9] gpio: swnode: allow referencing GPIO chips by firmware nodes
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D216c12047571
[6/9] reset: order includes alphabetically in reset/core.c
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D97d85328e3dc
[7/9] reset: make the provider of reset-gpios the parent of the reset devic=
e
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D46dae84a90f9
[8/9] reset: gpio: convert the driver to using the auxiliary bus
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D109ce747ac22
[9/9] reset: gpio: use software nodes to setup the GPIO lookup
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D5fc4e4cf7a22

5fc4e4cf7a22 is tagged as reset-gpio-for-v6.19. I'll send a separate
pull request for it.

regards
Philipp

