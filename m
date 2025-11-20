Return-Path: <linux-spi+bounces-11389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D54C73B8A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 12:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFF954ECDF0
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB027330D47;
	Thu, 20 Nov 2025 11:21:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B73314C4
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637681; cv=none; b=XWQSeb42Cn84epCXC5Ai143Y+O54iALr9zoFfA8twLWYlv1Gkb6VFQqBDJedUW5KobaDfwkVCIZaYl2x/2GN5m6/StH0/+mOHBiYzoR+zFXxVU11qrvjkVoHg3x0A4tX9tyrDQFER4oPAFkWYIWb5OjD1D26IEbvjo0vhDm6vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637681; c=relaxed/simple;
	bh=q22+mk677AzdY8Rl7fT4REmZrrpKMzHJBZ1Y4g5PasE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPr5tUv1LNzD4YG3Z4bpjU69xm3kqAxnRljV+zq3XWNvQ0Pr7zAoik1KE1eBVeGE9rnSRAYu509Gsp1ED0musmLBfN9wzz4riQWG1u3ZmakdWDzQ12QtTUP52u3O8aJJQObtSP8DSmO6d4c4hyc4CXf1boWp/VMYBKGzq2X1gNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM2it-00031V-Bo; Thu, 20 Nov 2025 12:21:11 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM2is-001PNN-1G;
	Thu, 20 Nov 2025 12:21:10 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM2is-000000005vP-1Hrs;
	Thu, 20 Nov 2025 12:21:10 +0100
Message-ID: <3beb841e99f62767547054c4344f2c60eae4ed9b.camel@pengutronix.de>
Subject: Re: [PATCH v2] spi: cs42l43: Use actual ACPI firmware node for chip
 selects
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org, 
	brgl@bgdev.pl, linus.walleij@linaro.org
Cc: andy@kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Date: Thu, 20 Nov 2025 12:21:10 +0100
In-Reply-To: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
References: <20251120105907.1373797-1-ckeepax@opensource.cirrus.com>
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

On Do, 2025-11-20 at 10:59 +0000, Charles Keepax wrote:
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently
> software nodes are added to support this case, however, the chip
> selects for these devices are specified using a hack. A software
> node is added with the same name as the pinctrl driver, as the
> look up was name based, this allowed the GPIO look up to return
> the pinctrl driver even though the swnode was not owned by it.
> This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
>=20
> Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> name as the key for GPIO lookup") changed the lookup to be
> fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. There is no pinctrl driver
> attached to the swnode itself. But other patches did add support
> for linking a swnode to a real fwnode node [1]. As such the hack
> is no longer needed, so switch over to just passing the real
> fwnode for the pinctrl property to avoid any issues.
>=20
> Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-=
0-69aa852de9e4@linaro.org/ [1]
> Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> Fixes: e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the ke=
y for GPIO lookup")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>=20
> IMPORTANT NOTE: This depends both functionally and build wise on the
> linked series from Bart, it probably makes sense for him to pull the
> patch into his series.

When included in the reset-gpios-swnodes series, will this need either
a noautosel or prerequisite marker to avoid it being picked up into
stable without the reset of the series?

regards
Philipp

