Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84005221FC9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgGPJhE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 05:37:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:20570 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgGPJhE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 05:37:04 -0400
IronPort-SDR: A/AiTkVuvs6YsXX/1hLKkO4zQPA8hAXvd+TPKDWyur9nJ+CVmGOwLGGcLO7d+pSb/zkTYqT80B
 OpgD77FbK60Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="129419530"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="129419530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 02:37:03 -0700
IronPort-SDR: B5vGQE5OQJ5THKVC+4M9W1HTo6oM0A7mrWthYGsouOZCwmwH9d6xcM5SmcDPZi65HGzhdt83/w
 namOFydSw4Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="326469187"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 02:37:02 -0700
Received: from [10.255.183.245] (ekotax-MOBL.gar.corp.intel.com [10.255.183.245])
        by linux.intel.com (Postfix) with ESMTP id F05CD58001A;
        Thu, 16 Jul 2020 02:36:58 -0700 (PDT)
Subject: Re: [PATCH 1/4] spi: lantiq: Synchronize interrupt handlers and
 transfers
From:   Dilip Kota <eswara.kota@linux.intel.com>
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
 <fce0b146-9ffc-839f-d34a-cb37206a0699@linux.intel.com>
Message-ID: <bb2cab96-af05-83bc-ec8a-3cc03426c5e7@linux.intel.com>
Date:   Thu, 16 Jul 2020 17:36:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fce0b146-9ffc-839f-d34a-cb37206a0699@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/6/2020 3:40 PM, Dilip Kota wrote:
>
> On 5/5/2020 7:23 PM, Mark Brown wrote:
>> On Mon, May 04, 2020 at 06:15:47PM +0800, Dilip Kota wrote:
>>> On 4/29/2020 8:13 PM, Mark Brown wrote:
>>
>>> I just tried to get the history of removing workqueue in SPI driver, on
>>> GRX500 (earlier chipset of LGM) the SPI transfers got timedout with
>>> workqueues during regression testing. Once changed to threaded IRQs
>>> transfers are working successfully.
>> That doesn't really explain why though, it just explains what.
> I didnt find more information about it. I will work to reproduce the 
> issue and share the detailed information sooner i get the 
> accessibility of the SoC (because of covid19 doing wfh)

I got the GRX500 setup and reproduced the timeout issue.
[   88.721883] spi-loopback-test spi1.2: SPI transfer timed out
[   88.726488] spi-loopback-test spi1.2: spi-message timed out - 
reruning...
[   88.961786] spi-loopback-test spi1.2: SPI transfer timed out
[   88.966027] spi-loopback-test spi1.2: Failed to execute spi_message: 
-145

Timeout is happening because of not acknowledging or not clearing the 
interrupt status registers. Workqueue is not causing any issue,
I am working on the changes, will submit the patches for review.

Regards,
Dilip

>
> Regards,
> Dilip
