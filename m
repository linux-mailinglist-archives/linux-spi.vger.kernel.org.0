Return-Path: <linux-spi+bounces-12104-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3527CDA785
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2520C3051328
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 20:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B834D382;
	Tue, 23 Dec 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="HUqO414M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF734CFD0
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521191; cv=none; b=sgDXa9mQzU/5CeF2uC4vn1UtLZnCF6lVZgvx9a4TXUVbjfRKE1gvigJG27RR4jC3DjyglAhMrxSkqZYhErqVz8/O4fpzW/Rd/F+krla4009V9tnnwghTonpdhLHDD4VIhgT/VmEn55w1G6sjUvENsS2Hkw2dJao6uWtrBaaWi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521191; c=relaxed/simple;
	bh=k/Yd1BmFzU0e9UFcJv9URIkTbmDEVBM0hOo+JTGIPAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYMV6+GYXngiJz6nVXdxQNIrQic0w8ZxZoxTzwV6DZQ7NsEHkexuU8F2GyfRsNOKj8N/aSgTBFwGCFCIsNFRNSmFsYWn717wtzbWfMyXuVHBY62meSfL/VF1P9ew/mvLknUbQHYNYMXBwez3hCirHHXoy2EveID37Bgof5hT4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=HUqO414M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso4381563b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766521188; x=1767125988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnKll+Mu3yr6wHuUg3E47hI29XfbMlTNI5VvcSPHEnI=;
        b=HUqO414MlgCB7zdxZlWKiA66FDKd7L0u1wR8AN9ttDrPg9lwMIj47NTBgAoPJEAAGa
         cY1T3OZEINElj1MhmU2gxplQO8bFLFVDU6XbeVOYavY58iOVkKZf1U1X6nA8d7ohZJjP
         qOZOYs8Gk6SKZjC85XLNMOWKy14Ax1T0wBXDOvD/yRP6sJE5+mHIVqXh049rbUOT7k9A
         TGrkqHVnIbg3geGjYDRD4LUaxT8ULeHfCeq28+wx1lfol7YmRNs5cTPUjVgyqHHlP9rO
         NNbWDDETwJXC3GEsUN1k+/pZLLqOQBCukXd3Z9lwPHHtk+UefNn1nqfNCX5qRs9AshBw
         g3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766521188; x=1767125988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnKll+Mu3yr6wHuUg3E47hI29XfbMlTNI5VvcSPHEnI=;
        b=Js5HR+q8Jd7LkWgyGbtB8C1Zhy5uh5yo3xwHvB/rjr+vDzX8HIw1JWAXSyWYeTa+Z5
         AanNwPaDmkS5DtzBeYyTahkfC+xq31Ob/KvYz4DvZ3OU3guvMwHsN4X2G4fgoN5kw9Mn
         XnmMxjCzsd0vPvM/YhEmlO+4IX9h8u3zLIaxhxjF+F4a5eCdZSa9k0/REaEKtkPz64sV
         Z0mjzlg3U/azRhuxEcNfOLYj+i9hX9cxtOtrQwiVoCyK8iAiz8oD7vvWpumUL+yDqMB5
         w14ImLiD3QskW4aIM78Stipak4CLaZC9tvGKZKzqkxSoUtW/YvVXrWnqVlO2CANUDzvO
         PW2A==
X-Forwarded-Encrypted: i=1; AJvYcCUNWAeRfTUCjO2J3ulvyc7P/RciQ0a7yyaj+pb1gK1xz22WGJ5N195Q9HW/BkxClDQQc74LNihVu08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mNYuCIgS/fqbnNDkVFsjX0LfRfgWxAbKLsZTdhOnxRy+Ql+B
	S1M40wUrfQt+2h0VcXiF2hLlRit/QcSqazsFiGEU6sdbCucALm4HmjSbbuap97TcpOU=
X-Gm-Gg: AY/fxX495aVWL4RV83n/nlZwS21IRYqBwQx4ul47YbOugtDz5hwG5zzCAMgGICEJ9mS
	dBS5bu3Ygzcsu6YAVfvGGR/okRtlO4+nxYoM6vLKFx19rWN8apKLWqvt8AeV4S3plaAs+ZTviZL
	2T6gyaDzJkkZ6paFbqK6z2B8lIb7TIYWu1F4nPfaNQZW7QS2r/U35FoZ0sPjuwSj+zz1YPUbdSt
	QBLVcNK6iVZVT4hkjA2DLZUITL2anPLEAZQ3J0oAqxmmbNYnMxydkgLmB7qfq8hkMJlkOLTPjqJ
	3Q33h8bNFDQcyUKquwiQtzbMIuH687/+MJd/rvkwc8CY1LX8pUiWio8ry1v++eViwA0jl4wJUen
	45nIuaCS79GEcDdCvPr3e7WiICb3v2w6fHRSSkWLvGWJIpG0MVG/r7orij2U3HjfoGDhknuVLEl
	6SC3ug7ow1z1/Rz94nRjtiSkzEmMX2lX98E3Ckm+fB/d3XAJAzIVlPgBV0iF6P+YH1wOgsvBU9e
	/zcX6v/
X-Google-Smtp-Source: AGHT+IE+Anjl+JtTMJZqrlQreb+g+wMpx+gUdAmyeFe7d/HK4xJHxIHW6brkXbwTDShJoU/zn1Vu9Q==
X-Received: by 2002:a05:6a20:939f:b0:366:1fea:9b54 with SMTP id adf61e73a8af0-376a96b9a4fmr12941961637.39.1766521187944;
        Tue, 23 Dec 2025 12:19:47 -0800 (PST)
Received: from fedora (dh207-15-53.xnet.hr. [88.207.15.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7cbfa619sm12567549a12.36.2025.12.23.12.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:19:47 -0800 (PST)
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
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
Date: Tue, 23 Dec 2025 21:16:12 +0100
Message-ID: <20251223201921.1332786-2-robert.marko@sartura.hr>
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

Add the required LAN969x clock bindings.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Rename file to microchip,lan9691.h

 include/dt-bindings/clock/microchip,lan9691.h | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/clock/microchip,lan9691.h

diff --git a/include/dt-bindings/clock/microchip,lan9691.h b/include/dt-bindings/clock/microchip,lan9691.h
new file mode 100644
index 000000000000..260370c2b238
--- /dev/null
+++ b/include/dt-bindings/clock/microchip,lan9691.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_LAN9691_H
+#define _DT_BINDINGS_CLK_LAN9691_H
+
+#define GCK_ID_QSPI0		0
+#define GCK_ID_QSPI2		1
+#define GCK_ID_SDMMC0		2
+#define GCK_ID_SDMMC1		3
+#define GCK_ID_MCAN0		4
+#define GCK_ID_MCAN1		5
+#define GCK_ID_FLEXCOM0		6
+#define GCK_ID_FLEXCOM1		7
+#define GCK_ID_FLEXCOM2		8
+#define GCK_ID_FLEXCOM3		9
+#define GCK_ID_TIMER		10
+#define GCK_ID_USB_REFCLK	11
+
+/* Gate clocks */
+#define GCK_GATE_USB_DRD	12
+#define GCK_GATE_MCRAMC		13
+#define GCK_GATE_HMATRIX	14
+
+#endif
-- 
2.52.0


