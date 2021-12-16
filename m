Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6256477D19
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhLPULZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 15:11:25 -0500
Received: from mga18.intel.com ([134.134.136.126]:45350 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhLPULZ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Dec 2021 15:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639685484; x=1671221484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OQ5tkb+mKf19Kj1M+JmkRU5CzgVeDU43EXvvxHFHGWI=;
  b=PcpvfIiNV53TrZm2klx4lDdL/vHa7+3AWA1ewruvp/iLBMDtC4Ycr7J7
   Puyf7QGpD7XXBQeNsgSqY6tWOMO4ZmrsFuJPTI8KExT+zrwxdLliomzyq
   krYT67ddUzInMikV1/I6/ALXnLlsl/zXwIkCUliWdkPmP2YGvIyoJNX3z
   gHYbKbjmWAnaMNXmFEo/DwB1KIfTYV7XvoK0AYBToMFqbn4+5UV82SCUl
   FdvfZCy3v02vrn/KMQk9Ht8d8qJF2iwOBZYZzY0vVgLsXDuqtNH14uAiw
   i7AHTsKc1tKFi6ViWr5bigHkzw68yB6wWzreUWtnve/xCThVGKbiOZgzp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226446288"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="226446288"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 12:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="464817797"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 12:11:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxx60-0003kZ-Sg; Thu, 16 Dec 2021 20:11:20 +0000
Date:   Fri, 17 Dec 2021 04:10:58 +0800
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
Subject: [RFC PATCH] spi: spi-mem: mxic_spi_mem_caps can be static
Message-ID: <20211216201057.GA15223@5de6fc93f9bd>
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

drivers/spi/spi-mxic.c:446:38: warning: symbol 'mxic_spi_mem_caps' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 spi-mxic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 8f8530bd37794..e137b1ec85d40 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -443,7 +443,7 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	return ret;
 }
 
-const struct spi_controller_mem_caps mxic_spi_mem_caps = {
+static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
 	.dtr = true,
 };
 
