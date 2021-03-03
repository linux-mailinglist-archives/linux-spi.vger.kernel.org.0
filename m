Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36EE32C6E9
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451135AbhCDAaU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:4472 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357227AbhCCKs7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 05:48:59 -0500
IronPort-SDR: rJ1FY+Cqd3m7RP5VCLmiOAG+PBG8u8OckMn0yu0CVkC2Quong0jI0Tuug03b9rbVJYa2Pfnw0P
 dCN/Wba2DrVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166404618"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="166404618"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 01:16:54 -0800
IronPort-SDR: k6s+b6Bbde6pVZUL0UtJY3o1hMgHiCqfbIj6ucu+tm897WjCaG9xKzp6fG60af94FbKk6vZGdT
 bgPjVwbzDMwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="435147543"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2021 01:16:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F103F4; Wed,  3 Mar 2021 11:16:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 0/3] parport: Introduce module_parport_driver() and use it
Date:   Wed,  3 Mar 2021 11:16:39 +0200
Message-Id: <20210303091642.23929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce module_parport_driver() and use it.
Greg or Mark, since we have this series tagged, can somebody of you pick it up?

Changelog v3:
- added tag on patch 1 (Sudip)
- Cc'ed to Greg

Andy Shevchenko (3):
  parport: Introduce module_parport_driver() helper macro
  spi: butterfly: Switch to use module_parport_driver()
  spi: lm70llp: Switch to use module_parport_driver()

 drivers/spi/spi-butterfly.c | 13 +------------
 drivers/spi/spi-lm70llp.c   | 13 +------------
 include/linux/parport.h     | 12 +++++++++++-
 3 files changed, 13 insertions(+), 25 deletions(-)

-- 
2.30.1

