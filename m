Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD627A0555
	for <lists+linux-spi@lfdr.de>; Thu, 14 Sep 2023 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbjINNR1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Sep 2023 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbjINNR1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Sep 2023 09:17:27 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36321FD4;
        Thu, 14 Sep 2023 06:17:22 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C014BF84;
        Thu, 14 Sep 2023 15:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1694697440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ExZh8arWjoLAqWaYBfj+NhGvaG2asTtrVaWvVhRaGmQ=;
        b=NPDfwE0jfBgGTpaoOvfxV8yahVzA2Raq3ydqZhb9uhfIatume++5WYCm737NL6O+46GBRl
        NEmepH9oYoYbBji7/6wUiO6OIhj52jmqs+2yWcwmmlbLuwVOMooYrFaoLGxzzgZAidYpU6
        Itofr5kE1yUf8lNJEQYB6kV98tTUq0CSVEjZs9zlATynvnnW2l3A2lKtUn0nMZQISsG7if
        UOhl8kZlennpEfgylfyDWMQCr5ybDLgKCp6ekiyEk32YyIqrQKxHfeWNmOyM1DJEQMSe2z
        XMKaNZA/Gqa1nlzU14FLuX6LEXcV6Naz/uZWKH1teZGI9qk8NuNkY4lwYCiDsA==
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 15:17:20 +0200
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
In-Reply-To: <OS0PR01MB5922AED5B1490E251669F45186F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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
 <41a960b2a039ab88cb8a6ed6ed21e067@walle.cc>
 <OS0PR01MB5922AED5B1490E251669F45186F7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Message-ID: <9bf6cf6f104145080d38c8658000c24b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>> >> >> > I'm not sure we can do that, as this code is part of the
>> >> >> > hardware initialization during probing.
>> >> >> > Biju: is this needed that early, or can it be done later, after
>> >> >> > the connected device has been identified?
>> >> >>
>> >> >> I need to check that.
>> >> >>
>> >> >> You mean patch drivers/spi/spi-rpc-if.c to identify the flash type
>> >> >> from sfdp info and pass as a parameter to rpcif_hw_init??
>> >> >
>> >> > Something like that.
>> >> >
>> >> > That configuration should be saved somewhere, as rpcif_hw_init() is
>> >> > also called from rpcif_resume(), and when recovering from an error
>> >> > in rpcif_manual_xfer().
>> >>
>> >> I'm not sure I follow everything here, but apparently you want to set
>> >> the mode of the I/O pins of the controller, right? Shouldn't that
>> >> depend on the spi-mem mode, i.e. the buswidth? Certainly not on the
>> >> type of flash which is connected to the spi controller.
>> >
>> >
>> > How do you handle the IO states sections mentioned in the HW manual[1]
>> > and [2]?
>> 
>> What do you mean by "IO states" you don't configure anything on the 
>> SPI
>> flash, do you?
>> 
>> I guess you should have to configure your SoC SPI pins in your
>> .exec_op()
>> callback according to the buswidth property.
> 
> Here, same 4-bit tx_mode IO pin (QSPIn_IO0 Fixed Value for 1-bit Size)
> to be configured based on flash type and bus width right?

Just bus width. There should be no dependency on the flash type.


> For eg: here Adesto flash requires HI-Z for IO3 pin and Micron flash
> requires setting "1" for IO3 pin for 4-bit mode to work.

That is odd. You'd need to ask Micron, but I assume it is because
IO3 is shared with hold# and reset#. And there is a note "For pin
configurations that share the DQ3 pin with RESET#, the RESET#
functionality is disabled in QIO-SPI mode". So I guess the reason
why they asking for a '1' is because they don't want to reset the
flash. I'm pretty sure, we don't really support this in linux, so
you'd probably want to disable that feature, i.e. see Table 7,
bit 4. You could also come around this by enabling a pull-up on
that line (assuming the SPI controller 'drives' HiZ during command
phase).


> 
> Have a look at the other spi
>> drivers. I'm not that familiar with the spi controller drivers.
>> 
>> > Without this setting flash detection/ read/write failing with tx in
>> > 4-bit mode.
>> >
>> >  [1] Figure 20: QUAD INPUT/OUTPUT FAST READ - EBh/ECh
>> >
>> >  [2] section 8.14
>> >
>> > https://www.renesas.com/eu/en/document/dst/at25ql128a-datasheet?r=1608
>> > 586
>> 
>> Section 8.14 shows a Read with Quad I/O and the flash will tri-state 
>> the
>> I/O lines during the command and dummy phase and drive them during 
>> data
>> phase (and expect an address from the SoC on all I/Os during address 
>> and
>> mode phase).
> 
> I agree, What about micron flash??
> 
> Cheers,
> Biju
