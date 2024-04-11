Return-Path: <linux-spi+bounces-2301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8708A129A
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CA28532D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4514885A;
	Thu, 11 Apr 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na0gyCO/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3F145345;
	Thu, 11 Apr 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833760; cv=none; b=BgJKM7c3ff+1/EcEw5qvxRZZHDOIutdlFJ6JApYkQeWZ4YvPuRdvvpLJcT+MyWUg2hAA1KCy3deSxlgJq620T8iP0rpCdk1fAlXu/fkuKe6G5hQLYTuXBNFQQb8iObXD9wSFqLpX1jGOHYEShOZkoqAlCSRfQJ6udcPm60xzO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833760; c=relaxed/simple;
	bh=VQj+YdLvpNHAMy4QC//a/V/gYG+Gm4qb1+KytslFy6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbGVbCEHyBGozmivLSRHShYamGKVmU6zrczevDFwbVMKFKbchsZ7HWHZhftBKmrEvGBOn/KxfqRi7FFzzTjt3JA56YjBqWZDt5F8dcPUSmr+pNw1+REL1RQ1J8PlEwf+wRlhi2zC1FGoaSOnvep4ZAk4z0Y7wZKlC6hIafXdhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na0gyCO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD5C433F1;
	Thu, 11 Apr 2024 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833759;
	bh=VQj+YdLvpNHAMy4QC//a/V/gYG+Gm4qb1+KytslFy6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Na0gyCO/pNIJ4ZN75L541vv3D2PAG/RWf+jqBikETwU/i9g3kNz3TBdbE9kPt5eDF
	 5omKAcGzdtwZBAsq75Oj50gZ2BIjLBnzRSJ6m3TwJzKGeOiy5/PudmZ9IRvuWseHWh
	 jjEFjb9Yq+VHO3xn+RdjAwVWiZk3LGz0DiQoP3Ki9gJ1QRbWIywSUqkXu6qjW5oPgz
	 5Lnt6UR9k6YMzBOWrPPzGKqHgPt9jiGJ5Ey8Sw1BW46PP6MnSI0W/etr0TBdovwVHK
	 0A8TJ8twm4PpdkKt8+WcU4Xo2UG2gOMjB3GqnZEP48HsI6ImqWLV7sMX7ubDi5Ot5d
	 hVyRDxAPeTflw==
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
Subject: [PATCH 2/3] arm64: dts: airoha: add EN7581 spi-nand node
Date: Thu, 11 Apr 2024 13:08:37 +0200
Message-ID: <16ece7e5f9ebd4a2485ee03401577fe136075710.1712833493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712833493.git.lorenzo@kernel.org>
References: <cover.1712833493.git.lorenzo@kernel.org>
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
 arch/arm64/boot/dts/airoha/en7581.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 5c4bfe3e1e5a..d2599cbb0fac 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -159,5 +159,22 @@ scuclk: clock-controller@1fa20000 {
 			      <0x0 0x1fbe3400 0x0 0xfc>;
 			#clock-cells = <1>;
 		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7581-snand";
+			reg = <0x0 0x1fa10000 0x0 0x140>,
+			      <0x0 0x1fa11000 0x0 0x160>;
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


