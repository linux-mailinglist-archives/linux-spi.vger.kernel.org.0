Return-Path: <linux-spi+bounces-12111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E7CDA80F
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 21:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A0230572F2
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4027D35028C;
	Tue, 23 Dec 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="f5o786rf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2C34F48A
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521255; cv=none; b=lQHtFwxm0qcyf0JjRayqq9aJ9Pgt4wNAxdt9SeOlIxMqv1D265QetUJo2/4BconZ+P5fIHKgMKlbH+yVE35j6xy9M36sgHQQuRgy+D5AsxucBUgoQUY8OOUsR3dZy9grkilA5HIWcS/nSBuBvhSfznzVrqB4WSC2gq4Ol9efEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521255; c=relaxed/simple;
	bh=zUvrtsolEdengocgVlyXQxoSJXOg4mGPqcC0PLdIbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2259wSFn4ZAz6ICI8UhR2eq9fvGgYqK0k6RqUYlvbelR/V1SjoFpJrZhv2cvJ7JEdl1LCvllbStl5n4vGi1Y/HCf4TtwvWiJab7SGj50suuI/xpLKjDg7pwdLhng1D1P7BktnTF8NIkJ2ijG8P2GNviEZ2porbX6cdLj+PYQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=f5o786rf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso6123131b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521252; x=1767126052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=f5o786rfpbEqGTAkLfK77Z37pbQHVVAGPLV2T0c8rfVmRgy+ZUKtUWtgj1SYABff0H
         L/mAOi4xMmDrrGw7OY3r3mRGBXGx9vFaY1gg5JJbdb2/MADKil2WI/A8KXYfJYEYUBAn
         OSA7IbCUsUFWKvziH6G2iG9jzg/an682GsIF4RXEoGI58HBdyRprlTOlD1U6zJQ9OPUg
         IDL1OVKrnE4OsG2Oxz6WjS810cW6VdtfL4JmzfG3UdggGN7fyN2+izwEjUrfQ04RIeng
         604AwjXBwQk/SgtjrD6UVc9lPFOglyHeE/VqvehkXpQ+Cq2UV3VsLMrk3InqRKbhTwox
         kW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521252; x=1767126052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XldW6lxnsgyAezmPBHgoeGUpbHtzZudWE9rMzsQl4gQ=;
        b=a2pLzkeoYXYsV2lApy4fchp5H1g94rzGxrCZuawML1mQIYd1jB30IkvsmiPmLWtKlP
         dTkl9Z5BUqohNX9/w/RO0NQP4tML99WeBWLXCvqzxQAmiW93bVrUoL6AQDAS5I9tVBs5
         LkZcxn81iYe9pACqNfxxqDuzv0p1pcPsY+MWar9Kx7nlsfp5a2QyJ49NoFuLjy1aTxdC
         xIOeH2cFLjjvh4qUyKo+FA7qXgQ34/Nlw9pqQ42IhyXceR2aBDIyFH9XpSQXYxn8jJla
         k+K8sRRnOnfBMJdbuc6anc9HWBYIW+gycyLRbzCnzIrs5xAIsuOgEej7mIjon3+yfRFP
         6fXg==
X-Forwarded-Encrypted: i=1; AJvYcCVh4gU5IraT7ip1sz4CmnHHUQoPTWptuVm7SWH16qMXyQwvkO3qbkoZJRsGG80Ncbsg4DHMD+Iozw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAyneI1YPVWDBfh6xZtTauSTlBsKbqf55QnCaUiVg2GUF3ZXu
	yYYCRk0R5qP+DSv6wcutStGdVI3b1iu/a9eIlSnvnKoxHCmTFFfbtrJSyw8y0XRNf1E=
X-Gm-Gg: AY/fxX5lvL51A91/ylI6LrUD55GeZ5iBVwb2ght9QJtxl28shrbVxmJYgs3b7FNhC62
	ITvnRJwLwtBcXfXPkdhIsQhEFAYawpSE3mHd2EeocOBAoHZijIhHiLpz9x2ExZBVdv9zxCYSPYB
	W7XnHTMzpcMetHRKwNgdgw2Y0IHhcSqEwCERcXMv03vOpItn1Gl/WADcfu0tDGO5aRhjE1zjGWm
	X8+uQgPxZtR+rCxWGrLaTv6+Rp7Prqg+fICRcsuNBAOW8m5EPcQO+smxlpyXfr1uBnIM1BJ8vyO
	pRu6yZnBJTsyqiXF7jpFEQHC6vRGhufdV/B330LTkASmp4yNjPWU82r+GQSmbpIJEjP/m5OiKrV
	vT5JZ16DdOLkQmSvnBpyDkU2kxnCWr7qpcgIGtQwaurTuYvqVatv4IV2VkPDsjfS5jJZF78+T3P
	51AUkMnOUz21cter1l9lkTtxA/48ZBP3BfIfInF7OZr30xyMdpMqa36ploXkTI2z3u/6bN0u5ia
	a/VogVTqqTfkmP11TM=
X-Google-Smtp-Source: AGHT+IHKR6G1JkjZPbcb6JKFu1uGkQq63m4FpssJS+cOb3Ug/zNWJVDVvih5redVT4o6Tq4IHHU3Qw==
X-Received: by 2002:a05:6a20:2588:b0:366:14af:9bbf with SMTP id adf61e73a8af0-376ab2e77c7mr15535010637.73.1766521251186;
        Tue, 23 Dec 2025 12:20:51 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:50 -0800 (PST)
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
	mturquette@baylibre.com,
	sboyd@kernel.org,
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
	linux-usb@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 08/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
Date: Tue, 23 Dec 2025 21:16:19 +0100
Message-ID: <20251223201921.1332786-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223201921.1332786-1-robert.marko@sartura.hr>
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
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


