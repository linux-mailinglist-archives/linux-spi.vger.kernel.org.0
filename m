Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B975624F8
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jun 2022 23:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiF3VQ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jun 2022 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiF3VQZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 17:16:25 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182832ED9
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 14:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656623783; x=1688159783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S3lpds+Dm08bh0wmuZJxD7UtITL3wTfX27aPen8VTS4=;
  b=L08f//uVVAqasHYcso2YTgVcDladYUMu20X4p38hNGZmPr3RJrInGZpW
   oDydX6kq6AeTSxb+c5Gym+iEiFvdd2ibjXJlyFRf9n2u0PvWDNXo9/Kch
   hPCBq8x24nQebE+wBcfEJcWeOZSeN0oIXyRHaG6GisWhsWyCRaxeU89A4
   hkEdZsS3g79pyXTELaqB64IrxLaSN8NEY5gwrRTgTGPFemSx1P0Qxrt5C
   pQ1msxBY2OnIgtVXC5MPP2iNJXmhxxcjR6dvJiBPMyh34y/HmnxVHfc7J
   /ESoLT0K63PHXh4hSnVosxQNY8v63wQpjPfBIgVFCI9oC3vYcFNlu79sS
   w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="209407246"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 05:16:22 +0800
IronPort-SDR: v9Tt6NHeAzIjm417w6PIcAVk9rBAiSBulO4hb12OJ7RA9RhjibEBWg5E7h4A4gnCRsWP1js6/r
 LVp77ycS02SKjdoH0EiYBecRmd0V83qwRftddLVlJcHwVmr5OBxRTY7TCy04W1qLjspGAw6sXn
 e20qtFxKTeXEaJAEDTBK3ouVr2zX1x/jkrvL3+vCTOg43crj703i42nTwW80+6VwzUE3aWojS5
 WVjxyt2krS+3JjLUjqghVBqw/7EuA2cjgjNMNRt32VYxSqSvtWBojd4OxLGrRVJtq+1BOhbvcN
 bSxFnLaGwAT7Ft5UBU+ysGq7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 13:38:35 -0700
IronPort-SDR: TBKUj6Ouc++/zCqHdwihWtLv7jjTRABJfDy6szaH37jJPJ1gkgFWZCgiBWH0lRJgcMtRn4h5a1
 GB8Jq1xR5QswGLlSQNT3ayvfVVEr+foU/RXU6PfA14U9/LPNpieJCDGtXH90u+Xzj4xYqBVWEp
 SYM6Mqeq1u/A6+fCngBb1OfzL+qbhBI/Q31+ZLahlXy2QDfdeApacaSeTr7sQu4bSTpYtZI4Au
 KY7rpc3bqDoGBubw/Fa7w4GG94jT4/iBAQsRCyJOj/LHK5D2c0yznjlLxOR0lf4DkE/fFMUCaF
 bkU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 14:16:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYrjg1kCXz1Rwry
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 14:16:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656623782; x=1659215783; bh=S3lpds+Dm08bh0wmuZJxD7UtITL3wTfX27a
        Pen8VTS4=; b=fqgmkU+iwbRN2+uHSjvLVbZM044xrtbN6ybNAxqU3pTozv2N4+l
        ibyfSai70KCZf9LEusqGftOtnBKvThI8qlw3u+IHNUfjozKWyj474NoqQ6917Yn2
        1WL1DcQZ2sQ9hYv+ciKGVsBWlAMyK45U71R8IahiJ8FTmsZ6AxSg/WCDMmCqEtpd
        YrBkDIyKeMOmlX50DRvFOTtIKnvIAYCTb058enQ9HpsXmg3os+iYLcq0zKKcDbFx
        nvjqkia3dvJTOA1bic5FQjsxuo6LcghR5Xx9fvgsMB7AKDAEnb5MLPzsjVZYW8pZ
        aQvxEJEBUd3V3B7ENvqn8rnl0Xp51xi4N5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iOTcCFUZQOGs for <linux-spi@vger.kernel.org>;
        Thu, 30 Jun 2022 14:16:22 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYrjX18xMz1RtVk;
        Thu, 30 Jun 2022 14:16:15 -0700 (PDT)
Message-ID: <f228057b-7c17-e536-ce6f-6597e263f06d@opensource.wdc.com>
Date:   Fri, 1 Jul 2022 06:16:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 00/15] Canaan devicetree fixes
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Conor Dooley <mail@conchuod.ie>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20220629184343.3438856-1-mail@conchuod.ie>
 <Yr3PKR0Uj1bE5Y6O@x1-carbon> <20220630175318.g2zmu6ek7l5iakve@bogus>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220630175318.g2zmu6ek7l5iakve@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/1/22 02:53, Sudeep Holla wrote:
> On Thu, Jun 30, 2022 at 04:28:26PM +0000, Niklas Cassel wrote:
>> On Wed, Jun 29, 2022 at 07:43:29PM +0100, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Hey all,
>>> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
>>> based boards. To make keeping it that way a little easier, I changed the
>>> Canaan devicetree Makefile so that it would build all of the devicetrees
>>> in the directory if SOC_CANAAN.
>>>
>>> I *DO NOT* have any Canaan hardware so I have not tested any of this in
>>> action. Since I sent v1, I tried to buy some since it's cheap - but could
>>> out of the limited stockists none seemed to want to deliver to Ireland :(
>>> I based the series on next-20220617.
>>>
>>
>> I first tried to apply your series on top of next-20220630,
>> but was greeted by a bunch of different warnings on boot,
>> including endless RCU stall warnings.
>> However, even when booting next-20220630 without your patches,
>> I got the same warnings and RCU stall.
>>
> 
> Is it possible to share the boot logs please ?
> Conor is having issues with my arch_topology/cacheinfo updates in -next.
> I would like to know if your issue is related to that or not ?

FYI, I see rcu warnings on boot on my dual-socket 8-cores Xeon system, but
the same kernel does not have the rcu warnings with an AMD Epyc single
socket 16-cores box.

> 
>> So I tested your series on top of v5.19-rc4 +
>> commit 0397d50f4cad ("spi: dt-bindings: Move 'rx-sample-delay-ns' to
>> spi-peripheral-props.yaml") cherry-picked,
>> (in order to avoid conflicts when applying your series,)
>> and the board was working as intended, no warnings or RCU stalls.
>>
> 
> If possible can you give this branch[1] a try where my changes are and doesn't
> have any other changes from -next. Sorry to bother you.
> 
> Conor seem to have issue with this commit[2], so if you get issues try to
> check if [3] works.
> 
> Regards,
> Sudeep
> 
> [1] https://git.kernel.org/sudeep.holla/c/ae85abf284e7
> [2] https://git.kernel.org/sudeep.holla/c/155bd845d17b
> [3] https://git.kernel.org/sudeep.holla/c/009297d29faa


-- 
Damien Le Moal
Western Digital Research
