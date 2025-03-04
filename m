Return-Path: <linux-spi+bounces-7012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB08A4D699
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 09:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD15D174A9D
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB31FBCA9;
	Tue,  4 Mar 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVYzzWTK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08311FBC92;
	Tue,  4 Mar 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077395; cv=none; b=tx+DD1kN5VHUkkb8ox5eqXChiprwpu/qjX3aSBJqdOFqxuz8DKyjO6VWC1hl5I60PntZ3t8n4cyR9MyCI5xIuBt8NSge73b0d3lFc0YqGZYgxxN0s8xT/ze7FJGQwINvtt0Fk1RVMSJm383TJgKotPMSk92kCy6usnDMY+VX8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077395; c=relaxed/simple;
	bh=wjM73AwUJLNRKdAYXqbBkjiFzYpEkJtIU5MGBsLYikY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDDAEJ/ledDmv43yI3jVdCVXsTRqKB3fh2d5Syh1EneBn3MIc8Id0FJqd9WWc8ftpXhC2CzgqsePEQUy5KziMVbC7pWkCKpUjIFK5XYMgeSHKZl+KgPYnovU5JxTaqHr1G6IrE4hFQOwIJGM5/0yT1a1XSwoT20PMo7VNX8fGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVYzzWTK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22398e09e39so41234425ad.3;
        Tue, 04 Mar 2025 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741077393; x=1741682193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzuLSIrLaXf7CXwEltqloxoRU7OJxMBLJdraw/sviOc=;
        b=bVYzzWTKfG4vUH8iurpgX+nitBXfIPXamXS/A4mWJg9G+71GEEX19QtyGhT7iy0j51
         CPxmtywclnUxF8ww6ZAK/HxsJ6nSvz4DRZWglVfSE0X7TCvi8Jo/TSk4MM/J6cFjWjAa
         yp1uV00cjtDVnunxbfMp+THvGI7DMVocQgiIW7hwgfD++Gy7Gu0fSb1uV+FVuc48BoWQ
         vHEaGqv0FXOlnqwh5LPslslTPUsauD5BLs2y9slopgCv0O0joVGVGB2ESDa85+Jeavlq
         AvY4CF+wg5t65Qbb/1GXFjvleWW3njXogAU5VtWznR3plbh7uw9uJ3uTakRLI4jkVV01
         42zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077393; x=1741682193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzuLSIrLaXf7CXwEltqloxoRU7OJxMBLJdraw/sviOc=;
        b=pfoXYe8DZpx4JRMzjZDlYTueSVPQfB7OarEBufipAOF2rty6Ztva+UeDbeLYFu41ag
         3TYAVCvUuqR+aoiUjcnxr9/au6+/WZMz/DF4+2TRncZn/UnfpY/RqFvsVVI77tEaj2qV
         kN4KWtt7UoJSuwv27TUHSTKFhirEGGoocjJEKoLjfPyz4HjHxSqqQ/dyr9YajKkpuOWF
         UDAPsjosPAH+UAzTUG2tfep1qfjcyJJ2Tury2r5WPZdEwwm0WFmM7AqbRWNm4GIvLkqw
         4UL9sJZeUQZLD1BOQYmzrkDfRpOKVaYGA09/t6zKBCQ+vHfqR07jRnZELAfWXO1WhMHY
         Yd5g==
X-Forwarded-Encrypted: i=1; AJvYcCUKErXW9cl5bfGiMbPfL7ZX6OZwglbCXinkVSqWBnpGHbcUTYNttGLJ9P+y+appa18KIi8+l5bqVKE0U9nr@vger.kernel.org, AJvYcCVk/0pxGSvhvUWoKiKbrShH1x2iHBlC648All4n+BmaZIs1/BooI4SqmMegIGL4/E4sZ0dAv4+KUl1M@vger.kernel.org, AJvYcCX2zCKcbxTLCuXxobo1fgkwALeG8WDns47WYUTgR7V1g4R47LS1WsCNzRHvkZ3qrh6vA8BYk5R2Y1MG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24QIvZWenwq9RrYa4wlaxsf2m7lpF50/aalRWncfgPRJZjkc/
	xMm8SAuWeIXI+kstpEugh04ibIYurfJGIc9zW59OP7tcxMvGYZ6g
X-Gm-Gg: ASbGncvWArel/EUut00N31/toaPRkzVndVsEe/3HacRs4xY7YTbjnzaSdDznOfcq2if
	yjr11FCwROYvm7PKVDaYHmQG7PzF6pkpCxpqtgIMWIeUPfJXp4imwBfm3Y1fTc9xMvtflur7+bC
	GX4kOC/Jv76e9McQe8FwLnNq4R6fdKbF9iBY89f19/GUWbtGLAw0DPlQPYVN5micKVxvEK9l+67
	fB2RAD6H6AwaTTJvFaeB17IBMXEL+zHIe38Wm5+CEYwyNzPfMsmEAXCP0iW+Yy56f9Rxn/YJ/2r
	1w9witKmqqsTIYP3/9i7FoVI19yh7YZf8fYW8z0=
X-Google-Smtp-Source: AGHT+IGr55HKPhNfScKm1lRs9LWFrAQAez2uJvzKffhcY65WHUgtIevtYlWDNcERpJS4FEIFQDm5ZQ==
X-Received: by 2002:a17:902:e844:b0:220:c2a8:6fbc with SMTP id d9443c01a7336-2236924e46amr249478745ad.34.1741077393052;
        Tue, 04 Mar 2025 00:36:33 -0800 (PST)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm90597735ad.173.2025.03.04.00.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:36:32 -0800 (PST)
From: Longbin Li <looong.bin@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 1/2] dt-bindings: spi: add SG2044 SPI NOR controller driver
Date: Tue,  4 Mar 2025 16:35:42 +0800
Message-ID: <20250304083548.10101-2-looong.bin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304083548.10101-1-looong.bin@gmail.com>
References: <20250304083548.10101-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPI NOR driver for SG2044, including read, write operations.

Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 .../bindings/spi/spi-sg2044-nor.yaml          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
new file mode 100644
index 000000000000..948ff7a09643
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sg2044-nor.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-sg2044-nor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SG2044 SPI NOR controller
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

