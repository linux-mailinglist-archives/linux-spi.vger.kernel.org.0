Return-Path: <linux-spi+bounces-530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546383323C
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jan 2024 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA4C283E21
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jan 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DD3D7F;
	Sat, 20 Jan 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdn8f/Os"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81493D70
	for <linux-spi@vger.kernel.org>; Sat, 20 Jan 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705714196; cv=none; b=ZkxmQCANkpE34iJC2UOf8+P7+boKA8KNZVvDvbV+CdEQMKJBkUH0oSaQx93MxTB4a3OMYRw+PhaxBaQ2gov4C3Gia1l+uBgvck+ic8ufgzVeIENTF9zsDzTCUzorzeRHcyhqXihBH6E3z57KA4TG8YVYNp+M3BFwaHLmzil+N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705714196; c=relaxed/simple;
	bh=US4/f7DtHifTyJjMsaA2zuMdo1/hmfd1fXIE8CYBx8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhnZUpbvHQW22oYPxMezZ7uw0Jqa4RqaxHDXJIJzh/6rukx0ZnjTQqYzdzMKW5A8Wtov0tzV4M34mzc49P9cTvlq/osYOzzEmQNJzsaSqPBelEkAGDQlGi0QG9KrYFolEwhmdBYKfzmbAc6OsJG5xPkoU/OzO3DaKTw4AIBXCC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sdn8f/Os; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-20536d5c5c7so849024fac.2
        for <linux-spi@vger.kernel.org>; Fri, 19 Jan 2024 17:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705714194; x=1706318994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcj1RqWVb7ASEjA2e/fTkkwzyy8aS20A5sYtXAZlaEA=;
        b=sdn8f/Os/3yG7W73uYVbLPC9EEJ1F+pxJiZG5XLfyGhcrpCeWe0ysEQSRHeE3y/vDD
         d1bKRmJiiBhbzDJIg0Z6yCrLjz67g4pAug/abSyvTT7UmuUuzbKypejsZzGAtyToqtP9
         F0mXmP32gBUAQXnc6RohOqnTNI6Oyn8gtn/G0iG0kW5Ytl+8f/WrnkMn8uQIvVQiIkwZ
         muXDkaJzpNqS4Akz4fmG5Zzj/pqOUZqmY2ziWvNVuVD0EuWs3TYCGcoAIQ39cjNQdNna
         9B8LDY3z7fp2s2ifOxS2V8XPriMlhQSXU8pwKrzPyRrNQOzRNcsTVHlnvySXszTUcG8l
         i98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705714194; x=1706318994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcj1RqWVb7ASEjA2e/fTkkwzyy8aS20A5sYtXAZlaEA=;
        b=lLYq54qkTzPEIOUbUq/ZIIRjoWbFc0LUs1OeYnpzk5+4S++dnfD0s34tgpv5Yek5AC
         M3SDf05kV7ZNLsdL160n63TxaZm6n51imHgj8g93jKzVDmWu+NtqkkWgrs+9EQqRDV0h
         Z59mBK08ilWvM4xGhRaAgEsrzqg1AaJKV3FoKvsVWMfHcU6OeX3Ji/MP2VPdqecLVnJ8
         6AJYmZZgwirV71OArRSOm8jW3Xj9olmaTlz/LsTtumCg92rjgG7owPsc1e0spA2aNIcY
         KuzfcWJrOjUXoD/I1fQKSuixE5UiUmLtYOpjtQ4P/X0ZiplQUYGw/7svzxQK/gglS3GH
         JMHA==
X-Gm-Message-State: AOJu0Yx+55yx4unrBKIjYLm5CPJ7ZErRiJaVfO1VrSIjYA5KPWp+GWnb
	gSz3qxIQzsOPH+Cs1qx0Uq2QkCtSK+EHMgnsA1aAjAlva0oWxOc13NYcU08mE5k=
X-Google-Smtp-Source: AGHT+IGhn8+HLMRqtKYZRNUVoodVl3V6xRiyc4pi0HMTeakTvQLfqysqG/v+QFQJgj+hdVgkkUnx6w==
X-Received: by 2002:a05:6870:b52a:b0:210:b1a5:9c9f with SMTP id v42-20020a056870b52a00b00210b1a59c9fmr499811oap.49.1705714193963;
        Fri, 19 Jan 2024 17:29:53 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id n15-20020a0568301e8f00b006dc6fbde692sm763928otr.23.2024.01.19.17.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 17:29:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: exynos: Add PDMA node for Exynos850
Date: Fri, 19 Jan 2024 19:29:47 -0600
Message-Id: <20240120012948.8836-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120012948.8836-1-semen.protsenko@linaro.org>
References: <20240120012948.8836-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable PDMA node. It's needed for multiple peripheral modules, like SPI.
Use "arm,pl330-broken-no-flushp" quirk, as otherwise SPI transfers in
DMA mode often fail with error like this:

    I/O Error: rx-1 tx-1 rx-f tx-f len-786 dma-1 res-(-5)

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index da3f4a791e68..cd0a452cd6b4 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -197,6 +197,16 @@ gic: interrupt-controller@12a01000 {
 						 IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		pdma0: dma-controller@120c0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x120c0000 0x1000>;
+			interrupts = <GIC_SPI 479 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_core CLK_GOUT_PDMA_CORE_ACLK>;
+			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
+			#dma-cells = <1>;
+		};
+
 		pmu_system_controller: system-controller@11860000 {
 			compatible = "samsung,exynos850-pmu", "syscon";
 			reg = <0x11860000 0x10000>;
-- 
2.39.2


