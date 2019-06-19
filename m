Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 288E74B787
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfFSL6l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 07:58:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:1708 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfFSL6l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Jun 2019 07:58:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 04:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="182722411"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2019 04:58:37 -0700
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        andy.shevchenko@gmail.com, masahisa.kojima@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20190619095254.19559-1-ard.biesheuvel@linaro.org>
 <20190619101604.GR2640@lahna.fi.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <54ede1d8-0e6b-e7d9-5e61-a7d057abbd2b@linux.intel.com>
Date:   Wed, 19 Jun 2019 14:58:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619101604.GR2640@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/19/19 1:16 PM, Mika Westerberg wrote:
> On Wed, Jun 19, 2019 at 11:52:54AM +0200, Ard Biesheuvel wrote:
>> The ACPI device object parsing code for SPI slaves enumerates the
>> entire ACPI namespace to look for devices that refer to the master
>> in question via the 'resource_source' field in the 'SPISerialBus'
>> resource. If that field does not refer to a valid ACPI device or
>> if it refers to the wrong SPI master, we should disregard the
>> device.
>>
>> Current, the valid device check is wrong, since it gets the
>> polarity of 'status' wrong. This could cause issues if the
>> 'resource_source' field is bogus but parent_handle happens to
>> refer to the correct master (which is not entirely imaginary
>> since this code runs in a loop)
>>
>> So test for ACPI_FAILURE() instead, to make the code more
>> self explanatory.
>>
>> Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
I hit yesterday a regression caused by 4c3c59544f33. I've a custom ACPI 
tables defining I2C gpio expanders (gpio-pca953x.c as INT3491) and a 
spidev test device (SPT0001).

Both stopped enumerating after 4c3c59544f33. With this fix spidev device 
enumerates but still get confused with I2C GPIO expanders (INT3491):

[    5.629874][    T1] pxa2xx-spi pxa2xx-spi.3: registered master spi3
[    5.644447][    T1] pxa2xx-spi pxa2xx-spi.5: registered master spi5
[    5.653930][    T1] spi spi-SPT0001:00: in setup: DMA burst size set to 8
[    5.661300][    T1] spi spi-SPT0001:00: setup mode 0, 8 bits/w, 
1000000 Hz max --> 0
[    5.671360][    T1] spidev spi-SPT0001:00: do not use this driver in 
production systems!
[    5.682325][    T1] pxa2xx-spi pxa2xx-spi.5: registered child 
spi-SPT0001:00
[    5.690240][    T1] spi spi-PRP0001:00: in setup: DMA burst size set to 8
[    5.697492][    T1] spi spi-PRP0001:00: setup mode 0, 8 bits/w, 
20000000 Hz max --> 0
[    5.706928][    T1] pxa2xx-spi pxa2xx-spi.5: registered child 
spi-PRP0001:00
[    5.715754][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
[    5.721688][    T1] spi_master spi5: failed to add SPI device 
INT3491:00 from ACPI
[    5.730648][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
[    5.736657][    T1] spi_master spi5: failed to add SPI device 
INT3491:01 from ACPI
[    5.745617][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
[    5.751546][    T1] spi_master spi5: failed to add SPI device 
INT3491:02 from ACPI
[    5.760628][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
[    5.766549][    T1] spi_master spi5: failed to add SPI device 
INT3491:03 from ACPI
[    5.777160][    T1] pxa2xx-spi pxa2xx-spi.5: cs104 >= max 4
[    5.783087][    T1] spi_master spi5: failed to add SPI device 
BCM2E95:00 from ACPI
[    5.797008][    T1] pxa2xx-spi pxa2xx-spi.6: registered master spi6

Ok log with commit 4c3c59544f33 reverted:

[    5.633116][    T1] pxa2xx-spi pxa2xx-spi.3: registered master spi3
[    5.647701][    T1] pxa2xx-spi pxa2xx-spi.5: registered master spi5
[    5.655668][    T1] spi spi-SPT0001:00: in setup: DMA burst size set to 8
[    5.663066][    T1] spi spi-SPT0001:00: setup mode 0, 8 bits/w, 
1000000 Hz max --> 0
[    5.672758][    T1] pxa2xx-spi pxa2xx-spi.5: registered child 
spi-SPT0001:00
[    5.680602][    T1] spi spi-PRP0001:00: in setup: DMA burst size set to 8
[    5.687820][    T1] spi spi-PRP0001:00: setup mode 0, 8 bits/w, 
20000000 Hz max --> 0
[    5.697366][    T1] pxa2xx-spi pxa2xx-spi.5: registered child 
spi-PRP0001:00
[    5.709064][    T1] pxa2xx-spi pxa2xx-spi.6: registered master spi6
[   11.021760][   T84] spidev spi-SPT0001:00: do not use this driver in 
production systems!

-- 
Jarkko
