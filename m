Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9B4BB16
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2019 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfFSOSE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Jun 2019 10:18:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:7997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfFSOSD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Jun 2019 10:18:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 07:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="186471096"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2019 07:18:00 -0700
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
 <c96afe71-c7bd-d30f-ef37-0c6eeb726f67@linux.intel.com>
 <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com>
Date:   Wed, 19 Jun 2019 17:17:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9fafXNrAYAgUuqMPVjZm2bWJmzg_aPz9WD1skemQme8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

On 6/19/19 4:58 PM, Ard Biesheuvel wrote:
> So can you explain how exactly the I2C GPIO expander is failing? I
> struggle to understand how the SPI slave probing could be related to
> that.
> 
They don't show up in /sys/kernel/debug/gpio, are not present in 
/sys/bus/i2c/devices/ but SPI core instead tries add them with a bogus 
Chip Select number:

[    5.727699][    T1] pxa2xx-spi pxa2xx-spi.5: cs56 >= max 4
[    5.733545][    T1] spi_master spi5: failed to add SPI device 
INT3491:00 from ACPI

-- 
Jarkko

