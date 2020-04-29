Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559E11BD727
	for <lists+linux-spi@lfdr.de>; Wed, 29 Apr 2020 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD2IWi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Apr 2020 04:22:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:44131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgD2IWi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 04:22:38 -0400
IronPort-SDR: dMiGYpRM5R3C/CcgAHoz2hsFfpTv2lrCHeVSKimyWK8bsBu4mCGhttxVKcH2oCc/xEV4c67VgW
 L3iBoL47mwlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 01:22:38 -0700
IronPort-SDR: F+sD5STICk/m6zujNoE9BvEABvPm9vfHA/7Vwbg/OxHjhyfuFBlI+4A+I2dBRswY9yrVoa2IZs
 NG95l8OV7VzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
   d="scan'208";a="459104696"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 01:22:38 -0700
Received: from [10.215.242.51] (ekotax-mobl.gar.corp.intel.com [10.215.242.51])
        by linux.intel.com (Postfix) with ESMTP id 142FD5802C8;
        Wed, 29 Apr 2020 01:22:34 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1587702428.git.eswara.kota@linux.intel.com>
 <3bf88d24b9cad9f3df1da8ed65bf55c05693b0f2.1587702428.git.eswara.kota@linux.intel.com>
 <310ca761-e7ae-1192-99fd-a1960697806b@gmail.com>
 <262f2739-494a-a59b-f1e9-80a95ea465b1@hauke-m.de>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <078a68ad-b82b-81c5-2d93-bfa4b70bc5d6@linux.intel.com>
Date:   Wed, 29 Apr 2020 16:22:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <262f2739-494a-a59b-f1e9-80a95ea465b1@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/28/2020 7:30 PM, Hauke Mehrtens wrote:
> On 4/28/20 1:10 PM, Daniel Schwierzeck wrote:
>>
>> Am 24.04.20 um 12:42 schrieb Dilip Kota:
>>
...
> Hi,
>
> The Interrupt controller found on Danube till xrx300 which is probably
> from Infineon like this SPI controller IP acknowledges the interrupts
> also inside this SPI controller IP automatically, this has to be done
> manually on the xrx500 and probably also LGM as they use a different
> interrupt controller. I prepared patches for this internally 2.5 years
> ago but did not send them upstream because of internal processes.
>
> I would suggest to only do this ack on the newer platforms starting with
> the xrx500 and not on the older.
>
> On SMP systems a lock is needed in lantiq_ssc_xmit_interrupt() to
> protect against an other thread reading from the RX buffer or writing to
> the TX buffer in parallel.
>
> @Dilip. Did you try the patches I send you one months ago on the LGM?
All the cases you mentioned are taken care in the patch, could you 
please have a look once.

And the patch you shared internally, has done below change. By referring 
it i have updated the offsets, mentioning offsets are wrong. But actual 
case is vrx200 are having different offsets and xrx500, latest chipsets 
are having different offsets. I think this could be the reason for SPI 
transfer timeouts when you run test on vrx200 with my patches.

-#define LTQ_SPI_IRNICR		0xf8
-#define LTQ_SPI_IRNCR		0xfc
+#define LTQ_SPI_IRNCR		0xf8
+#define LTQ_SPI_IRNICR		0xfc

These offsets need to be defined in SoC data structure as they are 
different across the chipsets(which i have done in initial phase of the 
patch which i submitted for internal review. I hope you had got a chance 
to review it).

Regards,
Dilip

