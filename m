Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C71BD58E
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgD2HUa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 03:20:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:53723 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD2HUa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 03:20:30 -0400
IronPort-SDR: hldEkLBas8zKC6Zpdsj1fU7GfCOTMYn9w5vnw/ab35rD0fuBG2iv/d/Gwa0U0D4F48ldzb7ivS
 aFWuInY3Y5EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 00:20:25 -0700
IronPort-SDR: QPa7dHTv8XQQJsIZN5cmsH7yNXzMZPGce0fOF6mMDVpLMYW3rZskWmYi79w7kHtpz65X8ogfOL
 mI6pifLqNZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="459496148"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 29 Apr 2020 00:20:25 -0700
Received: from [10.215.242.51] (ekotax-mobl.gar.corp.intel.com [10.215.242.51])
        by linux.intel.com (Postfix) with ESMTP id 355A4580619;
        Wed, 29 Apr 2020 00:20:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.schwierzeck@gmail.com, hauke@hauke-m.de,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <20200424112505.GD5850@sirena.org.uk>
 <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
 <20200427134555.GC4383@sirena.org.uk>
 <43ecffb1-4786-c038-09bb-648657c0f5f3@linux.intel.com>
 <20200428100055.GB5677@sirena.org.uk>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <68948cb1-6c78-1545-45c6-5a95465b05e2@linux.intel.com>
Date:   Wed, 29 Apr 2020 15:20:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428100055.GB5677@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/28/2020 6:00 PM, Mark Brown wrote:
> On Tue, Apr 28, 2020 at 01:39:06PM +0800, Dilip Kota wrote:
>
>> Do you suggest to use different ISRs for multiple interrupt lines and single
>> ISR for single interrupt line? I see, this results in writing repetitive
>> code lines.
> It looks like the shared case is mainly a handler that calls the two
> other handlers?
Yes.
>
>> Does single ISR looks erroneous! Please let me know.
> The change was not entirely clear, I was having trouble convincing
> myself that all the transformations were OK partly because I kept on
> finding little extra changes in there and partly because there were
> several things going on.  In theory it could work.

You want me to split this in to multiple patches?

Regards,
Dilip

