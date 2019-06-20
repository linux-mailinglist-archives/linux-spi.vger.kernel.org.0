Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4C4CD9A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfFTMVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 08:21:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:37409 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTMVI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Jun 2019 08:21:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 05:21:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="165303530"
Received: from mylly.fi.intel.com (HELO [10.237.72.61]) ([10.237.72.61])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2019 05:21:03 -0700
Subject: Re: [PATCH] spi/acpi: fix incorrect ACPI parent check
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
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
 <08e498d6-1ff8-771f-7d4f-6ea5f705d386@linux.intel.com>
 <20190619144255.GG2640@lahna.fi.intel.com>
 <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <efe4ab27-61eb-af89-f023-c0208253fc69@linux.intel.com>
Date:   Thu, 20 Jun 2019 15:21:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu82UcBcj_cjfEDpEyQyGzPvtGnVJN22hCroHKyudhk=8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/20/19 1:33 PM, Ard Biesheuvel wrote:
> Jarkko, does this help?
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 50d230b33c42..d072efdd65ba 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1914,6 +1914,7 @@ static acpi_status
> acpi_register_spi_device(struct spi_controller *ctlr,
>                  return AE_OK;
> 
>          lookup.ctlr             = ctlr;
> +       lookup.max_speed_hz     = 0;
>          lookup.mode             = 0;
>          lookup.bits_per_word    = 0;
>          lookup.irq              = -1;
> 
Yes it does.

I guess you have some cleanups or changes on top of your b5e3cf410b48 
("spi/acpi: fix incorrect ACPI parent check") since for me change go 
around lines @@ -1981,6 +1981,7 @@ ?

-- 
Jarkko
