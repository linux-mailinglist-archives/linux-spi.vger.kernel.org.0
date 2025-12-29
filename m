Return-Path: <linux-spi+bounces-12165-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F71CE7FFF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647F43016DE3
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA433E363;
	Mon, 29 Dec 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eDl6YqTI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397333D6EC
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033645; cv=none; b=HVDHEexi3JBuf8NxOkYwxsR/q120vWwJAIXmWwNBmPLCrYfIrNIK0phbcHyaI7krUglLDF+48kRHi7WGzI3XRDCMz5TAstYfKIPI549t9r7jyALVlmoCrfXHBbNowuJnmw1jxfhr+wZk7qRsIBo9VnGs39rChpKkdz1HH4iGJ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033645; c=relaxed/simple;
	bh=XoF0Eovrxm1txLTrLfP7MB7ayo4/Y25gdep/95xkk5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXAtUTRUQzikGn646gF8c/q6U56yIhap4IMcwdiQSsuHdWK6qB6TZ3FoWqAb4geidWp2cQsQckCAqc2KbGuTf0YCVfmsYHjTglWG0oIsf2O87CIwcAPjhzLM6BvU6o+YasudYvHC6679PnQ3b15ZrKlDj2fX3pSZusY7NezMNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eDl6YqTI; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477770019e4so78730045e9.3
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033640; x=1767638440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=eDl6YqTI35mE7mdIDYxmhJcA4HqpioN6T+TrIWpO7rhwFXtvwMqpaCt2rVWa5KOT3Y
         PzQmjNcD3ZrlKKrL+sLhAkAO1G+9JFeLQ6HfZ4RLRD+vGzqZ8nbHnAvPszy0K7JPB4H0
         5i9ecXb3tDLcQBOFCP5IF14KvLKRYmOOE1wWHk18pvjPph5g85omJIHxFYCFgCNgFzc5
         rRMoxkFKU+zAxax3cIGiVYf33wmRRaGswKq8m8cmtly5hnQJEOUTlktu8+2f62IgiqfW
         u/Neehn5EO2WPKUDyLjLyQBW3zkSTpdvIy0w+c2swIdgRBGSJSsWnY55ywc/rwY0oCsw
         nL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033640; x=1767638440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfMU7MT4/V4GUajmsYnn75DFErJTnupop06HbanZvHw=;
        b=VSyplPrJgMJ6pTTIM6/4ddm0e514OILCranVb/eanpv658In6F15vD8s/2kD/3sROa
         OYhWpi6JdoUBioKKTd+jgdjy2WiVr6xSv76FClSWLZPZs4Ml0QAkC4rIHLSON/AWOj0K
         qreV8Ldz6WuqO2SwLl8tRMEnrHcbX2BVnhpDJmaONVXNJQEJJpvNxtH2XkMegk69uhCc
         GMKwD4NejGFkPEvQCJlQsPkMOzOYJg+N0LIn6hZBQGyAVwuhV6PC8gs9sJoWhr9u0Fwj
         pPNGyljJ+qJJknXFJhus5NqzbDSg021IcCnIz5narlZJbXMmuMpLYiDvnYrw/lLO3ju/
         IhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYkZg7/H4AqdZoC+4DDL0JCdApFdkI3iK1iVpK04EN+xCO+kLkCEWFJ/A/hhXYyFeDfO+44cNaftI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Ye7TFLlweRdrpI7YLYzzX+oRSiNhY4QD3+vGzVIJnodFKB/4
	ihO8DnDhpXqntY9ScNSBJJqIxphncHmPRVcvODNs/yqPtiRbEfe4kjFmCIRWRAoeHKo=
X-Gm-Gg: AY/fxX5SnMv2GzBzZBgtLo55GqUHLuc7tEqBoa9NZHaGcVM3zLO8mDd7AaIt+LcWNkp
	6IyF8GBPySzaJpDwkQmlSZlBst4niGpNmOGfpnrbYjX144ahCje8J6ITm0Y7foHDSwdiIXMh4b6
	ZL6jzwOJr+wanoYk7VziAbyOfBKJHsYP5YujTruYfA6+iMDtgtGtWGI+9xhaTgh9sDaCeIyLb3Q
	dy5sLKZUP5ER2wOMbm4ta8xZXLihqv6he6Q1F8HSUqfrZmMmgyVcB186gUTWVY51BticI2gUCSk
	11za/NfRnezCGm6eXzWvVmhuOUu6VSV7j09GpYZAAQyQYzc2xljZvjZTo5cOGXZ9HpFTc7NpTa+
	nv/V1Km5Xyfw/o0C2c/szEHoEkt8PP928DCx36EVGO/Yw8yJ28lyz22Z5vHpSUbYsNwn4S88hq4
	BX/WJuD8eYG6yiUM0cZbcV2FQ0reInADhdZamSnpRmAusGz3i8/GQTB3cbW9vs+F8Zk1t75KQR/
	ZGNQT7vv5v6ULKNwU9BVTB6Uuez
X-Google-Smtp-Source: AGHT+IHW2rHrGjnHbMx7gSl8Rbl6YVS9e37XXYhb9JI7btIp7PDkapkLHawpn2EWrbvZF2/0cVQnBg==
X-Received: by 2002:a05:600c:8595:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-47d5d272cd4mr3349085e9.26.1767033640044;
        Mon, 29 Dec 2025 10:40:40 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:39 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
Date: Mon, 29 Dec 2025 19:37:55 +0100
Message-ID: <20251229184004.571837-15-robert.marko@sartura.hr>
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

Microchip EV23X71A board is an LAN9696 based evaluation board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 3a34b7a2e8d4..b0065e2f3713 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -241,6 +241,12 @@ properties:
           - const: microchip,lan9668
           - const: microchip,lan966
 
+      - description: Microchip LAN9696 EV23X71A Evaluation Board
+        items:
+          - const: microchip,ev23x71a
+          - const: microchip,lan9696
+          - const: microchip,lan9691
+
       - description: Kontron KSwitch D10 MMT series
         items:
           - enum:
-- 
2.52.0


