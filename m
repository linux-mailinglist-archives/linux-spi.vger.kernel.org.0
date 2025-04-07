Return-Path: <linux-spi+bounces-7407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8FA7D440
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C9D188E086
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF8C2253B7;
	Mon,  7 Apr 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoQuQzVX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B742253AE;
	Mon,  7 Apr 2025 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007730; cv=none; b=SYN90IJld5L8ZEMV1m+8CYMEY+M5XuAz6+OLMl8o+WLbOwudMHjU5ZtLEhET6mxf5YsWLzaqxGQPXV9O9JWrfXAXuwSVBn720zMWTjCrgh4gKjuiDbeSRhr5IeRM4dclHpDkd5plC88xD1RYMAGFyEj/HNovnnhORsGMuJn5GNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007730; c=relaxed/simple;
	bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amRx3srYkMS1ODymytbTOp0B7OU6YfAeM4YzicIuA6i8acmtY2UgaudyO3uWZsYLEt9qR9q2rF5gokrPd3GCC7iRKISo+ZlTf/I8C7V1HaQ2tgg4pfDDEjvuB/++WLQ9scvRNllm4QQhRiJJBbvsLyi3Ca7Vzr6OHE+LfLKxYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoQuQzVX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so3333861a91.1;
        Sun, 06 Apr 2025 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744007729; x=1744612529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=GoQuQzVXnSDQQHaUr+X1VBukmVpkEqYfJCUKSrwJ89l3E6j8nv4TZi0kypC/E1iT7w
         LZImr/5OtwPNwYv0kGIlFgtuilzZjWXmt1V1lqISMMJAjGAKOVvSGy+Vgvzk/DPi59YK
         0zZE7OG5kUe0O3RJ/3U/aS0S8LjDNzGkdJKLWQ4NRN/LJGYNz+YLL8xUdpkU49z3XfnJ
         HCiOxJvJ8DqyMVoTtSpctFApAfroeoTPSdf8gQXjg7wMt+uZHrYvJ2Es8nF31JJp59fQ
         iQ0cuCQdOFsrXxLwXaTZVUoGGB1yFZdYmDy8JyIZyzugNsz18Rf6WH689mxZAxL4QHnp
         8mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744007729; x=1744612529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYhIc8nI7TQrbMQ5ehdUi9XRR8BUa9kFTApEz1i6px8=;
        b=p/y6KsQc3AMHibTHb2cZfLPoqtyeh7kTcuvQJRMaXekFQkBN4oLMsRi0mMZKzfiI+1
         zmpBBEDM5eJTbidzgxtJM8GA7VQjPUWkVk4yRXoGwut0v+0KHCbVy/tJ1o1rEEvT/ac8
         wqKbMBXDVUzwZGshSV4wI6AT65kzLJN+PVYM33NRhp9/IyIQgXzqniU5waM1rg/BV1j0
         1jE9Dly5xP7qSQz3LhQrauS3qHGVwRmuVamLREpCz5Q4fjfaYuDsKeDibMV0b+VFZXeH
         xeE0nteSqtorp3GaE1bleI3zs/PFz1oJZW+O24r2WE7nQFD5igN2AZ6/xG943PJrmKCj
         3d9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgFiV4JdWfsceaHF4dVy8V19Ia8yQ61jGLES9AOZwumlf8tiN7Y+0wFGbT2jyiJqxz4BV+m3lR4dxWzTU=@vger.kernel.org, AJvYcCX51Qy0xqVzWtruKqQDXA+rHscDmoB6igft0V8le/tLbuaRbqXfGNmSmqqKf6TssfnLsV0B1XswWnsA@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaxo0Utm3xX7fN659kICtc3eIUCAyZ5nBO7JGpYxBXpoVbgJE
	iEtTey/vZqnw4dO66xq5EMa143T1X4+hU54O4VDCaMUbNQtos7/y
X-Gm-Gg: ASbGnctueW01NK/P7M80xSmM446XEoOuqDU3GSAfx9S6ZJet5YrgAr2HQeIicEsuQVF
	mlxkbGPSZ5VXoQ0581WeLt9vMjsZjv9iefUZUSVs1wip2pLKJfnf8B7p1SbQQjMIhQ8dZ8/0cRv
	iJ2d8s6L/pfnuO5wHZ/lWnIgso3nf+0EkmODfMtgawygbdbDbAjOnQ4I8IwtJxA0XBGhZ+84M64
	eiwQEUqZciq2eu7YsX9myZgeEVt9v7ikMHu4msmmBU5D/tt+IcI/u9Sq0k+OCQsuBc425m46nx9
	p/AS7yF68WH7HNoEGEhVJ6BWYCHfiIcedHhi
X-Google-Smtp-Source: AGHT+IEOZv/5BU5DtfI0kqmCTpjbskhnz9UwTHMxtKxMAXxrUs6NBY985DM+w/yiSsTGLeLjCsEYhA==
X-Received: by 2002:a17:90a:d606:b0:2ee:c6c8:d89f with SMTP id 98e67ed59e1d1-306af71d944mr11933303a91.14.1744007728522;
        Sun, 06 Apr 2025 23:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([2001:250:5800:1000::610c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983da691sm8048044a91.47.2025.04.06.23.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 23:35:28 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Mon, 07 Apr 2025 14:35:13 +0800
Subject: [PATCH v4 2/2] riscv: sophgo: dts: Add spi controller for SG2042
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-sfg-spi-v4-2-30ac949a1e35@gmail.com>
References: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
In-Reply-To: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 sophgo@lists.linux.dev, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
 dlan@gentoo.org, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744007714; l=1524;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=bsOb61YGYomuONd3drp4jb88EZWek6I8D8vdw/YFqjA=;
 b=NJH8TpWiMW4r06WrPW4gxUE+TCU5HZSZXBlR3ljOxPFklJJaLgR52pUKwZe9T4LAOIjOMf7QK
 kowq5MZbB3oC1jnWhE+PHAwndhoVtcWtlfI6l6C42zbkuA6xE66e3bw
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


