Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF69360C3F5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Oct 2022 08:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJYGqP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Oct 2022 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiJYGqL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Oct 2022 02:46:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63214BB73
        for <linux-spi@vger.kernel.org>; Mon, 24 Oct 2022 23:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680363; x=1698216363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vwSXk+ZageoOmaXcui41glKe0O9B57/gQ/VRRepddXA=;
  b=Iqbcb5oTFpezDCT1tnnyMSlCgzrclJX8OmPCPg2exkDpZYrliiloawVz
   pa8PFFhSh/sPxr1roFxelPUVVa1TWkck1jtZQODqXh8HBsUQIOsBWR4Pg
   nRMXQajn+xc7DL7skUEzjoNuJr36rXY/zvbbSJVnjKqO8yuAx8AmRKpdv
   VTKuX1sHroHy2TQdolr6AGgHg+LlOH3RPKJMvGXcTykzx89JnSWcOLHHu
   pYDywuzvKcBW3NKL5yLZGs4sX+UvFUntZJBsHB21e7qVVP22AllxkTIXq
   Gpz4hrgCHjoL9vyfBu9UjJ5MxuNSbmcsMLOj/7y46yHhbI32Olq4fPGkR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290904768"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="290904768"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="582670121"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="582670121"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2022 23:46:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0671E107; Tue, 25 Oct 2022 09:46:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org
Subject: [PATCH 0/4] spi: intel: Add support for SFDP opcode
Date:   Tue, 25 Oct 2022 09:46:19 +0300
Message-Id: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for SFDP (Serial Flash Discoverable Parameter)
opcode to the Intel SPI driver. This allows the SPI-NOR core to query
the flash chip what it supports.

Mika Westerberg (4):
  spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
  spi: intel: Implement adjust_op_size()
  spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
  spi: intel: Add support for SFDP opcode

 drivers/spi/spi-intel.c | 78 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

-- 
2.35.1

