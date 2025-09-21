Return-Path: <linux-spi+bounces-10192-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF6B8DA21
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997CB7B1FDD
	for <lists+linux-spi@lfdr.de>; Sun, 21 Sep 2025 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB202638B2;
	Sun, 21 Sep 2025 11:27:03 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78CD261B9C;
	Sun, 21 Sep 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454023; cv=none; b=LTAgdQkQjgZ0LaNilrxQ5I76j88uEQIwCiO8XXS9PHy3ZUEik8gxg6NtA+bV9d1kNl2SYFRCn3iLN/KDk0WARAu7CYo6TSbOhUYZPuYV08PWKMSlk+1stR8V4lxur57sFIevp61AVWIXr1Kn+AIHHrHGQ8D8O5BV6/C3VzlyN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454023; c=relaxed/simple;
	bh=IiVPhFnTYQPPhf0QrcJIrb95i8lqSitvi1eR3nJi2BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KH8ApAlzHDYDN/uBZdU7gOL6WDuVDXU4VV2iIE8u4kQe4HfquBhrYNYYUv3vV0+u4m1SwMaCpmytxFL972av8vgGi6OLb2dEtvyvz81TTj1lW5PEB8JZAvcOSi2XU03sdQ4LfGeMmucLazrj+xgNVIdrDQbFOWP8dVRSc/5dOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Sugn5N2wTVmJ5bGcOWwc8A==
X-CSE-MsgGUID: 5iXdZm60S+2OvBvU6V4gHg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Sep 2025 20:26:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 51B25400E4EB;
	Sun, 21 Sep 2025 20:26:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2] spi: rpc-if: Add resume support for RZ/G3E
Date: Sun, 21 Sep 2025 12:26:46 +0100
Message-ID: <20250921112649.104516-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
References: <20250921112649.104516-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On RZ/G3E using PSCI, s2ram powers down the SoC. After resume,
reinitialize the hardware for SPI operations.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index a8e783cc66e7..6edc0c4db854 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -207,6 +207,8 @@ static int rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
+	rpcif_hw_init(dev, false);
+
 	return spi_controller_resume(ctlr);
 }
 
-- 
2.43.0


