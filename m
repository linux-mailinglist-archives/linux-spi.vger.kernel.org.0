Return-Path: <linux-spi+bounces-12399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEAD243B1
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 286AB302A045
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84837BE60;
	Thu, 15 Jan 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="BzmUI76H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C637B40E
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477256; cv=none; b=E0jvQskp02j/oDpv6dgSgOdFm1t9PKhuDb5QAa0f4W+abf/nMRstJtVbI3PB/P2KEKx4e+RTUaJmMdHNrgwT4tlHapTQ8jQ4jtZ4etEa7sZVCxISX+2yRBkLz4vzd8iasM1hXYL4jApWNJpFRBsdjCfvkbHVxcVcOwSbLuaujY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477256; c=relaxed/simple;
	bh=b/54xVwD9NWBApT/YlbKlATwkJX1Z2JAQOFmiza0IIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhEvq88N08pwZAlfgSeXZNCbeng/6FFJl+IfQad1/D3pghPegFGXIKH1dD5kiSXje8721I917UEmEkS0NvgrC9dXJo/muH/0/o4LtIVHor01eMIt4y7WD8vGjiy6mBwfT667S1Hiz+++zLN7SgtzsJIPr7fbdu1iKG0EzbLb8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=BzmUI76H; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121a0bcd376so2134435c88.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477254; x=1769082054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3+In9zGTnNVCdfWyUqUmvhLH5cDZ41X5IQo0vghvEY=;
        b=BzmUI76HFoIf+H2p1c/j0xVbV4COe063YZKargTzFj/IGBRMeJPYbUTaHaxA3d45xG
         z8lSpJ8fz9wv6JQE09xRzLQTKoktg6GvXS/a8od588oaSVTo+xhBZ4Fqb74NiN6xvQZl
         HtsQUCSb7ngWotCTs5g2GJnkserXtPybEEXO1A2is6tuUeQVQ9jfHuQZVE8uX/IxPmM+
         KVHrgxVVvGxbUYvzt2bh43cxu90LawRwhWUJdAaZRIBmJZl91t5X4KDK98mBFre5IhJh
         k1dZtAE8z0oetFMzXE/+2TxlBijLZAi0Zr0lKGTLzrmxY51ROW2ekXGE3hQheRXpbNd2
         9xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477254; x=1769082054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3+In9zGTnNVCdfWyUqUmvhLH5cDZ41X5IQo0vghvEY=;
        b=uPfh5AdLefNdaPUsedvxXgUwMLRE9zRqg8zAyyrdiSKs1ior7Tfb1tj5c41Y+KVw4O
         n3w13Z3SLgV8QlF13PGtO9xm5oDFdn0YJJ5Cr/xEDa1mBVHUw9gGlC/KmdWmP1rcbvXI
         TARsx2H1gZ3GT0MnvrXzyTa5rn8z9DsSBmYmto56zksn2ZUJmBYxGuW6E+QBsOIRqKqR
         FntYG1GcHoxmRPAfy9vGrRmsjxw9AAgfKc5lKFyiSjKCph2AHr6aZw/6J17iiZibfFwM
         VJX6vSCg/hfxbm4HBlN+39usxJcTnWAzxWRtrZmDwiu8R/w06pV7RDjupmhG/D6pWMjY
         SbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf2Vcb3FZ0Pd3Pprjr5aYX8heEN5SppVMd6yZv/TdEeHG3C/wn5vspOKw4d7VdGrHeh0aE87NtgYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGba2xrjAPRDigGzN5tcSUzu9gJxn0K9I1MmAikYDCv/3r0E4C
	J1CsrkxtIDjwoKz6AphoFkrjpntn3szi+C8bqh+49CDsqH/bYvvv/N0r+ZxMWYAT444=
X-Gm-Gg: AY/fxX4QdhPH265Ytea98l5pPwsCzYCGR1qEtyB0MyPvIqgLSNPVH59FqriPcYIDaXf
	eoxFYAoj0acApxrI42CFS48UHRlB0E7RAgndkAZjln0nKm99TceEZ6QW221t5r/EJlQVUFLtGfx
	NT7LwNA13lrp+ioKLbsqNJHxYfXFXOp3vvhntc4mdaEmqKbBoDZnfySfsrOReSAd2bTsKJFan/y
	EGqk5nPOZDNC7JsVCPlAT/rH0JIVysuUChsSwnVzJ7WKi28J5p6/nq/6RtU7nMc2OErPrbi5trm
	cCF22yLxeXSh9bEH1YUD17spyphTg2ZC8G5JMHsPrQEotbAj0rmInJHE+JjyyZLfA+Rmgup/4JB
	sjy/nSmXeBu8uGq1YUe47HvXoT0PGcr4a52WrgyKw9VxC7HaV+0XZZkaw7ughKhZnSznqe2Tsy7
	V3cG+AaLSvkGjr9UMfotU+XOr+sFFje6VXKsZ7u66OXHujyebqkmrt6vjJFs7Krxn40nB/KO4xp
	JVr1xRa
X-Received: by 2002:a05:701b:2715:b0:123:3461:99be with SMTP id a92af1059eb24-12336a38feemr6811395c88.21.1768477254152;
        Thu, 15 Jan 2026 03:40:54 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:53 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 02/11] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
Date: Thu, 15 Jan 2026 12:37:27 +0100
Message-ID: <20260115114021.111324-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Microchip LAN969x USART compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 087a8926f8b4..375cd50bc5cc 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -24,6 +24,7 @@ properties:
           - const: atmel,at91sam9260-usart
       - items:
           - enum:
+              - microchip,lan9691-usart
               - microchip,sam9x60-usart
               - microchip,sam9x7-usart
               - microchip,sama7d65-usart
-- 
2.52.0


