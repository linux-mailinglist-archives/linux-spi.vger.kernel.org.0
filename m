Return-Path: <linux-spi+bounces-11921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50991CBF440
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24927301B10F
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082833B6CA;
	Mon, 15 Dec 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="VZQWF0V2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127B33345A
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816750; cv=none; b=iA//NC5hdkcJadE2nvtLGT9eE1znR7wHMfovf1I5+bj8+nZRIwh3B6I3y1D6gNntwERE4QhSSHsy78F284N6IyBINC+mgVhHgnH9deJtKaseLx+l+oNltR8/57I2fAj80R7W5gywGE1NbpwK22zLGW0y/VM2jDLv6Fo76eSXsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816750; c=relaxed/simple;
	bh=VPVs4jF75VJXH8mdDS9PaTAypaYoWoEKaAjTQEnezGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/5Oh1WC02zVfeclZUppz8V1kW9BuIwoj+41lwfPr/I97wEiYvGSlyKqFkjIAYAhRuh8+NxHuyjU3gnQMxssH5FoyPLOd0CZL0490IDtGf2Q25hbuuwZAbbQjGE+o8KUuh3hb56vf05IcZXDB+MjtLxzgY5/AhLoiH8Paoezpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=VZQWF0V2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779a637712so24958605e9.1
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816742; x=1766421542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0OEssTGK11BYSFNM6Q5GJFG0lDY4xg8K+duT0eXTMo=;
        b=VZQWF0V29r1IgpfaJxCInv8zUo3+O4jzEdgE4tPFejZmplpHFTHeqVt5D6cXNZ3Ukk
         L6AEFF6RG8SFASe5M2a4eiD/KbzxAgbQH36T3jjYKngJbqaWT/TPp/q/OpyhBY1sXQhj
         yIpYTxkVaUCjXyiqskr0VF/Bhig7ipzAFn37azEXrBmSHDP73kWveQSfb1/oJyoZhBqz
         rtPZItei02rqsC3yEHu6GAV6lTw9A7IUX0CoC7l23pFlwdi9C53Jyfagb4uKlZFcbfRm
         cI5aKxlYdr7G1ZK6jgWC4oGsmO+YoJznPt4a0HmkcFxhQfZfAJomZynzewNj9NqRqbRN
         jstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816742; x=1766421542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0OEssTGK11BYSFNM6Q5GJFG0lDY4xg8K+duT0eXTMo=;
        b=uw6cg3C1iK1k/HRODX6XWzpN+3w84WHF/I/+MMwfWNaoR1hdc+gwo9N3F9X2FRS1L6
         +h8NKtFLuYwKXZgRSs5hOKB20nwhaI16q51Dt6bTFrNygDcMWIQduejiePbMi0eFVXqj
         Ib4CBLTFaBcoHJfzLugJc2vRjUH+WD6n3KpkSBL0TWeTIVdd2H6B+pqUECl4VRlH2SzB
         lwXAKu+CoVWQAqwW0Ydl672zFP9qmIbUXjIYsAQjAQ9QClBXArdAPQsZPDtng9HZKtxL
         9keJcxq4BVaWUWdc1vz4cdhuwEHjjSEmwrVCnKg8+8+/FApmcO0BnNi0rQ04JBjOIPTi
         3QqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+HTlm83py9TlrhaGThr0j08bvSM1qQnMu55aGCkjaToKiRN64KsZdj8RzvIeCKpRvWtePaXxI1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VKbtOUiqs7r6odOl0R7vmzIkRbIEAtFwevEXkJEVeVmmiCjZ
	2kx+hbRoIiIeKgh/sMZTOJaQWMnHAb6mFXIY1tdW1UFDLP92Td3V+Oi5YGDIKOgud8E=
X-Gm-Gg: AY/fxX6qrfGPkTTIfeSzqIkdcOeLggHXod0HLyp19ekUP3OQTbC2j3G/on31smcGnds
	t0rQYCnCsp5OjOdDx0TrPfRWd7OE8LgJ11Z1cmx0YCjjdotJQsrOdFrEikoEGpNt0Q1P62Rch63
	5oVn0gFW3NByslEET1N4Zt2Ej98bH2l3lwcOwq9dIaZUaccQlgwzMSvE5Znjrdpwaqj4si+oNkT
	OkOFUIbi1ZQ6z+hRWVLtpsROUoag0qBK/tNXvYyMqNhvHAk1+F7FlSZ+OofYta0QRQL6SAkFERM
	pdJmdt93PiPe6ovkwC+1l0Lq7nHRqxjxk1W6Pp1Qiug4iOpOb4YtTkJo4slIlhKBaGJuVZD/lZm
	cERCE5AZdd/8fzfahlRg0wEybQi9tZzFt4igRXu51T6w+XS8VvFtJRH1aG2UTIGQc+FdTxlSlxe
	vJV11pdmXi8qy6cMnfzkqS6FpTLk3Pw0OVOSruwHpBwqxJ
X-Google-Smtp-Source: AGHT+IGZRk0nLa6XE7JBLcVbJ2etCXd7oowIPMfnZx4Z6qSPahCqU8A7b4zUyWiscDsHFjn+GrD1MQ==
X-Received: by 2002:a05:600c:8b16:b0:477:7c7d:d9b7 with SMTP id 5b1f17b1804b1-47a8f915711mr129583515e9.33.1765816742452;
        Mon, 15 Dec 2025 08:39:02 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:39:02 -0800 (PST)
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
Subject: [PATCH v2 15/19] dt-bindings: hwmon: sparx5: add microchip,lan9691-temp
Date: Mon, 15 Dec 2025 17:35:32 +0100
Message-ID: <20251215163820.1584926-15-robert.marko@sartura.hr>
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

Document LAN969x hwmon temperature sensor compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/hwmon/microchip,sparx5-temp.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
index 51e8619dbf3c..611fcadb1e77 100644
--- a/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
+++ b/Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
@@ -14,8 +14,12 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - microchip,sparx5-temp
+    oneOf:
+      - const: microchip,sparx5-temp
+      - items:
+          - enum:
+              - microchip,lan9691-temp
+          - const: microchip,sparx5-temp
 
   reg:
     maxItems: 1
-- 
2.52.0


