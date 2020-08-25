Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1572521E9
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHYUWy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 16:22:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:42382 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYUWy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Aug 2020 16:22:54 -0400
IronPort-SDR: JKflv9q8QSvXxf7MNM5uG4POnqTtRE++LPCa87kiDior77kaGMdTjnpK60utABE2yWsJmLec4M
 /stdxq9DLTtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="135743491"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="135743491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 13:22:53 -0700
IronPort-SDR: u7O27L3/frVrxlmEk2HVUAoI2nABvEgfmQo7F0xOQLdjHflAQJlaBvtPVAbro3Tr0LdOO97fJp
 pm3Mb11CJJpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="338917459"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.19.243]) ([10.213.19.243])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2020 13:22:52 -0700
Subject: Re: [PATCH] spi: pxa2xx: Add SSC2 and SSPSP2 SSP registers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org
References: <20200825171730.17638-1-cezary.rojewski@intel.com>
 <20200825193817.GR1891694@smile.fi.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <7eff0658-dd7a-6fac-6de0-b865e458411f@intel.com>
Date:   Tue, 25 Aug 2020 22:22:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825193817.GR1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2020-08-25 9:38 PM, Andy Shevchenko wrote:
> On Tue, Aug 25, 2020 at 07:17:30PM +0200, Cezary Rojewski wrote:
>> Update list of SSP registers with SSC2 and SSPSP2. These registers are
>> utilized by LPT/WPT AudioDSP architecture.
>>
>> While SSC2 shares the same offset (0x40) as SSACDD, description of this
>> register for SSP device present on mentioned AudioDSP is different so
>> define separate constant to avoid any ambiguity.
> 
> In general it's okay, couple of nit-picks, though. After addressing,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Thanks for quick review, Andy.

>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
>> ---
>>   include/linux/pxa2xx_ssp.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
>> index 6facf27865f9..935d7db5bc32 100644
>> --- a/include/linux/pxa2xx_ssp.h
>> +++ b/include/linux/pxa2xx_ssp.h
>> @@ -41,6 +41,8 @@
>>   #define SSTSS		(0x38)  /* SSP Timeslot Status */
>>   #define SSACD		(0x3C)  /* SSP Audio Clock Divider */
>>   #define SSACDD		(0x40)	/* SSP Audio Clock Dither Divider */
>> +#define SSC2		(0x40)	/* SSP Command / Status 2 */
> 
> Is it the same as been called SSCR2 in Tangier?  (Also called SSP Command
> Status register 2) I guess we may name it with R applied.
> 

It seems there is discrepancy in registers naming. LPT/ WPT specs have 
all 'R'(s) removed. Don't mind appending it - aligns with existing SSCR0 
& SSCR1.

Know nothing about Tangier, though : )

>> +#define SSPSP2		(0x44)	/* SSP Programmable Serial Protocol 2 */
> 
> Also, please move them below with a comment like LPSS SSP block:
> https://elixir.bootlin.com/linux/latest/source/include/linux/pxa2xx_ssp.h#L181
> 

Added in v2 as requested.
