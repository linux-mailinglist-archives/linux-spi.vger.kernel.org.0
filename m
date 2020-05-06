Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322761C6A31
	for <lists+linux-spi@lfdr.de>; Wed,  6 May 2020 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgEFHkV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 May 2020 03:40:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:36587 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgEFHkU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 6 May 2020 03:40:20 -0400
IronPort-SDR: zFFu9M223WP0/MMosOpIwwvy7gNJt+Sjab1hBN8ElUy2a5R3CuKTGRK3Tj0C2X+8rzOYhcFPvt
 eCRfF9dRP8pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 00:40:19 -0700
IronPort-SDR: QirAKY4LxgsJS8I4FdkzFFbfa513ClR/a4N5rxqtKlnQNz8Mz423RJZrNTJ9kiB9uoLAP3i3Ot
 Xtdn6vKb03ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="251127777"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2020 00:40:18 -0700
Received: from [10.213.154.130] (ekotax-mobl.gar.corp.intel.com [10.213.154.130])
        by linux.intel.com (Postfix) with ESMTP id 50A6658048A;
        Wed,  6 May 2020 00:40:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, robh@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
 <46f31699-e781-ae33-3ee5-d51e6940ee43@linux.intel.com>
 <20200429121310.GH4201@sirena.org.uk>
 <28f6511e-fe85-a834-1652-fd70def9ca88@linux.intel.com>
 <20200505112339.GC5377@sirena.org.uk>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <fce0b146-9ffc-839f-d34a-cb37206a0699@linux.intel.com>
Date:   Wed, 6 May 2020 15:40:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505112339.GC5377@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 5/5/2020 7:23 PM, Mark Brown wrote:
> On Mon, May 04, 2020 at 06:15:47PM +0800, Dilip Kota wrote:
>> On 4/29/2020 8:13 PM, Mark Brown wrote:
>
>> I just tried to get the history of removing workqueue in SPI driver, on
>> GRX500 (earlier chipset of LGM) the SPI transfers got timedout with
>> workqueues during regression testing. Once changed to threaded IRQs
>> transfers are working successfully.
> That doesn't really explain why though, it just explains what.
I didnt find more information about it. I will work to reproduce the 
issue and share the detailed information sooner i get the accessibility 
of the SoC (because of covid19 doing wfh)

Regards,
Dilip
