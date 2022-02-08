Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F04AE415
	for <lists+linux-spi@lfdr.de>; Tue,  8 Feb 2022 23:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386531AbiBHWZs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Feb 2022 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386535AbiBHUve (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Feb 2022 15:51:34 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0E8C0612C3;
        Tue,  8 Feb 2022 12:51:32 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,353,1635199200"; 
   d="scan'208";a="20363149"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:51:31 +0100
Date:   Tue, 8 Feb 2022 21:51:30 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Prajapati Rameshchandra <tejaspra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Mark Brown <broonie@kernel.org>
cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] spi: spi-xilinx: fix for_each_child.cocci warnings
Message-ID: <alpine.DEB.2.22.394.2202082148490.52266@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: kernel test robot <lkp@intel.com>

After for_each_available_child_of_node, of_node_put is needed before break
and return.

Generated by: scripts/coccinelle/iterators/for_each_child.cocci

Fixes: 3973536c4560 ("spi: spi-xilinx: Updated axi-qspi controller driver")
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v5.15
head:   1183ce490adb103e5e569b8ebd74c50c885ddc05
commit: 3973536c456079bf3d09e9a97bf33d29422b183f [861/872] spi: spi-xilinx: Updated axi-qspi controller driver
:::::: branch date: 7 days ago
:::::: commit date: 7 days ago

 spi-xilinx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -693,13 +693,16 @@ static int xilinx_spi_probe(struct platf
 		if (startup_block) {
 			ret = of_property_read_u32(nc, "reg",
 						   &cs_num);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(nc);
 				return -EINVAL;
+			}
 		}
 		ret = of_property_read_u32(nc, "spi-rx-bus-width",
 					   &rx_bus_width);
 		if (!ret) {
 			xspi->rx_bus_width = rx_bus_width;
+			of_node_put(nc);
 			break;
 		}
 	}
