Return-Path: <linux-spi+bounces-5645-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77A9C0A2E
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA231C21450
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 15:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72235212D10;
	Thu,  7 Nov 2024 15:35:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD232942A
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993734; cv=none; b=m3yi1CBm1TEfbUxa7f7bqZ/O3wSxgU4Zmmv1U61RASn9cIgtO9Ozhry6Kyg9IEr85AcH3a9MjUhPSHxoF+jsV3QuGyV9G21fU4BJKEaN3+kKYTV84Y/DjZzOoEOQ4fzuMQP8qoKsl4ImeL/4fyc/YqigmYmnEMCPhK+mZsMzudc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993734; c=relaxed/simple;
	bh=YqDuZZASfsbZbJh36sPWJxerqHJHk525rmka0yjYpsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V1tHhPUfRFNhbIacHYBb3Lg6uF5awANVsIVHCP/FASy/bqvojb/vjWFLVN7893qGX6nQ364ivfHsgXYHbaU4GvGMn/AEpWtpcbc8t03bBa0gbj5+q32fQYlDQeOCGbaLXi7TbE1Ozgd/qmK9C3aR9l7TsCS8Sghzsn4R41LXZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1t94Xf-0005DD-Pg; Thu, 07 Nov 2024 16:35:27 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/2] spi: imx: support word delay in ecspi
Date: Thu, 07 Nov 2024 16:35:19 +0100
Message-Id: <20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfeLGcC/x3MTQqAIBBA4avErBsYpUV2lWgROtVAaSj0g3j3p
 OW3eC9D4iicYGgyRL4kSfAVqm3AbrNfGcVVgybdKSKDcjyYTsE7RIeO9/lFrZwltZDprYUanpE
 Xef7pOJXyAebrH9VkAAAA
X-Change-ID: 20241009-imx-spi-word-delay-21dc01f098cc
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The i.MX SPI controller supports inserting a configurable delay between
subsequent words, which is needed for some slower devices that couldn't
keep up otherwise.

This patch series introduces support for the word delay parameters for
i.MX51 onwards.

The SPI clock (CSRC=0) was chosen as the clock source over the also
available 32.768 KHz Low-Frequency Reference Clock (CSRC=1). The sample
period control bits (SAMPLE_PERIOD) are set to the selected word delay
converted to SPI clock cycles. A deviation from the requested number of
wait cycles and the actual word delay was observed via both software
timings and oscilloscope measurements and accounted for.

The Chip Select Delay Control bits in the Sample Period Control Register
remain zero.

Behaviour on i.MX35 and earlier, where the CSPI interface is used,
remains unchanged.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Jonas Rebmann (2):
      spi: imx: pass struct spi_transfer to prepare_transfer()
      spi: imx: support word delay

 drivers/spi/spi-imx.c | 106 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 16 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241009-imx-spi-word-delay-21dc01f098cc

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


