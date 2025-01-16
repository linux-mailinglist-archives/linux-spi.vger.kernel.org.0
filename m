Return-Path: <linux-spi+bounces-6380-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA8A144E5
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 23:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FA47A2F37
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49E1DDC3A;
	Thu, 16 Jan 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhDo6Ujg"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA722361DE
	for <linux-spi@vger.kernel.org>; Thu, 16 Jan 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068152; cv=none; b=mCKlekwTwE1a4C10ueh8I2Ag34308/e0vFlIgZVv7NwHGfz2Idkhvx3vnpOClExCJVJEWhNEy1phcQR0lYC6txzBuB7qmJU00LRTr3Gz2kVzuUILQuJ+EHXhwMnFbjooCKpUFi0Ui+lNDfDci5VnEXuSBnBDHa6c2vEOCb6u2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068152; c=relaxed/simple;
	bh=itnHrqNHSm5DpYbOb1UJ0WRFSy/4BZ6dwcLlAkCtKJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEieTZ5U8ueUWBkWISsNxJJpLjKnxT9Lpld7crgRbqUqfvNBZ+e7gQQe+DWU+exCC/CAfMGBhHfXOHQ63C810I+GxGSV/vVUOU6Bzmz+DFvY+eD8OLJnu0iLcIlKPmQNbXWhph+QZ55osAe+Pgg9uFguteIGK7gqEJqqdmBhCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhDo6Ujg; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737068144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+quEYUkZhidwpAeLqq43u3BemjnbBw7+zBdpWqiraU=;
	b=nhDo6UjgeIKQmiyR5pQ04UEbN2zDRWdCs5UadY8A98Tt8cMQLdQHTnSjQ4xpH8esmUGDl8
	5ojOPwtNzMzbw2BhasYfr0heaIa6MfZn2n/NTMPtcTpA1+Fi00g52AYwjBANMjFl0Pkym6
	F6fwb0zfW4IJREt/5xrt1XB9n9LMuz8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 5/5] ARM64: xilinx: zynqmp: Add QSPI reset
Date: Thu, 16 Jan 2025 17:55:21 -0500
Message-Id: <20250116225521.2688224-6-sean.anderson@linux.dev>
In-Reply-To: <20250116225521.2688224-1-sean.anderson@linux.dev>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a reset to the QSPI.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 467f084c6469..5dac0542a48d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -986,6 +986,7 @@ qspi: spi@ff0f0000 {
 			#size-cells = <0>;
 			/* iommus = <&smmu 0x873>; */
 			power-domains = <&zynqmp_firmware PD_QSPI>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_QSPI>;
 		};
 
 		psgtr: phy@fd400000 {
-- 
2.35.1.1320.gc452695387.dirty


