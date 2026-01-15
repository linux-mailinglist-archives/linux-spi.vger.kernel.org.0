Return-Path: <linux-spi+bounces-12392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF7D23922
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 10:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77F6730EC09E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0901389453;
	Thu, 15 Jan 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vgyhb7k6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139EE389E1A;
	Thu, 15 Jan 2026 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768469157; cv=none; b=Em43LTb2ZCuy6y7KtvQCuYCxUX5pkJw+Cy/N8+C7/t1hPJ1C6CjjKTV32Ms/FC8jMdpQ0CnhMc/XgHQugEx555WvS4+IBXqAMnYEMDkCmlMURB1J8rElnW15Rk2+n3hJFdzZ1ENUzIPrArmxJAqHcseqSOXz3MtbsMSRLndfEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768469157; c=relaxed/simple;
	bh=tnlEHVBMfVuJ/xbWRgOe8Z364O4sTk4+Wlw3GmDnPcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKDmnXUMdzkmVPN4XoJjT5brbhcFEFHr5niGW5FZDARwudLVLSoNAyEL7nqFj6J691wmNs0EfL9t/UDy0SYP0vSvT/xVLC2Uzuu3XJOHTeFLwzEg7xkRIHZahCharwsdtoGB2jSAdEYZoaNRd5B0i+RM7Fa7Zy9LYRTWaed4GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vgyhb7k6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1CA3FC1F1E5;
	Thu, 15 Jan 2026 09:25:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CA5B2606B6;
	Thu, 15 Jan 2026 09:25:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8B4B10B6852D;
	Thu, 15 Jan 2026 10:25:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768469153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+LL3KeG0p9hrIlsBrxn1Y7duS7uVUzLvSPr2dOdaikI=;
	b=Vgyhb7k6Nqh6oF0QrSDrNPCv3jrxtFiHkcr6c8Mz2QJDE8+nZVMTVWWb1eyWR5Z/H4Zi/R
	YFB1rPkb1UFJ6j+ME/jg1Vgyzq0JYDSGHp41t8VRpDqpYnScS4NTu2qE+TjI4EJFSCu8i6
	x256iLxdKrEqK4J+CZSPhrTxiSXA/8KRpp4f/nfOS2mJeI+Ts5zm+/maQ1l2ire9zl/TVg
	YRluL8hGDdYWM75QYSLsm/kxMmFVHR9oxtlEBMJsLYJCGQAOgTtwKHTeCHeO5WSpOVt4Ta
	7EfG0aN6J2AE9NwFWEJHMG0Kk7HFec3QT2UuoZKvlvIdTJ5MVsz1L30AKpzg2Q==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 15 Jan 2026 10:25:02 +0100
Subject: [PATCH v2 11/13] spi: cadence-qspi: Make sure write protection is
 disabled
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-schneider-6-19-rc1-qspi-v2-11-7e6a06e1e17b@bootlin.com>
References: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
In-Reply-To: <20260115-schneider-6-19-rc1-qspi-v2-0-7e6a06e1e17b@bootlin.com>
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

Renesas RZ/N1 QSPI controllers embed the Cadence IP with some
modifications. For instance, they feature a write protection of the
direct mapping at the controller level, with this feature all data
writes to the AHB region are aborted.

Despite the fact that the flag setting write protection is disabled by
default, Bootloaders may (and actually do) set it, so mark this feature
as being available with a specific flag to, if applicable, make sure it
is disabled.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d84531aa470c..fc7e64614a32 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -48,6 +48,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 #define CQSPI_NO_INDIRECT_MODE		BIT(11)
+#define CQSPI_HAS_WR_PROTECT		BIT(12)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -218,6 +219,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_IRQSTATUS			0x40
 #define CQSPI_REG_IRQMASK			0x44
 
+#define CQSPI_REG_WR_PROT_CTRL			0x58
+
 #define CQSPI_REG_INDIRECTRD			0x60
 #define CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
 #define CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
@@ -1641,6 +1644,10 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 	}
 
+	/* Disable write protection at controller level */
+	if (cqspi->ddata && cqspi->ddata->quirks & CQSPI_HAS_WR_PROTECT)
+		writel(0, cqspi->iobase + CQSPI_REG_WR_PROT_CTRL);
+
 	/* Disable direct access controller */
 	if (!cqspi->use_direct_mode) {
 		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);

-- 
2.51.1


