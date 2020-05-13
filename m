Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7111D17CB
	for <lists+linux-spi@lfdr.de>; Wed, 13 May 2020 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbgEMOlj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 May 2020 10:41:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:14940 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388395AbgEMOlj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 May 2020 10:41:39 -0400
IronPort-SDR: fMcQmLgdCp9QN0PT92LMvDpFxtMC1+thL3c5pb7SQx8oWTDIzh0mTiaywaa57clcE/RtjMoEyS
 UT0H8OvFCfLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 07:41:39 -0700
IronPort-SDR: z/LwwDOuZhSyS3rvaD9yFkLshHEjGog5cmKgX+mVSZttANYRsDanxeHRqykqKaOzpXjY2HC7j0
 n95DSdK68+Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="251271896"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2020 07:41:33 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYsZj-006RTr-Aw; Wed, 13 May 2020 17:41:35 +0300
Date:   Wed, 13 May 2020 17:41:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, fengsheng <fengsheng5@huawei.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Aditya Pakki <pakki001@umn.edu>,
        "wuxu.wu" <wuxu.wu@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] spi: dw: Use regset32 DebugFS method to create a
 registers file
Message-ID: <20200513144135.GO185537@smile.fi.intel.com>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200508132943.9826-18-Sergey.Semin@baikalelectronics.ru>
 <20200508193027.GW185537@smile.fi.intel.com>
 <20200513124422.z6ctlmvipwer45q4@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513124422.z6ctlmvipwer45q4@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, May 13, 2020 at 03:44:22PM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 10:30:27PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 04:29:42PM +0300, Serge Semin wrote:
> > > DebugFS kernel interface provides a dedicated method to create the
> > > registers dump file. Use it instead of creating a generic DebugFS
> > > file with manually written read callback function.

> > > +#define DW_SPI_DBGFS_REG(_name, _off)	\
> > > +{					\
> > > +	.name = _name,			\
> > > +	.offset = _off			\
> > 
> > Leave comma here.
> 
> don't see a point.

It will help in case if this getting extended. Also slightly better to
distinguish between terminator type of members vs. data structures.

> > >  }

> > > +	struct debugfs_regset32 regset;
> > 
> > I'm wondering why we need it here and not simple on the stack?
> 
> Please see the way the DebugFS regset work. A prompt: how does the DebugFS
> core get to know what is a base address of the registers? =)

If they have a member in the struct which passed thru private pointer of inode.
But I see your point.

-- 
With Best Regards,
Andy Shevchenko


