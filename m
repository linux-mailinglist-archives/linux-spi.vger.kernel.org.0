Return-Path: <linux-spi+bounces-6887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF2A41A75
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 11:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE101888666
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2025 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A524A06B;
	Mon, 24 Feb 2025 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK7go54Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9B24A051;
	Mon, 24 Feb 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391979; cv=none; b=bZCEasexzuDBqRRpb0RvILnhFq2wrKFifI7qU4uhXLpJoCOtYgN80MLDAu6L2wuotZpahI5nHqoerg/g/uhu8n106vfPfY+vQQW+LoNd10Hg+UBEMteqR5/xbkAwUvomK+FKpT/+cS3fRx6X9Y9DtD6KrtJVARVYc2hYTyBuYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391979; c=relaxed/simple;
	bh=KGeJRad60cuqCHJZvLMv/sE5CXRM5iHWHfq4M41kVqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEJDeSzaVuyOLWEkEAXHpvPLOfxDQhdpqvTg04e33e2jQutHs7hZXG1Fqze/CaqndHtLL5LRB1SG+WJrOHQuuOabgY0UYeibScqeyj0rtY51pcqRvqiMEOdCy9VfKJsllG6ZMRfh0cCG5weg74KKX3+D2SGef5QGjNibgLPJ7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK7go54Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22100006bc8so70378575ad.0;
        Mon, 24 Feb 2025 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740391977; x=1740996777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfgdDU3dHCgHvLuyG46NLXGA1z+1QvVU4idXkiLTeYg=;
        b=WK7go54YfCelQ25HzFm9igXOxaU0w1y9EhaVvGH6SGSTRrONpKPdqj+gJdSN4ao5/O
         zRV8vnSH/YIs2NpOEiLVEWEestqwQL6NcHJI6TvMIOP/f9KDU5b+feA4PrDwQX4RdsQ/
         aQ+QGnKGwJXsVQcaKVMkGacHEW4T6VEezCtHvMDLOVmgGxyr1+9Xu8HRgNwX33a0YBCz
         O1Ky0Y040aR6MRK7F5mGarqHGBa2BT/lFUUeeewWVIiiMhAoLLVH7vUAyY0p/Boepg9A
         wREc0S0shKGqMGUEWN2UPveoUIHU4wbqCQSD5Hb5Uq4mml2hgrLRyHFWd4k5XUeTGMGh
         nh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391977; x=1740996777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfgdDU3dHCgHvLuyG46NLXGA1z+1QvVU4idXkiLTeYg=;
        b=pEbaEihcmRkgIbPVf5lscCvR1c6zj44TW0mI2DeqI5rnrEj9jaSshCzPvMxdUcrjaz
         0ycANCMkO/fw1cCRKcY5TXllbVnx+YHkW/Hjs3+D1v6JO8zr5XHsyOyhIesgoNhe3n45
         TdbUYcabZVshOeHRYHDmUu+NTjxRHvZCu0HabihGQU+c1W745pum+pwtg3yL28h8oJdd
         jZAeWrxJtmUhlT/Fk2JBzj0GBXyBl264U7hz11x8M8A+hc727CTXTSnsMqXI2BuboeDy
         UjdNhCDh6CoXIc0h7m/l46tI+X8Urtcf5IPxxz1YlD1CtR96bGQgYMPd0scfEa3ScEQf
         CP5w==
X-Forwarded-Encrypted: i=1; AJvYcCVEqa64AVIozFIUehyz+T5zHD9Xjgn4xjN7DKxU0xInjauIzztC2qvdJJ/1xinelCNXislBXD3EqEqf@vger.kernel.org, AJvYcCVZC1JncpY8cHtL3V9xvRo1fuzY1f34cTcfY4z0om9/m7ZMTy+54kgxnxNSa+ZAU0gFbgJDoM9ZwR9F@vger.kernel.org, AJvYcCW2IRZ0QqBN1a982Dh/TUr/p7L15ZbUuWYsj/CKO27xpI710tiqUsJ0Y5lntMCLCR1Fnd3mo8PMcCoQdXl/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn25SPWWsZE4fUN5kQq6P9541gHHDh0e9gk2C7DffYOMN4SQ/C
	OWoMdnO+3nJEFxkx19CsImQ8FYVxg84oX07BHOlhiKlFB09eGXk4
X-Gm-Gg: ASbGncvVCiVU7mCErLpnw7hEpJrjcgh7dS/8XQMU4T5MxEllF0SIk8U1BwB+UtruG/T
	u2kBpOzaWWjablm5UpLKjIvZz8YcXSphonCtfN+rBc8GjSu5EVEptOIafaUGzo+YpMgq83oQLy9
	ksP3rdV1xW/tbf6vnlweBJgajtu1Badd9oM3udEfWduZ02KtINU7XW/WC0CmmNOJO2LWdRCHaTi
	lZDvdtaUmTrUTRvzfX1HNxTv/OZ71/WelB/kxewDaCNkunwg5NtDF7nMnJ/7yv7PWNfIVmn7452
	6dqkZpbkkV5TLtL5kjfo
X-Google-Smtp-Source: AGHT+IF04L64yddkAFq03o8LvF25Xq5MWdPj2nGFRbtcPd0hUWOcQ6Di7Lct9JFSZGV4Unfn5iL97Q==
X-Received: by 2002:a17:902:fc4e:b0:21f:7964:e989 with SMTP id d9443c01a7336-2219fffb650mr207806035ad.52.1740391977163;
        Mon, 24 Feb 2025 02:12:57 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a464f1sm173274365ad.206.2025.02.24.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:12:56 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: spi: add Sophgo SPI NOR controller driver
Date: Mon, 24 Feb 2025 18:12:00 +0800
Message-ID: <20250224101213.26003-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224101213.26003-1-looong.bin@gmail.com>
References: <20250224101213.26003-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI NOR driver for Sophgo, including read, write operations.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../bindings/spi/spi-sophgo-nor.yaml          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml
new file mode 100644
index 000000000000..0b54946c649f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sophgo-nor.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sophgo-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SPI NOR controller
+
+maintainers:
+  - Longbin Li <looong.bin@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: sophgo,sg2044-spifmc-nor
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi@1000000 {
+      compatible = "sophgo,sg2044-spifmc-nor";
+      reg = <0x1000000 0x4000000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clocks = <&clk 0>;
+      interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
+      resets = <&rst 0>;
+    };
--
2.48.1

