Return-Path: <linux-spi+bounces-12403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10ED24452
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6608330C1448
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F637F0E7;
	Thu, 15 Jan 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HH1xjzbj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597C37BE8D
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477291; cv=none; b=eA2PyAOsKi4JRlybvY37BB0RMBj+34xLlA7prL2bD/Jyd6teZ3cFjJRoznJdPbo5hFBHJMgVXIv34Tg9PvS0918Xb3E3YChoaf0eXp88As5xUVWLAyOvg45Y71JyjD2ETlNgkcP21YDcGat0IuWD1y9zZlStcc/tHgzjAST75Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477291; c=relaxed/simple;
	bh=93VOl//T1710gnGzUbrxwFAJf93hjOVK3YA9kMeokWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpAE9iabe0EAyKr6FGSstr5P5OPBKq8tBeDohiwYVl7BT1s6oza+DIvEHvgmY5dqvYkQRZoq2yioUHB7mEzlLG3lpxfJ8/bCZGC4b8ZTcFRHLJXnp9j3LvPEB7TitX1pKKxHyds7K+mJzI8Km9hCQ+3HfflaBkTQKYTQzVjdEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HH1xjzbj; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233c155a42so926000c88.1
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477286; x=1769082086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=HH1xjzbjFzEvFTuYaEQ5nW7+KnA4ufCUvTIGdO29F+2BByw6owFoSV5LFqgnJqmNP+
         PzIW/fii97DhSeFAVfcwYuCOKxpaYUsHwiQxuv+UoIrs9wLZiWaLsyIRlMwIarYpuXae
         c/whJBTFucAhJaV2k4amzhKN0SdMGQR3+1hRKwV96f5MKZPVhJGTk7oQu+n3IXxG74+x
         fP/OpGTKm5VSFF8Z0q3KjOfyokSoN65OXNkmggxmxdvt6HdVfaaiV0rPoB7Z+fuuUPNo
         S/eBQHnZ3qh9P/HhTViiSs9a3tqqOd1iDTGx7bUjTM6hGqdbtwlg95BySgWqt9GcdjNN
         kbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477286; x=1769082086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HFCj5ztGvyCwGgMLXoFCMYjN9FIM/YL2Od2IwlkeWA=;
        b=GA7jjKAJa/dl0x7NgKuPanemf91YMdvw+iBjwbEhwjCXswPB/bQfh5kn2p0sbFAnJe
         wGv+ZdFEbDt1lKpgoqPPsMdU5kENJ+m9PQV6xVp4QYjrN+SYFPhBYq4AHlcnNbZBSo8D
         Xu64L+Sdw7DgQGEsjuFHr0MkkHmSHpXVKpPPLm73hFeXeDbdTdHA9GQobI8GuuBMVYe8
         r8gh6Ot9r5R/YNJRnJrI/iStx4gRAZ1Yr/TGEtMcn/EmD6HYYV7qE8GwPd6Omz6HOwaP
         Ovg5MuXWLjCe2a058gStMGPVqFkeAY0PhXyOQGY9kEAGXSaYVPj1dKFLgeL6v6YqXkf3
         hoEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+oneCEdi4UHvjmCHo8XXQ0rWk5B47qHXPBdDUdUi0x2axf5YsYqWWqRXpE2XabOG24THJk9EY85g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopHDiMLIdWprzzyhAYVTDsIb7b7NtFw4p6zYnWL0HirV33hNr
	VUVaI/7oTcbZCRBnHVJw8keUkICZT4U8qymFKU2bCwFVU5QLQQjBBUhJI4OfS8wpvV4=
X-Gm-Gg: AY/fxX5DJw2k2agLoc2pD3dZf5qNW0UObyythkQHt9s0E3whBF0mJbNSf+7ODFi6nOc
	DBBmApUvDRx3ICi28IZFR6cNUg4a8PPY7lvXE7GFzfWL7C7Ot0S+0b7NJDjz0Q5/sS0gvdKFVs2
	Ee1O9gx4ZVfWHJBhjAbcQJkWc9ov2M2PIcaLMVG10MXXFs0+OQKQPBpZZZMK/KZOF67e10qaSRC
	NzM6wPjRLHjJZArwn8UUQm/bvxLDqpsuHRiKJmPPZuGjpvjU9aIQ4nULlme1yblFeKgiz4ZFuFj
	BIJ1yD5SHZKFbx39HnDWY7AkFCYpTQOYzjA+zSx2WZR0G67fHAHJYyHBEOO0ZbzpSfAR9xtIO4R
	3hjLDHlkox2A6dLZncU4sVdNGT4K0pEWC3V65woTxN4+YM1vx7wNYv9VoGkHLSOxgkn/RRc5dAQ
	4jXWgW8vpII3cY0mItcebP5wSCcZK740XUyddrjeYJdzkPkNUlm8+uYMZbYIAy1c/+0owXj51Qq
	oDpOgUP
X-Received: by 2002:a05:7022:1719:b0:123:35c4:f39c with SMTP id a92af1059eb24-12336a67900mr5434114c88.26.1768477286121;
        Thu, 15 Jan 2026 03:41:26 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:25 -0800 (PST)
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
Subject: [PATCH v5 06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
Date: Thu, 15 Jan 2026 12:37:31 +0100
Message-ID: <20260115114021.111324-7-robert.marko@sartura.hr>
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

Document LAN969x compatibles for SGPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

Changes in v3:
* Pick Acked-by from Conor

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


