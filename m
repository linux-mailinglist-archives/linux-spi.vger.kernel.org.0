Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF02A37CC
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgKCAeG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 19:34:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:25247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgKCAeG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 19:34:06 -0500
IronPort-SDR: eq0scj/uCsSvlIK1VVt1x795Pvv5ov73+NTfMwIuLMjYENMVoXuWz6mkO1yE7yAZHGdORZ4Tqa
 Rnpq4tywEO2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="166384287"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="166384287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 16:34:06 -0800
IronPort-SDR: xbRQgWYrcrOuBoJfyMtFIq//3D72oJFk5fUeMIoJaOSek8AZq7zsaD5ZO3DeEPEjvEH7K1hGmG
 DZ0XEXWFmZBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="357499912"
Received: from lkp-server02.sh.intel.com (HELO 9353403cd79d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 02 Nov 2020 16:34:03 -0800
Received: from kbuild by 9353403cd79d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZkGw-0000FJ-Vh; Tue, 03 Nov 2020 00:34:02 +0000
Date:   Tue, 3 Nov 2020 08:33:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, broonie@kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au, clg@kaod.org,
        bbrezillon@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: [RFC PATCH] spi: aspeed: aspeed_spi_get_io_mode() can be static
Message-ID: <20201103003331.GA44379@4742e760afe2>
References: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102075213.32404-5-chin-ting_kuo@aspeedtech.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 spi-aspeed.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-aspeed.c b/drivers/spi/spi-aspeed.c
index 795f67c9ca6ac3..6b067dee833246 100644
--- a/drivers/spi/spi-aspeed.c
+++ b/drivers/spi/spi-aspeed.c
@@ -144,7 +144,7 @@ static void aspeed_spi_chip_set_4byte(struct aspeed_spi_controller *ast_ctrl,
 	writel(reg_val, ast_ctrl->regs + OFFSET_CE_ADDR_MODE_CTRL);
 }
 
-uint32_t aspeed_spi_get_io_mode(uint32_t bus_width)
+static uint32_t aspeed_spi_get_io_mode(uint32_t bus_width)
 {
 	switch (bus_width) {
 	case 1:
@@ -295,8 +295,8 @@ aspeed_2600_spi_clk_basic_setting(struct aspeed_spi_controller *ast_ctrl,
  * content is too monotonous, the frequency recorded in the device
  * tree will be adopted.
  */
-int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
-				       uint32_t cs)
+static int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
+					      uint32_t cs)
 {
 	int ret = 0;
 	struct device *dev = ast_ctrl->dev;
@@ -432,7 +432,7 @@ int aspeed_2600_spi_timing_calibration(struct aspeed_spi_controller *ast_ctrl,
  * of its related flash size. Namely, the total decoded size
  * from flash 0 to flash N should be multiple of flash (N + 1).
  */
-void aspeed_2600_adjust_decode_sz(uint32_t decode_sz_arr[], int len)
+static void aspeed_2600_adjust_decode_sz(uint32_t decode_sz_arr[], int len)
 {
 	int cs, j;
 	uint32_t sz;
