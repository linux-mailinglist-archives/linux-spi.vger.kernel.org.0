Return-Path: <linux-spi+bounces-6665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67632A2CDAE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F5E3A8912
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03B1B87C8;
	Fri,  7 Feb 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZfuC9rmy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A081B4151
	for <linux-spi@vger.kernel.org>; Fri,  7 Feb 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958977; cv=none; b=ZBEX8basBf5/bK4fwZ86pMe6xwp9SJPmFeJRe3/5M3CGLj6FWWVkZza8jvO88Z4Y83xnoMqV7svqazYqrrNGvjk1P5U6ImMtaIcLf1w45KwipZU8kloZo2ihGDUTQJG9uMc8Z0NobFNcxNQzqj21LdiFKteKAGwHsJ7LiD+DFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958977; c=relaxed/simple;
	bh=wIbk5mFn+xLWzifwyYYIf1Y11mKle1UlHYsEBuzuRpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHygzyhULOlRTAs7BhRfT3vxrFDY4c3gL/NIP7UzxtnsgniIgH8nuX1+4e8JbhI9u5StqiIqB4xWdPtNmLli6ZIwJziDEedEqLdCy4t5IK9x0cywuNRbauw330r8s1ufcBm2SxMSha514HLTrb2EIy2MNFsVMoHU56RhXXQnlHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZfuC9rmy; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f4c111991bso1314263eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 07 Feb 2025 12:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958975; x=1739563775; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcwsH9FSGgvZx1I+Qt+xMirbqx1PZqy/STFkdwYNSkc=;
        b=ZfuC9rmyYw8HCnuaEvsFPnoMWV/OmVUiL8HlxJy+WoSxNZSDlRjvq5FNAMAtLe7158
         y+M6tzH8ihYLtD4ifvGCeBZjJkWQRJJsgJ+GCXqM38bELxRVBsXCjFwhjNeat3IjpqDI
         TjBAFlCIRB6VQ37gRUhX9ViCNIik+gLkRHgNdXOhwk0RGIruKOi6nnBPOta+fYMbddKT
         I/RPl8l7/BRKwTQN4c3SSW97Lk7i3qEISX2+gGCkzjEaIUR6mrrQk+zaYvPnyJBOfRMF
         imCzuqlDrwxrDOldm9ddDSyNVREveAdIPPTTNAJZ01TFlYvQkUkRdyP8Y/7o1OGNW13S
         T3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958975; x=1739563775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcwsH9FSGgvZx1I+Qt+xMirbqx1PZqy/STFkdwYNSkc=;
        b=TWwxNVVhHqSQiq3F0pKd1mN+wbKtA5Utb3Sr85maa+jNnao1eF+PsuykUxXKg06Xbr
         wllTCqYEnO+RmWutG2vRVFMTySAasUXcxEpXamiVJiFUJZt4MdYpIGFpSye7Bzm6//ob
         oXsWDOuRQ5GyILIVmEuzmtMzt6qli9p0ZBEpsVK6rrp69HP5jCBPD45lfrEAoI1dnjp5
         1KjWUTYlbDADG3ObG7dVnDYoNgaeLUvuGv/SZiJhNFBgAmqkgv7IEpeEryWujyCe8Jyg
         oRrpAtP6NeBPvjzwzsuqmztNFfcOyrDCDYLAaLASY1+qvzw1hhVkeP5ozRV0wCMEZCsh
         ljXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAzazZRPIr3JVoutE66X+2b/AmUapMRp6VHoDsN/U/ACbXm7TXoPTiJTSlsao7YYryo4FWSFxVnnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNGJL6scATPgKw2w4FxTEVc3Vai5soNQ1EtREEhhu+rCo1UiP
	xPyNtRB8/Vc2fcF/beoTr3kSiVxK+nAX50vKIa4p+LA6LeiGlG21sZ6eckrK+K0=
X-Gm-Gg: ASbGncvriv6nvk8OjnL/cm9B6Z2Vx/6KMii34IgbuXab+n/fyaBFTEtQywS7a8SEgJC
	SRA3H5MitpB8r8fxpTKjTDcKO9wby19TOFlzGQM7MSvI89GTRiuoGz3Y9s8InHEj2NLTQ6VG2xe
	x0id+yapSZHxESnBERXuqytF6ZENEg5VlyOEPS/yWbCO4UedrydQVfwwAfoIOyEaCrSJeLaZxG5
	4Gbdk9iySjHZcLwi6tNj0CNl0Yr+EYlOxasrC8tEdoqbF6uuMgK6qgwbDi7fS1/z4iRV2ok+jWT
	8LFvVueIe8f8ddlF0GLbpbfa2lNN8u5RdGZXZlZLTntVM8A=
X-Google-Smtp-Source: AGHT+IHnl7iHgGAFvK/NvYE6ivOshF430NsG1tgBvCko0JvmrNF+h8vllEgQRGyP15pnWXp6FnjKLA==
X-Received: by 2002:a4a:e654:0:b0:5fb:fe5a:6dd2 with SMTP id 006d021491bc7-5fc51ea2720mr6545559eaf.1.1738958974710;
        Fri, 07 Feb 2025 12:09:34 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:03 -0600
Subject: [PATCH v8 06/17] spi: dt-bindings: axi-spi-engine: add SPI offload
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-6-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

The AXI SPI Engine has support for hardware offloading capabilities.
This includes a connection to a DMA controller for streaming RX or TX
data and a trigger input for starting execution of the SPI message
programmed in the offload. It is designed to support up to 32 offload
instances.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Drop type $ref for trigger-sources property since it is defined
  elsewhere now
* Undo v5 changes that limited the number of offloads to 1

v5 changes:
* Also document offload0-tx DMA names since the hardware can support
  that now.
* Limit the number of offloads to 1 for now since it would require
  significant hardware changes to actually support more than that.

v4 changes:
* Dropped #spi-offload-cells property.
* Changed subject line.

v3 changes:
* Added #spi-offload-cells property.
* Added properties for triggers and RX data stream connected to DMA.

v2 changes:
* This is basically a new patch. It partially replaces "dt-bindings:
  iio: offload: add binding for PWM/DMA triggered buffer".
* The controller no longer has an offloads object node and the
  spi-offloads property is now a standard SPI peripheral property.
---
 .../bindings/spi/adi,axi-spi-engine.yaml           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025b07d72baa61f8946f42acbaf47dc..4b3828eda6cb4c5524570f00033b081a6e027b09 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -41,6 +41,26 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+  trigger-sources:
+    description:
+      An array of trigger source phandles for offload instances. The index in
+      the array corresponds to the offload instance number.
+    minItems: 1
+    maxItems: 32
+
+  dmas:
+    description:
+      DMA channels connected to the input or output stream interface of an
+      offload instance.
+    minItems: 1
+    maxItems: 32
+
+  dma-names:
+    items:
+      pattern: "^offload(?:[12]?[0-9]|3[01])-[tr]x$"
+    minItems: 1
+    maxItems: 32
+
 required:
   - compatible
   - reg
@@ -59,6 +79,10 @@ examples:
         clocks = <&clkc 15>, <&clkc 15>;
         clock-names = "s_axi_aclk", "spi_clk";
 
+        trigger-sources = <&trigger_clock>;
+        dmas = <&dma 0>;
+        dma-names = "offload0-rx";
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


