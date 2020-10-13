Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42028D1CC
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbgJMQJb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 12:09:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731502AbgJMQJX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 12:09:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE576561C3C11F7ACB8B;
        Wed, 14 Oct 2020 00:09:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 00:09:02 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 5/6] ARM: dts: mmp2-olpc-xo-1-75: explicitly add #address-cells=<0> for slave mode
Date:   Wed, 14 Oct 2020 00:08:44 +0800
Message-ID: <20201013160845.1772-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201013160845.1772-1-thunder.leizhen@huawei.com>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Delete the old property "#address-cells" and then explicitly add it with
zero value. The value of "#size-cells" is already zero, so keep it no
change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
index f1a41152e9dd70d..be88b6e551d58e9 100644
--- a/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
+++ b/arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts
@@ -224,7 +224,7 @@
 
 &ssp3 {
 	/delete-property/ #address-cells;
-	/delete-property/ #size-cells;
+	#address-cells = <0>;
 	spi-slave;
 	status = "okay";
 	ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
-- 
1.8.3


