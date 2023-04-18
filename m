Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2FA6E66F3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjDROSj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 10:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjDROSg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 10:18:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DFE9C
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 07:18:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33IEIOfr038003;
        Tue, 18 Apr 2023 09:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681827504;
        bh=5IMdMs8isZRS+kikZ4o++RZhyJXAfZCLO37iKmBZvus=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WVkMjLdKjXvD41hQFylVGXi3oTneU8t5H+J8ak4+uSdMovYJtRgCPT6lBaXFnUBk1
         snkach3aVDTJCR5As3LbqlZlbjzaYrWtZl2u9Vvd6J7nYM17zrXOgeOaeQH3/wHqp6
         8mCjo6UaosFYzIhbo5V+kNPvDusI8Pi8aZVtMd9k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33IEIOND018875
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 09:18:24 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 09:18:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 09:18:01 -0500
Received: from [10.249.131.106] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33IEHvlN094080;
        Tue, 18 Apr 2023 09:17:58 -0500
Message-ID: <c2cc4f31-97e0-fa1a-befd-f0dfad751022@ti.com>
Date:   Tue, 18 Apr 2023 19:47:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] spi: cadence-quadspi: use macro SIMPLE_DEV_PM_OPS
To:     Mark Brown <broonie@kernel.org>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
References: <20230417091027.966146-1-d-gole@ti.com>
 <20230417091027.966146-2-d-gole@ti.com>
 <e65683c1-9f1b-4cfb-8e14-087ef7d69595@sirena.org.uk>
Content-Language: en-US
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <e65683c1-9f1b-4cfb-8e14-087ef7d69595@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark, Thanks for going through my patch.

On 4/18/2023 6:22 PM, Mark Brown wrote:
> On Mon, Apr 17, 2023 at 02:40:26PM +0530, Dhruva Gole wrote:
>
>> -static const struct dev_pm_ops cqspi__dev_pm_ops = {
>> -	.suspend = cqspi_suspend,
>> -	.resume = cqspi_resume,
>> -};
>> +static SIMPLE_DEV_PM_OPS(cqspi__dev_pm_ops, cqspi_suspend, cqspi_resume);
>>  
>>  #define CQSPI_DEV_PM_OPS	(&cqspi__dev_pm_ops)
>>  #else
> These days you should use DEFINE_SIMPLE_DEV_PM_OPS() instead.


Sure, I can respin this series with this macro instead,

https://elixir.bootlin.com/linux/v6.1/source/include/linux/pm.h#L399

So essentially it will look like,

static DEFINE_SIMPLE_DEV_PM_OPS(cqspi__dev_pm_ops, cqspi_suspend, cqspi_resume);


Are there any other improvements you'd like me to make in my next revision of this series?

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

