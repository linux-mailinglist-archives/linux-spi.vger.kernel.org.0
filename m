Return-Path: <linux-spi+bounces-11924-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6266CBF1E0
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2F163027580
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437633C1A1;
	Mon, 15 Dec 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rn33ZXnX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45419333733
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816757; cv=none; b=mUOPB4pGJg0NSYbxDD1gmRKQXUEdSgfQ8wcVcR7Hc/4wuQHm4AvNi7OMp5j/xdw84fGVOZv3qTDefFrp4FssLgTEE1rjbv+LatSr7pWtZuiCO78UDBIL1Th1Xw4sKZLmigaJlBtfpBu/TNMDqXMq3yGs1alfx/yDGCS1iKH4AEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816757; c=relaxed/simple;
	bh=gV+TkM5zsztCPBhE1oQ2+V8DbMXqPzezIUs2nyTxXhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhlzJMJKZFHJsk7x+F9n/zq/Ro+Cl+Iyzt0eJph9IQ0yKQquL/6mIpCx4tZBt79qTYnD5R28u2g1S7TpEWppUan9i2HKZDc4OZWVL04qq3JQCwUT0QpxDG6kzFJ3dVjbfMfhpFxAoiCrUsFUg1dPwO3VghZD7pXuraDVKSVIYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rn33ZXnX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so38781585e9.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816745; x=1766421545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tTqTgQ3RTUpDiEW13WMdCLExMtis8Qsfy3jipvKGlU=;
        b=rn33ZXnXrEUhiqrS7JriKukKQKWUMch19+hIe4N4Bv/WJEHSMLxXGFcTjjHxxtmm/Q
         246+I+MVHCghoIhSeZLgpd31ii9B9rbx2NkrrIVLIavwg8qn7hRok7xp0Kkx9vGNyB+m
         vUAfWPLSBxo/J1Wp0eTFbpJBrl0UpvL3gyb3WY4pOZldzUJz1lw7+1N323Vxy/3/nmAX
         rwzoS0btRzMXb+kaIj/HWNEIbWiPMmqWwNGUKI/OxB/4j7lYS/idkTrn6dL2GGjhNd2a
         SP5w6YQMVX1eRB39CoflRlo5pciO8xJd3/gzTce96rknAtQH+YfUNADQXy8Z+3gnXXRE
         pGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816745; x=1766421545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1tTqTgQ3RTUpDiEW13WMdCLExMtis8Qsfy3jipvKGlU=;
        b=MjoWSkjKky5MaU1BkZqYTGE5180P0NQaggFJ2PE5MLnghRS07KuYYNQfhhf4SLfaQN
         7Ywj8Di2GTqIrGHNxxuUWz5zv3Fj4xgWp62CvAXpjFZUiInfX1aD8bghEWs76HyFM5j3
         /EZ0Yf/1pqvI+T84cXXkitkWz48VBM3S4aN+gdBXvO0ozKT+NUa96QgfpV1Beo6GZtID
         OPbT7Lsi8edae68xbMi+q1tfnYpB3kGQ/fgglMaRr7zyDzxK4jF0hisEdb5MaDfF4ACI
         U6q0Ss+sllHeY1GxDJS7Izd9hgpxjYFRGaZfzPIh4+wVyG++AQ5KFvxWtghw9kcO4rxT
         Ah8g==
X-Forwarded-Encrypted: i=1; AJvYcCVa5Rp/lBq1K4C1LRcj6YTqnEmBPdnTMnqmz4WuWql9L3tqNC0bSqbHDjRrcOHK31JW9OfDmunC6ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBJIBkPfkujkVtoup9YDXnWAsz5eI6C/UXHT8ClyNdSaJ5fP2S
	FU8OQfMcuITykQu4gZvhW/NNjR8neXdMU/esVV8C36nlU9RHbEYh1tWQcaw0fv8kSFI=
X-Gm-Gg: AY/fxX66EynIXeaNUpD7yu5qt1g6uHFKbRk5q1x6KrVE8WonwcT/ykOJLT1CaNL1nZM
	O0KG8h4/bylm/ZP5Hr9NQ0ddJDr0SOlSQ5iSGBYjUnov+YAr8DGKKlsQFt/JTyJTfYFy3DvsOqI
	KAGf+X+0xEvo3iz0Ci1fy2fN7V+JZcwZN/QWb/JYGQnGJrjyECcWmQicjeF7XQ7dFmHIPG0IbHc
	dqF+QO69UO9KyZgPwIZ0FIgIX0AZTSIE+u/sM4quMRNKUEUZkNK70XsJnM2C5GzYq9K4r/54p6s
	lXNb7tEJio/vIjkCCV0qzambNS4WE0mU1Fjg6Ve7e09Fdiy4X77P7KzSrg5TKKkZ695Qfsc2SB8
	jY6a8pu/ZY1MgjUyjaIb9xsf1iCLObCthd0rqXgGUeb6YG/H3W6gewR3JCf7FWs9S4ZD4UdcoOU
	Gkcg8KpCliU3siUkf84pX0ThK20dGtzNPy6TEmv9MINDPn
X-Google-Smtp-Source: AGHT+IE6M+SXBjy46AfoFYCz7iRvtgEH/vJDLvmdk1N3q4CHw0hjvoykYQUZxdniQx5lw2yIA+Byqg==
X-Received: by 2002:a05:600c:4f86:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47a8f9057fdmr118554685e9.24.1765816744763;
        Mon, 15 Dec 2025 08:39:04 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:04 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	linux@roeck-us.net,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	wsa+renesas@sang-engineering.com,
	romain.sioen@microchip.com,
	Ryan.Wanner@microchip.com,
	lars.povlsen@microchip.com,
	tudor.ambarus@linaro.org,
	charan.pedumuru@microchip.com,
	kavyasree.kotagiri@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org,
	mwalle@kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 16/19] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Mon, 15 Dec 2025 17:35:33 +0100
Message-ID: <20251215163820.1584926-16-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215163820.1584926-1-robert.marko@sartura.hr>
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../pinctrl/microchip,sparx5-sgpio.yaml       | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
index fa47732d7cef..9fbbafcdc063 100644
--- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
@@ -21,10 +21,15 @@ properties:
     pattern: '^gpio@[0-9a-f]+$'
 
   compatible:
-    enum:
-      - microchip,sparx5-sgpio
-      - mscc,ocelot-sgpio
-      - mscc,luton-sgpio
+    oneOf:
+      - enum:
+          - microchip,sparx5-sgpio
+          - mscc,ocelot-sgpio
+          - mscc,luton-sgpio
+      - items:
+          - enum:
+              - microchip,lan9691-sgpio
+          - const: microchip,sparx5-sgpio
 
   '#address-cells':
     const: 1
@@ -80,7 +85,12 @@ patternProperties:
     type: object
     properties:
       compatible:
-        const: microchip,sparx5-sgpio-bank
+        oneOf:
+          - items:
+              - enum:
+                  - microchip,lan9691-sgpio-bank
+              - const: microchip,sparx5-sgpio-bank
+          - const: microchip,sparx5-sgpio-bank
 
       reg:
         description: |
-- 
2.52.0


