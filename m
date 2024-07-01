Return-Path: <linux-spi+bounces-3706-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC791DEE3
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83CE282A6E
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2024 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E214AD0D;
	Mon,  1 Jul 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6Q2hJp/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0D60BBE;
	Mon,  1 Jul 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836100; cv=none; b=T8623xn6rYPmCMwtK4qWOP9AQ4VeZK0F/nRs2LZ5OD4yFqB82+cU9nmV0Z8HrT4lcjZoT1joQUszo3aeEfK7AlSvp4LkA4TLY3gQLsv/M1JEiX/oswVLX3b2RwdYBAFbYg9r4+SZr4LbRNrrEG6FJ2pK85qcwdw/qMMumCQW+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836100; c=relaxed/simple;
	bh=5+KlnoDQMwCY+L9LzwtSsJQIvxvZ5Wnc6e+i87HjisE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8yROvd9DM/tcnRuYe1+F3hagVt0POvBsCzllBj9Hjf0CeR4gYb3KGludWOByT4VDvMutHxQJqSNClXZe5JiswzMlxndcJA+JeOBC3AQWKuuMVeyl8VmTGQMt2aWOq+9rTI/NByADs7EdhP61NWHqsaUTUXvqNYWBFwcbc4qYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6Q2hJp/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fab03d2f23so19962155ad.0;
        Mon, 01 Jul 2024 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719836098; x=1720440898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZGF+hSKAfpUu0JnRW8V7jeP7SMQ/BQAWzymiuvR/t0=;
        b=U6Q2hJp/JbOWtNQDfdQtHTlbsf9Gchr1Kn7gS9Oyg7gyOorJWMC/wZG06cA/XrgQ3u
         7z4ljwrsagbpLUYHJPHCZ6Q4HgtMhmcMFLUMPx/cHCuOQNgjS5r0uElx0TeOFIpZtmMz
         W+JoDUFzNEycl53vuSnxJgxGRY8ImzV+gbkIL1wcabMXDAyGNSNdfXl6CTa/vBxNFlOO
         US8xnae65uJhRV1iFpd6jddpkqPkoixknG426jIGYeVg+AuSCNB5A5UCG2NW2277DpO9
         tbEumtdvPOZOk4ggvZO6YlYxeqnuE+Y8xdQm49Zf/PEdGefVQfMklV+3SXgq3+CIQLtL
         Gddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836098; x=1720440898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZGF+hSKAfpUu0JnRW8V7jeP7SMQ/BQAWzymiuvR/t0=;
        b=mLUG4mgUO3v9SHLz3Y8bQ53cgdQNsmopZspQNg9TdDeBsktPvMSQq5NRIF+uiLK3aP
         ko1pemFAy8/Y36kEqXZoQ+hVUnBPsYm8lnH5IGEjcORRywFb/odOmXfD9sW2C7TcSR/k
         HLGv710RIxTglcWqAdqh5fl1d7zJow7xdnRHl1Y1XBsOnjOCJe4a5up/+l5qVyWK3euh
         OkguL78xnochRLJh8Ra2xy0MGfRF0FlXb9RsvmbnB9JMYdC1WyHoQHxQ6CG06FPd7UiE
         L4FMHlvoysQ8leItEs4+1Vly78z3jQ6pcNsXTwkrzztM4fUUj8qGdjA9jVbBHJ1K05Zk
         nhQA==
X-Forwarded-Encrypted: i=1; AJvYcCXl7gBYSaJTOyhWczbjAEoWW5D42hOQKds3fboee0H45IVDa7JELh1vSJzIaJMSH76qLzVpCaVMHyhoP7822sD0PCNRzdnFeUgE8ifWiP24tNEpiY4solzQ+fkrRjtwqUlchCgljiy/vBKJWYU016VGApZJjnqpOAUZ1aBeU8K8/aoBew==
X-Gm-Message-State: AOJu0Yy1WjiirQO/XFDjnYscJvBKUxEBi9sMaBaYVD3puGr7AuQ8PzAk
	g6xVkg3BtUe8A/CaPY3ltwEEtQPxOMLYSrAjDQ1dWrJAJQzK/S8MWr+MF4IB
X-Google-Smtp-Source: AGHT+IHw+TJdLcLvIGB0OVy2rxLeDd/zmLr5mcFmlnJl7GUR+T4SLoYKO4G/3uCq247sGd7XaGdgBA==
X-Received: by 2002:a17:90a:c394:b0:2c3:514:e0 with SMTP id 98e67ed59e1d1-2c93d76765dmr2671731a91.35.1719836098208;
        Mon, 01 Jul 2024 05:14:58 -0700 (PDT)
Received: from ga401ii.. ([223.178.83.109])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm6613098a91.6.2024.07.01.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 05:14:57 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: dts: thead: add basic spi node
Date: Mon,  1 Jul 2024 17:43:54 +0530
Message-ID: <20240701121355.262259-5-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701121355.262259-2-kanakshilledar@gmail.com>
References: <20240701121355.262259-2-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

created spi0 node with fixed clock. the spi0 node
uses synopsis designware driver and has the following
compatible "snps,dw-apb-ssi". the spi0 node is connected
to a SPI NOR flash pad which is left unpopulated on the back
side of the board.

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v2:
- Separated from a single patch file
---
 .../boot/dts/thead/th1520-beaglev-ahead.dts      |  9 +++++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi  |  4 ++++
 .../riscv/boot/dts/thead/th1520-lichee-pi-4a.dts |  5 +++++
 arch/riscv/boot/dts/thead/th1520.dtsi            | 16 ++++++++++++++++
 4 files changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index d9b4de9e4757..3103b74e0288 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -17,6 +17,7 @@ aliases {
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -52,6 +53,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
@@ -79,3 +84,7 @@ &sdio0 {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 1365d3a512a3..6939bd36560c 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -33,6 +33,10 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
+&spi_clk {
+	clock-frequency = <396000000>;
+};
+
 &uart_sclk {
 	clock-frequency = <100000000>;
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 9a3884a73e13..14b06dd81a9a 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -14,6 +14,7 @@ aliases {
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		spi0 = &spi0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -30,3 +31,7 @@ chosen {
 &uart0 {
 	status = "okay";
 };
+
+&spi0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index d2fa25839012..f962de663e7e 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -140,6 +140,12 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
+	spi_clk: spi-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "spi_clk";
+		#clock-cells = <0>;
+	};
+
 	uart_sclk: uart-sclk-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "uart_sclk";
@@ -183,6 +189,16 @@ clint: timer@ffdc000000 {
 					      <&cpu3_intc 3>, <&cpu3_intc 7>;
 		};
 
+		spi0: spi@ffe700c000 {
+			compatible = "thead,th1520-spi", "snps,dw-apb-ssi";
+			reg = <0xff 0xe700c000 0x0 0x1000>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&spi_clk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
-- 
2.45.2


