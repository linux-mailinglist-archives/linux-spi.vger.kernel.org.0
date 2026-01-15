Return-Path: <linux-spi+bounces-12381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C82D237E9
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE872302EC71
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DC35B150;
	Thu, 15 Jan 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="akI8CD3R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78419356A10;
	Thu, 15 Jan 2026 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469141; cv=none; b=FjBTudzONP5yAEbUh5/bJG6szT6lS4hECeoa+S0XMJ1HFQL1dSPtADi6yQGfRCKiawVP8V49bDHgYuAWkL06S6UR3Iz7yZ2mazkOrCRGDdxesC2MhjNZjVnuiiMIK+yMBKQ/JvcoMHGvsjEC7k3xwg7ngCXb0j852s+RMw6fvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469141; c=relaxed/simple;
	bh=/gd41pN+2oJIM9vptIsbXw8vPsTvmjAJ4LLt3mcWAEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QJ6ECZA/Djd5Likrojd6EE8YY2/kSzBH1CA3fMfWP9JEUmYx0ZQvGN50yliMSaBMwk50AhoCEdsA89iPoXgbqX0L1/1CYKAW86oGhdXuwCbs4a1PLubgQWPv3V6taqM3BeL5cceD1afoKKBueEaKrK5OWjH3Y7ElubcalfaeUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=akI8CD3R; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9612AC1F1E5;
	Thu, 15 Jan 2026 09:25:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45027606B6;
	Thu, 15 Jan 2026 09:25:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB45910B68454;
	Thu, 15 Jan 2026 10:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=K1qbl7S2rlm9JCoeIkodciVRDJ3Iedcf5ILamFg+cZg=;
	b=akI8CD3RJmrxk8tvBidwHPjmgLY26oOmJnPJCIDjAGoaBTuLLD9nIELbBll4eGRD15fCJa
	ZJXm3JzUvYQOpAfZdnAz/eL+sbiWCLxIiJAk6GSOfwsjqSH1Bn9OdZVUYioOTmTyHDvUoI
	KP/jn11nU95HrIz+P/fOHdFpUbO4ufM7NFSmMzblD5Q0hqrgQWyl5bnpgwDs6J7nYjzcIh
	lvABoG7up2UVpPJna220IY/EJOBnm4XHQfIYpm8nFUTbXzuyCtWUOBgHhLYN3vXjbMxDpS
	XVPuivGafNm48T3tnkLj+eAjTRtXrbTTQz+A9T2fjbxfg3Q2CiDV2mv/dD+yzw==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/13] spi: cadence-qspi: Add Renesas RZ/N1 support
Date: Thu, 15 Jan 2026 10:24:51 +0100
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBAF0KuQWTuGKRSUlfcwLGo7yCTaYkuIh
 nB3Kxdw+X7y/18hcRRO0BUrRF4kSfAZ6lCAHY2/M4rLBlUqTYrOmOzoWRxHbDAzWsJXmgRbWzH
 pujVD4yC3p8iDvPfla589SppD/OxHC/3S/5sLYYkn43Spqa24ri+3EOaH+KMNT+i3bfsCYG8BO
 cAAAAA=
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
Changes in v2:
- Fix commit log of DT binding patch, following Krzysztof's comment.
- Fix properties order in DTSI.
- Rebase on top of spi/for-next and fix all conflicts.
- Simplify even further the code in the cleanup patches following
  Pratyush's advices.
- Link to v1: https://lore.kernel.org/r/20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com

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
 drivers/spi/spi-cadence-quadspi.c                  | 260 ++++++++++-----------
 3 files changed, 144 insertions(+), 134 deletions(-)
---
base-commit: 0afb3ab76ffb521700af678ea931d31192f93260
change-id: 20251219-schneider-6-19-rc1-qspi-7c3e1547af6d

Best regards,
-- 
Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>


