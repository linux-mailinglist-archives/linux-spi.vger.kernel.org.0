Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37487E9E04
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 15:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKMOE2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 09:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMOE2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 09:04:28 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F31D4C;
        Mon, 13 Nov 2023 06:04:23 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6AD90A4D;
        Mon, 13 Nov 2023 15:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699884261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUzEw4TxH12VVyyaawGL2bUmESkOGHRb0hTdIzQjJqQ=;
        b=oymTYKSQXytO264g/g5zxuqMpJcNTAn1JwPKrIuok68U2TpRJyGSoGlkQx1PQmofFc0V3N
        oioQ0kfonF+F5eCOIIQnbDXrhF/DaKwb2f3H4X8PveLz3Cwi11WqJLMTF9Pk0Wq0fF++o+
        F8awPy7/CTvibNZ+K2PIdUmsTtzTZi0H/gQW6wx+iwagofw3SsSR6zQtKrLKIAD7CjgsD/
        Qh7eIqmPS8OEUygwps6N/LBztcU0HOWKfSRiJwt8S93AR5bRCEHDLcPgvyQLCYDNwdCF3J
        mixl6zy35Q+aYjj3mBw8/XKoRSmZy8eSgfZGCJEiPOkJD2GUAvACSWFX9bIq4Q==
MIME-Version: 1.0
Date:   Mon, 13 Nov 2023 15:04:21 +0100
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "biju.das.au" <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Add set_iofv() callback
In-Reply-To: <TYCPR01MB1126988E1A0741B99DB8DE59C86ADA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
 <877590a5e3f8c32ec0a032385049a563@walle.cc>
 <TYVPR01MB11279E535835F2998335F770A86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <b9831be88008b9f9960d1d79cd0e5a3a@walle.cc>
 <TYVPR01MB11279575676708170F3B3270D86AFA@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <f88759f98e865e68da5481fcbb969c47@walle.cc>
 <TYCPR01MB112699263B2EC0EC229746D3786AFA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <dcfa2cab21fc85bb9b2b0c1ceb754a1a@walle.cc>
 <TYCPR01MB11269C639CB7AA480E388360B86AEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB1126988E1A0741B99DB8DE59C86ADA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Message-ID: <3a9184e1e91689757a5b680e699ce02d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2023-11-11 13:26, schrieb Biju Das:
> Hi Michael Walle,
> 
>> Subject: RE: [PATCH RFC 0/4] Add set_iofv() callback
>> 
> 
>> 
>> > Subject: Re: [PATCH RFC 0/4] Add set_iofv() callback
>> >
>> > Hi Biju,
>> >
>> > >> >> Thus I was saying, that we probably wont support that and the
>> > >> >> easiest fix should be to disable this behavior for the atmel
>> > >> >> flash (there was nv setting).
>> > >> >
>> > >> > The fix up is invoked only for quad mode, I believe it is safe to
>> > >> > add fixup for micron flash As it is the one deviating from normal
>> > >> > according to you, rather than adding fixup for generic flash like
>> > >> > ATMEL flash(Now Renesas flash)
>> > >>
>> > >> Could you please try setting bit 4 in the Nonvolatile Configuration
>> > >> Register (Table 7) and see if the problem goes away?
>> > >
>> > > You mean, if it works, we need to disable reset for all the boards,
>> > > maybe at bootloader level??
>> >
>> > Not necessarily. First, just to confirm that it is actually the reset
>> > circuit. You can also compare the part numbers of the flash. There is
>> > a flash with IO3/RESET# and IO3/HOLD# (and a flash with a dedicated
>> > reset pin).
>> 
>> Part is MT25QU512ABB8E12-0SIT, As per the schematic, flash has a 
>> dedicated
>> RESET# with 10K pullup connected to SoC QSPI_RESET pin.
>> 
>> DQ0, DQ1, W#/DQ2 and DQ3 lines on the flash are connected without any
>> pullups to the SoC QSPI0_{0..3} pins.
>> 
>> >
>> > If that's the case, it looks like a hardware bug on your board. You
>> > left the reset pin floating. So you'd also not be able to boot from
>> > the NOR flash, right?
>> 
>> I am booting from NOR flash. BootRom code reads SPI flash and executes
>> BL2.
>> BL2 loads BL33 and U-boot from NOR flash. If this is the case, do you
>> think it is a Hw bug on the board?
>> 
>> >
>> > > OK, I will check that. Currently I have read that register and it is
>> > > showing a value Of 0xffbb. I need to do write operation. Before that
>> > > how do we recover flash, if something goes wrong during writing for
>> > > NV register?
>> >
>> > You should always be able to write that register from the bootloader.
>> > Maybe also through raw commands (like sspi in uboot).
>> 
>> Thanks for the pointer, I haven't explored the uboot path.
> 
> I have disabled RESET# bit in the Nonvolatile Configuration
> Register (Table 7) and borad doesn't boot any more.
> 
> By default that bit is set.
> 
> [    2.530291] ###### Before write Read cmd=b5 val=ff
> [    2.530431] ###### write cmd=b1 val=ef
> [    2.535518] ###### Read cmd=b5 val=ef
> 
> 
> NOTICE:  BL2: Built : 14:59:28, Nov 10 2023
> ERROR:   BL2: Failed to load image id 3 (-2)
> NOTICE:  BL2: v2.9(release):v2.5/rzg2l-1.00-3883-gc314a391c
> NOTICE:  BL2: Built : 14:59:28, Nov 10 2023
> ERROR:   BL2: Failed to load image id 3 (-2)
> NOTICE:  BL2: v2.9(release):v2.5/rzg2l-1.00-3883-gc314a391c
> 
> What is your thoughts on this? How do we proceed now?

I guessed you fixed this? Because.. if you boot from NOR the BL2
should come from the NOR flash too, correct? And that is actually
working.

-michael
