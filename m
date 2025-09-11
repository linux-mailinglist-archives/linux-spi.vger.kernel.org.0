Return-Path: <linux-spi+bounces-9983-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC104B52961
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 09:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B1E566C5C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Sep 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3A265CBE;
	Thu, 11 Sep 2025 06:59:56 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DC25DB1A
	for <linux-spi@vger.kernel.org>; Thu, 11 Sep 2025 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573996; cv=none; b=Z4O8C2z4uOhsUTLl1PSqOcqBrUUmIi+RMvHCNRrwomRAS4g+iLyDx2d7cLWx6wAExMh0yiguMXmILRabi1mer43qCLbAS6U3RYkPTfW/qLxcdTJuwMiPFPz3hG+iB2J2ULYSSS5eQpKwIXCPmZarlQZrpY4JVR8KkIP0P3z/8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573996; c=relaxed/simple;
	bh=xYIy1XN64GZ5/gu04ZuovWY5JAMht1uak8z/8ld38Yg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oznW1DJ4a1SfF4ykpJ7C3+zrxT/h4pU0sZq9Y+b8oQWP2Bc4+3fKfAX7qkYMtV/CeKooeoP+wQ7xNOriL9P9kLKms1vAchL8ACenb1rUByBUhov/xHf2c0k3Z7TR9yPqW0981EDEVyypJ1pkAt6+nYM+CLHrPc37EnKivAZLrUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1uwbHa-0002uj-Sn; Thu, 11 Sep 2025 08:59:50 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v3 0/3] LED: Add basic LP5860 LED matrix driver
Date: Thu, 11 Sep 2025 08:59:30 +0200
Message-Id: <20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJzwmgC/3XNQQqDMBCF4auUrDslGRMTu+o9SheaRB0oKtEGi
 3j3Ril0UVz+D+abhY0+kB/Z9bSw4CON1HcpsvOJ2bbsGg/kUjPkqDiKAmIOQsLUD2RhIngOyuQ
 calSlNFWOVhcs3Q7B1zTv7v2RuqVx6sN7fxPFtn5F5AdiFMBBotGyclYrkd0G3zWvKfQdzRfn2
 cZG/FEqIQcUJkqjt9bUpSyd/qPWdf0AjxwtwwoBAAA=
X-Change-ID: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steffen Trumtrar <kernel@pengutronix.de>, Pavel Machek <pavel@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The lp5860 is a LED matrix driver with 18 constant current sinks and 11
scan switches which allows controlling up to 196 LED dots.

This series adds just the basic support for the device on the SPI bus.
It is also possible to use it on I2C. The interface can be
switched/selected via an interface select pin.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v3:
- fix c-styling errors
- rename functions/defines/variables
- split out ABI documentation
- rename [rgb]_current* to [rgb]_global_brightness*
- rework multi-led probing
- Link to v2: https://lore.kernel.org/r/20250514-v6-14-topic-ti-lp5860-v2-0-72ecc8fa4ad7@pengutronix.de

Changes in v2:
- add open and short detection
- add ABI documentation
- fix devicetree binding (maxItems/minItems)
- fix commit message to imperative mood
- minor cleanup
- Link to v1: https://lore.kernel.org/r/20250220-v6-14-topic-ti-lp5860-v1-0-42874bdc7513@pengutronix.de

---
Steffen Trumtrar (3):
      dt-bindings: leds: add lp5860 LED controller
      leds: add support for TI LP5860 LED driver chip
      Documentation: ABI: add lp5860 led matrix controller

 Documentation/ABI/testing/sysfs-class-spi-lp5860   |  23 ++
 .../devicetree/bindings/leds/leds-lp5860.yaml      | 111 ++++++++
 drivers/leds/Kconfig                               |  28 ++
 drivers/leds/Makefile                              |   2 +
 drivers/leds/leds-lp5860-core.c                    | 222 +++++++++++++++
 drivers/leds/leds-lp5860-spi.c                     |  90 ++++++
 include/linux/platform_data/leds-lp5860.h          | 305 +++++++++++++++++++++
 7 files changed, 781 insertions(+)
---
base-commit: a32cf8a562e776ee75d4fa9432719e855d70fc03
change-id: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


