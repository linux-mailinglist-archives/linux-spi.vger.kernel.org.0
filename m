Return-Path: <linux-spi+bounces-9204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71EB14BAB
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 11:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9173AB925
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BA5288C38;
	Tue, 29 Jul 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="xbdUqbIA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211828934B
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782686; cv=none; b=Ratvn4Lu15X3EtXFffA0ar5YBNU7DBxwj4bz6goE/RiBKaKW8L5BzOUsWjDdM4/1fc4pmfxPdsMbxYZheFcnusGFrKOuEmkkYmtTog9OCe9ArD3sQh29MRV9l6fu6CCb79mvSN1hknKsu/M5x3IkSw/0ZszAlPXYs3K7yG9VFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782686; c=relaxed/simple;
	bh=ZJleRO/tmglmwyTY49Sq9b3ot5hWCGqXz2SxgsKeHM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFaPnBP0siVH6HUL0qIwEf+zSZSM/klkW4TH8bOULCxEOgOkBLyupLDmfVUp83PYrRgeuAIavluYfQb2olco0HfHA/p03Wt9AXJbluvJFjpQGgmKIH3XkSxOBtdLm8QDzXHGBCqTsW7dqv+BBDYRvfj32THJR2+81EW49XruJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=xbdUqbIA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7494999de5cso3700849b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753782683; x=1754387483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raxziZYeCxjaEOuosKAOJnUNwj1BxHTM8ZCk+kqmL9w=;
        b=xbdUqbIAaQbF13zZPVNCJmcAok0d0UpeKNKK74+70f6F/cDUhZ15iVzht62vg5XNBG
         xtE4Sw2e5DltFg/GdIITkyCBC7+vjgDoLYZNqNEZ+VBFDA4F9jLT9aKFLGoLStiO7idw
         j1ts+3hbPjKTOPuGt+et0Kx12r3tELo9to0yVnKQoVFydOlszGIyXMCWAr+nJ1Yc1zQ1
         NDVMGrXgpCL9tWV7hQO4akrorSyNqEp3Nyct9Vx7Cn7q6lvNdDcHlxKype4jM2A4VQET
         nQwNK+QwkXjSLF3qmfSalV2qGQqNSWH50NvXyZcZsBo77aCV1HuPtU9pUqfa0iGzIRot
         SpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782683; x=1754387483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raxziZYeCxjaEOuosKAOJnUNwj1BxHTM8ZCk+kqmL9w=;
        b=FsXNpgzXZnuZLHU3hw2WLqt2YuCf7okVFaz70UIfQZojHIcr5qOEQgg/Q1WhMYPfBd
         +U6WYQZUPa71i7Oq3jhG+pyqTLzv/Ev/qsowKCP3O4S/iiU22zOl/pwfNSrQ6a5vlmA+
         Eiv1fPLloJA8m94BbImwiHtYrvHXvSQdRk6IpCD0BIBEn8DIYKo5NLWm4+o9lm5eqD8t
         Ks3BV+x7AdzF4EpDpVvmbwRBk8LOkgiTva1FpQ3E52092wTHSsWVmxrMiUUl3FWVpjQ6
         tsi9ula0q0QSL0PCP0yoLKqSJIz5Q0VQ8SSJ57G9r5YKvRbE4Oz4OvYpDQqgPhfZoW/d
         5qRg==
X-Gm-Message-State: AOJu0Yxbq7et8vBA6tnxiS+8zs3wNxZfG+AUwJBgZ2GX9Ua60pZmwGJt
	55yRTk+UMjrEBucVqVd0NbZQ6KqVqUsHTj62BU3bjDiL1PeD9cTNMqfZhr8wHfQr0A==
X-Gm-Gg: ASbGncvANyMeDb4nmGNq6qUM1ZuV7ZLJOBJyy1+F5mALwwDhM6XbVOWlCGnXbUKwbd5
	j3J0FVWyXvlMgOhw9fpHjhtGfMLVsrtRV16Mm/YhbTXbsFZAlXFydfZg0Px5qOJ5L93CzLMDYla
	ME59N7A9RGa155cnh/hCpbG4p3ANy99CZS9wRS2UAj+inrRueikGKrp+1YKZRs1t3CUTmsY7o6K
	8K5OBltNRUlj13NBYWWrR1eX0l/yRzg+TjI27LW2Xst0O6Ta1jwR8/LFOlHJkypR3auT6uUmfw/
	WEpvQIHOh9QlQQHCQpM9ULWVCoBwQbeTzCW16R1mMb4c69zlioDsv7sq1UL9QPqxGUHc/xUUdxI
	k5iGUypIURGt3/7kiEuiLACevIgNtRf4=
X-Google-Smtp-Source: AGHT+IE2RNQrcZCxXmokA9dyXQMFoBXEA0vRnDeOHhDng0bNoTGMD2776/VKoUU8/Hl6rSF49pdk3g==
X-Received: by 2002:a05:6a00:1305:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-7633965f00emr22424727b3a.24.1753782682881;
        Tue, 29 Jul 2025 02:51:22 -0700 (PDT)
Received: from [192.168.1.6] ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm7614498b3a.117.2025.07.29.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:51:22 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Tue, 29 Jul 2025 15:21:02 +0530
Subject: [PATCH 3/4] spi: Handle spi bus extension
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-spi-bus-extension-v1-3-b20c73f2161a@beagleboard.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=ZJleRO/tmglmwyTY49Sq9b3ot5hWCGqXz2SxgsKeHM0=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBoiJmHEyTSX0+657ez+U7jHg14AHd1oQdKmCcKJ
 2DJCbkRHsKJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaIiZhwAKCRAFzvXHieVa
 dL2JD/9w08i6TbVyoTBn8FP0rTkWX1zJK1RaCp4Aj7s+B5GLVwvaaJ+SiTvw6dlA7kycMTwk2BZ
 Eq0tAmrseYxoEbhu8agaodyi90eNjmDL0kto+R14YpH2biXEgK79z7GlSaDbyp4jL+8y9G0DMBv
 5rwpfo0UXUilXMTzJi9tgDsYsl8cYZKdWHPCq/v3qiJkYfTNVkVWEr6CUeaiaoLrykxNyw9vhvQ
 AwPdyRbuc/M47eVgKf8Yl1qzTAhTsynZy/vkyacpFsaOcPFre8lmyjUme0DozfQcCvaNs+xQ02e
 mE/jyyS/VtQ8onzYkFjRP7YdQBxjJdLhk6EKra1bQDWtA6c3wFAakuHZzaPY5FEOBdAQukON2j4
 2Me4XZguAoyPsJqiZMFFVdDQI9kYltaWawOYAI7w75ONzc0g9fcvfvX057IKVsWpBCYEkPFp+Vw
 jX6jDWL2qgnYlXo1jlzVJb1t+qa1CYjDaniF/doeWThz7rCsOTbHnFH9ujUM0oj38b/LIdBLOfA
 y70TW3DeobvIWUcjVkM8H++d9MqEM+XVB77emED1Y/ze74iD6J7pTNwrekAKjFiZ4zI7yV09qkJ
 2J3wP11fGNm0Rqfot3wMvx+xT+R7REoU3ozXNRDM9S+uDhn8VAeektMTklQkOppxTt51+NCZ3aM
 KccXA+vx7DnidJg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

spi bus extensions were introduced to decouple spi busses when they are
wired to connectors. Combined with devicetree overlays, they introduce
an additional level of indirection, which is needed to decouple the
overlay (describing the hardware available on addon baord) and the base
tree (describing resources provided to the addon board).

For instance, the following devicetree fragment, available once
overlays are applied, is legit:

```
spi1: spi@abcd0000 {
    compatible = "xyz,spi-ctrl";
    spi-bus-extension@0 {
        reg = <0>;
        spi-bus = <&spi-ctrl>;
    };
    ...
};

connector {
    spi-ctrl {
        spi-parent = <&spi1>;
        #address-cells = <1>;
        #size-cells = <0>;

        spi-bus-extension@0 {
            reg = <0>;
            spi-bus = <&spi-other-connector>;
        };

        device@1 {
            compatible = "xyz,foo";
            reg = <1>;
        };
    };

    devices {
        other-connector {
            spi-at-other-connector {
                spi-parent = <&spi-ctrl>;
                #address-cells = <1>;
                #size-cells = <0>;

                device@2 {
                   compatible = "xyz,bar";
                   reg = <2>;
                };
            };
        };
    };
};
```

Current processing done when a spi adapter is registered registers
spi clients described at the adapter node level.

With spi bus extensions, the process needs to look also at
extensions to register devices described in those extensions and so
connected to the adapter.

Extend of_spi_register_children() to look recursively at those
spi bus extensions.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ea271e37c72d3dc099c5147ec404050ee0bbf046..015f86c6f3228a8746dc517112d466051b50e3db 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2528,9 +2528,17 @@ static void of_register_spi_children(struct spi_controller *ctlr,
 				     struct device_node *node)
 {
 	struct spi_device *spi;
-	struct device_node *nc;
+	struct device_node *nc, *extension;
 
+	/*
+	 * Register device directly described in this bus node before looking
+	 * at extensions.
+	 */
 	for_each_available_child_of_node(node, nc) {
+		/* Filter out extension node */
+		if (of_node_name_eq(nc, "spi-bus-extension"))
+			continue;
+
 		if (of_node_test_and_set_flag(nc, OF_POPULATED))
 			continue;
 
@@ -2541,6 +2549,23 @@ static void of_register_spi_children(struct spi_controller *ctlr,
 			of_node_clear_flag(nc, OF_POPULATED);
 		}
 	}
+
+	/* Look at extensions */
+	for_each_available_child_of_node(node, nc) {
+		if (!of_node_name_eq(nc, "spi-bus-extension"))
+			continue;
+
+		extension = of_parse_phandle(nc, "spi-bus", 0);
+		if (!extension)
+			continue;
+
+		/*
+		 * Register children available at this extension possibly
+		 * walking other chained extensions.
+		 */
+		of_register_spi_children(ctlr, extension);
+		of_node_put(extension);
+	}
 }
 
 /**

-- 
2.50.1


