Return-Path: <linux-spi+bounces-11920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF55CBF1B9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 18:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 524983019E35
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197733AD83;
	Mon, 15 Dec 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="wO7dD4TP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD930330D32
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816747; cv=none; b=ptojdGoEpUM4JQ7Esq6l850/9D0W5N4JnZGS4yuIOr0bAytPKfP5sXMNujQzwsvT5CsdcV16r6AG/KjBycpgR04xQJEAfb4M+Xx7Xabv6YefHCGjUK+BZ302gaZdGVojAKrP7M6wSQTu2W6g2gKd/aZY7Mf4dpT3abiMa3wADgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816747; c=relaxed/simple;
	bh=E3VI+rCrnmESMLY+TqQMYn/Qmb4uG9OsOtBt2o1msik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHAACeFC1WCspGwrXOeNdJPrngPFqNPVptu1ZC8M02HKicikkoT3/FzexijYmuKj/mSQpqR+qH3iL93E35Un1K2fALnyWzfTW8MoWZX5M1d0RngX+O68FubWCQcJUpla8VG69y45nS5w7E2+H9miAex1dlk1Hp8mYJOU5iqdsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=wO7dD4TP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so5335415e9.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816735; x=1766421535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0/OVgNCzmU+9SvTTiS2Q9ByKJcSPr0aQjDQgeNdxB0=;
        b=wO7dD4TPSyGMuRk0L6Ap9dSOcZI1MZ1dmXvZP//4NxH9Ao2EtrEp1gij5AvQqRBoEf
         8/YKWDj0e6ORbpDGL0K2pmL2kANfBBtNcCXZ/FLKXdN0Aak9995tfCaYWT0liApnYAF6
         /k7QAludqmVxhJoPW8yzEenGG98K3ZS6GslinItJqraPWqJ3aAhA2DB7tElRJBStUOGT
         TGig3lOlaSKRh0ClgQL5MNGq5Q++TY3eJbJMEXqClIM2iIQPS4jenSvoWsXF8TDQ+U+C
         5ddf6xKmuhevQI54uTki1bmtabDkq+fkecpTNbUxb3Fr7saSEf26UVilsblB5krE+rZi
         rwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816735; x=1766421535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0/OVgNCzmU+9SvTTiS2Q9ByKJcSPr0aQjDQgeNdxB0=;
        b=sFC1NRSeo2cREB2v7DHbtBN3GWmfYYsrIkCCki2DSLSWBYkScYjwcF9VnoTY3C4I9D
         Kb1eT4RxeLS42eU8CNa1HwGRtRzDIuVy5o2auSKBlWudztbzsq91FeAOUPHIZU/JkHhJ
         sO1MoPjzIcxB+Qm+aiiic1WOA3fyf/lP1VA6rO2ntsgN5JozMMAllKO5nEYwxfJgf4ZS
         2Xmpo/oD8m2ETeWf6yOCCqkQj7ySfWFLWNOh2VzPDW/5vaOux655/nic7dMBZVV3sobr
         3h4lrfLMGEUPy41iMHVjOgKMfPi9Jse29isDeHY1EUMy4/0QGJRjs1ysM7qfAAXE+Vc6
         QjhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6kSrxDKOnPwick3IU4CwjGZHepVlMLYMj6UEWG3LCdj4Wx+20pvNcw7rMjsodh3Wb3YFU8SFZYyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaED9lXAO6/Esp2IWAedikWnpmpX5gbMklZVMeuCd+nmd9GVfV
	eYWbATnsLlvG0KGdqN7Q6f1vaKVv2s25IpTLwBgkwp+THSR6P+XEYXHvki4mKLB227g=
X-Gm-Gg: AY/fxX6lwO5WL0eJr6MnUnoFioqOjtXt+TuM//K3oWdRpo0MGE4yk+gKlnsPJ6Qqp/u
	HIGN156awvEj6Fe+L58eQGhbTn4+oe/kvFfm+gJDBrHWr6TrowHgJ3tuIiuLHi9h5x7GKUcjuUT
	WOi5VW2ymWyBHQ+yrLfekVfS3oruRG3/MBq/c9d8AI6aQnDIKdWu/mHenccOv/Bk3/JRpReKhS7
	554zvLmPlZAAss7P5hRhCn3aqBaDXNN/k1FCgMjwIdI2ia8vJTumUl9PRCl28g71VhvumbuLLvt
	2ZqYDqzGf/arC0C+Ep5YOcVNfRN+BUq1Z9oTEMZQnCR8pC/v6pqQglxL7DR6o0kiFjKHt0CrCEl
	NIaGUpTSUjODoiA/6U21FS1+bHdnusJ7UsjJpJpywfUJnaBlFTYYEhB0tX8fHAFDSNde+cbSMpk
	gUvVh54ORPnuAA/che/A30K1+mXA7fF2LipjV0vNLa47tv
X-Google-Smtp-Source: AGHT+IGUYIEgjlTnPr2tLcPVUCL9l3M6N90prpNBbolsxQuhh1uHZmWWgCbqjrFvhJbCg5Xq2mMw6A==
X-Received: by 2002:a05:600c:a012:b0:479:3a88:de5e with SMTP id 5b1f17b1804b1-47a8f92029emr95523575e9.37.1765816735298;
        Mon, 15 Dec 2025 08:38:55 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:54 -0800 (PST)
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
Subject: [PATCH v2 12/19] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
Date: Mon, 15 Dec 2025 17:35:29 +0100
Message-ID: <20251215163820.1584926-12-robert.marko@sartura.hr>
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

Document Microchip LAN969x SHA compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
index 39e076b275b3..16704ff0dd7f 100644
--- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-sha.yaml
@@ -16,6 +16,7 @@ properties:
       - const: atmel,at91sam9g46-sha
       - items:
           - enum:
+              - microchip,lan9691-sha
               - microchip,sam9x7-sha
               - microchip,sama7d65-sha
           - const: atmel,at91sam9g46-sha
-- 
2.52.0


