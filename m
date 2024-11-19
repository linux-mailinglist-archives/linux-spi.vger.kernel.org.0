Return-Path: <linux-spi+bounces-5744-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70E9D2B71
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D8C283D71
	for <lists+linux-spi@lfdr.de>; Tue, 19 Nov 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA11D63FA;
	Tue, 19 Nov 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UHEcKduq"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0671D5ACC;
	Tue, 19 Nov 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034486; cv=none; b=DmWoR+4wipsvlSunxeBwf+cK2zgie3tkXM831LakbgDeaShBOsnG7q2CNEh5T482fgQIcxvTgHJRE0UhtTWgHT5WVcYtfw0RbiilWWh06nBeqSau3RRhtcbS0LHrJmt8LGe3DkOS5Sh7E5zYnrsjCysIZ4utejlwLiSVI34+igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034486; c=relaxed/simple;
	bh=BOxpeVFkqnL2Y5O3hgYqoVg6mqZBgyYjDKCVB/vo2FA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcVeWld3TKOV8m8l3kCPnLiy3n149BVU260piUgChKJtPimjUvOwqOrAHKfIKF3ZWdeg+Q2ANDprMRKFbmX23iHfheBiStMgrT99MrkZSYkSgZCP9O6cc1l8c0aAHQ4OtnLo3pK/ngVbtGspLgyaBuw5diyAXzHmePSE1c0yKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UHEcKduq; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732034484; x=1763570484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOxpeVFkqnL2Y5O3hgYqoVg6mqZBgyYjDKCVB/vo2FA=;
  b=UHEcKduqowzGkf/jvvbiImgBAAcPkCuu/nmanoKS+cKwVk+1IGEIS26Y
   wiB7jzrEpyJAM8XWTrDSszYwNHsmjR+MceOrR0ayPptuvbQE2fLPxWtlm
   gKEUVN3P7hLOdSHYlTIpImO5FsHfIesDsz1+szp6rqhmsdYJFiCWXeRpV
   oWdTnP9SrYG3aA75upZ8O7IP02wwJBxLn56rbgUZYdVip+CleGMHDEQ7V
   7kLXf5BwwLY12EL7++DsGKcv2bxu22kmXCxACKmZ70S5nZv8n39CPXj5E
   otofj1ZsqxS60vnD9xzkDGx6cCV7nvP9CSXJLUVJWTLUIpm1341UpVN/k
   Q==;
X-CSE-ConnectionGUID: RxwVwqVBQ5Gt75b5OWvVzw==
X-CSE-MsgGUID: UGV5CbIoTYaHNKXralljuA==
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="34239909"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Nov 2024 09:41:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Nov 2024 09:40:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Nov 2024 09:40:55 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Ryan Wanner
	<Ryan.Wanner@microchip.com>
Subject: [PATCH 13/15] clk: at91: clk-master: increase maximum number of clocks
Date: Tue, 19 Nov 2024 09:40:19 -0700
Message-ID: <cd6c8be4b476e04b2d18562bf72cc9387227e765.1732030972.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1732030972.git.Ryan.Wanner@microchip.com>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Increase maximum number of valid master clocks. The PMC for the SAMA7D65
requires 9 master clocks.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 15c46489ba85..7a544e429d34 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -20,7 +20,7 @@
 
 #define PMC_MCR_CSS_SHIFT	(16)
 
-#define MASTER_MAX_ID		4
+#define MASTER_MAX_ID		9
 
 #define to_clk_master(hw) container_of(hw, struct clk_master, hw)
 
-- 
2.43.0


