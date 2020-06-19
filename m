Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB01FFFDB
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jun 2020 03:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFSBrz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jun 2020 21:47:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:64012 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgFSBrz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Jun 2020 21:47:55 -0400
IronPort-SDR: IJ4pmpQVXRlaVc2gTk8cNknBiA+XDWvfgeSin93KfYccS4DQePtbkGN3nWe4xUUKNyqSjacbac
 ESAT67G0E1ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204278275"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="204278275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:47:54 -0700
IronPort-SDR: EUqhV7ZkfPUwu4HtXvIy8HbnUxNQb5hyykNhnJ5hkW2AK/7g6uLik0QWqZ5Qiek3AU+pIUmVS1
 F8KYPqDQSFwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="263746034"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 18:47:52 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com
Subject: [RESEND PATCH v2 0/3] add regmap & indirect access support
Date:   Fri, 19 Jun 2020 09:43:38 +0800
Message-Id: <1592531021-11412-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Updated the regmap & indirect access support for spi-altera.

Patch #1 is an 1:1 replacement of of readl/writel with regmap_read/write
Patch #2 introduced a new platform_device_id to support indirect access as
         a sub device.
Patch #3 is a minor fix.

Main changes from v1:
 - Split the regmap supporting patch to 2 patches.
 - Add a new platform_device_id to support indirect access.
 - Removed the v1 patch "move driver name string to header file". Now we
   use driver name string directly.
 - Add Yilun's Signed-off-by for Patch #3.
 - Add Tom's Reviewed-by.


Matthew Gerlach (1):
  spi: altera: fix size mismatch on 64 bit processors

Xu Yilun (2):
  spi: altera: use regmap-mmio instead of direct mmio register access
  spi: altera: support indirect access to the registers

 drivers/spi/Kconfig      |   1 +
 drivers/spi/spi-altera.c | 127 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 107 insertions(+), 21 deletions(-)

-- 
2.7.4

