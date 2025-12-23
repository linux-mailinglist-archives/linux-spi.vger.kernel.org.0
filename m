Return-Path: <linux-spi+bounces-12108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D8FCDAA59
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 22:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B873079A96
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D495A34D930;
	Tue, 23 Dec 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="WPMJMxT2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276734D93C
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521227; cv=none; b=YYEODld6jkOeD08NdIDz+BcNVyOJzl84WfOzqbKJkCkmKEx2FaFJ9gqGtLitFG0cPmDiw65n0MyMZwhY9JpuqYKfsP5Nm0z9J4yYAlcu1m8PbQxApM6GMxRad6OoCZ12osTFHyhTZyUQFwjZ1iUcxxXBAB3f1i9B26poMASdnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521227; c=relaxed/simple;
	bh=HaP35Mv3tJhzA+ZM5JG9j+YNJFp/ZeK++35o7px2hP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMqjaE7Mn1ZNGg2blB/sKbV/XLWH/SIX/v72YR0aldfYz+9vIFysL3KHk2T3lUWpnbHvcvD012sYSGuXOySROEwBmhdE2NEeDbXHa8UBo4ibHCUE2y05FiWcdzuMVXfYYgiGwz/2bTc1XguOUqfRkcN1Y6QnBq5wOowydAdCJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=WPMJMxT2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso6122712b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521224; x=1767126024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=WPMJMxT2Z86tRUSGNKn0CYAH7lwYVAgIaWB3yVBHo64gd/T2s91doAUDCV8wqm3d1k
         DqXXsn9br1YlTxfvMupgH3TmIT1S0x0xNftveqUk5jLtfQ1ixzf9b3ZSBozDvQE2pyQj
         hhOrWomNhyMz/EC5b18RIvwIaScGg1TC0qvDuhlBcWJ6GfC1lTqE2K73G9hASX2Oxm6M
         /UgVfZTNLJNSpUC4EIkLNjKwAmUHnH4XO05eDMmPyIj+hi6/jvMdE4U0XPk1o+gmoLW5
         VBVI94hQaZ0XoDa6zJ3zoBMsb5xR+5HTpnU/B/bPo4koRUuMa3SXd6NekJ9GtM3jn5gy
         M6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521224; x=1767126024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=dvuScfnIMz1DquBh80UD1PXJsOjGq/jE/+sediUBzAp7HR33cXjC/1L8pamRZHf8qU
         pDi82bP39KPPv2I0JSt6h4XCXj6v33n7oXyvdUgaBDz5ww+mzaO+78ctJUOIBMQSzYkY
         vcY/hBH2HxmgkXpnoe2r3+Xv9bOs5dp06tDbKn2Ip794tdqkXlLaGZ7TCczEvmQMcEvJ
         EMDGRe1PFFunV0lNZYDCkA0AO8jX7Gc3QWDibZ4H8LK6nM8pwVwy3S90sGKeF/h2M7A9
         3/NkbnXNqrC9TS9hFGFIhuSkSHBCXTsVAcI7UFqb1ICIESQLQR8wqUwjdvAdSUs6Bn0c
         5rrw==
X-Forwarded-Encrypted: i=1; AJvYcCXicSub2crvcL17zhdSgsASCpABkPLGZRPMVKxt8K1sIWZICbTEocoiFCFhCu8ppL1taSu1baRKiSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUCcxArrCkP5hOr6aUwD2tqseIwkCu9e0NQsJC1uI7YcEt7PoF
	nRvyICe6wwpPZKA2f7Wb2vbQORQQCJP5B3oXPbSPHnnuDtgP1gL1xmAv1OHqaUZKq18=
X-Gm-Gg: AY/fxX7ZQMLpCo6h2X+rOIkobXq1C3lK8VM1ByQWhvj4zrn/TARCrfSJPwWvK4/7370
	daqjbSWNC3btgxOteswdpeFhB2MTXR7J+3Q9CXH7x8O4zkDHc6l55hI7j9JzUW9cAQdFeGnMLbo
	HVtF9KgTQ5+SpmL1FCKq/pL7xBfHMFaWkFSIvzk8mB7BdvYdz6HGgCyMTDRpUZx2a4/re3lLytd
	uPcaC+6JJXy95nutXFeyp7mxBITGzMCNluBhYfTt33a+RaE8k1wRTv8SKmsXCSs/fzoX73PBxBN
	SmZhpBhB1Qa88u8ruq9ULvJ0ymEC0eIa/AMGqaLvSh5wZqhmgW8DB8FMys9pDkfgGbZEVU9Qnbz
	4y0cbDcDC/bkNzYeh8yZ22F7yCpPr04Dv6A1vXmUWhwncZUELNaixLcOfAhNLB4KZzYeQRKycSi
	BmLoJyQrNjdMCklsVCSNLShjgossXr4/rC48qbASIJyRfvtWS7acSwVk44cdQHJMDshHCljD/uV
	zvT4IKW
X-Google-Smtp-Source: AGHT+IHEkRqkF3+ulFb7YQxPiXmGF+AIEzrSLTHIV/1Chrc5EC4Qv4EqGmxiVXP6kKzXYBSaNsC5Ow==
X-Received: by 2002:a05:6a20:3ca2:b0:344:a607:5548 with SMTP id adf61e73a8af0-376aa8f3946mr15876623637.58.1766521223699;
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:20:23 -0800 (PST)
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
Subject: [PATCH v3 05/15] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Tue, 23 Dec 2025 21:16:16 +0100
Message-ID: <20251223201921.1332786-6-robert.marko@sartura.hr>
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

Document Microchip LAN969x SPI compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v3:
* Pick Acked-by from Conor

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


