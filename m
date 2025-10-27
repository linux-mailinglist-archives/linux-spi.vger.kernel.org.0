Return-Path: <linux-spi+bounces-10858-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964AC0E134
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C03AEE54
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E1303CBF;
	Mon, 27 Oct 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="z4+gpifF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A5302779
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571831; cv=none; b=M4GwYXqK0/+cQnZRftcjneW2qmbMr0unSGA+ioVCVw4ga3D0fInV8aG07VjAhO8NS6WzlufQ8GkaegcRuXBKjtWsQhDkpFr27aa8ulqHp3VMAidYADK8sqQGxpyCXwjpD6TMd7lQrPTY16hUTBkVMMhN4tb9luFaVLpQlJrFWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571831; c=relaxed/simple;
	bh=BzKRuhxyonoQsuopPQdi/8jOGmwxXgdxHX/BXxXKdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1e5+vLyDFrFPF/XEM/OHG1cwRxL52UsxiSoiKxrd728XIR9rYkY3/3H7Ef5A/hjQN9lFOaGtZ7R2n4a1kksn6nX/JeIF129gt/Og0dk6B4eZb78wjppHecqnX2dretKSSS9rGFugj3fIS6tO8cpWnRaiV8yXKAoTeTcj2Mh5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=z4+gpifF; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92790f12293so212875539f.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571828; x=1762176628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=z4+gpifFgUssu0G78T2IwiQuCWFQh5h9c3Z8vV/6Z0mKiJCRPSHGohgbW3ceDatwmg
         DfmkGXRD0Qa7fEfS4rMRcp/iLWVZa3AqsxuNMB4iRLd8g7DIYjLBMSmmk4r8BjyTIuJ8
         B0ECj2snNu5fFNfSYunhcu9PHZI//smk3ZJIOpU+vlQbn+rJr6+fyimmItUyBXJs2BXg
         V+/vK12KhNmxVQo4BJeVqhzcWhEDpWot6G9QygkTZf86O8KjYIRAEQXECGL3GKSvQLY6
         0fVdWss83m89ukv5sv55WDv963NIPQpWp0aMUfueDlG3MQ3KjzkNiDpR4Qv5Cv9Kd8hD
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571828; x=1762176628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdMeTbCiZFImBLpdSseleACrRi7JJpgsujeJgyCXmeA=;
        b=fVSoj8ENQYI95pCCAHoReZbC4WI6H0bA+kehsuhMDf78T3ohjak3GtGtM6SyT0rm+o
         BSIvx7pf49a7c0OgAHJdW8+IlPHubehABLGGsgg6oG3e5+X6BRJio2cxpxqgI+rLSc49
         gwrqCKd5/gQD63C32aaJafIIELclyK6NBHzIXWzV9uurCAKLQ/lmvPOhHqZvN2HCc+P/
         +DxHlGhrpoYTPZVGZD5bIaufTxLMRUxuEZjwe0tcinJt0xFkrrbsWYxKbygr8+5WOLfh
         wEFfuH+CZrLiY7/Z4AWZb8dC39cQyO6WOZm4rOnwFNfAHWxTdqlAH9xObHL3Lh4tNBdz
         8tyg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEN3fUkQeADXFhXEVPeIbLFJ62iacvNvWj7t6i5H1FSJn4MgoyqDMDCOiL1RVqvG/BGFFChR5Czk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyccia5kB/zgIxtCnJ5Hb75xDi3lWlvASahmQO8lhMmXv9E1yJa
	TugkwCFgjednhtBEoPtLR4QEwAUC1FAhtS7b5e9Rp0Ar0+03QMnB0YKK6FlD0CLChtg=
X-Gm-Gg: ASbGncsRYz3gNksZJav4KH5bdT3Y/G/LBG3V6YmcelJBlMsKy1XFv0eqhvd6gsswxCl
	pBaVJbyp6FZrfQ4LVpmPzzJr/J+r4li3/wsAMAR69qu0gsq91vuqU99TDccmiDMqHRHIGI8TDVz
	F6UUuunLCR4yF18Vll2ucyfdcaeSE5t4Vb+oXgkuz/wQCbg6V3wbc9os5sM3nsLxqOAN3YLnQFi
	UPTATqBt5AxiLee9GiJ2lTwnaservy6fydCGu/FytM1MzWANQJZneLLv+NEFjlOysqbaHqEFCSi
	YZKatFrkUNtN33Y90d+Ixq7mwO1WZeneeRjqxIx5iQ9MG7sXX7KbSwgFOgUIq5A9PdaG36RjGTO
	JngktkTyoZRdiucbWIgFcZunSDSGrMdo1vktRA47o3eU3FvTH2cF8DMo1San4zS/A2YjgofJJee
	Rl4Z804mJYlDcxDAW7mgiNnsL50OjgyAfIaQxByBgEnVY=
X-Google-Smtp-Source: AGHT+IEwi0+D29qzwfaIeFc/gnHZPerYoM3xz0awvDXq4gN/Y7hOOLjB+JgF5YW9xp73OHzxinZJ2g==
X-Received: by 2002:a05:6e02:1848:b0:42f:9847:15bd with SMTP id e9e14a558f8ab-4320f860164mr590635ab.26.1761571828284;
        Mon, 27 Oct 2025 06:30:28 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:27 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	broonie@kernel.org,
	han.xu@nxp.com
Cc: Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] riscv: dts: spacemit: enable K1 SoC QSPI on BPI-F3
Date: Mon, 27 Oct 2025 08:30:06 -0500
Message-ID: <20251027133008.360237-9-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define DTS nodes to enable support for QSPI on the K1 SoC, including the
pin control configuration used.  Enable QSPI on the Banana Pi BPI-F3 board.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  6 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 21 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 33ca816bfd4b3..02f218a16318e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -113,6 +113,12 @@ &pdma {
 	status = "okay";
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_0_cfg>;
 	pinctrl-names = "default";
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 4eef81d583f3d..e922e05ff856d 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -73,6 +73,27 @@ i2c8-0-pins {
 		};
 	};
 
+	qspi_cfg: qspi-cfg {
+		qspi-pins {
+			pinmux = <K1_PADCONF(98, 0)>,    /* QSPI_DATA3 */
+				 <K1_PADCONF(99, 0)>,    /* QSPI_DATA2 */
+				 <K1_PADCONF(100, 0)>,   /* QSPI_DATA1 */
+				 <K1_PADCONF(101, 0)>,   /* QSPI_DATA0 */
+				 <K1_PADCONF(102, 0)>;   /* QSPI_CLK */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		qspi-cs1-pins {
+			pinmux = <K1_PADCONF(103, 0)>;   /* QSPI_CS1 */
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
+
 	/omit-if-no-ref/
 	uart0_0_cfg: uart0-0-cfg {
 		uart0-0-pins {
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index af35f9cd64351..47f97105bff0b 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -823,6 +823,22 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			qspi: spi@d420c000 {
+				compatible = "spacemit,k1-qspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0xd420c000 0x0 0x1000>,
+				      <0x0 0xb8000000 0x0 0xc00000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				clocks = <&syscon_apmu CLK_QSPI_BUS>,
+					 <&syscon_apmu CLK_QSPI>;
+				clock-names = "qspi_en", "qspi";
+				resets = <&syscon_apmu RESET_QSPI>,
+					 <&syscon_apmu RESET_QSPI_BUS>;
+				interrupts = <117>;
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 
-- 
2.48.1


