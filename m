Return-Path: <linux-spi+bounces-5928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26A9E7964
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300E71886616
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EA145B07;
	Fri,  6 Dec 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H+E/anxH"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD681C548A;
	Fri,  6 Dec 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515275; cv=none; b=pnm3qDnb1F3iPVRDd0ZqnlWgcTQzyO9/Dz+w0oXMjY3nED/Qny4FlKNoFhY68I4D/QdSXQVFNBKQ9mZ7YMXw3rIXPGjwREnshrK5JO/uoAvdhWEs5cf/t8zncvBZLAk0LnRrkOWLeTJu1flFt8teqmYSF376XriikVdk7D94s3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515275; c=relaxed/simple;
	bh=Et72pDqDPKb2qbyOOGgj6Lp29bo2uZRk5VtQf2gzGT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaD8xnsFFdqkWftNADsexf1yvi+7riKsRUrs+qq5KRt8s7Jr03eqcRvppsaw2upP4IaQ7O/FgVSsGLqGzK0rz+nZz4Rb65hxXZspjDbthjpeJJvHXyAcgBt9vjivlZTBbp6ElgJ8w3X0NtexfZT9c7ghey/mOT3glfbLqXLwPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H+E/anxH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733515273; x=1765051273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Et72pDqDPKb2qbyOOGgj6Lp29bo2uZRk5VtQf2gzGT4=;
  b=H+E/anxHbZNz99NekoJ9Rd6RabMuhqR3ICFxZ+ZHlrJQmEjPyPEvAodg
   MHVWaRoKl3Qe8C5oQ5bfKQ5irnHR76FhS0oAlBrYk2iDNUsVhs27Bmsc+
   ZlUlkrITJi2EOz02VxZ9Cim4KooWxGBm1g96lgT9WL7KpUQB0TPTaOEMf
   pggn9wun0ABZcN44gT155rCd/+CWJo6WV/dzocfgst5Smcp5/rLGsFDAw
   zyeClFgvCxx75SYBE2vSfCXpW2r+kM0Xh2LggKU/OQiH1l76yu8s56r/K
   RZrKk8GvC9wa7/CQ2yot76RfO4OydI5olBR9ogsT86+62awxRhpobjnR8
   w==;
X-CSE-ConnectionGUID: 9plLhrxgQXuYZUyQ8wJyMg==
X-CSE-MsgGUID: sUD4NM/tRtysaXxvgsHykA==
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34926402"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2024 13:01:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Dec 2024 13:01:10 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Dec 2024 13:01:09 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<arnd@arndb.de>
CC: <dharma.b@microchip.com>, <mihai.sain@microchip.com>,
	<romain.sioen@microchip.com>, <varshini.rajendran@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: [PATCH v3 04/13] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
Date: Fri, 6 Dec 2024 12:59:49 -0700
Message-ID: <05baeeda872ab06d4d84718c535453b787740876.1733505542.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733505542.git.Ryan.Wanner@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add SAMA7D65 USART compatible to DT bindings documentation.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index f466c38518c4..087a8926f8b4 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
+              - microchip,sama7d65-usart
           - const: atmel,at91sam9260-usart
       - items:
           - const: microchip,sam9x60-dbgu
-- 
2.43.0


