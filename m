Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C07A03E4
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjINMbh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINMbh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 08:31:37 -0400
X-Greylist: delayed 3856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 05:31:32 PDT
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC81FC8;
        Thu, 14 Sep 2023 05:31:32 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 11206A06;
        Thu, 14 Sep 2023 14:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694694691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnGeaRlqgD/xr/0/aCcDmQv/xzmqADkeop/Opfhm1y0=;
        b=WzMITAAP0IXsjnaGsdIzxBrjaa8JXSw+FDA6hrHEaL+9ECChP4janeuQ443j9SuUnsiw05
        RPYPbDGE2md2fUAi/c1XRZb4XyhdjoIjXtok2zJ1bR4JK8xmj2jUQE9lI7anDew2hD4DS9
        HcVn3O2rct/NoQUkV8ogT+al1j5DKp2P00sVBxOpQnaCkLXM7Q/OjKwnDHRWB9wKOwt/4I
        oAVm1b2jba+XY8fWTWOBRCnXf/61ctiL6O7IF2Q0PDW9G14rUnAGZxOHcF+hsERvdbOuz8
        kLQS/8Dujfl+m48TcHKmlvHIrqClJ2/dURg1lb2la+R3mdKR/xAigCca6FAT6A==
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 14:31:30 +0200
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix IO state based on flash type
In-Reply-To: <OS0PR01MB5922A4F16DE8923373AA5DD886F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230830145835.296690-1-biju.das.jz@bp.renesas.com>
 <CAMuHMdV1qvypo1XmHBXV5Q1SHEhksMN3SxgweYxPu+=ZeDmg1A@mail.gmail.com>
 <TYCPR01MB5933571F06789BFF27A8FCC786E6A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <502336e9-2455-f3f6-57d1-807bc4b71f7f@linaro.org>
 <CAMuHMdWO8EdbxXetmc9-2jhZWeX1b_J74O0exo1Q85X9Gbc_SA@mail.gmail.com>
 <20230914105937.4af00bf2@xps-13>
 <CAMuHMdX8Vg2M2K3U_sbAtVk+6VDvL+GNYtbs5FTTRZzRvVGPCQ@mail.gmail.com>
 <20230914111200.6e6832ca@xps-13>
 <CAMuHMdVryt5bTk8HeFMS3NU-4EpQdU3Tf6LiGmGQQ5bVD-Emsg@mail.gmail.com>
 <OS0PR01MB5922B4BF11D1954DFBE2976F86F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUA23VxkK-8CebyqiF=Oe81QZgpEmWmMrMGVd_+BXfsLA@mail.gmail.com>
 <737c6865703b8e294601d86a911691da@walle.cc>
 <OS0PR01MB5922A4F16DE8923373AA5DD886F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Message-ID: <41a960b2a039ab88cb8a6ed6ed21e067@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

>> >> > I'm not sure we can do that, as this code is part of the hardware
>> >> > initialization during probing.
>> >> > Biju: is this needed that early, or can it be done later, after the
>> >> > connected device has been identified?
>> >>
>> >> I need to check that.
>> >>
>> >> You mean patch drivers/spi/spi-rpc-if.c to identify the flash type
>> >> from sfdp info and pass as a parameter to rpcif_hw_init??
>> >
>> > Something like that.
>> >
>> > That configuration should be saved somewhere, as rpcif_hw_init() is
>> > also called from rpcif_resume(), and when recovering from an error in
>> > rpcif_manual_xfer().
>> 
>> I'm not sure I follow everything here, but apparently you want to set 
>> the
>> mode of the I/O pins of the controller, right? Shouldn't that depend 
>> on the
>> spi-mem mode, i.e. the buswidth? Certainly not on the type of flash 
>> which
>> is connected to the spi controller.
> 
> 
> How do you handle the IO states sections mentioned in the HW manual[1] 
> and [2]?

What do you mean by "IO states" you don't configure anything on the SPI
flash, do you?

I guess you should have to configure your SoC SPI pins in your 
.exec_op()
callback according to the buswidth property. Have a look at the other
spi drivers. I'm not that familiar with the spi controller drivers.

> Without this setting flash detection/ read/write failing with tx in 
> 4-bit mode.
> 
>  [1] Figure 20: QUAD INPUT/OUTPUT FAST READ - EBh/ECh
>  
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qlks_u_512_aba_0.pdf?rev=3e5b2a574f7b4790b6e58dacf4c889b2
> 
>  [2] section 8.14
> 
> https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608586

Section 8.14 shows a Read with Quad I/O and the flash will tri-state
the I/O lines during the command and dummy phase and drive them during
data phase (and expect an address from the SoC on all I/Os during 
address
and mode phase).

-michael
