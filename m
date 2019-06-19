Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1788C4B9BA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 15:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfFSNVX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 09:21:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:55844 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSNVW (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Jun 2019 09:21:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 06:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="186456946"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2019 06:21:19 -0700
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com>
 <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
 <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
Date:   Wed, 19 Jun 2019 16:21:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_Bw3aV-pUVYf8T1hLfL35X7ozEPtqL9oLcDvwcQ4qMiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/19/19 2:59 PM, Ard Biesheuvel wrote:
> On Wed, 19 Jun 2019 at 13:58, Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> On 6/19/19 1:16 PM, Mika Westerberg wrote:
>>> On Wed, Jun 19, 2019 at 11:52:54AM +0200, Ard Biesheuvel wrote:
>>>> The ACPI device object parsing code for SPI slaves enumerates the
>>>> entire ACPI namespace to look for devices that refer to the master
>>>> in question via the 'resource_source' field in the 'SPISerialBus'
>>>> resource. If that field does not refer to a valid ACPI device or
>>>> if it refers to the wrong SPI master, we should disregard the
>>>> device.
>>>>
>>>> Current, the valid device check is wrong, since it gets the
>>>> polarity of 'status' wrong. This could cause issues if the
>>>> 'resource_source' field is bogus but parent_handle happens to
>>>> refer to the correct master (which is not entirely imaginary
>>>> since this code runs in a loop)
>>>>
>>>> So test for ACPI_FAILURE() instead, to make the code more
>>>> self explanatory.
>>>>
>>>> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>> I hit yesterday a regression caused by 4c3c59544f33. I've a custom ACPI
>> tables defining I2C gpio expanders (gpio-pca953x.c as INT3491) and a
>> spidev test device (SPT0001).
>>
>> Both stopped enumerating after 4c3c59544f33. With this fix spidev device
>> enumerates but still get confused with I2C GPIO expanders (INT3491):
>>
> 
> Could you share the decomplied D/SSDT please?
> 
It's Intel Edison with tables from Mika's sample ACPI tables. The 
interesting parts here are these two:

https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/spidev.asl

https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/gpioexp.asli

The full tables are of course larger but I think those two above are 
relevant here. I build SSDT from arduino-all.asl below which includes 
bunch of other files and with above spidev.asl.

https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/arduino-all.asl

Let me know if you need full dump.

-- 
Jarkko
