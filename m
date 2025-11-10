Return-Path: <linux-spi+bounces-11136-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E6C45168
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 07:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3143AAABB
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 06:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBD2EAD15;
	Mon, 10 Nov 2025 06:35:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD92EAB6B
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756545; cv=none; b=rg1jgqGbB+O01ArouRJgH1SH0F+o0zweof6J773EdJrRlj/2N0T5msLOhICPC3750jMTZeuv90dcb4Ln+tTwpasXjjD96/zBwO8/l4mjeHknMqWATPRjr1t9RDlN3cksPztkyvtpn4j13A7U/Z9DgsPepOQbQccjIpDGeHEwiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756545; c=relaxed/simple;
	bh=ziyBPnwId1hIqYZ/NwS+wAM+3tGvxLV0lkdeFla9Mv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pinjvmAHkoKtyeoDVKf8gUoFxlpzqY2efAgDbb3yPCh3ARkSRQRk6jglE8Rr/2THlcvOGhVQrijFTHUl39QPIxXFi4mMWnjo4NaYkxcNOWape3aBqEUAnpLRURSZWuZpHL9Wwq2HMJ9JBAzvHbWdj0uHRplIlD9oZ1ecR8hRdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vILV3-0003U0-3z; Mon, 10 Nov 2025 07:35:37 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v5 0/2] LED: Add basic LP5860 LED matrix driver
Date: Mon, 10 Nov 2025 07:35:32 +0100
Message-Id: <20251110-v6-14-topic-ti-lp5860-v5-0-5b777b99a905@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALSHEWkC/3XNTWrDMBCG4asErasyGv2MlFXvUbqwJTkZKLaRX
 ZESfPcqoTSLxsv3g3nmKpZcOC/ieLiKkisvPI0t7MtBxHM3nrLk1FogoAVUQVYnlZHrNHOUK8v
 P2XoHckDbGd87jBREu51LHvhyd98/Wp95WafyfX9T1W39FRF2xKokSIOeTJ8iWaXf5jyevtYyj
 Xx5TVnc2IoPyjZkh8JGEeYY/dCZLtFTSj+ooNQepRulA5D2eQiJ1FPK/FEKgPYo06jgiKwHF3o
 H/6ht234ARt22F6ABAAA=
X-Change-ID: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steffen Trumtrar <kernel@pengutronix.de>, Pavel Machek <pavel@kernel.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
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
Changes in v5:
- remove global_brightness code and sysfs ABI
- rebase to v6.18-rc1
- Link to v4: https://lore.kernel.org/r/20251007-v6-14-topic-ti-lp5860-v4-0-967758069b60@pengutronix.de

Changes in v4:
- move to drivers/leds/rgb
- fix some upper/lowercase
- use ATTRIBUTE_GROUPS macro
- unwrap some lines
- Link to v3: https://lore.kernel.org/r/20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de

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
Steffen Trumtrar (2):
      dt-bindings: leds: add lp5860 LED controller
      leds: add support for TI LP5860 LED driver chip

 .../devicetree/bindings/leds/leds-lp5860.yaml      | 111 ++++++++
 drivers/leds/rgb/Kconfig                           |  27 ++
 drivers/leds/rgb/Makefile                          |   2 +
 drivers/leds/rgb/leds-lp5860-core.c                | 202 ++++++++++++++
 drivers/leds/rgb/leds-lp5860-spi.c                 |  89 ++++++
 include/linux/platform_data/leds-lp5860.h          | 305 +++++++++++++++++++++
 6 files changed, 736 insertions(+)
---
base-commit: 1447d74a2d34d824c5fef5eafc9408f520d4f90f
change-id: 20250219-v6-14-topic-ti-lp5860-f25a48b62c79

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


