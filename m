Return-Path: <linux-spi+bounces-12158-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12522CE7F9E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B963021763
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D133A9C0;
	Mon, 29 Dec 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="nrSYBFVg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86D339870
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033631; cv=none; b=YG8qBK1nuEgdoqA3PM5TmG0Pz960JhN0RwpSYw1LCjiz0Q62tFkEzfAsLVcxmz+tvC4CD3+SbX7TWcFnKuTTRu69ivcd+eUtOcdaWwxsPIpgOXfkNrRUOmu5Md5iuSlHkcIwH3PcnqQ4IxOCassVI+ZuSKOMOTE8xzVPneKW5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033631; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFFZ0W28lwdkk+B4j4outJbWDIHYtdbVJXr2W/ZMyyR0D1NJpexwN3g7Llzs35fj+IjBDQxUfX76M3PGXyDhKS/zuRh6GFVACV59BU8zGbM2wgwVsAZX/mHTNx1U81FaiOjE65ViODVYXZsEDieakJdHYBPvIcrrdZX5e3b0w9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=nrSYBFVg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d3ffb0f44so22430865e9.3
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033627; x=1767638427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=nrSYBFVgIwnAefLeDPgYgl8LqPiDckGltKlnnW75XVRuK+1yY9xg3gh3tZq8mkufWc
         bhWiM36cUBWMUAHYQq5VxaauBN1JBIGM1CoAC8bv+EjP4ME/nR6R7Y2d1Atbm5cJQNSE
         YakDsZ/R1kZY+j4wBQsd5PAXPwYKwrwuFRZtmYDWxrtbnG27rLcX1oBpHJzbZkBOJeRG
         /O8465TNdb93NZorMxyrz+2AaTqkqW0Uztj86TFG1zFVqHK9e3/M7xA6e6pQgFYtDjDu
         S5XivWOem/+RsxE7b3hkn3aI+uUJz/5pGcDpvkkbhxo4xpt3Fb/AMTvy+Y9k6ba8G5Sh
         L9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033627; x=1767638427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=bsjLrTHJmLoDZQGbXwsMPmTr9y+oJwRwTMYljj0KA8Lhwz1iFrqFrCf6tpd+a+dvZl
         3AOlbAFdM1H1mKKFX9Stwo/6xZmChy+shDGrCUwLAbOEbmXpjS1I5wo/tfWlDwug+/Zs
         +sFlKS7C++Z93nubmbJkSwMbdDpU0NmQrlIY43Rj7IwWFRFpxTDsHH4nKH1V5NDm+Nmw
         UYG/6wWc89SJQIqOl+Xzfs3SeHBur+04jY3QKA6SqbE2Rvk21ey5GZ9Oe4tbvRpxE0Dp
         0VhplplRtV+6rdJYJjGx+u0zYcuDhljkPqnBGxdp64p9QF/3nebBmwpJ6UEDIIqXyU4e
         almg==
X-Forwarded-Encrypted: i=1; AJvYcCW34oVXjbahmtPsed89ORPUiJAaj4uQNlohanjHWpkRD9UKJSOnOFtMkze5OYKkySTVPxGp7Pr77cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpAPhBpz4fk3GI6SbfRfG/pWb6SsUOEovy6jIIIqNgm0E2C5Ze
	NfgRKEF4/G9/sYbCQQzMteIga3yElEkR9/ary8SThk8+7fw4bwhOZqZmuHDgBPu+25Q=
X-Gm-Gg: AY/fxX46qwi+7nE7V5/JFOyk0HikknHBLhkyocaNdtjCtjJIMDtsnP4jrT3prXUYJpe
	u4hT+KYj19IFLtCCTn+3LF0hfjkPWhKhmhnjl0a7KSSuFAkAxTKHxUQV7Ud5ERKLiCbUlb/v7nz
	nClQl5gQ0O/N+USIK0Xynx0H2Q7xb2KpAzdcBUf/1bBWitEfqhOs16tzHvg3SQzLjRmghhkWiGh
	FIiMtcZ1Xt3W1b27qW4QX9E7yMyOZ+OSzGbXrkXppAicdhpu+rWfFcin9bLbQ+WrzSl1kVUB1E8
	uuPCuqvPqWTCCGUbKNdWQLW8+eToC5CDxvZuBbe710bkIdsKA+9rLFqf2/sYyeMumh5ss0bcrAh
	RffXgUYny69jcCvVakNWlKb6RBIMu8s6Hzp2XMosTPz7EiQc/Zt53NxLugQAbJjRIFlQUsEeA4V
	ybhhFM2J+jKMzYhtgIriDaMu/EHUXf+YnaLBTKAMbuTF+M8qHDOlNzACOBPKvtyEiD8P68xd7Is
	otUkIVvO6vV7ws2Y1/OQWWeIjYx
X-Google-Smtp-Source: AGHT+IHcFjQCCkIHzURsiMd4ZffbXQCjBanKlfgaAMAIAjZSkOlosZ6OaPn7ElCbfUOqooZC1IjlJA==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr255230805e9.28.1767033626661;
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:26 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Mon, 29 Dec 2025 19:37:48 +0100
Message-ID: <20251229184004.571837-8-robert.marko@sartura.hr>
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

Document Microchip LAN969x AES compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 .../devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
index 19010f90198a..f3b6af6baf15 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-aes
       - items:
           - enum:
+              - microchip,lan9691-aes
               - microchip,sam9x7-aes
               - microchip,sama7d65-aes
           - const: atmel,at91sam9g46-aes
-- 
2.52.0


