Return-Path: <linux-spi+bounces-7317-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB94A7185E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9219E1885975
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBAB1EDA13;
	Wed, 26 Mar 2025 14:22:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EDA54652
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998950; cv=none; b=df6MgVkx3vk4wmFmCYq8DWJ9Vuo8sLpvIp6AN/TPBimhBpDA6ZR5+sRedqYgywBPI5L8yvUDlDwXWsILT0kxzikLR17HeISA3WBAkrWE1e6H6R1PKlk8mmSNk8IbHcg2y0XDe7HROdGzlz2piCm5K9Bwu/UFqMovyOYZfWU074E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998950; c=relaxed/simple;
	bh=TKxti6j94LxS0EU/52dbpDWY1Jx1BVAWz3BmQzJD2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDDpRuZncZHxSiDeprLWc9TvCYt1ZlaOcNrIjiZ4ZCauGtxtMwJlz+htYIyijkihC9TFLDLDD+FSfc9oR2r1xwR7L2klEkzuSQ8oZr6wz1W587nuuZU+rCH7PVhADHVPVEZgkry41/WGUa2AK7geeERxIiOjRRAs8aNWID9jzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b1ef:107c:7814:6642])
	by michel.telenet-ops.be with cmsmtp
	id VSNL2E0085Szt1p06SNLFp; Wed, 26 Mar 2025 15:22:21 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txRdf-0000000FjIr-0Skx;
	Wed, 26 Mar 2025 15:22:20 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1txRe8-0000000Gytg-2oz1;
	Wed, 26 Mar 2025 15:22:20 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: SPI_QPIC_SNAND should be tristate and depend on MTD
Date: Wed, 26 Mar 2025 15:22:19 +0100
Message-ID: <b63db431cbf35223a4400e44c296293d32c4543c.1742998909.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPI_QPIC_SNAND is the only driver that selects MTD instead of depending
on it, which could lead to circular dependencies.  Moreover, as
SPI_QPIC_SNAND is bool, this forces MTD (and various related symbols) to
be built-in, as can be seen in an allmodconfig kernel.

Except for a missing semicolon, there is no reason why SPI_QPIC_SNAND
cannot be tristate; all MODULE_*() boilerplate is already present.
Hence make SPI_QPIC_SNAND tristate, let it depend on MTD, and add the
missing semicolon.

Fixes: 7304d1909080ef0c ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 drivers/spi/Kconfig          | 4 ++--
 drivers/spi/spi-qpic-snand.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c18bb46ed13fea9a..0121ecb13d541799 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -945,9 +945,9 @@ config SPI_QCOM_QSPI
 	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
 
 config SPI_QPIC_SNAND
-	bool "QPIC SNAND controller"
+	tristate "QPIC SNAND controller"
 	depends on ARCH_QCOM || COMPILE_TEST
-	select MTD
+	depends on MTD
 	help
 	  QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
 	  QPIC controller supports both parallel nand and serial nand.
diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fbba7741a9bf336d..17eb67e19132612c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1614,7 +1614,7 @@ static const struct of_device_id qcom_snandc_of_match[] = {
 		.data = &ipq9574_snandc_props,
 	},
 	{}
-}
+};
 MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
 
 static struct platform_driver qcom_spi_driver = {
-- 
2.43.0


