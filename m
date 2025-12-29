Return-Path: <linux-spi+bounces-12160-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED2CE7FA7
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B17A300229D
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8C33B96F;
	Mon, 29 Dec 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="u7HmGPkA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20433A9E8
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033635; cv=none; b=I84/aNETVY/5HOlQukIvLWFEk1obMG4j5yZzXI8vpzMnqmsm6TT/H9M5G7z7R6ombYlPSCZJpHJpo/BgPKgIDPBKshOB9/Ra9iS2HEt4ZKMle6z09i33SbZqiArwx3cLEGgPZ5drgA5cxqBIdPOPEaQUaZvOeTHYDD5v5qyOeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033635; c=relaxed/simple;
	bh=7jtkvldmPSo6tJBxZSibRZu5hmUTyLaiO8iQq/Sa4wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTc/sWWn2dDTl/IYHPtH35888XFGbBogJaBT3eclqQjHpxvm2Aze35bg1eUMJqbVytP4p8Yi2yXkfOTvIf/bT5mnC8qjU1wYws2BcOsBcjLU2W6CPMssK2gReE4iBx08my9XF1vJ92RogKLVFsn4gHzKKgbQK6vVubiQIkOvGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=u7HmGPkA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47774d3536dso74515645e9.0
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033630; x=1767638430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=u7HmGPkAkdP3R7rcUekjuNxY1rqjuIdNyca9I/XGM9QnG+kfzr1RniY05coFnav3Ng
         RYHUu+lqU0wDiflHit52ZG0t1bmh/XBC+sQTV348FEuYagsi0eLdDABPMr2PVkaD7inJ
         smarDUYRZ7OjWsdOyQ7pkBVYoLoQKrRfREcBHdttYvdam13AsICcjYpaIixihY848NF0
         4+AVUcKCS1vvv6tkvlnLJv5CroC9pr3VorsPqY0IGKUkVt2HWY+/PhFxoJpOM5MxrRZR
         rn0bKm0ktUYeG/Ov+a8MT9JGcL8LG7NbpQ5e7zQAkwYV+aLTTb3hvAKTdGWO/w9MZ01Q
         gN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033630; x=1767638430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZY5t/vT8/2JoNFBpsoZEjWJnrTyKVma3HFBR0NVkIKs=;
        b=fyjuHQoukdNQ/R8jIsF54dDIbXUDM/PD6+33INOxe2xvLloN7F8J94cnnXUQQ/rjWQ
         eX1UtyZUjndZsJfIcBYmW28e0+zFCfzCh0dr/vTn4Yg8lrMsiCPvRguBs4JD29fARiDU
         UF5NCa7EoOVInuKtMw3iAp2aN0bYbdaIxIfTUVVMImpOrxofauEVk3e4t105RhhZ1yA1
         E//uzN7XCWpHbZuIfe3Obh8ZXs07l2fG2TWHty378PYx06RwKS33DSR8R0SZV6UIOb+M
         m66EXdcFbYD19WsID48izCt7+JZOFaPvh27Y3X/Vm7pmI9FvJ/ZJ1mV2MiMJmLRHq6F3
         8CrA==
X-Forwarded-Encrypted: i=1; AJvYcCWhTSHVvIRa4HVaosc8zP8xsmpGLCYOnvfqo/7vpI/Rm9q35m84Yw66gXGeax+tbt/g8Klorje5qAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcr4P69ilOeM7IZQdP83pKSz4kU0S3GhBWzkjlBwbQCEtEjRCw
	sUliwut27cAT8RbGFA1X+hnXMi99EyTK61MUMwbcR8BwA9LyK1i3WwPXn2AjzSwDYqE=
X-Gm-Gg: AY/fxX4Da7deby8BC03jMZ5d3nI9lbtx6A/trLQz0rnDx94qnmT6S0Z592hNLBjw4Tp
	ZE/Ebtbzpb1DJ3/EtapJX/D/fC3VoYHcWd6AzVkFi84CEpIjpL5yT2Jh6FL/feSRxgg7fkOvnMa
	CH6PTTOw3LlV2+m+2SnEviFESft17cGiCEEraG0C5JvZNa+NzZ5G4fxCQfu1f3zCoShZ0RuCAdf
	qqJG8HAYcX10vBYbobZ+FQpDwYmwYm953j2ZmNglVZuB/0IYP5aKkpO3VghV4lBcAqBQLECifBJ
	LGL024RFuMHsa124sWrz5WxJNxioQ7RoLnsIDFu5RCzyLUW8YkxrtNsvwFsi5zaAX2LydlA3s9F
	1BzbbyRmFlTpvZdnMAjfso8zvxH8WL/5FwJys9gz+S4t2kWtsocxcOKlNsKzwjIsN58qQrWHxtO
	+gCQQofgywIK6OSyNsRswCb4roODvdt4RLl4k3AHwZcVN4Dk4lj+dr6Igp8TQWbzCbMMH+CJxKh
	mOf9HRHGLuB9CmOiijfVpYuaddr
X-Google-Smtp-Source: AGHT+IHU5TUgf1GXiZLlNhFvhk9NZs5LXOVfATsL4H0x67DGWgTd0xHPjLFDLe/wLhfc9aOjmrDYdA==
X-Received: by 2002:a05:600c:8b11:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d2d273999mr360424715e9.15.1767033630467;
        Mon, 29 Dec 2025 10:40:30 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:30 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 09/15] dt-bindings: dma: atmel: add microchip,lan9691-dma
Date: Mon, 29 Dec 2025 19:37:50 +0100
Message-ID: <20251229184004.571837-10-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x DMA compatible which is compatible to SAMA7G5.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Merged with microchip,sama7d65-dma since that also falls back to
microchip,sama7g5-dma

 Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
index 73fc13b902b3..197efb19b07a 100644
--- a/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/atmel,sama5d4-dma.yaml
@@ -33,7 +33,9 @@ properties:
               - microchip,sam9x7-dma
           - const: atmel,sama5d4-dma
       - items:
-          - const: microchip,sama7d65-dma
+          - enum:
+              - microchip,lan9691-dma
+              - microchip,sama7d65-dma
           - const: microchip,sama7g5-dma
 
   "#dma-cells":
-- 
2.52.0


