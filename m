Return-Path: <linux-spi+bounces-10217-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E344B922F1
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A363A8234
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C75311C09;
	Mon, 22 Sep 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JSMYWnY6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE549311975
	for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557850; cv=none; b=HnoQ85EqXNzRhVpd11NDzx/gFvGCb1PgiUkvWM7f9GDf/HBQE2AOraA9VmJVL7tE9dymQP4hKtAQzrQK080K/zGaTsALOrhd5FO38OxwZZvKrQqMQRg8QdxELcI+8P/11df+7/31mHb5h7O/4OZXVnq6GmE4RVer+g8E+jXThx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557850; c=relaxed/simple;
	bh=NlbheDXpECv8KOzHHrPYOJU3W86bTH3Ut6RJOpS2J+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcSEBuDdur6FCz+WKFJVLbFMG6nJGQq8qnCBE5uTKS/Ayimi/6eyZC0oaBPCoeCTKYVWJy9lFVZcO7low/SUsHcehM6YuCUpGsWBU+Z+o8woYqkDadk5fXdahvD5vAdzGZH87KKom4ePW9vPy43AEYHgrJ9BSeWx3dbsY5HQfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JSMYWnY6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-425715aeccdso9408265ab.2
        for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758557846; x=1759162646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoOY7RfK5Srk9OHnvU+owYvzqDNBeS7oAz1E0iurER0=;
        b=JSMYWnY6b1aq4LTuusPdEF/bkDK0s6nCSWl9YiXI7gGUysANeAbWXN4FNarI5TtzLu
         ZksnaVez5PvYEuXlH8QtmN9XNoaZHH3uxEppeahuBDfTkI/R2pHFpJcGjDTU0YKUsQiu
         U7Wdl6vcvmMYh7lbxnn2dWfFHwx19ePptC3Hk0JUjZ3/U9xvZSL19hFFsTE5thPfZT5h
         BjEXaHLieOgbkuYhfhIvLl3cCp0JjRMYCJ7VYWLH92C6ho4aKEs+5xZJrXRH/TNDtiUh
         Vy6hNruaAIjxkJDtT+LGVgEDpl8apXzt2i+41NghenN3zUWqQkoS76m4/Mu97yahgDvD
         ySWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557846; x=1759162646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoOY7RfK5Srk9OHnvU+owYvzqDNBeS7oAz1E0iurER0=;
        b=QFN1XLHZlF9EtxWa0TQfRt3r6c/tmI7XGqn9HDgMS/PGBjRiXlIOSJ7sSWMn3y+ntr
         yVI+kwnfre5YF7mYdtR9jOmDP9sYRlvZxRtPlfuPXYTIquMzVwF6AsK/4Ay8QhBwegAI
         5HmbFTFDgSnFFZfTRL9DBNzenonz9quJWcQ5c3DXinv4L8MWzpesOhJ7wTWuBbN5xbJI
         dnKPRKE8BYgeCzBhdqJbv3MMcsUjfL2Xht7ydHfaaI8voPJWm1wotRSmebAI74MWcx7B
         JU8tx71Rg5Tola4uwCbETF/xfBElsX/qNRbRMv3X/HeQCCfxF8PUlGFX3zGAlR9VtIl7
         XM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+0NpLZ4MxUJhJRFPGRrSStWn2/DQKIt2rwfhffNNC45HOMzG7VBNIsAQ1r+PqCBfCLaki8yWDCrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSHylgAmiWvHqe8E/MP8KYCjLKLcfZV9dMft2RUw8/g56EKop
	cE20Gmh3x4Yxt55T//L5y2M4ZQpf4V55vfisoBxg/KKRz7IZYA87l7uKWDfiavujxS4=
X-Gm-Gg: ASbGncvekcEsl4DBvSNErufDx3dMKSGzE1aRMpWbm39otMLePkyrHaw3aK0sREnVoRr
	s1mSZQ/Be5Mz0CTIRgVqqdhgQRdF2mwzT2iUXk1bsUh81zvz/94p6RYpxRBcnU3kIHRJg09H5/E
	HUF+cx5SNANT6+JMkv3TcfnTrSeQuCTuCL9rDu6dUZmR9lw72l5rdnFVZzMgWtafjl9YM1qZQut
	eo517cOKD3akm4hhE66lLrccH8obZP/QUJEqgRbXiOT0xp0shvYN9QpN72W4MdwzOCNWBq/Oba5
	c4H+c42K8yP26tXXMI087DSdwWHF4EwbGA9pb5BpNNoSe3GlSmP0qhxdl054hf/OQoKeA5ez5gR
	KmbFq+5jYpVKiakLBx9tHY5uPO8AOi7ukuppG7gkGRd2/Odvp1qDC/xT//Uiq8rmCgQ==
X-Google-Smtp-Source: AGHT+IGtbLw0Yh8YMxa0k32ja3gy2lmtWw7KYJ5toaZ8D6XiMR5qUSNHvj3Y8EAnz6GgOP6IVLuhZg==
X-Received: by 2002:a05:6e02:164d:b0:402:b8e3:c9f5 with SMTP id e9e14a558f8ab-42481911960mr204709235ab.2.1758557846329;
        Mon, 22 Sep 2025 09:17:26 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425711d9aa0sm25207185ab.48.2025.09.22.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:17:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Date: Mon, 22 Sep 2025 11:17:16 -0500
Message-ID: <20250922161717.1590690-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922161717.1590690-1-elder@riscstar.com>
References: <20250922161717.1590690-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a node for the fourth SoC SPI controller (number 3) on
the SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Moved the SPI controller into the dma-bus memory region

 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..d9d865fbe320e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 	};
 
 	chosen {
@@ -92,6 +93,12 @@ &pdma {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index aff19c86d5ff3..205c201a3005c 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -76,4 +76,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-no-pull-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 6cdcd80a7c83b..eb8a14dd72ea4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -797,6 +797,22 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>,
+				       <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 
-- 
2.48.1


