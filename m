Return-Path: <linux-spi+bounces-5311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BD9AC98C
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E761F222B5
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502C19F461;
	Wed, 23 Oct 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVQEZuiG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9401AB6C2;
	Wed, 23 Oct 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684838; cv=none; b=NFY8x7/YYnBLyhvcn6JEuasA39cUq2HHksRv/0BHHCE27YPVeQNHCqfiRbb7WpvAL4Ll0apGH8JhvQUmtG05LEDGdTzv06Hqu7x47ZT+/qiu1Ipl73sOZUep0Tt4n05/JIkjTdI9jcQxrLrduPelURZCbrvaG4e1JVoTg/xjoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684838; c=relaxed/simple;
	bh=1/xvUlurrh7XAHZGgKT9KvqDGdpU+rwSGR+13Cm4W9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ti6IKFroVTrSSc9HGEKd9qFqh671UVvFw4/dR5ZTTbeLtCQSR9JqGxetLBgruuE9zF06RbkaHK0m1ZJD6kvMekWmdHKrz/okxh6YKoOVIDTNCMt6F2peBj3EmuHoqew6HynSu0sPJBhg+Et9EC43yIrpA3jxcAUA2mG1F8d2VKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVQEZuiG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-208cf673b8dso65176395ad.3;
        Wed, 23 Oct 2024 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729684836; x=1730289636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2MTS/u+0Vf8uU8MokaRsyUGwP3Z9gCshpIWDYlPy20=;
        b=UVQEZuiGZdMf1ou/7wHXB6yt/eAgC+1ELqzWcbSfDxr5RDW853LqwMEocOUcIffwHv
         RpuPsWbHStnUiuL1PZmVfTg8U9ayfXCNK4P7CpYHZEOZMcvh42BJc2T6SdcJOxlV2F0l
         sinIcE8Rss2GsiGJeG7vTO9z3RDyo4xhLwx/7y4I6MXqBCZeuZueYeFy2AolRCLV4Vhx
         b9+uYQJgPEFrUEEkCNRwUwc6D5nXdRLbkPryFa/wqOdAJ5rIt6OMefJgYLD6dFiRZ0TI
         8lunqKH1c/mZKwV8YJpbqph8UqkFPcpP5Wx0Y0I/yibd10J8DL1CBg9i3SOFWd3xoMhj
         2wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684836; x=1730289636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2MTS/u+0Vf8uU8MokaRsyUGwP3Z9gCshpIWDYlPy20=;
        b=PYGOz3pRNtK8s5xJTO1nZSMqdptdSWm7aS7O2XgTciSepH4/GLhQErHAWJ8zCCWfDt
         0hhPqgiyaFOAwDhdOzz6OyPdH7t2w4SGOCr7vODqXRi/CSoQEm/6aJ5049mRQsRl3xmv
         VuUcKAvP1qaUW6xHY5yM/Q4ndT26iszGbsSOvat4SpNSXXZ3iOuVdXB4lyhU90akJE0l
         CV5dDsV1ziqOTKFZ9a+ghFMdALJph+74VQBrBgJA0gt9UVwefsU5qsbcvMHddY5HBVaU
         5xamaA5LmI3QicWqPYGpfJOyL6pOzjmqwclwKMQHQigiNQKbUMYM5ZYQ+qU8yomGHnl/
         MehA==
X-Forwarded-Encrypted: i=1; AJvYcCWkPYN6vqb/W1ryJdjO385SqIWsxHGCjh/BdkJWvglaqvrHfly7G6QkVQqq2awtUPtcpTdC+Cwpv5ts@vger.kernel.org, AJvYcCXbuet2oMyvBkghw77ZxkzCbHaqoMtYxKew38Qr7JVeiDdNHlJcECEGjxipSOvVHSC1aCFBL298puzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxb66+evzwqtEtxJ8OuLHk8oV1CEUmB25NAdPEwsv3R7z9yJ++
	JIq2C0vHKt0TNqXdRyodqn9tohml7Rv68JDQGwtLXABEcA0thJAN7qLAgA==
X-Google-Smtp-Source: AGHT+IGxv5dhAMbuXomoFYpbS6FEm3jtO/yUDIs/ac5RmQKBFN9OI2RYgb7XmCKEqMNPK3ZzAdsf8w==
X-Received: by 2002:a05:6a21:1698:b0:1d4:e68c:2eb9 with SMTP id adf61e73a8af0-1d978b1dd36mr3306402637.20.1729684835614;
        Wed, 23 Oct 2024 05:00:35 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:3468:366c:e529:6d8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f3665sm56598825ad.271.2024.10.23.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:00:35 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lukma@denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] dt-bindings: misc: lwn,bk4-spi: Add binding
Date: Wed, 23 Oct 2024 09:00:13 -0300
Message-Id: <20241023120015.1049008-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Add a lwn,bk4-spi.yaml binding for Liebherr's BK4 external SPI controller.

Currently, the compatible string used for this device is "lwn,bk4",
which is the same as the board compatible string documented at fsl.yaml.

This causes several dt-schema warnings:

make dtbs_check DT_SCHEMA_FILES=fsl.yaml
...

['lwn,bk4'] is too short
'lwn,bk4' is not one of ['tq,imx8dxp-tqma8xdp-mba8xx']
'lwn,bk4' is not one of ['tq,imx8qxp-tqma8xqp-mba8xx']
'lwn,bk4' is not one of ['armadeus,imx1-apf9328', 'fsl,imx1ads']
...

Use a more specific "lwn,bk4-spi" compatible string for this
device.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/misc/lwn,bk4-spi.yaml | 54 +++++++++++++++++++
 .../devicetree/bindings/misc/lwn-bk4.txt      | 26 ---------
 2 files changed, 54 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt

diff --git a/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml b/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
new file mode 100644
index 000000000000..7fb86e6abade
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/lwn,bk4-spi.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/lwn,bk4-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Liebherr's BK4 external SPI controller
+
+maintainers:
+  - Lukasz Majewski <lukma@denx.de>
+
+description: |
+  Liebherr's BK4 external SPI controller is a device which handles data
+  acquisition from compatible industrial peripherals.
+  The SPI is used for data and management purposes in both master and
+  slave modes.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: lwn,bk4-spi
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  fsl,spi-cs-sck-delay: true
+
+  fsl,spi-sck-cs-delay: true
+
+required:
+  - compatible
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spidev@0 {
+            compatible = "lwn,bk4-spi";
+            reg = <0>;
+            spi-max-frequency = <30000000>;
+            fsl,spi-cs-sck-delay = <200>;
+            fsl,spi-sck-cs-delay = <400>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
deleted file mode 100644
index d6a8c188c087..000000000000
--- a/Documentation/devicetree/bindings/misc/lwn-bk4.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Liebherr's BK4 controller external SPI
-
-A device which handles data acquisition from compatible industrial
-peripherals.
-The SPI is used for data and management purposes in both master and
-slave modes.
-
-Required properties:
-
-- compatible : Should be "lwn,bk4"
-
-Required SPI properties:
-
-- reg : Should be address of the device chip select within
-  the controller.
-
-- spi-max-frequency : Maximum SPI clocking speed of device in Hz, should be
-  30MHz at most for the Liebherr's BK4 external bus.
-
-Example:
-
-spidev0: spi@0 {
-	compatible = "lwn,bk4";
-	spi-max-frequency = <30000000>;
-	reg = <0>;
-};
-- 
2.34.1


