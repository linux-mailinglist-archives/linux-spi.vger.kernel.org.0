Return-Path: <linux-spi+bounces-2391-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F58A7C7F
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E312428220A
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B64B653;
	Wed, 17 Apr 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZZdPovF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67369DFA;
	Wed, 17 Apr 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336416; cv=none; b=r7aJlXd2qsER0M9mAyb5/mXd2QFS7do9/9BBvZ0Ag9urEjY65D5sclOS1OFEaA1NsT6K3SoYUDb3n8lUnuI0jpBQEgzJPFy+CDaAt+ghe3ovjAp1lWCsUtvkLjV7EhgpWxewuX2eMKeWyJ3cy7m1uj+zrKLLi4A4+If+TbgNNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336416; c=relaxed/simple;
	bh=bqF+h4NZ8hG/kLT9eXCgWtdxJRiX7vstn03+7psmioc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff1lurK1nCIsYXsw75yPOuwVTgFUB78LCLacYdUmrlvDVfCCetBXgHBxh13MThKxabSuLumftNmhcgNd4MkA0tulRZ+/C8dw2D/ji2a51vBOyECHSFIU/h9z3r5bslrJGEKQ6DUPql7+GcEmKBb7x/SYnfNwtvLHPGYEoaLsyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZZdPovF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B43BC072AA;
	Wed, 17 Apr 2024 06:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713336415;
	bh=bqF+h4NZ8hG/kLT9eXCgWtdxJRiX7vstn03+7psmioc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZZdPovFTN0PDf4t2dnwTdQF18fw8U/xqD5Pc1+YKBDZibfBDAk102t74PJjIG8pL
	 wNII7e+DxmhkySdYVHoZJyLjpgsi2hW1jiBRz7rSP1Mjkr94EAlkHDBZ4Qu6C4GfrT
	 rXIGLViYVZcAOfdX+2Fnnr7fWkaiuP20zCKx1XfGnuJUvcMO4ZOeVEw456zCydKjwI
	 zSEx6wsaYuIQg6NcxL9iYLA/KnVIIlnfiXk0jAnx3ox+kes3AzqFzH/oDGUVadwP3w
	 QOMR+07fAN2rlDL6zj5sR7CymeMvtkfelAFpVBk55A9TkVj0zcwwYZ+rH7ZrtyeWRL
	 vcd3ZC5czu7zg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
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
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v2 2/3] arm64: dts: airoha: add EN7581 spi-nand node
Date: Wed, 17 Apr 2024 08:45:51 +0200
Message-ID: <df7749ec0a85a6b0d5a9851bec2d273f2b6e362e.1713335916.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713335916.git.lorenzo@kernel.org>
References: <cover.1713335916.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the Airoha EN7581 spi-nand node in Airoha EN7581 dtsi

Tested-by: Rajeev Kumar <Rajeev.Kumar@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 5c4bfe3e1e5a..8affe1c70c7a 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -159,5 +159,26 @@ scuclk: clock-controller@1fa20000 {
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
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
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


