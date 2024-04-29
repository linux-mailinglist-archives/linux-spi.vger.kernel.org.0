Return-Path: <linux-spi+bounces-2575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11D8B52DE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21521F2130C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F09E16415;
	Mon, 29 Apr 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2UtIac+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D515E8B;
	Mon, 29 Apr 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378410; cv=none; b=pljEVI2Eq/yYsDAsM70qC0fhoBXz+rynNvICqEeyShSBJwhCpe5LyYkvZGrH3SE05IXFP9PSK8sxCunwzkWlAHr9wVKgCc7oykg4XV/rP40GaSbCLQfaXaSwrIVe0V2JNVpq5eFMPmGrqc2EvC2uJOlBeIUj+sBBwktegEm/Tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378410; c=relaxed/simple;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpK90g0S2lDniYRaFq1LtAisGNHDEogs2ODmC/IRAnO9tgHVUiIIiFKSbLQivexFS5WaRqd6/QmalR5wUE6l7gorcI50LitjQWgPhSaxQURVzvQerVJgLm2LQS2ARx3/Wiz+wmvipzP41X7+mAAOHGOrYRRex70Q49MzlGhgxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2UtIac+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3BFC113CD;
	Mon, 29 Apr 2024 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714378409;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2UtIac+SOuEMBPfU99SXXIf+1cpf740a61Q/ZHZbsSHX/moEXWgr1ClzX3UoycCz
	 6DVGKnA+yfbxNBz6oc0k+rMuzaj7SBH3yO6E8aY+3qP6jXdgNk+CNBEm74bz/t5FBo
	 vVhSIfHXacvJcfsC0NGBqjmVLfaBbKgam+j+XkdRdzZC3Ze6MtjGQFFJdQeK+O4InC
	 q9/LLR2MhvHkTn3NaVi++zYd8vf1GOVw7vPY/5IAsb+BCULAiUUUIaivDKw0GlZSFS
	 dDtPOTHwnglZE9Blgl7WMsNiIQzGL00dwBZ/ehjnkYn15f7bbMOu5PtEtVcGhU/mDo
	 CmgVZkG1mVdhQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	broonie@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: [PATCH v5 2/3] arm64: dts: airoha: add EN7581 spi-nand node
Date: Mon, 29 Apr 2024 10:13:09 +0200
Message-ID: <b18405037de9a014b9bb3fd2137fe9d6a5db43aa.1714377864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714377864.git.lorenzo@kernel.org>
References: <cover.1714377864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the Airoha EN7581 spi-nand node in Airoha EN7581 dtsi

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 5c4bfe3e1e5a..98c2a86086e1 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -159,5 +159,24 @@ scuclk: clock-controller@1fa20000 {
 			      <0x0 0x1fbe3400 0x0 0xfc>;
 			#clock-cells = <1>;
 		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x160>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
 	};
 };
-- 
2.44.0


