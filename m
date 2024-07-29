Return-Path: <linux-spi+bounces-4039-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C493EDFD
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B74428278D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA7484DF1;
	Mon, 29 Jul 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0jzPhzcK"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348D12C7F9;
	Mon, 29 Jul 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236829; cv=none; b=QF6mkZ3FKTZ+qHaNeo9YywE5ISvNG+jfH9OkKw/eGNu3PnxHWE/MW5pNNqxQGMLyN9QUj4lLPk9/tKeGI0+/S4B20YDZhyl3JAmh8o+nTiQBkDfZNYphfWT3qC8lvMlSG/klQHoUxIeV+XsjRQllUzzUzN1jx0+TCUUDw5XOVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236829; c=relaxed/simple;
	bh=HvRchHRsZ8Se1MnE+Du4j5tNP8ULjzxQzw9kwHT1H1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0LNPBN7/8R7WOWJCScbkDwd4aaya0IGYHrzkdztYRmDA6Qf3EZk5A4B60zfs1McHR0HuDR5y0MhqgUqBM9ctxjcgtIDBXoRto8aWb3GU738yl+Thr+jV91nuXxdo8x9yZJ2YNCfZW4vQQVMcFizXlJpcdaZEoAaOa5hvhasJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0jzPhzcK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236827; x=1753772827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HvRchHRsZ8Se1MnE+Du4j5tNP8ULjzxQzw9kwHT1H1A=;
  b=0jzPhzcKrA59w5dzK3nZKi4TzQJKrK4EovNXG2UN1uKkycpgfJD/Xbol
   Bf1EuYRI3pUKNuRnfnuW3rwzdN9aOKpLlj78mpiwIkaoGNcFBqGzZ/K+j
   HMVeQdq3n+F0W1TvPxguUHZT/uTDleyOdfdvnPaJPPP+5yh1Ra1y8IKCP
   6vy8WhFW3+VkmiLLUraOvpiSoUeh+dKK6cGJs+59R2WvCA1SVCukBdNFL
   bGGyuGBxnaZtjjTaKRvsaCVCLsZyk063YgsDiw7BMbM1fhNtosw1RPxdE
   Gp7V9nspEc6blLtNhJCje8VB8JBnKjI6BRhmLjQZHKo3dBFeCkFwd43y/
   g==;
X-CSE-ConnectionGUID: pQjOSLNzTjuj0oMDb/547w==
X-CSE-MsgGUID: x5fW3k08Si69lrRIGDsp6w==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197213805"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:06:49 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:06:43 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <richard.genoud@bootlin.com>, <radu_nicolae.pirea@upb.ro>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v6 04/27] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
Date: Mon, 29 Jul 2024 12:36:36 +0530
Message-ID: <20240729070636.1990368-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add sam9x7 compatible to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v6:

 - Updated the Acked-by tag.
---
 .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index eb2992a447d7..f466c38518c4 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -23,13 +23,20 @@ properties:
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
       - items:
-          - const: microchip,sam9x60-usart
+          - enum:
+              - microchip,sam9x60-usart
+              - microchip,sam9x7-usart
           - const: atmel,at91sam9260-usart
       - items:
           - const: microchip,sam9x60-dbgu
           - const: microchip,sam9x60-usart
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x7-dbgu
+          - const: atmel,at91sam9260-dbgu
+          - const: microchip,sam9x7-usart
+          - const: atmel,at91sam9260-usart
 
   reg:
     maxItems: 1
-- 
2.25.1


