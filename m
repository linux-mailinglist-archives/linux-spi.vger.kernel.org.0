Return-Path: <linux-spi+bounces-12155-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0CCE7E9B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D763C300118C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAC338936;
	Mon, 29 Dec 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="rAN65fHm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BE337B86
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033625; cv=none; b=HbLzZfV1JJq3Y/eTmGGLd6uXzLyjxdU7woIPXUkqBGl0gRfLBdfxzTHnqDoKk0A1YRifwqDPgdWqK+OrMKNPeA3n5Cemar/VBgT6u1A4IFX0mFBCiytND7LiSIf7vp6CPo6mYVu0dRtCAsGYLxyEYcvVYvERudpMoFfzC0KBwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033625; c=relaxed/simple;
	bh=HaP35Mv3tJhzA+ZM5JG9j+YNJFp/ZeK++35o7px2hP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx/M5H4XCOdQyywdcphEed+QUSgJuH0XASylZ5CJruNATW98AidFyk+APZNe7fHNtZMuTuSNnBNTuzmsLaCLJRR+uIVxwdhTayUyAg3Aae4vlqfdlUFUwD9dcNBcF0IKlZBYi7v6dr4ed/syeJ0DmrzF6w8ucg7LgOcXj0jFoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=rAN65fHm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47774d3536dso74514185e9.0
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033621; x=1767638421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=rAN65fHmKfnf747fiu0xJKX4ZKtSEl85xWTiGHh2yK9PtFAx5rmx7at2Nv7gLO78W7
         OV4InTTTyHBGYPT8exXPdlhA73vU6K8k8ehNW80AtuAZWhI1VAHB2A7XIaQS3VOebVD2
         eCKbab9bNCQbsVlYjDiH24VxJtGk0lSD/m1iujnc9X/vX1z/w9yiMNpiMYIk3+hGuAe5
         mnxWz9YKwF1WWCodx3w4jMIzYRIE6ONts/UGsLU/+TlbLQ83X6Q0V6T5aQaK1rXQ71ca
         AaChK8GuJubAbAwuq9xpkAeyY2reuKT9cDw01CTLf0Zdt3g7cZNoTPXe+4pbanqELASx
         ba3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033621; x=1767638421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PTgt2hO049DGrJM4Ny2YlS3thIKNeyR96EH9617zL0Q=;
        b=UptVkzw+sK7+vh2FulV/bozqnvAoKIXOzVyZEZuUUJDqeQrbnKWmyQOC5/AFs2RmTf
         UL0jCC5697ht9qm11hsLjRtZtGxL9YO+dWQ9ZRvWCGOkn5nuNvs26omHAD/JGTN5dlbt
         S0ZrebqdY9itH12xeAXl+gT8Rbj6kZkwdYBiFGVx2+v8OY1ou+gR476S45JKJBP81ypa
         A5dQlyWj2Jopp0pqytj5PbRQTHFJ4KQqvOHnLE8LRwmh5Hg6XnoJZsE9YAj7PCHlFASE
         bQmg3UtkLqOimEh5OlcApNnxZANvxQTnU1MszPC6HwqFbQ8HJ1CGeh0aCRqdOA2GagFN
         wK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpjCLcQTzlLc9acrgnYqnG3ylXdMZd6+pRz5soqRWB7m+DVwjmcP2FS6fNKMnjZZTwq1KPy8czqK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LcprBJsr/ytgn5oBDI3KRd4fME/+vPMph57+2aCjN6kKmfp8
	mIXtN7mp8GCkA+UZ5jeNh9hO7Y778Z6qOSZX+5v1/nhx0/WCf68PMnDYgok2ByL8Q1c=
X-Gm-Gg: AY/fxX7+X79NtQB3Sq7hSp2qH1xvT4WwLlit+RslPBXeiawXmYIGhFRBeYuwCOaFtFB
	PorcNryYkMHpxP/u7bQZ1ixl3INzorL0HHroR1JkriYLtX7IzmPJApTU9vkMJ4uKWWzyj0Si2fe
	2ASADCXkxKsTY7rEbF6picuJOfjl92b45Esys5O0hPMSf4mXcsoJUZVUf4mMuBM/l/BVGPfsReP
	gb7pnN1uYZTQSO8zP3BzId+XlZ5SiWoX4u+DLgKkbnx811ZJkIKo0ZUS5v4/4aBnehPHdpM/nTP
	YbeHkZkce1LZhPxoiL2ANxxoZbevXg0F1Htfx4uMLGaJyTO4WLsj8ijpBokYPH0wpNrr64nuzIU
	SHyfjIZjAR/4e1FeF3XyR97aJXWvCN5jMWzPBkANhPQkEGjW1hEnacej8ISH2LthDW7M+zdu7KZ
	ZwHKvgOPDr9D0UI90ByLizRHKRof88yaHGmgCdJk2xjjsSvYrdSgmj0elZ8PS7CA7MFUzNbtcgL
	qbPVNCnCrSKBm1GgYfE7m5/Fz+I
X-Google-Smtp-Source: AGHT+IHraG/JyQO9QwP0oXSI7eMgGvD7CgkRfD8/mVOlJdqCEGZOX7/g3w8MfUOgGbFTAvRzzainqw==
X-Received: by 2002:a05:600c:c493:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-47d18ba7befmr332757985e9.8.1767033620871;
        Mon, 29 Dec 2025 10:40:20 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:20 -0800 (PST)
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
Subject: [PATCH v4 04/15] dt-bindings: spi: at91: add microchip,lan9691-spi
Date: Mon, 29 Dec 2025 19:37:45 +0100
Message-ID: <20251229184004.571837-5-robert.marko@sartura.hr>
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


