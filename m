Return-Path: <linux-spi+bounces-12029-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D507ECD19A0
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D245F3028DB1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47003340A57;
	Fri, 19 Dec 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p3CO3Vzp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4E340279;
	Fri, 19 Dec 2025 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172186; cv=none; b=rIgGHfpt6I25Ds6e30S/Tjd+xHCrBv/csUopwMUEIZ0yv42yTs1o7B1dyI7e8nB1D/DiSTacfYzP+OXt8NcD7WjfTsFBa9BgKuPf9PG2uKj2/yGJNi40K9Wi51qcjv2FNA7YV1DkA0rjx0XJ9EeXWZKKk09gRNag3asQd24JwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172186; c=relaxed/simple;
	bh=54JBkEU1l8fYS1m5qSa1lsuYP8dvattbdEHeBHUBHfQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NVkCsRswQVnFuHQz/c6/Qu74HVgDRdIH6nTDKXOFRSz5e5X4cmhETvbDy+vX0zQ2C4YT3RdPiRklFbzNddbOtJeSnofIL8kdnHZlMveocO/mfXevzMArNhiU9eIYfiUbOECBTUPHSdxL8mVUZc8/m9OPR2xgQErXsBgYJkELEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p3CO3Vzp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 40A711A22FA;
	Fri, 19 Dec 2025 19:23:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D0946071D;
	Fri, 19 Dec 2025 19:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 490E7102F0CDA;
	Fri, 19 Dec 2025 20:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fVvTSEvtsdBcY0MvbSH39zSsl5X9+FtJmWcj/1B7560=;
	b=p3CO3Vzp6BXEvGYKax9dm+5rGIPbZTpcLFzA8vIRk2VnjzsGsZlR8hYrSllEvlzk5kuV+8
	sp5PPq9khm7nk0gnqbMoe+yL+QHkYCUEF9OO5UVgmUa3XEZ3CDYQjfQcX7bx7Go/j1e0GS
	CjMIyng1RCtQnayA6zuwhqchcdEsUfVUl72rv0UUgO5JWPbOXJxZGQlfYhsVknoditNSJR
	VKDKbkRTmSCrRnvcHh9KPEbuGVay5pU0+Nb1dqMFYEcCqTeSIS4C2l5/XIxlkULr/w0DPP
	E6J6r/uaDfM5pQY0z9WyCLv5KhhQzMHoxd2gjgu+bYYsgjbs2An80//PjYtf+g==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Subject: [PATCH 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
Date: Fri, 19 Dec 2025 20:22:02 +0100
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgOm/qFXEQdpo2apmoAIxbtbH
 L/hvQTGKmwwFgmUbzE5YgaVBfh9iRujhGxwlWvJ0YDm98gSWLHDTPWEl52Cva+Z2qZf1i5Ark/
 lVZ7/PM3v+wGeGo7waQAAAA==
X-Change-ID: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello,

This series adds support for the QSPI controller available on Renesas
RZ/N1S and RZ/N1D SoC. It has been tested with a custom board (see last
SPI patch for details).

Adding support for this SoC required a few adaptations in the Cadence
QSPI driver. The bulk of the work is in the few last patches. Everything
else is just misc style fixes and improvements which bothered me while I
was wandering.

In order to support all constraints, I sometimes used a new quirk (for
the write protection feature and the "no indirect mode"), and sometimes
used the compatible directly. The ones I thought might not be RZ/N1
specific have been implemented under the form of a quirk, in order to
ease their reuse. The other adaptations, which I believe are more
Renesas specific, have been handled using the compatible. This is all
very arbitrary, and can be discussed.

Thanks,
Miquèl

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
Miquel Raynal (1):
      spi: cadence-qspi: Make sure we filter out unsupported ops

Miquel Raynal (Schneider Electric) (12):
      spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
      spi: cadence-qspi: Align definitions
      spi: cadence-qspi: Fix style and improve readability
      spi: cadence-qspi: Fix ORing style and alignments
      spi: cadence-qspi: Remove an useless operation
      spi: cadence-qspi: Fix probe error path and remove
      spi: cadence-qspi: Try hard to disable the clocks
      spi: cadence-qspi: Kill cqspi_jh7110_clk_init
      spi: cadence-qspi: Add a flag for controllers without indirect access support
      spi: cadence-qspi: Make sure write protection is disabled
      spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
      ARM: dts: r9a06g032: Describe the QSPI controller

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   4 +
 arch/arm/boot/dts/renesas/r9a06g032.dtsi           |  14 ++
 drivers/spi/spi-cadence-quadspi.c                  | 256 ++++++++++-----------
 3 files changed, 145 insertions(+), 129 deletions(-)
---
base-commit: c83903530c78c9ae49235ac135d43bf188762169
change-id: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d

Best regards,
-- 
Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>


