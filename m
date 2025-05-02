Return-Path: <linux-spi+bounces-7853-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432EAA76C6
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 18:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00CB01C05A66
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D025DD16;
	Fri,  2 May 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="trImmTPt"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CE25DCE6;
	Fri,  2 May 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202227; cv=none; b=c5hU2VObf4Nz/WziIGar5yD2+/69CUwmwoBtcBsHLGisk9L5iyzgFXbDBXVKn1IlTnbJ8SqdIhfA2an19pBUV9xH9QL+cwc3rzWtCSbyJBoZaZSFLLN/7JBBGOkc9+xHRb56uUE7ZJjoOuoHUEkqgibhE5tE+CerlxYUKNlpPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202227; c=relaxed/simple;
	bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDlFknauf9MszawiQYMXIX9aF4V85N5oDvpzmV9mu6m+UY1iNmyDXAEU/Kf6uS/tVKJE77m7tHCC++eJY1L9RH3j8oPwUK+zRFYdqN8NqhueqrOLlCJYwtC8dYG1mxvl/zgzTVz99RPGajRE2PlUgGAPUxtaadlFr0sRRK2pK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=trImmTPt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1746202226; x=1777738226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
  b=trImmTPt7bgIQUB/3DbtdppW+BJ/MVMhb8leQBbwl+/Ia2eFM00Q0wag
   VZTskIhexeY0PmGdUVW9k48t5irlV1IADg0XK0Ia8ZaCxiw+D/wqXCGOD
   FpxVcztv2XouAXug//MRF83GiogGEPbdNXaJovX5LV/oKUJlKuNia+N2+
   ZKYTSBTf4dZnpO4o1JGStuoz15vp67syiMpfWgDcc4GhN1maNyCuX55UJ
   mUsm2sbxOgRzeNrCnKlgts4VXRxATT8QchuowgG9MXD0Mmk1auWqN5/6g
   JtsNNJpc3stvoiOS2Jkz9vHWY5HY9QA/2J+jyOemi1QXsvf+j5qw1b4r9
   g==;
X-CSE-ConnectionGUID: JuVaQLK6ReSI1JeiqIMSGg==
X-CSE-MsgGUID: 6LSpReV7RC+S7xg2a8j0Gw==
X-IronPort-AV: E=Sophos;i="6.15,256,1739862000"; 
   d="scan'208";a="272519113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2025 09:10:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 2 May 2025 09:09:33 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 2 May 2025 09:09:33 -0700
From: <Ryan.Wanner@microchip.com>
To: <radu_nicolae.pirea@upb.ro>, <richard.genoud@bootlin.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<inux-arm-kernel@lists.infradead.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
Subject: [RESEND PATCH v6 1/1] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
Date: Fri, 2 May 2025 09:10:00 -0700
Message-ID: <ba19dff5c20bd022cf5391ac909a85ab5e1797b4.1746201835.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746201835.git.Ryan.Wanner@microchip.com>
References: <cover.1746201835.git.Ryan.Wanner@microchip.com>
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


