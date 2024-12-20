Return-Path: <linux-spi+bounces-6143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB69F9BA2
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1D168142
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738AD22B5AB;
	Fri, 20 Dec 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xbW5rwO2"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F222B590;
	Fri, 20 Dec 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728968; cv=none; b=oWyzFVLTHD9wKA2KtI28T5HT3zk88BDh5RdgjGY/qhPMDFI8fteCZOpJpDHNvpO9ml/U3BC9eg2gviJJTPe6/XL/q6L3dtTQlGhGt0I8uu9YgYi+i6IuyARcU5lnfEvqWqKHp8t4t1Rx//53loEXjveW1DV4WkQ3gQHFLybd5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728968; c=relaxed/simple;
	bh=WxKGQHGRlICtETZCHRtiOGzBGngq7I0z6ILbpYiy6mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVuQNR35q70BwCMHBiv+M6MZTIF6786FwJ6n8y8mkErznN7SyeHWpmdKpvYJ/zFFZHM/WRJI1kYnQnF2hC4dybG6EJu3dYxQov9O5nhMIJC+0zV4zQ5pvIDQPZ2+9cPoYG6XyLQMC4AKZxipF3zxgLIDKsTzoK6qFJMghDDd7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xbW5rwO2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734728967; x=1766264967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WxKGQHGRlICtETZCHRtiOGzBGngq7I0z6ILbpYiy6mI=;
  b=xbW5rwO2HJC/R3HFbWSZ3jeaglteWgl5Oh/R0EHMVQeyTZ/0cIxCAPor
   cIWd1Y80Mr3XiecrZmTtnWRhX3ZGAgh774qkaOdStVTHRl6OI+SFf8cYQ
   FwU8GNfu3LyTyNzPBlHUJBAv6GDk03Zl+cJypeSZd7TRy6PTAXNaLTH4+
   QGSednqkF4j9FQ3AZ7ee/sfUyU8mEEJl8UNeLYoDk/a2as9rWph7eH0Wh
   kvNOp1yIedDLPy/NxUhxi5RGEGYVDVnpL4CeCQHS94T8FUQp1gtG4eNH8
   XVaz2PMvSZSsgVroYZI/rj5AH46NdLzGwy0oHVmQ5ivSLtDmLk9RKmrhl
   A==;
X-CSE-ConnectionGUID: USBJ4PpbRGWL74rt+H8wuw==
X-CSE-MsgGUID: 75iIFNfXRv6unfXPQM8JLA==
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35811481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2024 14:09:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 20 Dec 2024 14:08:43 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 20 Dec 2024 14:08:43 -0700
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
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 06/13] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
Date: Fri, 20 Dec 2024 14:07:07 -0700
Message-ID: <d45866ab6caca970170199af9fd8588e33c2de2a.1734723585.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734723585.git.Ryan.Wanner@microchip.com>
References: <cover.1734723585.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add bindings for SAMA7D65's slow clock controller.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
index c2283cd07f05..d4cf8ae2961e 100644
--- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
+++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - microchip,sam9x7-sckc
+              - microchip,sama7d65-sckc
               - microchip,sama7g5-sckc
           - const: microchip,sam9x60-sckc
 
-- 
2.43.0


