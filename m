Return-Path: <linux-spi+bounces-9203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801DB14BA5
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C291AA45BE
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D132882D0;
	Tue, 29 Jul 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="NU4g2+NN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB9288C36
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782680; cv=none; b=M4KrxntI3SL0X8VO0gTsZFJnWB3eNiJ8qqAVh0IEOPmAtk5f1AC7rKfnrUKMglJmjV/9E4piuudJ+MLt/WED9jItGb+ypvdr7hraIuya8xw0DIH+UKpkBUE+FBuf3ntR2f9QBFXCTLGz0jgorZ+UTNbUwA/GrRZWs593wHIWraU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782680; c=relaxed/simple;
	bh=b/Mksh+F1LXb+8Jny3q81UBRPZONY8Vngy2QwjQfK8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMYkkZA4/QOmjPfxPAZnRK04I3WZUZC7NmwRQMvqE8vXo8GMgzcQqnw7z4eM8di64ad8aPynkxShuV8eIVF5MAm5y+H3LwG1+34q3TMf+4sboC5fLXMnfpqCYAdVIQFB/1DgX7GYSS0dPJ6RNw+Bzvz2RNt6mM5Pk0oWTdbGEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=NU4g2+NN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748fe69a7baso4803240b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753782678; x=1754387478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=307W0kIt+xImUi0edOEACRFJ5jTo6uhrappdUP5dsBM=;
        b=NU4g2+NNcEi/idyLygqflupNagUOUWUlXn5odeh8PsOqI1yGJhR955WbXyK1w8ujzH
         7PtR67xvEgowCSk7FOa5Hi8aqso0zTEQEfuoGQ+JJIveiAw9ZAphQO25FkFu/e8iQJTY
         ZJ/3DVQJkGl1bZaxiXf10iAMz45FU4pHnGzhsadMfqQMW2jEAe1kfSpGsYqf9ZFQWe+5
         VehupuucBSNYgx9FICT2qTFrLoIr6QVMe8vIcxDySJsezuDbSVF5oDs0szta97Ghb5o5
         LM/l45tnRDp74tcab2yFQiNvQnks29+Jf1Y1qs8UktV1rY8vZVAUACAt8T43+FNkGKJY
         D3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782678; x=1754387478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=307W0kIt+xImUi0edOEACRFJ5jTo6uhrappdUP5dsBM=;
        b=lGR6JOCX0wfxSzajDLmw4vq25AwuCFvKA2EDAm6jWhiSR+B09P/1gDE6Ejr1ynE0iJ
         TQX9PlhnbhiIc2roDKO4t8ucadx2O7grV5Cl+ZfsuCHrz8gJTFwE4RGqcXpeOie+wK+N
         AZujrqncmME0jkzhsOAK0wspmNHIPi/6keyQL27feKq3RqBA+/DTrAM0i98lGzAnnR11
         WxmZoaQRSCLSq2kRzkBA6LSqsP4yKAs+DDgnP5MPk0u+qKaRSIVYKDLp6WXQP/YHXSaS
         rvIixWhx5000XEXPvgsvobtCIEX1VDf/R0bhDuX1Bk0o7hYRLLgB6mJSQHFhcR9tOp6i
         BTww==
X-Gm-Message-State: AOJu0YzTX4PW2Gd5j2hXV/Pclnyty96tKhhuZBmHZ/TAna1JX5PSH/Ib
	EX5CZ0RDj3EEMRnoAekyg+o4XoJ3nm0HbhonfYl3eOSq6jdQLnBWsW2W6JgW3s3KTg==
X-Gm-Gg: ASbGncsieSPOfltuKpaYew01ub1/y6U5WuLYLFnD7p+TiMZNsfxj4EClfVHXX004F3M
	ymu2rnxusm/PM3SIJscoWFcUUlgms+68XqhCIbJdagwlLjKUlbfVxh0ZGB0+TUVPSrAbWyqveR4
	K7O31JoQ8c8sTkKi+DY51o6gEyghGCsmznDixFDZvZ2CGw+rf0tcTMyl1P3JxpPJVcJ79sxObM6
	5NVap1C4KyHNN0hkl0ZAgS6dqNr3/1cV/ggz5x/fWePOfL+gOiN87tDB+EKGO20C094keArQCFo
	5u550KD/p0vvdg/cPXob7F6MwazJyiZ/fIWAKcv9nyQMIQOPXX++fvv09IkkvMdwqLkkWtv7WGw
	HJipEb7IeBlHmXEAL4UFr03AYIXQHXoE=
X-Google-Smtp-Source: AGHT+IEjloV/Y1umCKUPUannzloeRYDv5MbEYRcKOlQp0hp38m8s+l0zTYHjRrwtPFRQbz3vBtZLAA==
X-Received: by 2002:a05:6a00:92a3:b0:758:72b9:e5da with SMTP id d2e1a72fcca58-763349b9fa3mr17324141b3a.17.1753782678070;
        Tue, 29 Jul 2025 02:51:18 -0700 (PDT)
Received: from [192.168.1.6] ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm7614498b3a.117.2025.07.29.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:51:17 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 29 Jul 2025 15:21:01 +0530
Subject: [PATCH 2/4] spi: Move children registration in a dedicated
 function
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-spi-bus-extension-v1-2-b20c73f2161a@beagleboard.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
In-Reply-To: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, herve.codina@bootlin.com, 
 luca.ceresoli@bootlin.com, conor+dt@kernel.org, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>, 
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=b/Mksh+F1LXb+8Jny3q81UBRPZONY8Vngy2QwjQfK8U=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBoiJmH4RnG9CxVp40e5a/y9pP77YnCAdZPDOVB8
 8Qux/IT8xuJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaIiZhwAKCRAFzvXHieVa
 dI7eD/4xJ1nG75U2r89YWYSA/Xl6H/s1Cio4Z2Cqqbc3hSDtU2dNAOQaV12dekx1pULe82n6n63
 xu7T2Y95SkzRRyry254+eAwSxfx0h+LhhjcTNROUUjq8WDWM2lgL4Fgiv4Pb9iXa9cT7+qDQmCK
 4bNlQbMTjz5HlcYXkHlQcrrPMQckII23F2wcFSpuWZhU9JiY6/h21vJ9hfyzDsUl1q4omgl6eqI
 GGm46iwbztMHhTgF87qyFm+bAybfwcmUM311FGZ0NZDZaBD2uosibh8OogBK/12avP/RLTnKWBt
 HPOqXVhVa3uGH6b035iOecnDouylhwTGbDNdkLSODFxYUQDTTzAwTNrD1lb0wc0EIz0uv44Bu1U
 5sn+aBXpjQc+WSeBlxlvO3zYixCNqRFT3GTqNasJ3Ul1wXzjxyKD2+cZiWwv6rQLGUMghb5s26p
 p1Omq41/+0pPVc+/9aYYz1dwx8VFZK393U+5nu/E1C2kVyUW7Sp0+vyIy24WyGn8ZzUm61K34S7
 54z6VBdIpzaScAhGFJ/6pBavNBPKraCkFovShBCIajUODRSlo+TYC2FGhmJQRLF6ze4LnKWbZPY
 ZUs+f9Rh7VFL22X7U1+92h86AomPNBnBwx4CmcYWdWcZSIrb7MlTId4FK+cuLtV4NUcBGXak1OI
 jytS1hL860ErR9Q==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

of_register_spi_devices() perform the loop for registering child devices.

In order to prepare the support for spi bus extensions, extract this
registration loop and move it in a dedicated function.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0030e0be0d9b2f9e2b0c4a1d806b42bdb4ecb5d2..ea271e37c72d3dc099c5147ec404050ee0bbf046 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2524,21 +2524,16 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	return ERR_PTR(rc);
 }
 
-/**
- * of_register_spi_devices() - Register child devices onto the SPI bus
- * @ctlr:	Pointer to spi_controller device
- *
- * Registers an spi_device for each child node of controller node which
- * represents a valid SPI target device.
- */
-static void of_register_spi_devices(struct spi_controller *ctlr)
+static void of_register_spi_children(struct spi_controller *ctlr,
+				     struct device_node *node)
 {
 	struct spi_device *spi;
 	struct device_node *nc;
 
-	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
+	for_each_available_child_of_node(node, nc) {
 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
 			continue;
+
 		spi = of_register_spi_device(ctlr, nc);
 		if (IS_ERR(spi)) {
 			dev_warn(&ctlr->dev,
@@ -2547,6 +2542,18 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 		}
 	}
 }
+
+/**
+ * of_register_spi_devices() - Register child devices onto the SPI bus
+ * @ctlr:	Pointer to spi_controller device
+ *
+ * Registers an spi_device for each child node of controller node which
+ * represents a valid SPI target device.
+ */
+static void of_register_spi_devices(struct spi_controller *ctlr)
+{
+	of_register_spi_children(ctlr, ctlr->dev.of_node);
+}
 #else
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif

-- 
2.50.1


