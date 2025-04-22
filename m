Return-Path: <linux-spi+bounces-7704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6979DA95C1A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BE4165C74
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C991E9B1A;
	Tue, 22 Apr 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmdtY1xi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326D1E7C28;
	Tue, 22 Apr 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288860; cv=none; b=u8WHMxLliDHQ2MHK7uT0619n5ErY1p/YRuKF2bYXIhm72uOZMFUNH+b7uT244PiZht4NZfnRIwv5BD9Mrd8B12Kjp8mWl8FijiXA/4PgAP3KT68G8+0C+rT7vMWxVOh7dVAVHfNs0bJvBTi2+x+EWWpUWlrb6V+2np4FpjrvAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288860; c=relaxed/simple;
	bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YccGCoMfykLXW1AQNikWlNe3RQ17UyQnaxleI3nM48KyfUYj/5kXP+McbWFVm4by9U9T42uT/6voGKyDuZC8mdjQkkOKAZv39oImjPbsS9NRjcRzSIgzxfkS1IadMbT1Olbr71+NMEwgpgRGhKvrXuNsTAksJOOXzTDvmGNOvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmdtY1xi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227c7e57da2so40073555ad.0;
        Mon, 21 Apr 2025 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745288857; x=1745893657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=WmdtY1xiT9V/PFr+cntWuSLOIOOEHJYHja0M7utXDEg2XzI4vAQ4w7Bvo+Ap8Hes/b
         EYCMDT8nPJGNKL/Hj1DaCMPyX9ZQjq579d9dpgJF1rhOWo1UIxyCocUoZHrYpFLh8kIS
         55LxEfsUkOsfQkefzYaUEQZpG6uKpf0BpEf9qeaLAHIt4P07S0+pqqM16GPOrM8RMHF+
         W1lb2z4tItT43GV38hAIgQMBxZZkqR28nllQLqylUwpHf2X/W2UvL7N/XXs+XgRhZTxU
         WTGFQIqgyb4t9e3jJMVJeUEqF/r7lFX+2BR2fJZJ9NU8CzvLR5rtuUz+03EXufVNVC8f
         b27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745288857; x=1745893657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=wYV6f/Zymeil1nqFZOyU0XTVFOjzLjs7oS1qzGxLqDtcbSB9h/PTuYLU9spXn3G78L
         gSK1LbdvznqXkFOFnOWp2yyLh1GCUTMfeGdrT9ak4BytD495jCJkoyRGdAjZlllDiFZQ
         la/Do1WARiQQD62O39HmkdXW36tMfXls1F+Gk36LZ6lG5p0AUTs3Dz1CVaNk/1QzZx8k
         WEdX3uH6z28aoyyVnv0hp9lzU6S1HXsKe6oUXhCWYCZiF31U7GD+scwDuTpCsPeJsbHY
         LXm5J9UK709ZLEImPgwfc3H2MfokyYijnRvh9o6Z2DEWoyAUbn8UCROiQVec9ZQNb0Ob
         JoNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8W17yTmphgsl7P3pafVsq59YUiJcP1kayQMaqvKvFNB12ETXmNVqWAqIs1HaHodinYQhEI77tLVDOT6fzdIidOVg=@vger.kernel.org, AJvYcCVHzxV8JFXrFHgtjhTENfYmJBILsYh+iBJYs223wuZKTsdIUUSzqMdyA9sanrmMhLhYA8Z9c5j2wxcgMRg=@vger.kernel.org, AJvYcCWaBd42SCLsmM/d0+YPQyjx3sXJ5qKIDnvbbXUD3Ob/ndXXPXjMQ5LxKpIzE9FrM6shioBGtjzz2Hix@vger.kernel.org
X-Gm-Message-State: AOJu0YzgF8EcygxbH18RcbHn9aiAxFRygCqz4Auzegbk1wZl0GCk1rvA
	Zg4goWBinNPvj2wJfqWRWFsGQWkCr0a4kttIcCipfU3EZ73E8Kqsve7ePwPppxahEg==
X-Gm-Gg: ASbGncuH5sv9r+Sou9CZjBy6kXqDZ+wYfmB+79scyv0HPa7dTMjlHNZdl8tTUDntzOH
	wUAj70zrVlXN1IPjj16JlC6VQCWH+9o2C9T0zaYwR9Jb2j1ls/sdncrlrBBECtop9qs+F0pq/g5
	qxYx9LJw1u4QzbgdMmtI3wUP8iOkKbM4LeJLRX03H/ujxdHcTXn/blDn8PDIh3FLaFf2HMhl0Ri
	2VCGWUKRByCNcptS0L3eKpeMO9rvNlRR8XVZVu7cSToiVL5UdV+fBqWoo5mdG/QCvy2cVe7dICG
	62LAVj1x6p03ItO1LAmFK9rUeiL0pxXxAfHCLU6MHcJM1PQd
X-Google-Smtp-Source: AGHT+IExQ+ztUjssrgQSM1us5/55FyqKMbgSSaCY7W9HzLRHDBJHaDVv7TjABQFxbCdhKT4/A3fWOA==
X-Received: by 2002:a17:902:cecc:b0:223:4b8d:32f1 with SMTP id d9443c01a7336-22c53285bb0mr208982725ad.1.1745288856770;
        Mon, 21 Apr 2025 19:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ae9sm72962905ad.110.2025.04.21.19.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 19:27:36 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 22 Apr 2025 10:27:10 +0800
Subject: [PATCH v5 3/3] riscv: sophgo: dts: Add spi controller for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-sfg-spi-v5-3-c7f6554a94a0@gmail.com>
References: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
In-Reply-To: <20250422-sfg-spi-v5-0-c7f6554a94a0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, linux-renesas-soc@vger.kernel.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745288836; l=1524;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
 b=3nFg+D2YxLVxcX9tiCAuyqRm8Zv2W7XtJoeJ8rKEUvkzPCQBp52ycjtBSOgMztlNMYeeHMmsX
 cQ7rG2Mn4jBD1jpXGmi2Kk12Xwa/vhSD3KiPhLi8rrykE6nn/wTVzcW
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add spi controllers for SG2042.

SG2042 uses the upstreamed Synopsys DW SPI IP.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index aa8b7fcc125d71eec12b09493964d90f5dfed27c..ddde4c613c4734db191de500b016b322a9602efc 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -537,6 +537,32 @@ uart0: serial@7040000000 {
 			status = "disabled";
 		};
 
+		spi0: spi@7040004000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40004000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI0>;
+			status = "disabled";
+		};
+
+		spi1: spi@7040005000 {
+			compatible = "sophgo,sg2042-spi", "snps,dw-apb-ssi";
+			reg = <0x70 0x40005000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>;
+			interrupt-parent = <&intc>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			num-cs = <2>;
+			resets = <&rstgen RST_SPI1>;
+			status = "disabled";
+		};
+
 		emmc: mmc@704002a000 {
 			compatible = "sophgo,sg2042-dwcmshc";
 			reg = <0x70 0x4002a000 0x0 0x1000>;

-- 
2.49.0


