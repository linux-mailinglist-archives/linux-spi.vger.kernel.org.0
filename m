Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E12A7E9FA2
	for <lists+linux-spi@lfdr.de>; Mon, 13 Nov 2023 16:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjKMPKt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Nov 2023 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjKMPKt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Nov 2023 10:10:49 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1111A6;
        Mon, 13 Nov 2023 07:10:45 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 41711A55;
        Mon, 13 Nov 2023 16:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699888244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53QSCJBmrUzUetZ9PQLwNLOxibqvKBRGPoj01mizcWI=;
        b=xTZEDIhnkH67/mfsh3zhJy2ctJMNRIUcr1g9wqJw8GV69hgEJ+g1Oea4T02u5Zu0Jm+OzN
        WgQ3Qlbng2ni/CVphvcYflITLEV77w7QRnbazMPkSHOHtf1FRRuyq5HNkTb+viSW99LpHb
        zQlP/tTeT9q+cUJT2In/j+fZ6JkJRZrVYXHc5CKy75LEbS60lyWbE+mOYxfu/sQGe1OHLb
        RODIt8qEJFuSCcSSSTd6emPVo3BOP4vuGmrF8sWxrWA0d1nIhBhoAwKOPMOYNATSt51Fsa
        ZRgsc7EWOtTvFu1H5Ma0xYYhZ8TU/NG8d+Gr2xB7jhpwk0i1H6P9Xnt9iOVCsA==
MIME-Version: 1.0
Date:   Mon, 13 Nov 2023 16:10:44 +0100
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
In-Reply-To: <TYVPR01MB112794AD059F78FEE41FAE03686B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
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
 <3a9184e1e91689757a5b680e699ce02d@walle.cc>
 <TYVPR01MB11279DF8A78E6C15CB0E6209E86B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
 <c0928bb386aa3d8ad8d1966fa5060efa@walle.cc>
 <TYVPR01MB112794AD059F78FEE41FAE03686B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Message-ID: <b3a322973f8969713a732587c73ca215@walle.cc>
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

Hi Biju,

>> > After that I will send a patch using IOFV {3,3,3,3} for both micron
>> > and Adesto flash.
>> 
>> Just to be clear, that will just touch the spi controller as a global
>> default, right?
> 
> Yes, it is in SoC specific bus controller 
> driver(driver/memory/renesas-rpc-if.c)
> 
>> That shouldn't go through spi-nor. Otherwise I'd prefer to use fix (2)
>> from my previous mail.
> 
> Agreed. Fix(2) won't work as renesas-rpc-if probe which sets {3,3,3,3} 
> is called before flash detection.
> and that will make flash detection to fail. So we cannot use fixup. The 
> only way (2) to work
> is to like patch[1].

Ohh I see. Makes sense. Can you ask your SoC engineers, why they
choose the IO3 default to high? I'd guess because it's usually
shared with HOLD# or RESET#. But that really begs the question
why the Atmel flash isn't working with that setting. I suspect
some problems during the turn around of the direction of IO3.
You'd really have to probe with an oscilloscope though.

-michael
