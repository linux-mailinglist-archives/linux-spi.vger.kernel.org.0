Return-Path: <linux-spi+bounces-12153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA208CE7FBF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D833130456BE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F53358BE;
	Mon, 29 Dec 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="EtboB3HH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DB3358C5
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033622; cv=none; b=V1X6I5TkEm7OWTKNOg4arZ6lwu/MWuyVPdbygJm8Ce1ZFTcj5Qp6Fy8cvtKmyIz7RfU9KMHPxOhMkxNTqt9QNZJ7zMEOmNOoAxDFt358tca5QOa4pNm4bSdk1XKjkmVI7UeAGsuJeX1AIV/waX1BmaAK18XKY6uXR7ODUIaP3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033622; c=relaxed/simple;
	bh=lnkhvIt3TrOEyzf6TQ1BG1hfakQAvNrAup7QLQoickg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6pJkh3e+4ONlfU2+0idCT5jfujawvMX14I0S/t1m0Zmvu65Zql5/cjYify7FJngb7pCYKd6eAz4y1se648JPIN6oQx+Sj6XaXgV339vzJY+MCuhdK78elHLIoqIPwhqm8+vhLAtnejqC/MwjbDWZL+G4Lha8r6BucaP2IYqxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=EtboB3HH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so71187695e9.2
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033617; x=1767638417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=EtboB3HHe08w0XqyvQc3lIhAD3Wrb3A+jSxyRDBnGZHNNGsDYTpopftjz07wgCqGTg
         wVeB0SBg0sYtcFqQU94CuwWFrINZ8JOPcHYxaQ6Eqrk7RF9dttwfVjkFrtKvAte42QKe
         r+FYs+x/gVWoMwshb1deUAAslnK41Cwlqc6VYn9NzC9sJc0HbsKoDjg1tHFyEjsIuV1E
         ATaaF/DfSISmFUI6qUXqycxRqvEHQLBI94pKcPYVDNRLhHS4veRqPGH7ev44aJH8hGtb
         2pYEvIocOndgsPPLrTFgpsyOh5/kaYmScXGx3p7T8JaO6Sc3tDW4z8sPJigQKU51gN30
         qWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033617; x=1767638417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akmDQhsi4smXKOu+AQ0134jZY6Y2uyR0jebUNjrF2nI=;
        b=MOIKrlFW0wVEaZIkuthoqCdjpaLoQEMolG7JhEfaKWiBZhop30rCS+KncOw6n/xPGZ
         5fuVmz/z97pTWhrix68YttvR/84j5DsyOnFEcfIguSd3YAdFWbCGUg+unBR4tfa72RjI
         bGrx+ZklpKkD5C7uF2KXIo4uCWmhAuvBxz8VOubnqpNBxk2x18GZiOnVoD/ZdNzSTZMB
         y3NwT7WJHvKOouMj5nYNKrt84J6qM9m0cmzsseV7tG6CUnRXerX61IeTzWu7pwf98kD4
         XnUfysHfPFuYD9Om5nG1MLVGOGfqlhRLTUM4kdGqTd/DAXu+d+oMQmA+ujbxjkBXpoLj
         hMBA==
X-Forwarded-Encrypted: i=1; AJvYcCVA38t17iEHOk0tPwWEw5jAibixng5n3G6YXvFNspTIlWQbjShvPxREr/YIhfwpMZrhWSUJ6U6NEd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JqSRax06kF3DynJCwP9Y1iV4ZMios3iZQ+eQoKxhj4HE4Gjd
	mvhk+/aAifH0vXpSr0+bjcuI28h/z79hZSOVDj5+0ZmrVywcriD7L38Z5iqEgzkE0AI=
X-Gm-Gg: AY/fxX7gtG8n8l27TETkz5JR8vMur+vvzH5cYVDAH1hOQwiAUKKr19nyQciYySA4Mja
	JGSddLfnY0nnQBrvG++KHl5z5O0TDatGwLidgAB/iLFCxjnYe2/TAOS4xSPjgheeocrK6cU6dpp
	1dNrPbg3q4AWJVeAeJ6zDCCOTzqx58UYKpGtFBQwjiMQkWs8JbuvA07v9QXMbutNJDytfcmGian
	zNKVJam2v3eRyiwwmpskA0v/ArI9w16zZpVUnLVRaTH/OmD+QMW5sN0+s1R4ghrr+cSC2Zgw6PY
	SbXN6Z1+psZ9vG+KOaAmMW/8iURHKr1j1yXnclNkQRuuQ8s9zTAYx5J7oW0acs1T8pdOigA9T62
	c6EaSgS43gzZz/w0e5+ZWjxm4KW2kBjpO7wLJTiznv2VOc+fn0jcj7hPZo2MuBAHjEub7U+Qt8x
	HsUzyhTF3qn7rchQb+HYRNx/6B9OPk7w3wX1Vic+ZEFcrATPW4Efr0/oraAN+pcGYwsSkgL/erd
	+HyKXOR8tkwzx9f6yDERRS8Tg7Gwn4L5x+AqjQ=
X-Google-Smtp-Source: AGHT+IGjzQS21rGuoSBITpTDpuhXFeVyR+ePrw+9us1bVyog91e0BDAjrgenQhgGZwBix2fL5K0wjw==
X-Received: by 2002:a05:600c:1d0a:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d1959f72amr367970555e9.30.1767033617043;
        Mon, 29 Dec 2025 10:40:17 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:16 -0800 (PST)
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
Subject: [PATCH v4 02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Mon, 29 Dec 2025 19:37:43 +0100
Message-ID: <20251229184004.571837-3-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index c7d6cf96796c..5e5dec2f6564 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -20,6 +20,7 @@ properties:
       - const: atmel,sama5d2-flexcom
       - items:
           - enum:
+              - microchip,lan9691-flexcom
               - microchip,sam9x7-flexcom
               - microchip,sama7d65-flexcom
               - microchip,sama7g5-flexcom
-- 
2.52.0


