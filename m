Return-Path: <linux-spi+bounces-6337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D4A0C2FC
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4BB3A84C6
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E41F9426;
	Mon, 13 Jan 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p/Q9lKeg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D61DDC0A
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802063; cv=none; b=sOoGrD2JoU+lZ9HkbK1ppj/DcB1zWeuAq3taZJGI2QkTJyoOIfX5/vrKJ4LFVhz5pNAM9/DRab+ynxcS9qC2ae0dsLZhm3E+in3VwvONcAW3mnyQZLkvcE/xITrEg0AadHXLS2kI5ff+qdQvG4Ahwl4JMdXrUfLVACkuR2735C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802063; c=relaxed/simple;
	bh=wIbk5mFn+xLWzifwyYYIf1Y11mKle1UlHYsEBuzuRpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAnPofq2vGeyu0QTQoszR/tUS9cqYM2UcfU9pFOCMaJoZ+EuiKL/GUgo+6g08BngIr2arnA1oXW16NL416OklDbB+ZNo+Yu1Q6kkFE3MRQHj0SFiVOs0YRmV//0/L7pDWs/xyxjWfGeNN2FwP0YjWnCKMXDyIQMh5UirNSVE6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p/Q9lKeg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e3284f963so2442053a34.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 13:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802059; x=1737406859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcwsH9FSGgvZx1I+Qt+xMirbqx1PZqy/STFkdwYNSkc=;
        b=p/Q9lKegSf40L5TetQLQMZo9X/chbE4wy99NmyvNgA9FP0xeKzTpCDO8TkV37Xt60h
         mPzGHT950R+s+lRHPWA+u97ZwmIB24e+70J1g/qMe6ltxdIhcPZlj+41FmFoGmp24N8O
         +F7GsheP4qeFNpOvV1//o/BHj+x0TXttN0EEuNrM9dpXgHMGBDH4jUGvP6rrb5QVHMxu
         Lv9dOMjJQzk4vRWph7ztv3SSccKLC9Y8CoP2QrYDCO6la1RHdcC/npZkebO3sVPqHFTk
         xR/JnunDfShINUnODv/LF1S54UGgfFa8up9apiN4R7cHG3V3HgxuRJiNfrKocYODzBEo
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802059; x=1737406859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcwsH9FSGgvZx1I+Qt+xMirbqx1PZqy/STFkdwYNSkc=;
        b=RHCRAaSBizPKEnNRhXjKOK7ICQMKpI/bOMNwgMQNiUtEZO/Hp2AfYqdDSn/tKR6vDI
         5n4ft06OslF6stT7GX6PxycibqGykWIZry+WXIBlUwfitGMShVmqPwUuUr5tFUf+3OoJ
         PF7F7Ojzvl7pJwXTT8ZplGmSSHPx+XCj29uRAqS6kwJ1pnKPy+pMMVyTcw9Xj1FEOdJu
         Z8aQ14uMW6RCtLGZ8eLO8IJYIFar3YCeiB8Wi5R2whE2/nGZc0ZXgqeWYXrbvRfPM/Go
         DiF3dtzecAe4sVsc5z0e600d8DuP1+FuqPiOAMBLDKRddRT9cLUnhqGyZJ/r1+9wyx8g
         xuFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtpZU6R0JsDrHvbJwexGRrEPRkW/9cEb1oe8FOxLV1ENN3cGjI7oTaZp2Gi088fl5JrzgprEqCBJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV2Qq7mDQS0rl8jaLp7KZBsMMxvGlAOzlI5RWeN0cQmL0C/eNd
	Zc3sc7PoMPyLMvjIgL0Hpa5czmxgEdIgCgv24UVGYj1T5xuZPZlf1pGmqzC/yOE=
X-Gm-Gg: ASbGncu0XIMDmMupzmbvw/KDjJtiEesT4ODhWbwPXrmXzeLyXloOgZraC3vPpwhNBkS
	aAiW5XAJcZGjYCtoKWXe6bGs6EdZUpBRim5cSVeS6/Exkboemr5P6O0ahpSFGMzg7hLiAggnBE9
	n+FoOgDG6DQPHQ24jjqNMA0z8BFR3++qI8UZ5G0+goCpHIl6jOr6wgXnXSC4wrQE21pUFJ//iPQ
	0mJ6gBwlv5y9yCN1SbYVNNkwp8VrozedoFr3mfmcZekiFdHsgVsih418f9UlX01EJhx8bL0jdHo
	u+7GZK4mCr0n
X-Google-Smtp-Source: AGHT+IF4i+QczDvcBDjHfAPq2kj2tWT1x+3YMnXTnRob3Rb5vYjiECOlgwx1k9Vfqc6Vc0z/InDQPg==
X-Received: by 2002:a05:6830:6509:b0:718:a52:e1cc with SMTP id 46e09a7af769-721e2ecc7e6mr15931630a34.25.1736802059516;
        Mon, 13 Jan 2025 13:00:59 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:00:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:11 -0600
Subject: [PATCH v7 06/17] spi: dt-bindings: axi-spi-engine: add SPI offload
 properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-6-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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


