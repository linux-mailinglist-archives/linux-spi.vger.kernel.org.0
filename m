Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA51C368E
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgEDKPx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 06:15:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:39941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgEDKPx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 06:15:53 -0400
IronPort-SDR: zac0n6+mH4OGwqJlyJPhQ8YUboM1GZLbOwg4U5I+xGCy8OfgwLujC5hTbHqPAywYMUP6V/BMIf
 XiwcgJm7sOzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 03:15:52 -0700
IronPort-SDR: kWzOexmE9gA9GHIa+C/aOVrhX7sZAgooMMGkA7wWet4plCES6C0LHJKpk/ebmQ5jghUQWYWDmf
 qla8KiukKhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="277483002"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2020 03:15:51 -0700
Received: from [10.215.163.15] (ekotax-mobl.gar.corp.intel.com [10.215.163.15])
        by linux.intel.com (Postfix) with ESMTP id 2E749580609;
        Mon,  4 May 2020 03:15:48 -0700 (PDT)
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
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <28f6511e-fe85-a834-1652-fd70def9ca88@linux.intel.com>
Date:   Mon, 4 May 2020 18:15:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429121310.GH4201@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/29/2020 8:13 PM, Mark Brown wrote:
> On Wed, Apr 29, 2020 at 04:20:53PM +0800, Dilip Kota wrote:
>> On 4/28/2020 7:10 PM, Daniel Schwierzeck wrote:
>>> actually there is no real bottom half. Reading or writing the FIFOs is
>>> fast and is therefore be done in hard IRQ context. But as the comment
>> Doing FIFO r/w in threaded irqs shouldn't cause any impact on maximum
>> transfer rate i think.
> Have you actually tested this?  Generally adding extra latency is going
> to lead to some opportunity for the hardware to idle and the longer the
> hardware is idle the lower the throughput.
>
>> Also the ISR should be quick enough, doing FIFO r/w in ISR adds up more
>> latency to ISR.
>> Handling the FIFOs r/w in threaded irq will be a better way.
> Consider what happens on a heavily loaded system - the threaded
> interrupt will have to be scheduled along with other tasks.
>
>>> for lantiq_ssc_bussy_work() state, the driver needs some busy-waiting
>>> after the last interrupt. I don't think it's worth to replace this with
>>> threaded interrupts which add more runtime overhead and likely decrease
>>> the maximum transfer speed.
>> Workqueue has a higher chances of causing SPI transfers timedout.
> because...?
I just tried to get the history of removing workqueue in SPI driver, on 
GRX500 (earlier chipset of LGM) the SPI transfers got timedout with 
workqueues during regression testing. Once changed to threaded IRQs 
transfers are working successfully.

Regards,
Dilip
