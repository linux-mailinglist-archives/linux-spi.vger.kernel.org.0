Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114115612E3
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiF3HDu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 03:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiF3HDt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 03:03:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738033E28
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656572629; x=1688108629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3T71yGI3xgqjMqu8DLOwct4gWhun0znIsxahv38rovc=;
  b=k2Ip/9rmw5UZYJBrc4D3EWOVZMqgzS8fqi2hhBycSntaZ874N48dHVMh
   0swpA+Az3dG3E1HwZXo5Fg8N5ADt+GoZ4DFqw4i/YTL912yPFp3iHWMRz
   BUwm13Q0sExlr1a114pYfT2jzz+2ZzcY2C3WnBJQLhMXFdWBadKV4GC3e
   p0SrptIEK1bMlCTEYERWFuLblIFuorohwBAf4ap+3fKl/LdxUMYruivLG
   S2HzMR2nh/s+z0gmOBK19Q2cd6N5YAouRsy+H3SxT2Knfiar4EIvRSG9G
   OZE35ZMjsY3qrrZaw2mdLYKsIn07w257POsaup9X4UWWrjhfsu64HJmi8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279810867"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="279810867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 00:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647762585"
Received: from mylly.fi.intel.com (HELO [10.237.72.55]) ([10.237.72.55])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2022 00:03:47 -0700
Message-ID: <6e0bd3a8-65a4-2066-79f2-d59e6bb2b7ea@linux.intel.com>
Date:   Thu, 30 Jun 2022 10:03:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Meteor Lake PCH-P
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ap Kamal <kamal.ap@intel.com>
References: <20220629120700.620108-1-jarkko.nikula@linux.intel.com>
 <CAHp75VdhGDR0cGt2Aky=sRRDB=u4mwxWZgQ+DGL08QZFBMKiAg@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <CAHp75VdhGDR0cGt2Aky=sRRDB=u4mwxWZgQ+DGL08QZFBMKiAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/29/22 18:35, Andy Shevchenko wrote:
> On Wed, Jun 29, 2022 at 2:09 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Add support for LPSS SPI on Intel Meteor Lake PCH-P. It has three
>> controllers each having two chip selects.
>>
>> This squashes a fix from Ap, Kamal <kamal.ap@intel.com> fixing incorrect
>> PCI ID of 3rd controller.
> 
> With PCH removed from the commit message (including subject)
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
Hmm, right. Thanks Andy, Meteor Lake -P seems to integrate PCH die 
functionality into a SoC.

Jarkko
