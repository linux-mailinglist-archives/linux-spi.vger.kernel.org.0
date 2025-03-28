Return-Path: <linux-spi+bounces-7358-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E35A74550
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 09:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688D43AD8C3
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B518DB2B;
	Fri, 28 Mar 2025 08:24:14 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907542AA5
	for <linux-spi@vger.kernel.org>; Fri, 28 Mar 2025 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150253; cv=none; b=BMmYY7DYARZpXMnufMllLQ3yM3ZNUpi7/iHb0i6FGuR6jJeJUaGeMWJtAcjmzSQ+UirnnRVGZ0bf8ahSx2wAmbMaZJtgayNm9K50e9xZzeOUPIbEGVZF0/Vtg29HiNjqZwdiZJZTyCffzdNkT1Mdapj1IFVx7krwY7KPFts2YrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150253; c=relaxed/simple;
	bh=3K9E9P/3fJhtWUagyMGSRbT2D5mew/Y9C8iypQyVCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptUQCMJTnD9K2pJvKFvg9pNZHBtBUlwdcjwmvBdCz0zEcSppNAS7LIQ31Lf31mo34i0CvGsCgA+34mGnLs2uK67ulKTujI5o2ZU3GbRjBGMGO9VywmJWiFU31e2feSewO55Oepb0TYmN9lbFEdocL98d91oAX25uXZbOmPyW82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:84f5:57a8:7b3b:9088])
	by laurent.telenet-ops.be with cmsmtp
	id W8Q32E0051KBnwa018Q3pj; Fri, 28 Mar 2025 09:24:07 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1ty50U-0000000G6nn-2d5Y;
	Fri, 28 Mar 2025 09:24:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1ty50V-00000006N2R-0Qmy;
	Fri, 28 Mar 2025 09:24:03 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: nand: Drop explicit test for built-in CONFIG_SPI_QPIC_SNAND
Date: Fri, 28 Mar 2025 09:24:01 +0100
Message-ID: <99eef91c334f3f2314c2f5671e1eb55211a5ff19.1743150196.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_SPI_QPIC_SNAND=m, but CONFIG_MTD_NAND_QCOM=n:

    ERROR: modpost: "qcom_nandc_unalloc" [drivers/spi/spi-qpic-snand.ko] undefined!
    ...

Fix this by dropping the explicit test for a built-in
CONFIG_SPI_QPIC_SNAND completely.  Kbuild handles multiple and mixed
obj-y/obj-m rules for the same object file fine.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503280759.XhwLcV7m-lkp@intel.com/
Fixes: 7304d1909080ef0c ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mtd/nand/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index db516a45f0c52635..44913ff1bf12cc24 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -3,11 +3,8 @@
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
-ifeq ($(CONFIG_SPI_QPIC_SNAND),y)
 obj-$(CONFIG_SPI_QPIC_SNAND) += qpic_common.o
-else
 obj-$(CONFIG_MTD_NAND_QCOM) += qpic_common.o
-endif
 obj-y	+= onenand/
 obj-y	+= raw/
 obj-y	+= spi/
-- 
2.43.0


