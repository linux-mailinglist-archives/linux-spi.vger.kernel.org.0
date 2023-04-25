Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFC6EE65B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjDYRIQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 13:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjDYRIP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 13:08:15 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021AE71
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 10:08:14 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PH8A4l096447;
        Tue, 25 Apr 2023 12:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682442490;
        bh=1l60BThl24uJt/TIOHfygV8AAr42d3x6iHZSVOZGA1o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WjSLQwdrChDhJRZ/tnSITnOLoNkLyi+sPex/gSWCvZKtJldYCf3SGmuhSO7DDJpE2
         EaVJIlWq/jOGaVMLhjzTEndRVOAlLQsXkHBMjf73YcILL53KMRs5v8yvK/5P0S8/Vb
         T9G/Z/c/o1PyUF7FPHKzSAEGDwrRE6weEXPlZ2t8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PH8A7t020942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 12:08:10 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Apr 2023 12:08:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 12:08:09 -0500
Received: from [10.250.150.138] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PH87Uo020888;
        Tue, 25 Apr 2023 12:08:08 -0500
Message-ID: <88237fc2-4ec8-7182-2c78-c8bf0c71a581@ti.com>
Date:   Tue, 25 Apr 2023 22:38:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
References: <20230424102546.1604484-1-d-gole@ti.com>
 <CAOiHx==anPTqXNJNG7zap1XP2zKUp5SbaVJdyUsUvvitKRUHZw@mail.gmail.com>
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <CAOiHx==anPTqXNJNG7zap1XP2zKUp5SbaVJdyUsUvvitKRUHZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jonas,

On 4/25/2023 4:55 PM, Jonas Gorski wrote:
> On Mon, 24 Apr 2023 at 12:25, Dhruva Gole <d-gole@ti.com> wrote:
>> Using this macro makes the code more readable.
>> It also inits the members of dev_pm_ops in the following manner
>> without us explicitly needing to:
>>
>> .suspend = bcm63xx_spi_suspend, \
>> .resume = bcm63xx_spi_resume, \
>> .freeze = bcm63xx_spi_suspend, \
>> .thaw = bcm63xx_spi_resume, \
>> .poweroff = bcm63xx_spi_suspend, \
>> .restore = bcm63xx_spi_resume
>>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> I think this should have an appropriate Fixes tag as it will fix a
> build warning when building with !CONFIG_PM after applying the
> previous patch.


You mean these build issues that have been pointed here?

https://lore.kernel.org/all/8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net/

So I should add a fixes "spi: bcm63xx: remove PM_SLEEP based conditional compilation"

corresponding fixes tag?

>
> Regards
> Jonas

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

