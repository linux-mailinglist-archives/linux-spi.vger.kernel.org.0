Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145D12B9202
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 13:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgKSMDA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 07:03:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54227 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgKSMDA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 19 Nov 2020 07:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605788066; x=1637324066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wf/FejK7z/uXHb5mg4MRAl9M/wAxMVeO8inZ9o+YmVY=;
  b=OG9OwEbFSpG5ychOL/p3o3ITZDA2zhE8TBTJNX+hiQXHznYZWaK7L5f4
   qRzwBY6ycxdjyxkYOV2gdIe+07hTjPhlonRYIgjEa8wevFxaHd04mqioo
   6QHNV3GR0vL/Hy4oH//cfRQ4jm7qmJiY3ccafLhMBsQOQKSwMoeHZ9D8q
   aZX77BxKEF44LXBrAOgI/Zye/Dl4/2h1NMfpYhmfPkZqgC4zCyvOAUWT8
   LE852WP6lQbtSQkcMxUIAL8PwNyPpjbpTnnTYxujMVE2sWHQpPJYvdThz
   dRQuXnK0uAY6ZeOM/eKx0DHrJvHcptbwy7Xg4TogDEf5Rjyd3RKVvikUH
   A==;
IronPort-SDR: N1tdo7cl+Csp5PBfq94U/uTYD6IpgqMoxDXuzbD5o2Zlv0w2ALzY+6PGPbyl6kSCaohethr9PU
 fR+vz8Ewe/NleH/HcjApSRIt77lxAYZBi0EQNPA/MWbHxvvvPU6m40a7/zShzveKd82H4ZmlTR
 SUxSwR79YRARXR3OExx5xqhNxkYUTVHqJMXLyTC5mdKlB/CyfZoseLtiKIzzOSJAkDRHFd3hP7
 1vf6Y81j8YMhjc0w6k+EF1DJguJMP0t+DF/aPVb/psb/pzy8RgJSNQWGZYWPb2pI7wurNUyDic
 BvM=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256574393"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 20:14:26 +0800
IronPort-SDR: Dnao9rPBKzXZ7Up6pFchtEMYdKpECWtURLOP4rCrZyJH8WsJNTkJ7EudL/8WrqiLv3h1AROixk
 RmZQiSdmigFaoNmW9BadrqshV4UEMMh/gudMXkqDot6rnbqEzOY3D5sV8ul04nWcJYgEr+xQmQ
 FgSHSt1hv4PxPABrKWPjwNDWwTD8xg1GfaS8gS8VbyXObpyvf+Jby/vE4FOZqaG9VfRvMqdxbq
 +uss2JQnWB74LMyh2I/pnwayNkE+zBfywSkVSed838zWu8lcnTeyaNCsI9yXmEtW0QHLljHsyy
 xAxh2CUDVZ5U6dXwrtoTmVw2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:48:50 -0800
IronPort-SDR: zHCA1ONG6vlEoq0lAABzvdDNqSfm49/xsrGsNDv7ydyxpA18pc49ucJDWTdQvIBiiAoYBXdV17
 d7bzRn25uklSCOxP+UJ/gabd4zPoC4OnnG+xrA7PEIordKorNWly5RdNug5JRuDQJGCdICWXu0
 RSGFKzyYQgpYBOWbIuqlHsLGKFbNc28D8Vzs9y8M1sNiEygw2Ak4DZ/xAwZG8LRRJsz+9Re4nY
 JckWw3FnoowHWMuZKB2aAMiEBR41QJFBTlWVQsDzZTRIDitVT8zgkueGpcZdl2cPC3qqHndIiB
 VcE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Nov 2020 04:02:59 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/3] spi: dw: Add support for the Canaan K210 SoC SPI
Date:   Thu, 19 Nov 2020 21:02:52 +0900
Message-Id: <20201119120253.390883-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119120253.390883-1-damien.lemoal@wdc.com>
References: <20201119120253.390883-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Canaan Kendryte K210 RISC-V SoC includes a DW apb_ssi v4 controller
which is documented to have a 32 words deep TX and RX FIFO. The FIFO
length detection in spi_hw_init() correctly detects this value.
However, when the controller RX FIFO is filled up to 32 entries
(RXFLR = 32), an RX FIFO overrun error occurs. This likely due to a
hardware bug which can be avoided by force setting the fifo_len field of
struct dw_spi to 31.

Define the dw_spi_canaan_k210_init() function to force set fifo_len to
31 when the device node compatible string is "canaan,k210-spi".

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-mmio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index d0cc5bf4fa4e..17c06039a74d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -222,6 +222,21 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_canaan_k210_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	/*
+	 * The Canaan Kendryte K210 SoC DW apb_ssi v4 spi controller is
+	 * documented to have a 32 word deep TX and RX FIFO, which
+	 * spi_hw_init() detects. However, when the RX FIFO is filled up to
+	 * 32 entries (RXFLR = 32), an RX FIFO overrun error occurs. Avoid this
+	 * problem by force setting fifo_len to 31.
+	 */
+	dwsmmio->dws.fifo_len = 31;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -335,6 +350,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
+	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.28.0

