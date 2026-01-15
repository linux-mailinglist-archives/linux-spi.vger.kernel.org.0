Return-Path: <linux-spi+bounces-12398-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C8D243BD
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42468306ECC0
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F06378D7A;
	Thu, 15 Jan 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UVcP/v20"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41D3793C0
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477248; cv=none; b=WHPbRjc5yrhFCezpkwB2W/ejDApMKbqQ1G1roZFYXOKICeYFr/WScHrxBWSBljOj/VcJvXcMxgHNamYnRku7Kl/hlZhooxykvMlPdrhpBu7zNmopVRJ8NSuW2sJe4cODLp7cEsUC1QkREb1x92lyxrkKrUuLTzs5h/aJW6MpZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477248; c=relaxed/simple;
	bh=WWvO7fvS51VGIasNJgUp3QyEPuObUZpxHbR7pn28FTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY6f81Fmbr159wriL6HuLExZV654EP+nExJ2+RVEtc1D5/o1Vdt2F9rO0Y8VDigwDZ0uUE5CgLpFjTqncGs19Fe5ZTLiyi6vCLxP7b42kBWiaRdOKX3jmj3sesQGb17AdUYHf3SChXSDKIBsGbuFOgjG7+2j9dAPm4V5VmyCQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UVcP/v20; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-121a0bcd364so1061221c88.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477246; x=1769082046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=UVcP/v20an1Ri/KQX0pwKtk8IAvtwsby0xjBw61cKlNrVlC3TDhaqpNaluYDS/2jIM
         BWRr1w+09ZCctBa2GQGQxakTSqfDNXYv3gb9kcXbnYzK/j3ghIrArgDxhs6vWGUp8+oz
         8LISVjzM+5XaCtbqkAGVoGpwEvW6JpAY2v1pvUMP1+rMTXo3eg4HGJn1CxRU2zsaJeGx
         hvT4IEdvfB/SCQiQLmtXEG5pFMpWDJRIQvvpl4zxcqkYCpHN4rAu2SCJ/cI6615bsSsL
         suoU/9ddLvKABiycIMuTvbtzXnKVugaz1cHH7XQ61XUJVkJFz4lhWMBiVYPlKlSIoXT0
         2QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477246; x=1769082046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tEJGOG9KziC5WmpmFadtMIPKcgD9jyuKUB8JZhjDo5k=;
        b=qYJ5+3bxQalZvqRX04Y6Ew8zf91isCBx+JEhRJVItlNwZmchEl9kHGhnppaASTDxYS
         526qpZTy9Ul1AXhoSJQebRA3tfpkPqrGy/o/DDjB+fKfutsPnJu7nF1jgXzkRCyjDRzX
         GA+QTpiDlDh/Ko+W1s0cQeJLPcgL1BRpJFGgLwhMHpT63M1cRfIJ9gzjAMWIKKr6ssb4
         trCW3MXrXKbE/L344PUZceN+kXYTfdwJllWJi0OwM8n/L7UZvD0tc4Pv0JzyqpC8uxEH
         3qaXgYg4eew65uw6khSMNas3PGJgtysoUzw3IP33nP/r3vgFkHM5td3pfPYoTv++Qe4R
         zl/A==
X-Forwarded-Encrypted: i=1; AJvYcCVjYSgZnu2xLnci7IXg0xZFv3TeNMuUM7a3k5srnhdCumMc+Y7m8KVePX1sql0MyKf4ULUn3Tk5vII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVAn7sBGGuKtZDEvnqhq3NeDz+KWNf5LfvEj9UoO1TOXxRs7k
	lkpwsJlsBnNkbXwtXCLqa6MwvgrJkhVE6sGX0sXsQPmCxgoHjOwHgfGSilUhDuoMsx4=
X-Gm-Gg: AY/fxX4UaHL9O2kwkFXY4XkyghkpJHKICrkZ7Y+1BKk6wnlC0FLdzXPrKqfdMBFobJ9
	2gDNb5pPXOHLtqVRkFzEUhwb8obASPsrIIA6MD+3ujJxdNYZ25rXGN8TAw8CSqO752ybnFjaLtt
	sNdwaAaBfZjSMrf/D47R9fr452M1vwrsUHFlYpSTMPLpzslvUPhI8MCwrMY0NKxJlVQMnCr/KXM
	Sz314S8WMWDOKkcglQr/1WPrrA4VOrsLQqCT8XiQzf59p/CPvrFFP6Xqpcu/roe79PKtozypdFz
	iJqR7zJ+auoB2pt1iRG/Dj2edQeLAZ1F98cfVB5nHyFA2zOC2OYJVWaJrFwCW0OOhNOnllRuNgz
	mAnGZ+7zYSo4+Cu1ha3ALYGnCI79VPpCO2jhalKvAPLx62KPf7pBSkW4s3U76VP53O2B83dXsOW
	YnrEyuiqelIJ2q8V53e2TDYmOEre6+3pyHxICbZsvy6RGJAZtKClgPyqmiH5VH2CASg0DxEQbIh
	PEqMX97
X-Received: by 2002:a05:7022:4392:b0:122:2f4:b251 with SMTP id a92af1059eb24-123376fccd9mr8604410c88.21.1768477245907;
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:40:45 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 01/11] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
Date: Thu, 15 Jan 2026 12:37:26 +0100
Message-ID: <20260115114021.111324-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v5:
* Pick Reviewed-by from Claudiu

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


