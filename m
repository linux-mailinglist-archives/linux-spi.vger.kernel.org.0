Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1F2CAE39
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 22:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbgLAVOM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 16:14:12 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14599 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgLAVOL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 16:14:11 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6b1d90000>; Tue, 01 Dec 2020 13:12:57 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Dec
 2020 21:12:57 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Dec 2020 21:12:56 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 7/7] arm64: tegra: Enable QSPI on Jetson Xavier NX
Date:   Tue, 1 Dec 2020 13:12:48 -0800
Message-ID: <1606857168-5839-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606857177; bh=GInpj6T70m3778V+Yp4yxBHh4Eak5vnqih3rso+ksSM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=eW8Npzw8B40MM4rQ3VDIkyU+x34hszglC4gYigZsT0HqtmQRoY2GvArnxxWNWTOV5
         T/Kc5S9jgxphi8uN2BX/dWllgBTNa1UYw+DHtvYbzXcWhog9dmgjqL0VLzrPE3aLKS
         XOQ5Q4E0PaIcqLae1OlhZZoNzzrIC99pGuQofPBYCPvpHBgiAL/5qW5/Gd0w1pkKSU
         26dDPvy9mXcFh60kzBENWi2wpKRlSVGmjLTFtOGk+EXGRGetlNTwuWbs1SfoKsZ+5r
         /D0LcTkA6bTp5okfC8nyd94My1ycDtgzzQxkmwAZfYPiq0V9nwHEv00SHABnFbvb0g
         6f58HXHk8cXEQ==
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Jetson Xavier NX has Spansion S25FS26S Quad SPI Flash.

This patch enables QSPI on Jetson Xavier NX.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
index 7f97b34..f1053e7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000+p3668-0000.dts
@@ -100,6 +100,18 @@
 			phy-names = "usb2-1", "usb2-2", "usb3-2";
 		};
 
+		spi@3270000 {
+			status = "okay";
+
+			flash@0 {
+				compatible = "spi-nor";
+				reg = <0>;
+				spi-max-frequency = <102000000>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+			};
+		};
+
 		pwm@32d0000 {
 			status = "okay";
 		};
-- 
2.7.4

