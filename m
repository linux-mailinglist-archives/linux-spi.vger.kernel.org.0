Return-Path: <linux-spi+bounces-2843-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE388C50AF
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 13:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9616CB20D07
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A413E41A;
	Tue, 14 May 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ts2LRsbE"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9561674;
	Tue, 14 May 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683584; cv=none; b=ghxz+fHrAU0Xz4+HJHBTE8gvYbt/AyeE/3YhFXJu/HEUr/pVtvTSSp83sHqLwF+Yrt49OApW838urs5TzfcfDLIuFdk7rc538UidMgQbc7LsjoRXjYzyFwwwGN2t4iIQiL6Z86jPv+MJxxLKUwxVjpI4cenLt3jOopYZkQoX3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683584; c=relaxed/simple;
	bh=4slCxc3P8EDvVix44D3POLsDodsmYi4dyKslEAmSSbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU82h/ebEt1Z/pb0JLlvDfRPlANpPk+lW4SuvEZjoZEo4ILk903oX9JGb7Atr88s6GlmyBcyQAL2VfrES/HpxgBsge0YVkaDYfNwmZjbz5IpxWCbbMp89JilY7I999DdQD/jodQ9aTiWVacpFFtE2kJHeS1BZ7DGLIlOOyWiSQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ts2LRsbE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715683583; x=1747219583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4slCxc3P8EDvVix44D3POLsDodsmYi4dyKslEAmSSbc=;
  b=Ts2LRsbEw1ejGLdPpaLjCCehXJ48iOmpG2n7hs7vR3nU+n5NGCC0Lm6P
   FTey8VRWTDI4Q5t6YY3zmTkrdmMkr8qLRLY695df00S6addtmj1vZDSx7
   r6DQYIsvikETbRV0XUh1xRhwze4nog9nPpVLqI1kvBANDh2ByT9L3fvPf
   UdQZsX7D+nhGLjqi8gieIGU92MyW91L9tBupJ3qzIez5DU1uH/8kivbXf
   uS3UXRuIuMI0s4i6xgQ+j4joHoCEZNU2lVrNQx+3viIYkjQtxP1ZwpJlN
   RPFxRcQ/CDZ3qvc3eqF7OsCdDFy3MqPD5fCoJfJN/ovu2xJHLNhdeQW1M
   w==;
X-CSE-ConnectionGUID: pbXPAEwqSv+MVNI86TSxeg==
X-CSE-MsgGUID: eHmYSOjGTcGSvJS2RCp+kg==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="25223737"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 03:46:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:44:59 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 03:44:57 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>,
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 2/3] spi: spi-microchip-core: Fix the number of chip selects supported
Date: Tue, 14 May 2024 11:45:07 +0100
Message-ID: <20240514104508.938448-3-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
References: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The SPI "hard" controller in PolarFire SoC has eight CS lines, but only
one CS line is wired. When the 'num-cs' property is not specified in
the device tree, the driver defaults to the MAX_CS value, which has
been fixed to 1 to match the hardware configuration; however, when the
'num-cs' property is explicitly defined in the device tree, it
overrides the default value.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 634364c7cfe6..c10de45aa472 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -21,7 +21,7 @@
 #include <linux/spi/spi.h>
 
 #define MAX_LEN				(0xffff)
-#define MAX_CS				(8)
+#define MAX_CS				(1)
 #define DEFAULT_FRAMESIZE		(8)
 #define FIFO_DEPTH			(32)
 #define CLK_GEN_MODE1_MAX		(255)
-- 
2.25.1


