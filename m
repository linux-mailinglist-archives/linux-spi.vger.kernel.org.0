Return-Path: <linux-spi+bounces-6004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADFE9ECD72
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 14:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8922845D6
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D68232373;
	Wed, 11 Dec 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htefGGcB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC023FD00;
	Wed, 11 Dec 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924472; cv=none; b=HK0Zdt3pRR7WtcAVxaMq+PL1nDet6bHjXssQctj8Rz9wtJEV4Q9Fjxd/Hg1cAIgCEXofmyr4jkB6x17BBl8EA7WKLHhs417zVgWpbVUMiVOl6JmYOmIiKl2ctaIjIncUxSolDcOxNcD+jg+xa6s//bAeD0CsM6lKabaXYBRGn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924472; c=relaxed/simple;
	bh=8e19zAXg7Rv8dVSb132mYsMYuz4SKK1xxylwQPPeLKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLiHK0pDT3wHTVz1sX3otOeNJbYYHWl7ud6O182H/cRbwbfqZyE+c9y5EMCKji+b23DLxLbOjN72VRK9hebKSCzVh3tiaBipKZcFgw48rkrCtXrtdmKIYVjOlYdUW2YGYcBSabmQZSijSET6E/KWNv8Z8OR0y9odM197uNT/luA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htefGGcB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434fef8203fso18500175e9.1;
        Wed, 11 Dec 2024 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733924469; x=1734529269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhExhDrgWABDqpjLnj2+v3HQ5s0zHIAmpRzOT1p8kQQ=;
        b=htefGGcB57pzEn3tYukaMy/P4BCDwM0tuyDYmKtHjd2wDO7b400qb6uTaBuFQMVlun
         f4Ixx6gZj/vehPjulzg+Dk/IGBOUoGKTfXUivvAt5o0+ZV8ktGPMCdp4uv1vyQgILvcB
         IM4Y4efIWT3BrulHg0UCnCvSSjiDaFV6YKkG7UD2/275ETE0D+GKQ0WuEYdDYV0U+cPq
         L3Vxm7kwUjXXPmiS4ARPkfXgEEEhP1zrzxlcX5U3EnaKjd0R2IEHOXdUn0EDFaO0omG2
         rADOVWCDyurBPQQnNzHfcACRo/1PlEyniWj4918vR+9X/mFgDA6yDWbDIGJZ2ub3i+G1
         Fv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924469; x=1734529269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhExhDrgWABDqpjLnj2+v3HQ5s0zHIAmpRzOT1p8kQQ=;
        b=Lctz+t0Qf4Uvg7E5FtTG6MhOhrO6ctNiDRqJOIHwui+/BhbTLiQh8+KIgD4G1DGYQC
         16CbWdXH2FkZntdGalF0A40ctENvHGGn2+AJletwKCsuCjOhWPb1jSHerd3cZ84Aegvo
         GDrtcQRT+8ZamfVlRNLY0dFWOgsq79v5GK6Zc5sF/lsyevC75I/OGUDNQ4EEYrZMnFVD
         LFVIKfioc85JPi0DUkSHoLX+m+SLnVtfr4ETFcDsjhJMUwvIXkdHikrBYmSBLEqmink3
         1L3EzxBPKfoRLKG27IcnwbiZMkpxIRj4Ustf8Fi82BZPIivQt3aSBwJ7zUKnVhyZa9m3
         9MVg==
X-Forwarded-Encrypted: i=1; AJvYcCWtIw98oBIJH8PrRbEYEUNA0zUZdOj7QiU/ObwWJiL9++Lheq7ZJUbcXRRkVpuK8GQF+ecKy1ZXev6c@vger.kernel.org, AJvYcCXQ+V1jf3lvfc+1bhh90bdV2zHpINlG6djUgo+aDNEay3LgKQfCmck3I/N9ybrrMkAze3iMrvRWmc0r@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUzAb4fst0wFGwN1t1mJznYb7Fd049+t13kzzG9AeCsUQBFEx
	YSTCOjjl4jFW+fSf4m7Tb434Bm1fRTeOdjOSoOqq1lsDp+w68cWqV79FFQ==
X-Gm-Gg: ASbGncuz83oE2TWY+Kz6HGjv83L2TlC1jtQ/DVreTzJ5A7mQs1j6tGTc7KwUz8c8wJS
	nrdhGFdGCVsGf4x+wR0MACIZWRRgoCrVT1PpmxcHm3qtKuLAPAWok4r8ke8hh2zCcuyGPmP5JHU
	sm8SUBBdxI68mQHg+DUFLmT+scqjuGe4zvB+SR5JAZ2XAM8R5doOQUQ1xqmIJ34IHNSBo04ait6
	pvc1YWfn2+3DoCoGx+S+vnht0Gjd6QY3yWjOaMVlnNTSihUpTKwHE6es3X+fsM1BQ==
X-Google-Smtp-Source: AGHT+IEOOFZb/b4CVILg4KmP71SN2zMH8s09AMYV4q0kp3AAkqkMK0r7aVUS7IpD81AXnDzianhL8Q==
X-Received: by 2002:a05:600c:4f11:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-4361c3aa6demr21039065e9.11.1733924468977;
        Wed, 11 Dec 2024 05:41:08 -0800 (PST)
Received: from fedora.redhat.com ([67.218.245.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f43aedb2sm124958295e9.41.2024.12.11.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:41:08 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	javierm@redhat.com
Subject: [PATCH] dt-bindings: devicetree: explain how to get CS active-high
Date: Wed, 11 Dec 2024 14:40:17 +0100
Message-ID: <20241211134023.222473-1-ikerpedrosam@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current documentation does not clearly explain how to invert the SPI
CS signal to make it active-high. This makes it very difficult to
understand.

This patch adds a simple explanation on how to set the CS line in
active-high and adds an example to make it easier for users who need
that setup for their SPI peripherals.

Link: https://forums.raspberrypi.com/viewtopic.php?t=378222
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 .../bindings/spi/spi-controller.yaml          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 093150c0cb87..02dc3e1abcad 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -69,6 +69,11 @@ properties:
          Should be generally avoided and be replaced by
          spi-cs-high + ACTIVE_HIGH.
 
+      The simplest way to obtain an active-high CS signal is to configure the
+      controller's cs-gpio property with the ACTIVE_HIGH flag and set the
+      peripheral's spi-cs-high property. See example below for a better
+      understanding.
+
   fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -189,3 +194,22 @@ examples:
             stacked-memories = /bits/ 64 <0x10000000 0x10000000>;
         };
     };
+
+  - |
+    spi@20204000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "brcm,bcm2835-spi";
+        reg = <0x7e204000 0x1000>;
+        interrupts = <2 22>;
+        clocks = <&clk_spi>;
+        cs-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+
+        display@0 {
+            compatible = "sitronix,st7920";
+            spi-max-frequency = <600000>;
+            reg = <0>;
+            spi-cs-high;
+        };
+    };
+
-- 
2.47.1


