Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25021BB5EE
	for <lists+linux-spi@lfdr.de>; Tue, 28 Apr 2020 07:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1FjY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Apr 2020 01:39:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:63316 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgD1FjY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 28 Apr 2020 01:39:24 -0400
IronPort-SDR: KziNq3O3XknjiREGYsv95QBlYyIyXSA/UoCKxsY4eYhtVnIPaCq1frUJ0Rth8GY2iZps5mRHr9
 FHa4Fvaet7JA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 22:39:23 -0700
IronPort-SDR: m+H+nb1OaaspRpQgfK0qpLTGXT3lNbUM/ZWNN8QiZ86cMnXOpiJF3KFCLOHseMsG+cxh10KQ4U
 gD+DK5+hO/gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="275722694"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 22:39:23 -0700
Received: from [10.215.240.200] (ekotax-mobl.gar.corp.intel.com [10.215.240.200])
        by linux.intel.com (Postfix) with ESMTP id 670825807CA;
        Mon, 27 Apr 2020 22:39:08 -0700 (PDT)
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
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <43ecffb1-4786-c038-09bb-648657c0f5f3@linux.intel.com>
Date:   Tue, 28 Apr 2020 13:39:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427134555.GC4383@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/27/2020 9:45 PM, Mark Brown wrote:
> On Mon, Apr 27, 2020 at 02:01:29PM +0800, Dilip Kota wrote:
>> On 4/24/2020 7:25 PM, Mark Brown wrote:
>>> On Fri, Apr 24, 2020 at 06:42:30PM +0800, Dilip Kota wrote:
>>>> Synchronize tx, rx and error interrupts by registering to the
>>>> same interrupt handler. Interrupt handler will recognize and process
>>>> the appropriate interrupt on the basis of interrupt status register.
>>>> Also, establish synchronization between the interrupt handler and
>>>> transfer operation by taking the locks and registering the interrupt
>>>> handler as thread IRQ which avoids the bottom half.
>>>> Fixes the wrongly populated interrupt register offsets too.
>>> This sounds like at least three different changes mixed together in one
>>> commit, it makes it quite hard to tell what's going on.  If nothing else
>>> the conversion from a workqueue to threaded interrupts should probably
>>> be split out from merging the interrupts.
>> While preparing the patches, i got puzzled to go with separate patches (for
>> threaded interrupts, unified interrupt handler and fixing the register
>> offset) or as a single patch!!.
>> Finally i choose to go with single patch, because establishing
>> synchronization is the major reason for this change, for that reason
>> threaded interrupts and unified interrupts changes are done. And the fixing
>> offset is a single line change, so included in this patch itself. And, on a
>> lighter note, the whole patch is coming under 45 lines of code changes.
>> Please let me know your view.
> The single line change to fix the offset sounds like an especially good
> candidate for splitting out as a separate patch.  It's not really about
> the number of lines but rather complexity.
Sure, i will do as separate patch.
>
>>>> -static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
>>>> +static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
>>>>    {
>>>> -	struct lantiq_ssc_spi *spi = data;
>>>>    	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
>>>> -	if (!(stat & LTQ_SPI_STAT_ERRORS))
>>>> -		return IRQ_NONE;
>>>> -
>>> Why drop this?
>> lantiq_ssc_err_interrupt() getting called, only if LTQ_SPI_IRNEN_E is set in
>> the interrupt status register.
>> Once the 'LTQ_SPI_IRNEN_E' bit is set, there is no chance of all error bits
>> being unset in the SPI_STAT register, so the 'if condition' will never be
>> successful. Hence dropped it.
> So this is another separate change and TBH it doesn't seem like a huge
> win in that it's still potentially adding a bit of robustness.
>
>>> It's not clear to me that it's a benefit to combine all the interrupts
>>> unconditionally - obviously where they're shared we need to but could
>>> that be accomplished with IRQF_SHARED and even if it can't it seems like
>>> something conditional would be better.
>> Lets take a case where Tx/Rx transfer interrupt got triggered and followed
>> by error interrupt(before finishing the tx/rx interrupt execution) which is
>> very less likely to occur, unified interrupt handler establishes
>> synchronization.
>> Comparatively, unified interrupt handler is better for adding support to the
>> latest SoCs on which SPI have single interrupt line for tx,rx and errors.
>> On basis of these two points i felt to go with unified interrupt handler.
> Does the mutex not do this regardless of how the interrupt handlers are
> wired up?
Yes, taking mutex and defining in the single ISR will be better i feel 
while adding support for multiple SoCs with different number of 
interrupt lines.

Do you suggest to use different ISRs for multiple interrupt lines and 
single ISR for single interrupt line? I see, this results in writing 
repetitive code lines.
Does single ISR looks erroneous! Please let me know.

Regards,
Dilip

