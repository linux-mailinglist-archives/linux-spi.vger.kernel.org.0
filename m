Return-Path: <linux-spi+bounces-5237-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC3A99F510
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F4C28485F
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38A1FAEFD;
	Tue, 15 Oct 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l69htUbo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792438614E;
	Tue, 15 Oct 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016393; cv=none; b=GDLZJ+rxfiVFKH8gQqZKS+EEzVcQDTTSsCr4eqrobaUFALsHP6Buoc4WfvHg0qk00E3/kRAPXXcjcQrs1mQq8iht1gXRQjjlny2y1SWUPpk1NAJ/PEXJOpuY0lEFn+erh818cHwMOzeRJFQAo+phNZGiD9KAlAVYLEV3x2skzjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016393; c=relaxed/simple;
	bh=D0wqwwc+2l7FZ4G+CsRrETsoRPZFwY8lf/JTxvdcieM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z18jfup6WhEgpUntKkrdJBYy+drb9F8pTHambumLEE6+YF4aLvHqCkj7O33Nnil+mn0+gM4PvgaURZAJkQpMuiKOnDjdBwPXOYxm3rQlIJXj9UWrwPQksFfrRWo+hqXNZgaXc1grMAaHApAmPy8620wKNvlIk2gSSv9LTJ3blac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l69htUbo; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so1660017a12.0;
        Tue, 15 Oct 2024 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016392; x=1729621192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUbBPBPP6n93y/ZkM4yEPNH409bvn+Ap0g0YwYGDBdk=;
        b=l69htUboq2K2xB/eaCK+FYct2kA3WY9TJ1kSV/Zr5ljRtxnaRLFTbvd2xK5ZOPHtTy
         Gg2txpns76Z/1/2+IywYoaL3S7WLV5Q/Pznsz52NO1L1SXV05OJO8WcsB5XmNRIU6jJ5
         XilqhAmGdSjH6j4L5FESprrcFWocG7q5jm2RAK4K9uikkn7iXw3mTOE7gNK1j80WHNQX
         Btk8PH0uxJGrzR/O81g5wiVgn7awq5g6VuzQrjXBEGjOkhfGNqocaRfoUA5D4/X6V6Cv
         MbiyU75SUMRKp4gbZXnu6bKt3emDyzLZmSDEgXTxeVN8WdfGBMMNztLeDEdSC1AtdKkC
         6loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016392; x=1729621192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUbBPBPP6n93y/ZkM4yEPNH409bvn+Ap0g0YwYGDBdk=;
        b=n8Lc947na6d9dd0T46lfoc3l3mbGb6Y3JPiZMVVgN2HNLjjUFK/coFkKDwnaYORVqI
         xXjr8KM7l0d3pIi/GteZMe88WKGAFAL4DdgO/h4ReWCoTK1+Amxe8gJ5L0Na3sOzb7BU
         55fS20b4qHMBuWshO03nWz1QVSjdKW41unddJshqWxByDIgrHwjSbQkPxiz6p7q1P3WR
         YnZAJWFaeUhmj/tPSlTCa5vbUiY7kQSX6TaxDeQmk+5bTj+YT0/1uWKKV8KmmJGtuXaG
         5baf4Xj1+2Ipgg0Bwn0glhqQVb0c8BNEx3mfRwl0T7W+nbf0pCE+CwV8Y7enD85JLVkQ
         hL6w==
X-Forwarded-Encrypted: i=1; AJvYcCVEwZSmr8gJ3AohRQlRGXLwtFk3ZCC8Wb6uwrNm33DdaZby06kBtwrdo/PiiLVdAJBrf60wxzlDSgfw@vger.kernel.org, AJvYcCWIv0cO9DVNfGt3CXIcK375tf47XyzfIxcA+MLRVeY3rTwO57JpLGhwMdrZ/6jJjHDnXLhtoU9ePhDi@vger.kernel.org, AJvYcCXlp2qPaspHc2exvR74VzeoaQtepfT1nldV/tJmt4YQ986v0hlgMd4ozG+e7h1mnB6rgwcT7WL02yZoDVm8@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrTMrBGKlEK13XjFcO+DeD/nwSP16/X0LUlVu1XHYGsUTmlTe
	TSyTaDfzFzcMBMG40eKy+e/ziEADAw4toOhKMIXUYaMA8uiaCMU2
X-Google-Smtp-Source: AGHT+IFdv1ov76co9XcCBPH2tecuWNespEChoX0P5WctzQjUBVF8lHaNyEpj/9RVXuJqyyrX6CpvGA==
X-Received: by 2002:a05:6a20:d487:b0:1d9:553:8a2f with SMTP id adf61e73a8af0-1d905538b87mr1863568637.21.1729016391579;
        Tue, 15 Oct 2024 11:19:51 -0700 (PDT)
Received: from Emma ([2401:4900:1c97:c88d:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm1584543b3a.186.2024.10.15.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:19:48 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: krzysztof.kozlowski@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	florian.fainelli@broadcom.com,
	karansanghvi98@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	rjui@broadcom.com,
	robh+dt@kernel.org,
	sbranden@broadcom.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] dt-bindings: spi: Convert bcm2835-aux-spi.txt to
Date: Tue, 15 Oct 2024 18:09:07 +0000
Message-ID: <20241015180906.8464-2-karansanghvi98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <09826ffb-b7d1-4244-af0d-854f1f0339a1@linaro.org>
References: <09826ffb-b7d1-4244-af0d-854f1f0339a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converted the brcm,bcm2835-aux-spi.txt file to
its respective yaml file format.

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
v1->v2 : Made the necessary changes in  the yaml file 
suggested by Krzysztof Kozlowski

v1:
- https://lore.kernel.org/all/Zw1Oj1utiBJ9Sosg@Emma/

 .../bindings/spi/brcm,bcm2835-aux-spi.yaml     | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
index 4c24cf2fe214..f83f71ba78dc 100644
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.yaml
@@ -9,8 +9,7 @@ title: Broadcom BCM2835 Auxiliary SPI1/2 Controller
 maintainers:
   - Karan Sanghavi <karansanghvi98@gmail.com>
 
-description: |
-  The BCM2835 contains two forms of SPI master controller. One is known simply as
+description: The BCM2835 contains two forms of SPI master controller. One is known simply as
   SPI0, and the other as the "Universal SPI Master," part of the auxiliary block.
   This binding applies to the SPI1 and SPI2 auxiliary controllers.
 
@@ -21,7 +20,6 @@ properties:
   compatible:
     enum:
       - brcm,bcm2835-aux-spi
-    description: Broadcom BCM2835 Auxiliary SPI controller for SPI1 and SPI2.
 
   reg:
     maxItems: 1
@@ -30,8 +28,7 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Reference to the auxiliary clock driver for the BCM2835.
+    maxItems: 1
 
 required:
   - compatible
@@ -53,14 +50,3 @@ examples:
         #size-cells = <0>;
     };
 
-  - |
-    #include <dt-bindings/clock/bcm2835-aux.h>
-    spi@7e2150c0 {
-        compatible = "brcm,bcm2835-aux-spi";
-        reg = <0x7e2150c0 0x40>;
-        interrupts = <1 29>;
-        clocks = <&aux_clocks BCM2835_AUX_CLOCK_SPI2>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-    };
-
-- 
2.43.0


