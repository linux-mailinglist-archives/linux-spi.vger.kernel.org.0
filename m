Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74481730E1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 07:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgB1GPo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Feb 2020 01:15:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:49165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgB1GPo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 Feb 2020 01:15:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 22:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="257017344"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2020 22:15:43 -0800
Received: from [10.226.38.23] (unknown [10.226.38.23])
        by linux.intel.com (Postfix) with ESMTP id 148405805EF;
        Thu, 27 Feb 2020 22:15:36 -0800 (PST)
Subject: Re: [PATCH v11 2/2] spi: cadence-quadspi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, robh+dt@kernel.org, marex@denx.de,
        devicetree@vger.kernel.org, tien.fong.chee@intel.com,
        tudor.ambarus@gmail.com, boris.brezillon@free-electrons.com,
        richard@nod.at, qi-ming.wu@intel.com,
        simon.k.r.goldschmidt@gmail.com, david.oberhollenzer@sigma-star.at,
        dinguyen@kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, cheol.yong.kim@intel.com,
        mark.rutland@arm.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, cyrille.pitchen@atmel.com
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227183032.77ef0795@collabora.com> <20200227173224.GH4062@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <5a63a66b-e82a-30bf-5939-842549299772@linux.intel.com>
Date:   Fri, 28 Feb 2020 14:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200227173224.GH4062@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 28/2/2020 1:32 AM, Mark Brown wrote:
> On Thu, Feb 27, 2020 at 06:30:32PM +0100, Boris Brezillon wrote:
>> "Ramuthevar, Vadivel MuruganX"
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Reported-by? What has been reported?
> There were static checker issues with some of the earlier versions.
> Vadivel, normally you wouldn't carry tags like that forward when you fix
> them.

Than you Mark, will remove it in the next patch-set.

Regards
Vadivel
