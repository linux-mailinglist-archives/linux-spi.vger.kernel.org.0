Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FB1F6070
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFKD2w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Jun 2020 23:28:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:28223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgFKD2w (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 10 Jun 2020 23:28:52 -0400
IronPort-SDR: uSniKQ5GQ+UH6vlr5L1mns3KXoFgPxcOZGIgc/jVdh2Kp5iwDhH8tSuOiGiv93IOLgcCh01dIe
 +dsA3RNYU3rg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 20:28:52 -0700
IronPort-SDR: M2ZiU2/j1WU9UBLcbeNIrGyW4zW2JaG3HcrAQsFpMbz51KVDkvR/wA5WBFlql+BAUFBss5KzvI
 1ndmrWwUTYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="260587339"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2020 20:28:50 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [PATCH 1/6] spi: altera: add 32bit data width transfer support.
Date:   Thu, 11 Jun 2020 11:25:06 +0800
Message-Id: <1591845911-10197-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
References: <1591845911-10197-1-git-send-email-yilun.xu@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for 32bit width data register, then it supports 32bit
data width spi slave device and spi transfers.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/spi/spi-altera.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index 41d71ba..d5fa0c5 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -86,6 +86,13 @@ static void altera_spi_tx_word(struct altera_spi *hw)
 			txd = (hw->tx[hw->count * 2]
 				| (hw->tx[hw->count * 2 + 1] << 8));
 			break;
+		case 4:
+			txd = (hw->tx[hw->count * 4]
+				| (hw->tx[hw->count * 4 + 1] << 8)
+				| (hw->tx[hw->count * 4 + 2] << 16)
+				| (hw->tx[hw->count * 4 + 3] << 24));
+			break;
+
 		}
 	}
 
@@ -106,6 +113,13 @@ static void altera_spi_rx_word(struct altera_spi *hw)
 			hw->rx[hw->count * 2] = rxd;
 			hw->rx[hw->count * 2 + 1] = rxd >> 8;
 			break;
+		case 4:
+			hw->rx[hw->count * 4] = rxd;
+			hw->rx[hw->count * 4 + 1] = rxd >> 8;
+			hw->rx[hw->count * 4 + 2] = rxd >> 16;
+			hw->rx[hw->count * 4 + 3] = rxd >> 24;
+			break;
+
 		}
 	}
 
-- 
2.7.4

