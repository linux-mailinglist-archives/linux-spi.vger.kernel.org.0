Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15651B96E4
	for <lists+linux-spi@lfdr.de>; Mon, 27 Apr 2020 08:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgD0GBg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Apr 2020 02:01:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:29239 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgD0GBf (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Apr 2020 02:01:35 -0400
IronPort-SDR: wj6SPiLfZn1W+xoaByvY9ECQl+E6lvTOpqfsDMVAYvHZEtMvQwJclH9ZSZ3PFrDcU7Zg918rB/
 IoQbFmR/CQZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 23:01:34 -0700
IronPort-SDR: Tbvmk32U8pXGkx1MtpOonsRz7dQHWFUGWcQDrlFH9X4px9KwcuhmgnP/3NtibVV60Lc23EbyEN
 qNIffhnF9OCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="292341155"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2020 23:01:33 -0700
Received: from [10.215.243.21] (ekotax-mobl.gar.corp.intel.com [10.215.243.21])
        by linux.intel.com (Postfix) with ESMTP id 72B9B580646;
        Sun, 26 Apr 2020 23:01:30 -0700 (PDT)
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
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <616a5419-add3-085e-32dc-c83d9d975725@linux.intel.com>
Date:   Mon, 27 Apr 2020 14:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200424112505.GD5850@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/24/2020 7:25 PM, Mark Brown wrote:
> On Fri, Apr 24, 2020 at 06:42:30PM +0800, Dilip Kota wrote:
>
>> Synchronize tx, rx and error interrupts by registering to the
>> same interrupt handler. Interrupt handler will recognize and process
>> the appropriate interrupt on the basis of interrupt status register.
>> Also, establish synchronization between the interrupt handler and
>> transfer operation by taking the locks and registering the interrupt
>> handler as thread IRQ which avoids the bottom half.
>> Fixes the wrongly populated interrupt register offsets too.
> This sounds like at least three different changes mixed together in one
> commit, it makes it quite hard to tell what's going on.  If nothing else
> the conversion from a workqueue to threaded interrupts should probably
> be split out from merging the interrupts.
While preparing the patches, i got puzzled to go with separate patches 
(for threaded interrupts, unified interrupt handler and fixing the 
register offset) or as a single patch!!.
Finally i choose to go with single patch, because establishing 
synchronization is the major reason for this change, for that reason 
threaded interrupts and unified interrupts changes are done. And the 
fixing offset is a single line change, so included in this patch itself. 
And, on a lighter note, the whole patch is coming under 45 lines of code 
changes.
Please let me know your view.
>
>> -static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
>> +static irqreturn_t lantiq_ssc_err_interrupt(struct lantiq_ssc_spi *spi)
>>   {
>> -	struct lantiq_ssc_spi *spi = data;
>>   	u32 stat = lantiq_ssc_readl(spi, LTQ_SPI_STAT);
>>   
>> -	if (!(stat & LTQ_SPI_STAT_ERRORS))
>> -		return IRQ_NONE;
>> -
> Why drop this?
lantiq_ssc_err_interrupt() getting called, only if LTQ_SPI_IRNEN_E is 
set in the interrupt status register.
Once the 'LTQ_SPI_IRNEN_E' bit is set, there is no chance of all error 
bits being unset in the SPI_STAT register, so the 'if condition' will 
never be successful. Hence dropped it.
>
>> -	err = devm_request_irq(dev, rx_irq, lantiq_ssc_xmit_interrupt,
>> -			       0, LTQ_SPI_RX_IRQ_NAME, spi);
>> +	err = devm_request_threaded_irq(dev, rx_irq, NULL, lantiq_ssc_isr,
>> +					IRQF_ONESHOT, LTQ_SPI_RX_IRQ_NAME, spi);
>>   	if (err)
>>   		goto err_master_put;
>>   
>> -	err = devm_request_irq(dev, tx_irq, lantiq_ssc_xmit_interrupt,
>> -			       0, LTQ_SPI_TX_IRQ_NAME, spi);
>> +	err = devm_request_threaded_irq(dev, tx_irq, NULL, lantiq_ssc_isr,
>> +					IRQF_ONESHOT, LTQ_SPI_TX_IRQ_NAME, spi);
>>   	if (err)
>>   		goto err_master_put;
>>   
>> -	err = devm_request_irq(dev, err_irq, lantiq_ssc_err_interrupt,
>> -			       0, LTQ_SPI_ERR_IRQ_NAME, spi);
>> +	err = devm_request_threaded_irq(dev, err_irq, NULL, lantiq_ssc_isr,
>> +					IRQF_ONESHOT, LTQ_SPI_ERR_IRQ_NAME, spi);
> It's not clear to me that it's a benefit to combine all the interrupts
> unconditionally - obviously where they're shared we need to but could
> that be accomplished with IRQF_SHARED and even if it can't it seems like
> something conditional would be better.

Lets take a case where Tx/Rx transfer interrupt got triggered and 
followed by error interrupt(before finishing the tx/rx interrupt 
execution) which is very less likely to occur, unified interrupt handler 
establishes synchronization.
Comparatively, unified interrupt handler is better for adding support to 
the latest SoCs on which SPI have single interrupt line for tx,rx and 
errors.
On basis of these two points i felt to go with unified interrupt handler.

Regards,
Dilip

