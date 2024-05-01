Return-Path: <linux-spi+bounces-2679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C508B8BAC
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 16:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF8B1C21339
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 14:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63112EBED;
	Wed,  1 May 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd7iah7Z"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B512EBCC;
	Wed,  1 May 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572422; cv=none; b=Xaq9VIYezDUv5dQJqf0tdFSQqTHTcmwwHPzRDYotI1KnnfnBVika0nOUPwTksHBCF4XIoAxFMQQrRaix9FDlURWp60w9yYfRdzkkU4Yb5DRrYCX2sbN4PPBUQS4nvjBc1Q72lMsqOKaqMKnz4Bmx/hCJXvZzrv56KKUvg2QspMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572422; c=relaxed/simple;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjfIYoTTUnbRE3py5C4kZHvIzC3308v/Dfg9gvl5ZW/Dw0o5d85cGtQoKobXGu/YVtZE6MjBoLHDwid8kIEVrR3LOjgr2MFK1on+v5KQGsP2lFhEh7OOdsZ35402fhMFXlAxv024YiweSAWw1wFZttaoGOUhW7j1P1gPZBCq6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd7iah7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D45C072AA;
	Wed,  1 May 2024 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572422;
	bh=mEwTjhCKwRP0s6SVX+aqKXH0QKJm+wD0+J+IOMS/bmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gd7iah7Zms4hySBsHX/4/Qm8LeeQ0kq7p0/11ni3c48vj+ePNovtOlJxBSOCj405M
	 Int31NlZERn+D6or6cSX0bCGfIXdlchNzKkbH59Bhc8rEO7k+UCIf5qUDewg1YhcbB
	 fJWELDaPlznGSOZcLXQCvL2FcjC0G34GAp+XxVuqncfRVbK8ddKgLYMAz9v5YWcDux
	 V1asXtsKYU2nVgyClgDqtvok4zsEf9KiIYxlcsrt7kF9pT7HuXN7AGXxvzUDgcUgMr
	 o/d2xUGKVG+whDLqTzktwLO//iZT6NL5kWa38VtSRfdKXnqU8aJpqPou4ijbIGYK2i
	 ETecIjHf6uBng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	conor@kernel.org,
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
Subject: [PATCH v6 2/3] arm64: dts: airoha: en7581: Add spi-nand node
Date: Wed,  1 May 2024 16:06:42 +0200
Message-ID: <189790802f3ba1a80c4ab5e064b2425e5a360098.1714571980.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714571980.git.lorenzo@kernel.org>
References: <cover.1714571980.git.lorenzo@kernel.org>
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


