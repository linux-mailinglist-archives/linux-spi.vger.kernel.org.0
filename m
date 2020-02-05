Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA88215257C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Feb 2020 05:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBEEIU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 23:08:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36570 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgBEEIT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 23:08:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01547abQ083641;
        Tue, 4 Feb 2020 22:07:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580875656;
        bh=CAV1QR8slHije4jUH3qk7JjiH6cRqY6xGNy7DYePN78=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=exxoYmLnAqlMeO2ENd1TcPHzdytE7GInT8mptXJXaRVWFZ5AhYTkJg/ImLeksCuik
         DT18+jmJEStTV0Wjym+VR2X35a+yIdkC19WEiGMoa0487VtVpYgwAfdJ+E6Vb+OPdk
         t2JLIeJOJWORUr4+4q0uciX2Dl4mkyLE58/ryx9k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01547aSb127351;
        Tue, 4 Feb 2020 22:07:36 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 22:07:36 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 22:07:36 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01547WAK040074;
        Tue, 4 Feb 2020 22:07:33 -0600
Subject: Re: [PATCH v8 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Dinh Nguyen <dinguyen@kernel.org>,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Tien-Fong Chee <tien.fong.chee@intel.com>,
        Marek Vasut <marex@denx.de>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <dan.carpenter@oracle.com>,
        <cheol.yong.kim@intel.com>, <qi-ming.wu@intel.com>
References: <20200129072455.35807-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200129072455.35807-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qszwQ5sJw4G_fM5vKjYu24xs03CuW371gyFE4G0hNJHdXw@mail.gmail.com>
 <abaae0fa-c2b8-bbe0-b64d-0ee4c95c1479@linux.intel.com>
 <CAAh8qsxRPx8KDyqvp=8zcrGCE82YJ_9O9cJXrgKdH7VwXeGQgg@mail.gmail.com>
 <0f079cf6-c146-8941-5bdd-f978ff3455ab@linux.intel.com>
 <d938fcc6-3e9b-2b5d-bf6c-1de7c8649798@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9fc3e36d-18c2-c5fb-2fed-7ffcef817692@ti.com>
Date:   Wed, 5 Feb 2020 09:38:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d938fcc6-3e9b-2b5d-bf6c-1de7c8649798@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dinh,

On 04/02/20 9:27 pm, Dinh Nguyen wrote:
[...]
>>>> Already I checked that Graham Moore <grmoore@opensource.altera.com>
>>>> who has submitted the existing driver patches to upstream,
>>>> His mail-id is bouncing back, then I decided that you are the right
>>>> person to ask, could you please add them in loop if you know the team
>>>> (socfpga platform engineers).
> 
> Thanks for including Graham, but he's moved on to a different career
> that no longer includes Linux.
> 
>>> OK, done that. I mainly know them from U-Boot development, so I'm not
>>> sure
>>> who's responsible for the Linux drivers...
>> Thank you for adding the team and respective members, let's see.
>>
> 
> I don't have the original patch series, but will monitor going forward.
> As long as the new driver does not break legacy SoCFPGA products that
> use the cadence-quadspi driver then it should be ok.
> 

The legacy driver under drivers/mtd/spi-nor will be removed as we cannot
support both SPI NOR and SPI NAND with single driver if its under
spi-nor. New driver should be functionally equivalent to existing one.
So I suggest you test this driver on legcay SoCFPGA products.


-- 
Regards
Vignesh
