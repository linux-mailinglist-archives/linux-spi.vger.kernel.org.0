Return-Path: <linux-spi+bounces-11914-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E23CBF065
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C59A306D8FA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D4337111;
	Mon, 15 Dec 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mh3bUpSK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3A332ED3
	for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816729; cv=none; b=ScoW94ZxvWA93hd30UwUFWzoQnZp3QF6neift0NvwayEODfwKeqp8w4NTZqCFTD7AspTa+F8LysDKLWtJ9zXN4/P0qa2Hdcci677XimnRZunpISwzr51jbWRQllHTJQUbP8Rs7T5IY9YYgWtALhPS9i4msrguViQqYj8KhP+cTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816729; c=relaxed/simple;
	bh=Wi9AS/Q9Z9rJWlYN+9bptQ35O1l7qMfPD8Nl+Hhabzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVeVAgxqT6Dggrkgqa8WJ1iIjfxwIcTmnZrrcO8qBxOn9FvYIehfZ42kRR5xOx8YVFxex6MAwWgPoWgxJjM8KG6pBy2OYgk3GPcyLGHG+fgsDLwLR39thvfPTjCjzw/2HcRMzBH3UQRmwsxXkz1qALyzcr7/X30TT3OCD06I/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mh3bUpSK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so28325365e9.2
        for <linux-spi@vger.kernel.org>; Mon, 15 Dec 2025 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765816721; x=1766421521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dr/KALHxcw299I9hw1j3lrM8oXcQDyuqwKf9keXmbo=;
        b=mh3bUpSKu6JlE2ZCje7XOGuaHUYeu2cxxu+IFs9v1wVAGHi8paQTpFs9+NH5OVCp0N
         IaP1HdtWkevWI5zyVvTj1IT/ssgm7NUeftrGx6xtKwNhtFX3HeSnE2DO8hvKzvkvMeqK
         bZbhFfk/QeR0QJG8UnZ8noCrwYcXUu0soBEQ/4uABPC2yg0ey0hv1kKgLI3f4Li5fb48
         R22A9VIhPq666CCEvipUWez6Zxxu01uB+fdRWpn7Ka1i/uiypH1W0PqYYEw8+Rl34yz2
         JtFz/ipWF9b1RitIgLBKMqQMVUoZyjMQPSiOhcuTPsd90t1A2ohaklznD+C81YD7CK2a
         4eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816721; x=1766421521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2dr/KALHxcw299I9hw1j3lrM8oXcQDyuqwKf9keXmbo=;
        b=H6VPi3oVhPoznlWOhCrviSyQvu+RY7su+wGzKyZamT+mLysuLnUXcwhCX20w+Cp1qQ
         JXxSTFi+2IfZ88MhuefpqfOlAEbLD8WKn+fRXQXTj2/fqmyE4o2Zm62yN+pE1oSu6r6m
         xxDEWYVOwAaSSRfNGEWesKbydbUbx5FlC0HpQUCYQL+ffKgAn7w+XmQi00FYihwVl2MG
         fPXlAkv2Q+Nk/0HgibWu1zMS0eZXshvjgmRKrV9wHR6YZQCRIhAU2FfxDN/H0AiM50pa
         a+D4rKnJCR8fce9lVMUY3LqBOydD3ClAcXRq506udWmQHB7vNzQ0k9b5AYG8uW8mg33R
         QDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX08ilDYfIw1wR0mkG5U+q+s+Z/PhyrwjfbiTww3CpTAW4ClBa6b/odiTb9v6E/Zfc27HFeuHUf614=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzt8CFqdEBqcB5IArAG8WKUSkx4wIAfucXjV+BByAyaDR/Ckot
	wt0xS2YIyCnfYWXRLJzsnOO4t5QNBPSNZ79fW4aKSPFPitanp5XXpcthv/mV62zBioc=
X-Gm-Gg: AY/fxX7iHD3aY/wQlrlZsJDg+g0+rhVOrg7/WEr1XalCHl+ApLZZWm+//ertyW2xsAl
	My7vNLr6Xg7gUDxAXU63BDU6os6I4eVRhME6vf45a4KRkUNxHC5GWo3L46ApEMH26EtpqjYSjMn
	nJvoAjRTkbfK6aBhhzaFJZuTjSO0lyvdC412V7lRBFl6IkkjXgjGPS+VhwJteyunE3UTKeSg0KG
	JnHbODwxbaXpa/a2DbuhaS7RjEuQUZy3DU8kKi4kJQX/50mHlUGHzMPtFNADsWVEUABDqGx81PT
	bLLrdtwJL97uZfHFbUXfwvn9AXq9zPoZXqv14U8RNCaCb6ymSnhGpf2kdZs27vIJ4IaM5IDBF7b
	o1VqfEyob9qv1C7NASPVHj68/ZX0GXOV99PETLLw7rbhRbCYie5jZMBwC82DhatSuCmGs8vzvba
	P1cDlTK82Z23HkbXHEjJMTVhnH5mnaGDj48D44EY4FNe9Y
X-Google-Smtp-Source: AGHT+IHVHrhWHHd5t7v+NK+1xDZQB9RPKOfbhSwk160Kp7+0yxWrCigeVebl1Gn8PfXk1Ze7IDyXTw==
X-Received: by 2002:a05:600c:64c5:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47a8f915607mr114002895e9.32.1765816721213;
        Mon, 15 Dec 2025 08:38:41 -0800 (PST)
Received: from fedora (cpezg-94-253-146-254-cbl.xnet.hr. [94.253.146.254])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm192209725e9.3.2025.12.15.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:38:40 -0800 (PST)
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
Subject: [PATCH v2 06/19] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Mon, 15 Dec 2025 17:35:23 +0100
Message-ID: <20251215163820.1584926-6-robert.marko@sartura.hr>
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

Add binding documentation for Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
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


