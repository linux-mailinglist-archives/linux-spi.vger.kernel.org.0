Return-Path: <linux-spi+bounces-793-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535383C65D
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1505328EE40
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D717E771;
	Thu, 25 Jan 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCeui8pa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25426EB60
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195813; cv=none; b=lxLYN4cViC6uRKwUFN2i1rVYEPh6HxXQ8mqoG+3NiMq+4nO3oVlyaoKNXzJQsp1CqVig2etiw23XUDYyMoV+ItpHL8WOaKu8rveT0ry+XflgHgVobLEtO9sfkVT1RfH63D5Iz/rXP8hgDww3+ARwZt4K2S54lppWyUlVOgfvjGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195813; c=relaxed/simple;
	bh=BdvEdsI+9ZwmAcWu9r+fn2zpwOJ5y95xenR9tMcXHt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h++jIfT7it2aKBdWnzUp7UaHTY0aprT5bMuZnBgEh8xKJvdM5qxC1YSDauF0NsVH8LpiixltFz6LKmSLQX3+GMwwzI814+q4afQ7A+zofNTPN7fXyOFPaSFYQTV+cLM7AU4Iw9MCKoyYjPdzsOso4/i3/DAZsg3JfdnLliUIk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCeui8pa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339237092dcso4837446f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 07:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195809; x=1706800609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7fZHgdtAk254b2Ta6r4jswrfEyOE+a6C3SzcwRbr5s=;
        b=MCeui8pa96/950ae+M3AilAREYSAapIKOLfsm/x3xcvdrw6ebBuU391l90CvjM6q+h
         LKgCN6L5Zj2eTZfbnu0EoCnvh76pevcVuyk6XjQfYltDeFbpjDE+0ONBain0EfV8kvG+
         LIIo9ENvRSki+ogerLl5fKGCpBL+mFet5bc/j41pqZpssY0oqrtC8PQqP3eznv7a5Aka
         KAyH5M+kctHrIVPO9qhQM2ELE4Vd/ZNevFXCJgiJC18VvtTWpPeFplM+rMGnuLar3Y8Z
         DMvkTghpSpnZmQvIVAzw20gD9+KjpImafYNMUKWsc/WdYQmoLAbvvEPoUzmzXwTXjWLi
         7i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195809; x=1706800609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7fZHgdtAk254b2Ta6r4jswrfEyOE+a6C3SzcwRbr5s=;
        b=fUTQCjRNskYQrMX8je7Cq236HoOX0JNWcvTPHGQ2/efZ0hTkbx8YypgizOYbaKbglj
         wtxXgHkv91GVvxqa4vmpL26+TrC5VlYEnm7jrjhASaHe9J+TYYKQaT4j3StY2hwawWKl
         Zp7fIhA7Rcq7yQII9UdwVf8RvmI77haOyJ8r/2BeEePLY/SaxZhpMGbXvLbftgaiJvv0
         omckSLbxU4/o492eRP+xLtZejXgPi4suCpdhb2PC2z2rS7KMdYO+Er7ve+pqWkRgOmj9
         CwhuPZ+Nixeou/pKzH2tpTfbq6Kmy7cRlwZAvbLJsCWG7ntnP51nMDjnc2OyfP78Vs63
         DoFg==
X-Gm-Message-State: AOJu0YzrPAeGUuV/Zla2XwoM8XeFLeyeu2T1m8ePYCgRpvidQPrfJ19k
	ch3Uv+liEV8faJEnuOuZpTk43YcIWmdhEtevr/Xnizfo2zh7J8TNm+thmUcn0h0=
X-Google-Smtp-Source: AGHT+IGoYO9kOPahwZ6XA2vuBj8K4clNsgjxliD3BZy40XKH+w00g1wwRaBaodP+bbbqXxngyjZQ8A==
X-Received: by 2002:a5d:4906:0:b0:337:c4dc:c6ca with SMTP id x6-20020a5d4906000000b00337c4dcc6camr722087wrq.14.1706195809268;
        Thu, 25 Jan 2024 07:16:49 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:47 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 7/7] ARM: dts: samsung: exynosautov9: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:30 +0000
Message-ID: <20240125151630.753318-8-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and specify the SPI FIFO size directly into the SPI node.

There are no SPI aliases defined, thus the FIFO size was determined by
matching the FIFO size of the I2C node of the same USI parent.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index c871a2f49fda..3615da60dc9a 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -435,6 +435,7 @@ spi_0: spi@10300000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <256>;
 				status = "disabled";
 			};
 
@@ -526,6 +527,7 @@ spi_1: spi@10320000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <256>;
 				status = "disabled";
 			};
 
@@ -617,6 +619,7 @@ spi_2: spi@10340000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -708,6 +711,7 @@ spi_3: spi@10360000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -799,6 +803,7 @@ spi_4: spi@10380000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -890,6 +895,7 @@ spi_5: spi@103a0000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -981,6 +987,7 @@ spi_6: spi@10900000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <256>;
 				status = "disabled";
 			};
 
@@ -1072,6 +1079,7 @@ spi_7: spi@10920000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -1163,6 +1171,7 @@ spi_8: spi@10940000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -1254,6 +1263,7 @@ spi_9: spi@10960000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -1345,6 +1355,7 @@ spi_10: spi@10980000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
@@ -1434,6 +1445,7 @@ spi_11: spi@109a0000 {
 				num-cs = <1>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				samsung,spi-fifosize = <64>;
 				status = "disabled";
 			};
 
-- 
2.43.0.429.g432eaa2c6b-goog


