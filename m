Return-Path: <linux-spi+bounces-11916-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17779CBF044
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E60A304A2B1
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326E338F23;
	Mon, 15 Dec 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="f/Uk4jf/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0E3370EE
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816737; cv=none; b=LCywT9/PAN49uZgWguXU4+N7C4XIZTqYSQRtO4fgLvbHibC1eC8gh4VF7Z7Z0YqE4Df9tAUWkgXVI6+VUIKLHWdikbpzpVWYzuNIl+IDpeXP3GK7uCDnbv/Z3IkXOQQMz0gq35w2jBNBmvi4+nIB6a/M7DHt0unIBYm6yy4V4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816737; c=relaxed/simple;
	bh=scXnJzjuPLNSqcnBYVeFur/Bhfo2CWH8BsQkTIJqlg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF54hvp5lgrj1NvkIgkNPI+I9FXoQznwz2DdN5U9TSxZi9RxTrzIGBdbVAHQwRx73Gv68zb5/Brh2O/hNCRjzoDVTrYqnsCNFrcPdYrdeWyq1aNiXZGjF4afISRNVGKRWFjhibFHBeWcbmGSW9gkhcbr22U6aZxPC04A5X6MC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=f/Uk4jf/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so24009155e9.1
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816726; x=1766421526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=f/Uk4jf/MCQ7QC0/lGEeRSSR47tTDriJfcTMv27DyQbaioho2/kAASrIt4a5+bYcYp
         ZJgpkKLA0nJDcMozIad6cn7rJdLc8Tm2E1zkk7ff/1FaOdqF6orReOxSR6o9vC5O1ckZ
         lZ9v2aWwesGBbtKVw8svbs7pCmctke6m6FrgROnx6TyUHDH7tYZCV89BQ7uHWWPIfCyj
         4CPf0hQ7/AU3x6gjMkqA/nU8pR9spOwxinJhS1d59wtu9cEJrWe623vqvNQad+4XGDc+
         z0nYFmsZ5fenhMoFo4LqgmQjgdpmhimZkSqa2fAEsMpfbFFZXZ1Z/36xrTxv6Fyz1wuX
         7d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816726; x=1766421526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPjIyKwQFm6/JfqeS/3dLKxm8lxQV1Fis85PngA8h68=;
        b=Nzgq+X1yCzw+ETjvmRPkAglPLyvJeykAtEQuIDL8jnhql8W1w7KMGWJ4xWiJ9uzr8c
         awB6NF0K41ePWNafg53dispDYszAHAPaTk8vtddGGZk1v4a1low1ZHAZkTkGE3yTjwBS
         gFKKfERsYdVs7/l4Tlb1h9uSdj0lY+4fFUmHw4TADim0+jOBr6gsj3iydRG21+SHeC6j
         719mC3ALdfxD+pDV8hyvsWmdKIu0QRrp1kXiThAapgk7uoF2zgMWbQKEUJBhdBHex63e
         vMYOh2bgDE7d/WwZ479pAymejF5bvY5EuKpfDwAj/VJmvHj30WlZpCUrnIg/xK1c3fnu
         3ZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9TkCZEt+zd25rUUGe6WuCK/palzSyyGMGYaHHc7CuJ6K574L6FaXHFzefMFYsRgVPJpHPPLnJHrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI29uVq3SiEA5wwdNWvuXZsuOpmLzZy+wExm2IW5i4aLdFNmGi
	fbcFmshgXfcj/kF5FsUAwKulPPN+4X4vB5ii0pChWkb2YTu0U6BEoxMjr5Ky3UJBs7k=
X-Gm-Gg: AY/fxX7l2s0v4rG84ydj84AV0mkqfERYyOo2mcYEUXAWCmwZXWTYLd9YlyqRL7HN6YY
	z/2vNtSJI76zJUQMRjJFzVHXwHUmwW0A4gL5l68ipdmSuVb92m7g5quwTGmEpS5oUxvM9CA8T2l
	U2mYZWgE/xYVLr7D8GngBD207NGQOmusheDolvwEPqmLpKNx1Hq0X8Q+SH7mWtNVvvFmp6ngSLX
	TBdRFuUzNA+Pud4AGlvELrPYEWNvajqmsevm2G43HALtCIgq3l49oZMUJem5gFPi9HidYVo0gDf
	0nY+ex0yJilbwIcouziXxlw+fYljAWgE4xelCb9okZZRTbS/xwWsete+YK2GlluN6cI/zukRjpM
	Wx6gwOLxgfdJb7X5c0Yj9AhW/jEKceQqs8kIMx2+spE2flnOkwckKs2X1JNI7rjytRu/CMlqnmk
	HdeEQr+FposTo4LgkQq3ciJoimZZAEPImLwBzS4H7PIrqD
X-Google-Smtp-Source: AGHT+IG3as62jY6VN+R9xsd44rJLyQGjfxg1Etzm6TzvOyKAMBySitGXaUcEuYOfJtLLJDAMKGWwPg==
X-Received: by 2002:a05:600c:1c29:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-47a8f917acdmr137389255e9.35.1765816725969;
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:45 -0800 (PST)
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
Subject: [PATCH v2 08/19] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Mon, 15 Dec 2025 17:35:25 +0100
Message-ID: <20251215163820.1584926-8-robert.marko@sartura.hr>
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

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
index 11885d0cc209..a8539b68a2f3 100644
--- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
@@ -19,6 +19,7 @@ properties:
       - const: atmel,at91rm9200-spi
       - items:
           - enum:
+              - microchip,lan9691-spi
               - microchip,sam9x60-spi
               - microchip,sam9x7-spi
               - microchip,sama7d65-spi
-- 
2.52.0


