Return-Path: <linux-spi+bounces-7059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C7A55015
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226057A92D8
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792D21323D;
	Thu,  6 Mar 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u+H8IMOs"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650920F062;
	Thu,  6 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277034; cv=none; b=SOULIZNPvbkVzBLtzm4AQF5MppckfxIfa0RiwMBNfM7e8kx7ukP6T0fg4dgI8YwEpGFCL/AUW0xqITPr/W/kLX45mK+tYRYGpjTeeN+EuoXr44R6H/toLg9Z08D58dSdGhZP7N41rrue58OC3Nwm5DyUOUKKtKXnZ7Jo6OR9amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277034; c=relaxed/simple;
	bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4KVeQDUIOHJVZJfqaoavyRALSjAsbubrobGhXpw+SskPadTF60uMG6C5XfbLjinaA89KRdWXPKvd980sD9TwcxGPJ8dSCK/b/s5Nf6ZR9MoIZrqZ5KlCHSiPNMKl4dXTEsb0yin9bggEna3vVyKTX8MUFp+DgzjYbUvcMr7E7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u+H8IMOs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741277032; x=1772813032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T+l6OVVT45tzMYV8TY6DeZg93MwIQ0gaakx3sxA0rT0=;
  b=u+H8IMOsha0tdkdrRC0z57HnhZ33FYUGtszyCA6SQYUuPQgrc6B8WEBK
   +YRrdDlP3+xcisAAUrOryf6c/iiv39GSw16bH7h3+q8cfdrjyLvRMwm0h
   L7aAZv7XsHPqRDtGbxVN1L2CAD1bUalZkB7eQIL7Wx80F+w6tuWtxpyoU
   17j7GIXxbZTDsxj3cifsgQoWGwHSZsG1AUASccWIx7Pp480HZZ2+tmPI4
   Kbup5eNYaM+mEz58F5tYlY9OMXBDBELeC62DYHgscKypkzoPZDOYuMi3j
   bCZRyV3E68qb6W9Lq2mEv9hVHwem55nJnD0KPzBKufDBlCEx9Cqo7LYK7
   A==;
X-CSE-ConnectionGUID: Mtzc/U5nQtqKRw1uIzvygw==
X-CSE-MsgGUID: q+68X2whTyi3QABO9oC+Fw==
X-IronPort-AV: E=Sophos;i="6.14,226,1736838000"; 
   d="scan'208";a="269901969"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2025 09:03:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Mar 2025 09:02:57 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 6 Mar 2025 09:02:57 -0700
From: <Ryan.Wanner@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linus.walleij@linaro.org>, <ryan.wanner@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>
Subject: [RESEND PATCH v6 1/3] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
Date: Thu, 6 Mar 2025 09:03:18 -0700
Message-ID: <07aa3489013b4d4105edb50d99fbee6a70ffca1e.1736522006.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736522006.git.Ryan.Wanner@microchip.com>
References: <cover.1736522006.git.Ryan.Wanner@microchip.com>
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


