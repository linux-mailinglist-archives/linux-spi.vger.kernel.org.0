Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3ABF2AA355
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKGIOd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:33 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIOc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736871; x=1636272871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zXOUn4luDWiHlH2xEcGo8nQgZxG+Qoj008WbUn42J5Y=;
  b=crzFMs3XDaG1cU78uSsHo8c1cOoAik6QKMOG4iMG67YtD0Yn7FD5eBQU
   uAvnH/SDOfS0zI1+biTtDmv2JC26+Fw1tvJKPgdG0ilgfr2fwELCNuzLw
   aXe7z8NDl3UYqs7ulqd//G10jT9YUb1kGIBp2OFs2Aln5/gqF4YAa0rBD
   SideB1a3jauIoLlxfES6SM+PxN6m8yuB+ipgB5qekOfQNMnrWNou9s+jH
   yYJR4A7nbFyq9e7PPYELrmdV5vI2nIzb3bcq1ESkadC9ferEJvT6p2Q5q
   E2SonPf3h1wnvjHYrXdc4rmORG9DLwAQrsGx7ullwVGXJRf8KZ6oPqXvn
   w==;
IronPort-SDR: S9Edc8I9RiGkZAvf3c1nFzN0b6n9qHT7xyK5WQXGchHPp2zVSYE5F7lNRDXGD3rG70NqYpC4bt
 2/NW8eA8O7UGrqyks8PGn/18r+bV3kF7ZoLfWojzNLuIn7RQsiPoyXzaJa39SBYCijT1k5dPtw
 PTnibuFVkkWwh8li1ByLBWKLH7JpazkhmdJYP73Y5RLBukhLv+XvmVBfrhOHKSFz8QpnnFy3FJ
 hv0+sFx9vYCyNpO1F+Nm2nP77s1c/cz7XtPK0fJVAyZViYodktQvptyxgvoG9+s6BZHXJQhYLc
 KC0=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564361"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:31 +0800
IronPort-SDR: iTOv1qbttoj9oV6ab4Q2KjBD6lMVP4SQebjOckLOn9CY3oaqDXbuBBF73QyLQa92mfVZYsRNfL
 n7clU7NC+LzXc6RehVTvXxHAD9ozVD4eFTTA9rDgNIDou4+HBPMJu/NPfQihfsrqn1ggQpUh9f
 baFGLv/UBYGKhG/Blxuv74vWnZuOht+FwlteVSyAvCfWEcO/HJ2El7omxwOUX2Xn/RVVGT0Xyu
 mQfnqU1EVrTdyhpP+c8HCqnwdiGrDUw4TRDEQhiscbuYYzbs4ZB7KhuIq4TNVOuVMhI8CTyRBP
 HTJtx5HEsLv8LpquX8OFlYdw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:22 -0800
IronPort-SDR: 5bMS7b8/oLSlphvaD4IRhBm6Eo/58VNOp/fpJO2woBA813YdnNsPHPyJK/Z/P5Qjuvf5fIKXww
 +hPXtu1SxJzByuUOQ/9GIaSKjctTWWsy2g3FaIZMcFDPX5XqJTMQTKHQldpOI/+AQzkPQddNjN
 nM8wKRoWn59ma3g0/DCaPbkXtaaxsTWHTXKmGM3YPZk/xAfSVJAhfiTaHkKcAoxX0QD5ShtmUR
 9+mCVSuTOeM6wmBgCiaK4xvFT9GmfT2ZkxTHkPv9DxFfMkqn+T3ghAnlBxLxwx/ArefX6JBG8s
 NPA=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:30 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 03/32] spi: dw: Fix driving MOSI low while recieving
Date:   Sat,  7 Nov 2020 17:13:51 +0900
Message-Id: <20201107081420.60325-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix for the Synopsis DesignWare SPI mmio driver taken from the work
by Sean Anderson for the U-Boot project. Sean comments:

The resting state of MOSI is high when nothing is driving it. If we
drive it low while recieving, it looks like we are transmitting 0x00
instead of transmitting nothing. This can confuse slaves (like SD cards)
which allow new commands to be sent over MOSI while they are returning
data over MISO. The return of MOSI from 0 to 1 at the end of recieving
a byte can look like a start bit and a transmission bit to an SD card.
This will cause the card to become out-of-sync with the SPI device, as
it thinks the device has already started transmitting two bytes of a new
command. The mmc-spi driver will not detect the R1 response from the SD
card, since it is sent too early, and offset by two bits. This patch
fixes transfer errors when using SD cards with dw spi.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 841c85247f01..c2ef1d8d46d5 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -137,7 +137,7 @@ static inline u32 rx_max(struct dw_spi *dws)
 static void dw_writer(struct dw_spi *dws)
 {
 	u32 max = tx_max(dws);
-	u16 txw = 0;
+	u16 txw = 0xffff;
 
 	while (max--) {
 		if (dws->tx) {
-- 
2.28.0

