Return-Path: <linux-spi+bounces-12406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D258AD2449A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4429430DAB91
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EFF3803DA;
	Thu, 15 Jan 2026 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zqtLJLd5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29F38170D
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477313; cv=none; b=tLxdSM7l4unSRHuJkOGyPiFz9EwmAqROSq70kPVh3eP9PkdIA0A2DJufK9qFTXdOfjNxjLDKBjz1CWN7CYeAt72nqFrAgnNYrXi8EdCU3vSHJpKpLGnKQn9fH+0nYum9Gq54OpEgr9bzzn8Ujetfzd1MCnazQZ2l1HlYt30W/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477313; c=relaxed/simple;
	bh=Wp32ITHx7s2+X+835Jbu4gJ7F+S1PggViopmVDWASsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOIn1o5GYvl0j7ev3lBYk+B42U5Vum7H6i2PGMskJ4rrY08Yclim8wW5UUhAOswyrgabZ5Kn73dv9MBnXbfW2yXhTzIF9Uc9Mt1bMFNJf60AX55dGTl8e8J15Yw2y9ozJ0J+4G6UlxCrIWT0JVHEkDiaaV7VHkDrqY2Pqv/gtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zqtLJLd5; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1233b953bebso1973036c88.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477310; x=1769082110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=zqtLJLd52zChUvs4oYWUJHIMhxUAmPvrUA/0RxveUEHPvgdR011hU/GyGExJrIAUtw
         ovZapknkgFlI5/Zy7PYrplN8lb0nEvwlrB2bitjgOHP/9PAg1nrZA9Fj3UIvooQSj2Eb
         aOmSZy9AaiWsrmQA8A5g+8gR30/6QW10C906so7KV/BSfppbdAkUBExMMWuejC1oyg8a
         hS1eVLAVKZ6isDD7pGVC/rjV+tM4j3B2ep3BO5FIQk93c4p82HoWhGA3oGp1gXkRV+Fx
         7lVupRmwIN+TVrcbFZYu3fb4M/QxwuuB4FgD5JB2r/pXEiPUEbhi6FRsYlGJffrqypV0
         R7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477310; x=1769082110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6BNeAKcW11oL+iAABviMYbNNLfmxyGYsliVava+u3M=;
        b=ShNAPX/MB3JlH18e6S6dFwAYjGU6qkGaaAcxvK0Bf5eGmoCrQzw3F8r8fERcPhz/iY
         6LhlCvtMEY5BTQ/735KBjOwghTjwmSCO23jcWMs+JjWvv3R4Dypz6JkKasnOdlKl0KPX
         5C+v1WorcN2FgEZz44KeIdgzFdiijn/UmIaIzb2bByWPltaWMnly/r3AVarfYb3QIZrk
         bg4WLwNcq69upyMw1jW5CSB2lfpJNmiMN36zsI/JmNQieJSfzzipWY1lWFoxfoweWP1Y
         pjJU69faGeIlLPS16sHuuam+1HICaC2OIqhzRZMcLBdaEn/tIQ8wMlUleCz+6Q5UgP7G
         km+A==
X-Forwarded-Encrypted: i=1; AJvYcCXvCBdSsjNlOYBWBGSnaNzogz6j64YzJVayYa5UVKxDuu/k28MLnGEd1d00JJ0VBTPfpqoUYKijd38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQrVWX5osOU6unv9+Op3lbMonMZK80GSHT0OyJsCVcrshqCxR
	SzQaYGDsJ5ux5cZXCPxMVlf6io80rzhOuZEk/Jw2YIiRo39eeOf8Az21pjcY+o5cQLU=
X-Gm-Gg: AY/fxX4Ut8WtTZaiPY7uKq7VTUndN3v4Q1f8VqwisAnfx9ZsUoL+96EaxQ5iSi0R8YB
	igoAaRhRe+a1PgY8eb9EPanKJUA7J84771eXYFRtJzLX2yEbIUD1/BfrAYeBxzXfnOADWFLzKw2
	Nho1PQo1XFUI4woE0+1WFMguxMic2fVvcvecFa2m/JEcCCnkz/4hN7hkftnVkJIOF3vzdPHuVl1
	Dbl/XOQqoNxx3cvvOXftosmUKQDaelcqjI8iMGCCHVulIO6WHQsvCU3UteGGbGDNok+QikSNmU1
	kZAKuh9kIXJeuWy+fMCFfcAsc0F3GybtaH3RN04HuX0UvIdDxkwmTn3O43pzz7jDEXdcxzXhrNA
	lDrwHbrhUbgXbE33e8lhniKYKaoh5erft6jT71cVTKPG830EIM3XtyAyM/u0EFOfqnMRds5muWk
	FiIZFnOGpgV28eA+AaEf7W6dMH2nY+nZrUkbLQB5mzvw+hkNnVRTKSTNJ6hIPYrwP1jRKEEgdMJ
	zp9jZbG
X-Received: by 2002:a05:701b:2715:b0:123:3461:99be with SMTP id a92af1059eb24-12336a38feemr6814416c88.21.1768477309977;
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:49 -0800 (PST)
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
Subject: [PATCH v5 09/11] dt-bindings: arm: AT91: document EV23X71A board
Date: Thu, 15 Jan 2026 12:37:34 +0100
Message-ID: <20260115114021.111324-10-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Acked-by from Conor
* Pick Reviewed-by from Claudiu

 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 68d306d17c2a..bf161e0950ea 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -243,6 +243,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0


