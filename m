Return-Path: <linux-spi+bounces-11915-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B045CBF056
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 319393059693
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6A338931;
	Mon, 15 Dec 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="TIMTbnL5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C63358C1
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816737; cv=none; b=naLwOl047/Tn3tztaxhOQFW6QiWJcm+YzlnOgwTXplvZ4PqiJUfVa3xQvEzTsn8owg+4DQy0shUmN7fscle3aQyvYSJ2zePqgYEwFk90hNIUkY/MvPz/7JQo6qMmLcnFsvqDUeEwbPZu9tJGBOFU78HMT9wWmJmZgQ9PmJuXJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816737; c=relaxed/simple;
	bh=tveRsbPZXzZXhM+Y4ZL/xeAZhYPJspnG2nmDI5Lswyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6XtNUrV6x2ooOM1vL6uU6g/M+lBIsS7h80s4kcQx3A8NdGOyAf87hQc8KwzT6Gyun8GuuBUg+7CdS+PpTjrshngm4+oumfnFu5LSVRAqy6xDsAWQiiKYt2P6eo+be0EpNQWj1PvnwR7vNv9BZDo6nQvFgefJjswzW26dpBuNsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=TIMTbnL5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso29788315e9.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816728; x=1766421528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GXKAmimvfw8ijk1jKim17aNEIYNsEIF53cEg9wyafg=;
        b=TIMTbnL5Em/KH6EZ1AcGswOTA8nTJvUHKKm2Pz771cI9CVZvlCDopkoqTAva50aEqA
         VAvTMj14W/P63wkCe6DJS/XYIr//ifvfGpzvvw75fSuf45b05uLOG5DOs6HVtszdnv9Q
         OIUMeF9yWoqOyIgcdPi0ZMEBbNuYljd1ptw8AU9xi7TEhisDZdScz0eHTCfMc7x9wXrt
         kpmH42zqbUL5cORxpDZr0pbZx8mEZox9sb54O2O+K9r4/kbOTj4S6RYajMGwfNIXAdd9
         Sgwghwqcz8imo3Z7cjI4LtBBTMVjsidan0IG4I0hZQVfX4VGYq7t9/5kFtSJMPJpi4OX
         UULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816728; x=1766421528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GXKAmimvfw8ijk1jKim17aNEIYNsEIF53cEg9wyafg=;
        b=ArxgAQRVacPPo0Iaf8AFGur9S8xKAgKwkqAw1VfS5vT2BJ3Zid46o4MjnBm8+VhPhr
         AJmzID1GK6nuL0VpuQh0CnqFnKhWSwEG+ZIgq3RimT+Y5ppwC2BDgfxxvmniCqdM3Mp1
         jECyM4vgU4HKAcLPCPy9gB3UeynDae92tDBBjYWYVxwMJ2jZcEGMCfgq6wMyEXwcn9cB
         +5elrDFocnb1k+fJCoK80x5ISNlLvEZXW+GTkybBTtgnFwK6G0vSNBz9QdSm065Z1Rck
         YzvCDaQzhayekLtqJOrHAAvrrZQ3wd/uhyvbyFHPk585xyefSiPC8+Qm6PTAtTPiXpkY
         vgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUOebyCAL9WTFSS87rKdIpJ2t16mIiNhfzLyb+l7V21kb7Xgsy/VZere92TXE6etqECCF5ac3yjEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2k0H5qsiYn5tdGHSL9QGZobR/z67FWPWN741IHZW3bYzJQgIk
	cZ4DzP0Jw13GeTPhTb/rEPzqy+pIvQuPvk3godJBDO4GbeiQ2Ds8gArEw84nwQuBYr8=
X-Gm-Gg: AY/fxX4ClmhdEr5zl6bD11BNmAslvY56W+GMXq1Fv3TGzCmAnYH3mZDTJLOem8CtnJO
	NA2Z9zgK7H8LMytaN+jW7xpur1olkPWAvv/J+izMMUscfBqMxPy67czkSpjNVLAu0uGIkoZdoKk
	F3lBxoFW4gk3zAf0f9Os/Z94Zt+p5pXhj5Z7GpqrtQ9kU/7SzGffGFydB1rlYMqViZ7rL5r+G0N
	gvpjvPyc1gC1c7jIT4ppAWinqwp5fk4cLutb3jRflxS4/DLGGpl7Rm3j89rOb6dzmKFqYlM6EiS
	o+B6U8Vhwkh0G804R2rG04iXdYJqK3BiYGCJ4e6jkiNkiRzfhc6Ju/MpO3qgqr/4N3NnGdJqck4
	57ucdSdj4Yzc+kqNwhC4JTsT7zssdzqc4rRiFurG4R5kIy5RYBFGwVPzRyrhjD115zJc/CVaa8D
	ALvwl97Ith/nQJUYm7ewgDpi3djMsRkYXSQnpq3uTmDnVu58eSUCZE468=
X-Google-Smtp-Source: AGHT+IFkqZliIsZtRCNZPvKJ2k+bwRt8m/V9TgUCZlXWy3Yhe4IyvA99Hp8H08ozBRujUcKubFPJwA==
X-Received: by 2002:a05:600c:524b:b0:477:bb0:751b with SMTP id 5b1f17b1804b1-47a8f90d716mr120031825e9.27.1765816728371;
        Mon, 15 Dec 2025 08:38:48 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:47 -0800 (PST)
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
Subject: [PATCH v2 09/19] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
Date: Mon, 15 Dec 2025 17:35:26 +0100
Message-ID: <20251215163820.1584926-9-robert.marko@sartura.hr>
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

Document Microchip LAN969x I2C compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
index e61cdb5b16ef..c83674c3183b 100644
--- a/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/atmel,at91sam-i2c.yaml
@@ -26,6 +26,7 @@ properties:
               - microchip,sam9x60-i2c
       - items:
           - enum:
+              - microchip,lan9691-i2c
               - microchip,sama7d65-i2c
               - microchip,sama7g5-i2c
               - microchip,sam9x7-i2c
-- 
2.52.0


