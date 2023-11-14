Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCDB7EAD8E
	for <lists+linux-spi@lfdr.de>; Tue, 14 Nov 2023 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjKNKFo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Nov 2023 05:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKNKFn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Nov 2023 05:05:43 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C562197;
        Tue, 14 Nov 2023 02:05:40 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C395817E;
        Tue, 14 Nov 2023 11:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699956338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cc+AlxmF73YQgRQPbI8MrMzhdobkgpHXHYUEe3HGxPc=;
        b=bBRzJIUao/6Bnt+uUZ/0mvrYgqndWz2GpBqkzcnNantM5qjetIXnMpZBa6BKSJTNBpcbGD
        rHSALi5FS95sBk6SR9XGmqbfWv4JVU/TWIOBA5K9gvjA/4NVYaHeUCMkpOhC+MmG8+0sX1
        Z+X/Zh2Dzje26Q4W/xOIRGg6tWtT7yTdvzAk9Q6LgGrLVcIodK43DWFPpKGsrTOeSJB704
        z4QFviLAdeqY0lukjTAeSGJM/RgHswgoiUljBqXgrFhhuTP+0PgM58WSP91pNlcJ3cmMlw
        i4LM5SXc7jr5i418iEn6fdIrcbDNMwbQpTGO/+jEKt6WRhmc7ckF+6RVAnG/AQ==
MIME-Version: 1.0
Date:   Tue, 14 Nov 2023 11:05:38 +0100
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
In-Reply-To: <TYVPR01MB112799D6CB8A0BCD1A20F406186B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
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
 <b3a322973f8969713a732587c73ca215@walle.cc>
 <TYVPR01MB112799D6CB8A0BCD1A20F406186B3A@TYVPR01MB11279.jpnprd01.prod.outlook.com>
Message-ID: <c9b0cffbb1566a7d38f2251ac7c8883a@walle.cc>
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

>> But that really begs the question why the Atmel flash isn't
>> working with that setting. I suspect some problems during the turn 
>> around
>> of the direction of IO3.
>> You'd really have to probe with an oscilloscope though.
> 
> OK, but as per [1], 8.14, IO3 must be HiZ for Atmel flash.

Sure, but the question is *why*? The flash shouldn't drive IO3
during the command phase. Also, because it might be in HiZ it
cannot read the state (as it is undefined at this point). So
what is going wrong here?

As mentioned, I suspect something is going wrong during the
change of direction of the IO3 line. Either the SoC is driving
it for too long, or the flash is driving it too early?

-michael
