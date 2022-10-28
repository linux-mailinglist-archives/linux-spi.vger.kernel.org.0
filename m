Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA2610A4C
	for <lists+linux-spi@lfdr.de>; Fri, 28 Oct 2022 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJ1GZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Oct 2022 02:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1GZd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Oct 2022 02:25:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D026524A
        for <linux-spi@vger.kernel.org>; Thu, 27 Oct 2022 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666938333; x=1698474333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MqoXu2wQyv3G3L76HC6ilwoqzRzxIgv2l2DtGnnavvc=;
  b=kudYq/cYTONy6Q+a+xioEvkJDc98bD4wX260DpErZu5a4kvjxP1EJ01l
   lE2IcghvvLz+A2ixnqdtKYQuTT+EPrsysWJSvKSkQokNCiYtwdEMXdvRM
   h/lhKQkVZJBHEW5YKpd/zfooJq6GGVJylcynjaXEGO4oaIInzqIWVdI1n
   nC9PRQn4/npvi7trSuUA9QvFAqsJ4sE7+iaQWD5IBlxzwgmWm17pVJivO
   hQuau/mcOd7EnznddVqrd2gSPYeTaTy5ewzWhODsV+7aGvFzgwDfWnuBg
   jnN/jlBWt/hgQW89aFG/i1X64O4CwjqOF1VtjoE/Mhr/ByNNd0+goGR06
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="372635875"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="372635875"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 23:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="663913088"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="663913088"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2022 23:25:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 03B29107; Fri, 28 Oct 2022 09:25:34 +0300 (EEST)
Date:   Fri, 28 Oct 2022 09:25:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Gole, Dhruva" <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: intel: Implement adjust_op_size()
Message-ID: <Y1t13q53WbQxDzST@black.fi.intel.com>
References: <20221025064623.22808-1-mika.westerberg@linux.intel.com>
 <20221025064623.22808-3-mika.westerberg@linux.intel.com>
 <99f962a4-0101-b040-17dc-cec3d877dba8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f962a4-0101-b040-17dc-cec3d877dba8@ti.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Fri, Oct 28, 2022 at 11:42:09AM +0530, Gole, Dhruva wrote:
> Hi Mika,
> 
> On 10/25/2022 12:16 PM, Mika Westerberg wrote:
> > This allows us to get rid of the checks in the intel_spi_[sh]w_cycle()
> > and makes it possible for the SPI-NOR core to split the transaction into
> > smaller chunks as needed.
> 
> If I understand correctly, the controller ops are called from spi-mem.c, and
> 
> spi_mem_adjust_op does exist and on it's own does "split a data transfer
>  operation into multiple ones"
> 
> So is this really something that you require the controller to do and
> 
> can we not rely on spi-mem.c to do it's thing instead?

How does it know the size supported by the hardware? I think this is the
reason spi_mem_adjust_op was introduced but I may be mistaken.

> I would like to point you to another controller spi-cadence-quadspi.c
> 
> that also doesn't have it's own adjust_op_size but I haven't seen any issues
> as such
> 
> inspite. This is because everything first goes through spi-mem.c then onto
> the controllers drivers.

Well Intel SPI driver did not not have any issues previously either
because it handled the read/write split internally but SFDP read is done
through "register read side" which only supported max 64-byte read until
now :-)
