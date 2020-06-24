Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77720698E
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 03:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgFXBfc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 21:35:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:13602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbgFXBfc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 23 Jun 2020 21:35:32 -0400
IronPort-SDR: l9o2OuhBsHckxYLa+1MIsvzRIZ2Z8Nx02FDwA2rM1HFh/A3GO71ef+FCmMJkESbqAugAzuKehM
 MWGc7W4WEnSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141785212"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="141785212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 18:35:31 -0700
IronPort-SDR: HRUn7XNkzjdVGv0MDWcXUHdFXAqL+VhUi0Ym/KHPJLpYLgkwAGWzbtJ1Z1pF7kwHeXCnLl0jz0
 11WHGL1FPZnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; 
   d="scan'208";a="452459689"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 18:35:29 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, yilun.xu@intel.com
Subject: [PATCH 0/2] Some fixes for spi-altera
Date:   Wed, 24 Jun 2020 09:31:24 +0800
Message-Id: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Two fixes for indirect access support patchset.

Xu Yilun (2):
  spi: altera: fix driver matching failure of the device ID "spi_altera"
  spi: altera: fix module autoload

 drivers/spi/spi-altera.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.4

