Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B269477D35
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbhLPUPZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 15:15:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:51859 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233950AbhLPUPZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 15:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639685725; x=1671221725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3t7tVPDq17Bs5oBsrsC18t2E5pFFYQnWPZs/51fi/T4=;
  b=YCraedoUsoO+N0Sykzl2lcewZcexX/E3nV3UsQde0FVlgoz/CcBv+nsa
   vCqV5TL/3JNs+KkZUkbXHNunywZMjByVfNRlkiliO4JE8rnGLZuFC42Y0
   d5pL6x/vW2NbJ/E1WTGZF9NnGx4SCCGzoVx9pDpXE/yWcRYzFAqU1tT5c
   5PAtTkv3CDY7BkIkCzps1FR/T/N2f5b6oFJMmw5rjIswnncrUsznljljM
   nKtMoznQzfGrXCMKSyUaCHOthX685RKJjplrwmM80ZTjteTqLtZ26/CqE
   InN/wJ/rN6Y3V0vDDGqzuTGwYN/HOq8c1ZkHxUyCIaKr5HcwMGwe4RLmQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226873111"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="226873111"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 12:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="756228471"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Dec 2021 12:15:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxx9s-0003lH-V2; Thu, 16 Dec 2021 20:15:20 +0000
Date:   Fri, 17 Dec 2021 04:14:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: [RFC PATCH] spi: spi-mem: cqspi_mem_caps can be static
Message-ID: <20211216201426.GA41877@ee91f2b6365d>
References: <20211216111654.238086-21-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216111654.238086-21-miquel.raynal@bootlin.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

drivers/spi/spi-cadence-quadspi.c:1592:38: warning: symbol 'cqspi_mem_caps' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 spi-cadence-quadspi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index bc7ae56fe565fb..ca05ab4d0c5923 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1589,7 +1589,7 @@ static const char *cqspi_get_name(struct spi_mem *mem)
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
 }
 
-const struct spi_controller_mem_caps cqspi_mem_caps = {
+static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
 };
 
